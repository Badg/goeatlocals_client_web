<style>
    .slippymap-marker{
        position: relative;
        width: 2.4em;
        height: 3em;
        cursor: pointer;
    }

    .marker-main,
    .marker-indicators,
    .marker-pinner,
    .marker-unpinner {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background-size: cover;
    }

    .marker-main {
        background-image: url('/static/img/mapMarker_main.svg');
    }

    .marker-indicators {
        background-image: url('/static/img/mapMarker_indicators.svg');
        display: none;
    }

    .marker-pinner {
        background-image: url('/static/img/mapMarker_pinner.svg');
        display: none;
    }

    .marker-pinner.pinned {
        display: initial;
    }

    .marker-pinner.unpinned {
        display: none;
    }

    .marker-unpinner {
        background-image: url('/static/img/mapMarker_unpinner.svg');
        display: none;
    }

    .marker-unpinner.pinned {
        display: none;
    }

    .marker-unpinner.unpinned {
        display: initial;
    }
</style>

<script>
    import { onMount, onDestroy } from 'svelte';

    import TouchHoverState from '../modules/touchHoverState.mjs';


    export let place;
    export function pinMarker() {
        isPinned = true;
    }

    export function unpinMarker() {
        isPinned = false;
    }

    export function clearHoverState() {
        touchState.clearState();
    };

    let touchState = new TouchHoverState();
    let isPinned = false;

    onDestroy(touchState.clearState);
    onMount(() => {
        touchState.setOverCallback(place.highlight);
        touchState.setOutCallback(place.unhighlight);
        touchState.setClickCallback(place.togglePin);
    });
</script>

<div
class="slippymap-marker"
on:mouseover={touchState.addHitEvent}
on:mouseout={touchState.addHitEvent}
on:click={touchState.addHitEvent}
on:touchstart={touchState.addHitEvent}
on:touchmove={touchState.addHitEvent}
on:touchend={touchState.addHitEvent}
on:dblclick|stopPropagation={place.gotoDetailPage}>
    <div class="marker-pinner {isPinned ? 'pinned' : 'unpinned'}"></div>
    <div class="marker-unpinner {isPinned ? 'pinned' : 'unpinned'}"></div>
    <div class="marker-indicators"></div>
    <div class="marker-main"></div>
</div>
