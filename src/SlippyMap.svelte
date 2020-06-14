<script>
    import { onMount } from 'svelte';
    import mapboxgl from 'mapbox-gl';

    let mapContainer;
    let slippyMap;
    let drexlMarker;
    let drexlPopup;

    export let center = [-122.2719456, 37.804685];
    export let zoom = 16;

    onMount(() => {
        slippyMap = new mapboxgl.Map({
            container: mapContainer,
            center: center,
            zoom: zoom,
            zoomControl: false,
            style: '/maps/maptiler-basic/style.json',
            transformRequest: (url, resourceType) => {
                return {
                    url: `${window.location.origin}${url}`
                }
            },
            hash: 'mapPosition',
            attribution: '&copy; <a href="https://openmaptiles.org/">OpenMapTiles</a> &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        });
        slippyMap.addControl(new mapboxgl.NavigationControl());

        drexlMarker = new mapboxgl.Marker()
            .setLngLat([-122.2674272, 37.8072493])
            .addTo(slippyMap);
    });
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
