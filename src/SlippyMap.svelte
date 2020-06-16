<script>
    import { onMount } from 'svelte';
    import { createEventDispatcher } from 'svelte';
    import mapboxgl from 'mapbox-gl';

    import SlippyMapMarker from './SlippyMapMarker.svelte';

    export let center = [-122.2719456, 37.804685];
    export let zoom = 16;

    const dispatch = createEventDispatcher();

    let mapContainer;
    let slippyMap;
    let drexlMarker;
    let drexlPopup;

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

        addMarker(-122.2674272, 37.8072493, 'Drexl');
    });
    
    function forwardMarkerMouseover(event) {
        dispatch('markerMouseover', event.detail);
    }
    
    function forwardMarkerMouseout(event) {
        dispatch('markerMouseout', event.detail);
    }

    function addMarker(placeLong, placeLat, placeName) {
        let markerElement = document.createElement('div');
        markerElement.classList.add('slippymap-marker-container');
        let marker = new mapboxgl.Marker({
                element: markerElement,
                anchor: 'bottom'
            })
            .setLngLat([placeLong, placeLat])
            .addTo(slippyMap);
        let markerComponent = new SlippyMapMarker({
            target: markerElement,
            props: {
                placeName
            }
        });
        markerComponent.$on('markerMouseover', forwardMarkerMouseover);
        markerComponent.$on('markerMouseout', forwardMarkerMouseout);
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
