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


class Place {
    constructor(name, placeID, placeLong, placeLat, placePrimaryType, info) {
        // These are all from the constructor signature
        this.name = name;
        // Note: currently ignoring placeID and generating it randomly here
        this.placeID = placeID;
        this.placeLong = placeLong;
        this.placeLat = placeLat;
        this.placePrimaryType = placePrimaryType;
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
            .setLngLat([this.placeLong, this.placeLat])
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
    let response = await fetch(apiRoutePlacesAll);
    let responseData = await response.json();
    let newPlaces = new Set();

    responseData.forEach(placeJson => {
        let thisPlaceID = placeJson.placeID;

        if (placesCache.containsPlace(thisPlaceID)) {
            placesCache.touchPlace(thisPlaceID);
        } else {
            let thisPlace =  new Place(
                placeJson.name,
                placeJson.placeID,
                placeJson.placeLong,
                placeJson.placeLat,
                placeJson.placePrimaryType,
                placeJson.placeDetails
            );
            newPlaces.add(thisPlace);
        }
    });

    if (newPlaces.size > 0) {
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
        return { error: false, placeData: placeOrErrorData };
    } else {
        return {
            error: true,
            statusHint: clientStatusHint,
            errorMessage: clientErrorMessage,
        };
    }
}


export default Place;
export { Place, getPlacesForBounds, getPlaceDetails };
