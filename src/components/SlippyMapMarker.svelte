<script>
    export let place;
    export function pinMarker() {
        isPinned = true;
    }

    export function unpinMarker() {
        isPinned = false;
    }

    let isPinned = false;
</script>

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
        background-image: url('/assets/img/mapMarker_main.svg');
    }

    .marker-indicators {
        background-image: url('/assets/img/mapMarker_indicators.svg');
        display: none;
    }

    .marker-pinner {
        background-image: url('/assets/img/mapMarker_pinner.svg');
        display: none;
    }

    .marker-pinner.pinned {
        display: initial;
    }

    .marker-pinner.unpinned {
        display: none;
    }

    .marker-unpinner {
        background-image: url('/assets/img/mapMarker_unpinner.svg');
        display: none;
    }

    .marker-unpinner.pinned {
        display: none;
    }

    .marker-unpinner.unpinned {
        display: initial;
    }
</style>

<div
class="slippymap-marker"
on:mouseover={place.highlight}
on:mouseout={place.unhighlight}
on:click={place.togglePin}>
    <div class="marker-pinner {isPinned ? 'pinned' : 'unpinned'}"></div>
    <div class="marker-unpinner {isPinned ? 'pinned' : 'unpinned'}"></div>
    <div class="marker-indicators"></div>
    <div class="marker-main"></div>
</div>
