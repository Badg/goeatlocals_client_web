import mapboxgl from 'mapbox-gl';

import SlippyMapMarker from '../components/SlippyMapMarker.svelte';


const detailPageRoute = '/places'


class Place {
    constructor(name, placeID, placeLong, placeLat, info) {
        // These are all from the constructor signature
        this.name = name;
        // Note: currently ignoring placeID and generating it randomly here
        this.placeID = placeID;
        this.placeLong = placeLong;
        this.placeLat = placeLat;
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
        this.mapsplainer.highlightPlace(this);
    }

    unhighlight() {
        this.mapsplainer.unhighlightPlace(this);
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
}


export default Place;
export { Place };
