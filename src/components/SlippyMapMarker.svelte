<script>
    export let place;

    let markerDivElement;
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
on:mouseover={place.highlight}
on:mouseout={place.unhighlight}
on:click={place.togglePin}>
    <slot></slot>
</div>
