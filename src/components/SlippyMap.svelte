<script>
    import { onMount } from 'svelte';
    import mapboxgl from 'mapbox-gl';

    export let center = [-122.2719456, 37.804685];
    export let zoom = 16;

    export function getMapInstance() {
        return slippyMap;
    };

    export function addMapBoundsListener(callback) {
        boundsListeners.push(callback);
    };

    const attribution =
        '&copy; <a href="https://openmaptiles.org/">OpenMapTiles</a> ' +
        '&copy; <a href="https://www.openstreetmap.org/copyright">' +
        'OpenStreetMap</a> contributors';
    
    let slippyMap;
    let mapContainer;
    let boundsListeners = [];

    onMount(() => {
        slippyMap = new mapboxgl.Map({
            container: mapContainer,
            center: center,
            zoom: zoom,
            zoomControl: false,
            style: '/api/maps/styles/eatlocals_light.json',
            transformRequest: (url, resourceType) => {
                return {
                    url: `${window.location.origin}${url}`
                }
            },
            // currently can't do this; it washes away the route for the map.
            // I don't know why; I'm 85% confident it's a bug in either sapper,
            // mapbox-gl.js, or the interplay between the two of them, but I
            // don't have time to try and troubleshoot it. so for now,
            // unfortunately, we can't preserve the hash like this free out of
            // the box. See https://github.com/mapbox/mapbox-gl-js/issues/9917
            // hash: 'mapPosition',
            attribution,
        });
        slippyMap.addControl(new mapboxgl.NavigationControl(), 'bottom-right');
        slippyMap.on('load', initSlippyMap);
    });

    function initSlippyMap() {
        slippyMap.on('moveend', notifyBoundsListeners);
        slippyMap.on('resize', notifyBoundsListeners);
        slippyMap.on('zoomend', notifyBoundsListeners);
    }

    function notifyBoundsListeners() {
        let bounds = slippyMap.getBounds();
        boundsListeners.forEach(listener => {
            listener(bounds);
        });
    }

</script>

<style>
    .slippymap {
        height: 100%;
        width: 100%;
    }
</style>

<div class="slippymap" bind:this="{mapContainer}">
    <slot></slot>
</div>
