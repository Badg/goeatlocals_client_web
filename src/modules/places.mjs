import mapboxgl from 'mapbox-gl';

import SlippyMapMarker from '../components/SlippyMapMarker.svelte';


const bits64 = Math.pow(2, 64);


class Place {
    constructor(name, placeID, placeLong, placeLat, info) {
        // These are all from the constructor signature
        this.name = name;
        // Note: currently ignoring placeID and generating it randomly here
        this.placeID = Math.floor(Math.random() * bits64);
        this.placeLong = placeLong;
        this.placeLat = placeLat;
        this.info = info;

        // These are internals
        this.pinned = false;

        // These are set during mountPlace
        this.slippyMap = null;
        this.mapsplainer = null;
        this.pinCollection = null;

        // These binds are important because JS class support is lame
        this.highlight = this.highlight.bind(this);
        this.unhighlight = this.unhighlight.bind(this);
        this.togglePin = this.togglePin.bind(this);
    }

    mountPlace(slippyMap, mapsplainer, pinCollection) {
        this.slippyMap = slippyMap;
        this.mapsplainer = mapsplainer;
        this.pinCollection = pinCollection;

        // This adds a marker to the map for the place
        let markerElement = document.createElement('div');
        markerElement.classList.add('slippymap-marker-container');
        let marker = new mapboxgl.Marker({
                element: markerElement,
                anchor: 'bottom'
            })
            .setLngLat([this.placeLong, this.placeLat])
            .addTo(this.slippyMap.getMapInstance());
        let markerComponent = new SlippyMapMarker({
            target: markerElement,
            props: { place: this }
        });
    }

    highlight() {
        this.mapsplainer.highlightPlace(this);
    }

    unhighlight() {
        this.mapsplainer.unhighlightPlace(this);
    }

    togglePin() {
        if (this.pinned) {
            this.mapsplainer.unpinPlace(this);
            this.pinCollection.add(this);
            this.pinned = false;
        } else {
            this.mapsplainer.pinPlace(this);
            this.pinCollection.delete(this);
            this.pinned = true;
        }
    }
}


export default Place;
export { Place };
