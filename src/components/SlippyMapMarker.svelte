<script>
    import { onMount } from 'svelte';
    import { createEventDispatcher } from 'svelte';
    import mapboxgl from 'mapbox-gl';

    export let place;

    const dispatch = createEventDispatcher();
    let markerDivElement;

    function dispatchMouseover() {
        dispatch('markerMouseover', {
            markerElement: markerDivElement,
            place,
        });
    }

    function dispatchMouseout() {
        dispatch('markerMouseout', {
            markerElement: markerDivElement,
            place,
        });
    }

    function dispatchClick() {
        dispatch('markerClick', {
            markerElement: markerDivElement,
            place,
        });
    }
</script>

<style>
    .slippymap-marker{
        background-image: url('/assets/img/pin_basic.svg');
        background-size: cover;
        width: 2em;
        height: 2em;
        cursor: pointer;
    }
</style>

<div
class="slippymap-marker"
bind:this={markerDivElement}
on:mouseover={dispatchMouseover}
on:mouseout={dispatchMouseout}
on:click={dispatchClick}>
    <slot></slot>
</div>
