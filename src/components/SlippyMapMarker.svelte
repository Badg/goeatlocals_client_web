<style>
    .place-marker {
        position: relative;
        width: 2.4em;
        height: 3em;
        cursor: pointer;
        --place-is-beerwine: none;
        --place-is-liquor: none;
        --place-is-grocery: none;
        --place-is-restaurant: none;
    }

    .place-marker.pinned {
        --color-marker-inner: var(--color-red-medium);
        --color-marker-outer: var(--color-neutral-medium);
    }

    .place-marker.unpinned {
        --color-marker-inner: var(--color-neutral-darkest);
        --color-marker-outer: var(--color-neutral-dark);
    }

    .place-primary-type-light_bar {
        --place-is-beerwine: inline;
    }

    .place-primary-type-full_bar {
        --place-is-liquor: inline;
    }

    .place-primary-type-grocery {
        --place-is-grocery: inline;
    }

    .place-primary-type-prepared_food {
        --place-is-restaurant: inline;
    }
</style>

<script>
    import { onMount, onDestroy } from 'svelte';

    import TouchHoverState from '@/modules/touchHoverState.mjs';


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

<svg
class="place-marker {isPinned ? 'pinned' : 'unpinned'}
        place-primary-type-{
            place.info.identity.displayClass ?
            place.info.identity.displayClass :
            'unknown'}"
on:mouseover={touchState.addHitEvent}
on:mouseout={touchState.addHitEvent}
on:click={touchState.addHitEvent}
on:touchstart={touchState.addHitEvent}
on:touchmove={touchState.addHitEvent}
on:touchend={touchState.addHitEvent}
on:dblclick|stopPropagation={place.gotoDetailPage}>
    <use xlink:href="#mapmarker" />
</svg>

<!-- Insert the map marker SVG into the head so we can reference and style it -->
<svelte:head>
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="350px"
     height="460px" viewBox="0 0 350 460" enable-background="new 0 0 350 460" xml:space="preserve" style="display: none;">
<symbol id="mapmarker" viewBox="0 0 350 460">
    <filter id="GaussianBlur_10">
        <feGaussianBlur stdDeviation="10"></feGaussianBlur>
    </filter>
    <g id="marker-pin">
        <g opacity="0.25" filter="url(#GaussianBlur_10)">
            <ellipse fill="#161A0D" style="fill: var(--color-neutral-darkest, #161A0D);" cx="175" cy="425" rx="150" ry="35"/>
        </g>
        
        <radialGradient id="marker-pin-gradient" cx="175" cy="160" r="150" fx="175" fy="160" gradientUnits="userSpaceOnUse">
            <stop offset="0" style="stop-color:#161A0D; stop-color: var(--color-marker-inner, #161A0D);"/>
            <stop offset="1" style="stop-color:#31332E; stop-color: var(--color-marker-outer, #31332E);"/>
        </radialGradient>
        <path fill="url(#marker-pin-gradient)" style="stroke: var(--color-neutral-darkest, #161A0D);" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M175,10C92.158,10,25,77.157,25,160
            c0,40.526,15.63,77.733,42.189,104.292C133.798,330.901,175,460,175,460s41.202-129.099,107.811-195.708
            C309.369,237.733,325,200.526,325,160C325,77.157,257.842,10,175,10z"/>
    </g>
    <g id="marker-icons">
        <path class="liquor" display="none" fill="#F1F2ED" style="fill: var(--color-neutral-lightest, #F1F2ED); display: var(--place-is-liquor, none);" d="M202.735,231.094h-19.141v-42.801l57.676-57.67c5.304-5.305,1.547-14.374-5.954-14.374
            H109.999c-7.503,0-11.259,9.068-5.954,14.374l57.675,57.67v42.801h-19.141c-7.55,0-13.671,6.121-13.671,13.671
            c0,1.511,1.223,2.736,2.733,2.736h82.032c1.511,0,2.733-1.226,2.733-2.736C216.406,237.215,210.286,231.094,202.735,231.094z
             M249.222,72.5c-21.401,0-39.428,13.741-46.206,32.813h17.959c5.692-9.758,16.157-16.406,28.247-16.406
            c18.09,0,32.813,14.717,32.813,32.813c0,18.095-14.723,32.812-32.813,32.812c-4.801,0-9.328-1.093-13.442-2.953l-12.05,12.052
            c7.453,4.546,16.123,7.307,25.492,7.307c27.182,0,49.217-22.035,49.217-49.218C298.438,94.535,276.403,72.5,249.222,72.5z"/>
        <g class="beerwine" display="none" style="display: var(--place-is-beerwine, none);">
            <path display="inline" fill="#F1F2ED" style="fill: var(--color-neutral-lightest, #F1F2ED);" d="M174.755,97.501h-93.75c-5.177,0-9.375,4.197-9.375,9.374
                c0,0.196,0.006,0.392,0.018,0.587l9.375,131.25c0.31,4.939,4.407,8.789,9.357,8.789h75c4.95,0,9.049-3.85,9.358-8.789
                l9.375-131.25c0.324-5.167-3.602-9.62-8.77-9.942C175.147,97.508,174.951,97.501,174.755,97.501z M164.687,116.251l-2.01,28.125
                H93.082l-2.01-28.125H164.687z"/>
            <path display="inline" fill="#F1F2ED" style="fill: var(--color-neutral-lightest, #F1F2ED);" d="M257.732,233.438h-11.719v-34.332c20.061-4.656,34.586-23.412,32.637-45.165
                l-4.672-52.178c-0.217-2.414-2.213-4.263-4.604-4.263h-65.473c-2.387,0-4.385,1.849-4.6,4.263l-4.676,52.181
                c-1.947,21.753,12.578,40.509,32.637,45.164v34.33h-11.719c-6.471,0-11.719,5.246-11.719,11.719c0,1.295,1.049,2.344,2.344,2.344
                h60.938c1.295,0,2.344-1.049,2.344-2.344C269.451,238.685,264.205,233.438,257.732,233.438z"/>
        </g>
        <path class="grocery" display="none" fill="#F1F2ED" style="fill: var(--color-neutral-lightest, #F1F2ED); display: var(--place-is-grocery, none);" d="M257.072,175.49l16.157-71.094c1.167-5.133-2.734-10.021-7.999-10.021H130.979
            l-3.133-15.316c-0.78-3.817-4.139-6.559-8.036-6.559H84.766c-4.531,0-8.203,3.673-8.203,8.204v5.468
            c0,4.531,3.672,8.204,8.203,8.204h23.886l24.011,117.384c-5.744,3.305-9.615,9.498-9.615,16.6c0,10.572,8.569,19.141,19.141,19.141
            c10.57,0,19.141-8.568,19.141-19.141c0-5.357-2.203-10.197-5.75-13.672h71.656c-3.547,3.475-5.75,8.314-5.75,13.672
            c0,10.572,8.569,19.141,19.141,19.141c10.57,0,19.141-8.568,19.141-19.141c0-7.578-4.405-14.127-10.794-17.227l1.886-8.299
            c1.167-5.133-2.735-10.021-7.999-10.021h-91.744l-2.237-10.938h100.196C252.903,181.875,256.224,179.225,257.072,175.49z"/>
        <path class="restaurant" display="none" fill="#F1F2ED" style="fill: var(--color-neutral-lightest, #F1F2ED); display: var(--place-is-restaurant, none);" d="M94.962,75.448l81.76,75.915c9.844-8.716,6.152-5.469,16.543-14.663
            c-7.314-12.408-5.879-25.67,5.503-37.052c7.452-7.417,32.403-25.088,33.736-26.045c5.503-4.034,12.852,3.931,8.477,8.955
            l-27.754,32.061c-0.444,0.513,1.024,2.051,1.606,1.573l33.12-26.935c5.161-4.204,12.955,3.486,8.717,8.716l-26.935,33.121
            c-0.444,0.547,1.06,2.051,1.572,1.572l32.062-27.754c5.024-4.341,12.988,2.974,8.955,8.511
            c-0.957,1.367-18.628,26.285-26.046,33.702c-11.689,11.724-25.122,12.613-37.085,5.537c-9.093,10.288-4.957,5.572-14.015,15.826
            l52.878,49.083c4.546,4.205,4.682,11.384,0.273,15.759l-10.938,10.938c-4.375,4.375-11.484,4.238-15.723-0.238
            c-6.528-7.725-68.566-80.839-71.267-84.017c-54.688,0-73.83-30.797-73.83-76.53C76.573,73.944,87.955,68.953,94.962,75.448z
             M101.661,233.363l10.938,10.938c4.443,4.443,11.758,4.238,15.928-0.479l40.163-45.359l-19.347-22.833l-47.203,41.802
            C97.423,221.638,97.184,228.918,101.661,233.363z"/>
    </g>
</symbol>
</svg>
</svelte:head>
