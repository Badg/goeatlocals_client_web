import LRU from 'lru-cache';
import { writable } from 'svelte/store';

const maxCachedPlaces = 250;


function createPlacesCache() {
    const lru = new LRU({
        max: maxCachedPlaces,
        dispose: (placeID, placeObject) => { placeObject.unmountPlace(); },
    });
    const { subscribe, set, update } = writable(lru);

    function cachePlacesBatch(places) {
        places.forEach(place => { lru.set(place.placeID, place) });
        // This triggers the subscribers to update
        set(lru);
    }

    function cachePlace(place) {
        lru.set(place.placeID, place);
        set(lru);
    }

    function getPlace(placeID) {
        return lru.get(placeID);
    }

    function touchPlace(placeID) {
        // This is purely a prod to update the cache position
        lru.get(placeID);
    }

    function containsPlace(placeID) {
        return lru.has(placeID);
    }

    return {
        subscribe,
        cachePlace,
        cachePlacesBatch,
        touchPlace,
        containsPlace,
        getPlace,
    };
}


export const placesCache = createPlacesCache();
