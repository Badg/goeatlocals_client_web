import mapboxgl from 'mapbox-gl';
import { goto } from '@sapper/app';

import SlippyMapMarker from '../components/SlippyMapMarker.svelte';
import { placesCache } from './stores.mjs'


// TODO: do I want something that formats these based on parameters instead of
// needing to format them in the fetch call? Probably. That would be another
// good API glue class. OOOO, you could even define it identically to the
// backend (ex "/api/places/<placeID>")
const pageRoutePlaceDetail = '/places';
const apiRoutePlacesAll = '/api/places';
const apiRoutePlaceDetail = '/api/places';
const apiRoutePlaceCitiesAll = '/api/places/cities'


class Place {
    constructor(placeID, name, status, info) {
        // These are all from the constructor signature
        this.placeID = placeID;
        this.name = name;
        this.status = status;
        this.info = info;

        // These are internals
        this.pinned = false;

        // These are set during mountPlace
        this.slippyMap = null;
        this.mapsplainer = null;
        this.pinCollection = null;
        this.markerComponent = null;
        this.markerObject = null;

        // These binds are important because JS class support is lame
        this.highlight = this.highlight.bind(this);
        this.unhighlight = this.unhighlight.bind(this);
        this.togglePin = this.togglePin.bind(this);
        this.pin = this.pin.bind(this);
        this.unpin = this.unpin.bind(this);
        this.unmountPlace = this.unmountPlace.bind(this);
        this.gotoDetailPage = this.gotoDetailPage.bind(this);
    }

    static fromApiResponse(jsonObj) {
        return new this(
            jsonObj.placeID,
            jsonObj.name,
            jsonObj.status,
            jsonObj.info
        );
    }

    mountPlace(slippyMap, mapsplainer, pinCollection) {
        this.slippyMap = slippyMap;
        this.mapsplainer = mapsplainer;
        this.pinCollection = pinCollection;

        // This adds a marker to the map for the place
        let markerElement = document.createElement('div');
        markerElement.classList.add('slippymap-marker-container');
        this.markerObject = new mapboxgl.Marker({
                element: markerElement,
                anchor: 'bottom'
            })
            .setLngLat([this.info.locators.lon, this.info.locators.lat])
            .addTo(this.slippyMap.getMapInstance());
        this.markerComponent = new SlippyMapMarker({
            target: markerElement,
            props: { place: this }
        });
    }

    unmountPlace() {
        this.markerComponent.$destroy();
        this.markerObject.remove();
        // Note: we're resetting these, but we're not unpinning things, since
        // pins are assigned by nodes and we want them to be retained even if
        // we scroll out of view and overflow the cache
        this.pinCollection = null;
        this.mapsplainer = null;
        this.slippyMap = null;
    }

    highlight() {
        let overriddenHighlightedPlace = this.mapsplainer.highlightPlace(this);
        if (overriddenHighlightedPlace !== null) {
            overriddenHighlightedPlace.markerComponent.clearHoverState();
        }
    }

    unhighlight() {
        this.mapsplainer.unhighlightPlace();
        this.markerComponent.clearHoverState();
    }

    pin() {
        this.mapsplainer.pinPlace(this);
        this.markerComponent.pinMarker();
        this.pinCollection.add(this.placeID);
        this.pinned = true;
    }

    unpin() {
        this.mapsplainer.unpinPlace(this);
        this.markerComponent.unpinMarker();
        this.pinCollection.delete(this.placeID);
        this.pinned = false;
    }

    togglePin() {
        if (this.pinned) {
            this.unpin();
        } else {
            this.pin();
        }
    }

    async gotoDetailPage() {
        await goto(`${pageRoutePlaceDetail}/${this.placeID}`);
    }
}


async function getPlacesForBounds({north, south, east, west}){
    let response = await fetch(
        apiRoutePlacesAll +
        `?north=${north}&east=${east}&south=${south}&west=${west}`
    );
    let responseData = await response.json();
    let newPlaces = new Set();

    responseData.forEach(placeJson => {
        let thisPlaceID = placeJson.placeID;

        if (placesCache.containsPlace(thisPlaceID)) {
            placesCache.touchPlace(thisPlaceID);
        } else {
            let thisPlace =  Place.fromApiResponse(placeJson);
            newPlaces.add(thisPlace);
        }
    });

    if (newPlaces.size > 0) {
        placesCache.cachePlacesBatch(newPlaces);
    }

    return newPlaces;
}


async function getCitiesWithPlaces(){
    let response = await fetch(apiRoutePlaceCitiesAll);
    return (await response.json());
}


async function getPlacesForCity(city){
    let response = await fetch(
        apiRoutePlacesAll +
        `?city=${city}`
    );
    let responseData = await response.json();
    let newPlaces = [];

    responseData.forEach(placeJson => {
        let thisPlaceID = placeJson.placeID;

        if (placesCache.containsPlace(thisPlaceID)) {
            placesCache.touchPlace(thisPlaceID);
        } else {
            let thisPlace =  Place.fromApiResponse(placeJson);
            newPlaces.push(thisPlace);
        }
    });

    if (newPlaces.length > 0) {
        placesCache.cachePlacesBatch(newPlaces);
    }

    return newPlaces;
}


// TODO: this is sloppy/boilerplatey. I really want two different glue classes
// here: apiSuccessResponse and apiFailureResponse (or maybe also a third for
// partial successes)
async function getPlaceDetails(placeID) {
    const response = await fetch(`${apiRoutePlaceDetail}/${placeID}`);
    const placeOrErrorData = await response.json();

    if (response.status === 200) {
        // TODO: update place cache with details
        return {
            error: false,
            place: Place.fromApiResponse(placeOrErrorData)
        };
    } else {
        return {
            error: true,
            statusHint: clientStatusHint,
            errorMessage: clientErrorMessage,
        };
    }
}


export default Place;
export { Place, getPlacesForBounds, getPlaceDetails, getPlacesForCity };
