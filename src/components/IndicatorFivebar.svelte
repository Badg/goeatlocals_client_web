<style>
    .indicator-fivebar {
        box-sizing: border-box;
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }


    .indicator-visual {
        --indicator-negatory-fill: var(--color-neutral-medium);
        --indicator-unknown-fill: var(--color-neutral-medium);
        height: 1em;
        width: 2em;
        object-fit: contain;
    }

    .indicator-visual.indicate-none {
        --indicators-negatory: inline;
        --indicators-bars: none;
        --indicators-unknown: none;
    }

    .indicator-visual.indicate-unknown {
        --indicators-negatory: none;
        --indicators-bars: none;
        --indicators-unknown: inline;
    }

    .indicator-visual.indicate-0 {
        --indicators-negatory: none;
        --indicators-bars: inline;
        --indicators-unknown: none;
        --indicator-fivebar-1: var(--color-neutral-light);
        --indicator-fivebar-2: var(--color-neutral-light);
        --indicator-fivebar-3: var(--color-neutral-light);
        --indicator-fivebar-4: var(--color-neutral-light);
        --indicator-fivebar-5: var(--color-neutral-light);
    }

    .indicator-visual.indicate-1 {
        --indicators-negatory: none;
        --indicators-bars: inline;
        --indicators-unknown: none;
        --indicator-fivebar-1: var(--color-neutral-medium);
        --indicator-fivebar-2: var(--color-neutral-light);
        --indicator-fivebar-3: var(--color-neutral-light);
        --indicator-fivebar-4: var(--color-neutral-light);
        --indicator-fivebar-5: var(--color-neutral-light);
    }

    .indicator-visual.indicate-2 {
        --indicators-negatory: none;
        --indicators-bars: inline;
        --indicators-unknown: none;
        --indicator-fivebar-1: var(--color-neutral-medium);
        --indicator-fivebar-2: var(--color-neutral-medium);
        --indicator-fivebar-3: var(--color-neutral-light);
        --indicator-fivebar-4: var(--color-neutral-light);
        --indicator-fivebar-5: var(--color-neutral-light);
    }

    .indicator-visual.indicate-3 {
        --indicators-negatory: none;
        --indicators-bars: inline;
        --indicators-unknown: none;
        --indicator-fivebar-1: var(--color-neutral-medium);
        --indicator-fivebar-2: var(--color-neutral-medium);
        --indicator-fivebar-3: var(--color-neutral-medium);
        --indicator-fivebar-4: var(--color-neutral-light);
        --indicator-fivebar-5: var(--color-neutral-light);
    }

    .indicator-visual.indicate-4 {
        --indicators-negatory: none;
        --indicators-bars: inline;
        --indicators-unknown: none;
        --indicator-fivebar-1: var(--color-neutral-medium);
        --indicator-fivebar-2: var(--color-neutral-medium);
        --indicator-fivebar-3: var(--color-neutral-medium);
        --indicator-fivebar-4: var(--color-neutral-medium);
        --indicator-fivebar-5: var(--color-neutral-light);
    }

    .indicator-visual.indicate-5 {
        --indicators-negatory: none;
        --indicators-bars: inline;
        --indicators-unknown: none;
        --indicator-fivebar-1: var(--color-neutral-medium);
        --indicator-fivebar-2: var(--color-neutral-medium);
        --indicator-fivebar-3: var(--color-neutral-medium);
        --indicator-fivebar-4: var(--color-neutral-medium);
        --indicator-fivebar-5: var(--color-neutral-medium);
    }
</style>

<script>
    export let indicatorDescription;
    export let indicatorValue;

    const indicateNoneCeil = 0.5;
    const indicateLittleCeil = 2;
    const indicateSomeCeil = 3.5;


    function clampAndRound(value) {
        return Math.max(Math.min(Math.round(indicatorValue), 5), 0);
    }


    function assignVisualClass(value) {
        if (value === null || value == undefined) {
            return 'unknown';
        } else if (value < indicateNoneCeil) {
            return 'none';
        } else {
            return clampAndRound(value);
        }
    }


    function assignTextDesc(value) {
        if (value === null || value === undefined) {
            return 'Unknown';
        } else if (value < indicateNoneCeil) {
            return 'None';
        } else if (value < indicateLittleCeil) {
            return 'Little';
        } else if (value < indicateSomeCeil) {
            return 'Some';
        } else {
            return 'Lots';
        }
    }

    $: textDesc = assignTextDesc(indicatorValue);
    $: visualClass = assignVisualClass(indicatorValue);

</script>

<div class="indicator-fivebar">
    <svg class="indicator-visual indicate-{visualClass}">
        <use xlink:href="#indicator-fivebar" />
    </svg>
    <span class="indicator-desc">{indicatorDescription}</span>
    <span class="indicator-text">{textDesc}</span>
</div>

<!-- Insert the map marker SVG into the head so we can reference and style it -->
<svelte:head>
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     width="700px" height="500px" viewBox="0 0 700 500" enable-background="new 0 0 700 500" xml:space="preserve" style="display: none;">
<symbol id="indicator-fivebar" viewBox="0 0 700 500">
    <g id="indicators-bars" style="display: var(--indicators-bars, inline);">
        <path id="bar5" style="fill: var(--indicator-fivebar-5, #7E8079); stroke: var(--color-neutral-mediumest, #161A0D);" fill="#7E8079" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M599.5,49.5
            c0-27.338,22.386-49.5,50-49.5s50,22.162,50,49.5v401c0,27.338-22.386,49.5-50,49.5s-50-22.162-50-49.5V49.5z"/>
        <path id="bar4" style="fill: var(--indicator-fivebar-4, #7E8079); stroke: var(--color-neutral-mediumest, #161A0D);"  fill="#7E8079" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M449.5,49.5
            c0-27.338,22.386-49.5,50-49.5s50,22.162,50,49.5v401c0,27.338-22.386,49.5-50,49.5s-50-22.162-50-49.5V49.5z"/>
        <path id="bar3" style="fill: var(--indicator-fivebar-3, #BF3600); stroke: var(--color-neutral-mediumest, #161A0D);" fill="#BF3600" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M299.5,49.5
            c0-27.338,22.386-49.5,50-49.5s50,22.162,50,49.5v401c0,27.338-22.386,49.5-50,49.5s-50-22.162-50-49.5V49.5z"/>
        <path id="bar2" style="fill: var(--indicator-fivebar-2, #BF3600); stroke: var(--color-neutral-mediumest, #161A0D);" fill="#BF3600" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M149.5,49.5
            c0-27.338,22.386-49.5,50-49.5s50,22.162,50,49.5v401c0,27.338-22.386,49.5-50,49.5s-50-22.162-50-49.5V49.5z"/>
        <path id="bar1" style="fill: var(--indicator-fivebar-1, #BF3600); stroke: var(--color-neutral-mediumest, #161A0D);" fill="#BF3600" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M-0.5,49.5
            C-0.5,22.162,21.886,0,49.5,0s50,22.162,50,49.5v401c0,27.338-22.386,49.5-50,49.5s-50-22.162-50-49.5V49.5z"/>
    </g>
    <g id="indicators-negatory" display="none" style="display: var(--indicators-negatory, none);">
        <path id="indicator-negatory" style="fill: var(--indicator-negatory-fill, #D7D9D4); stroke: var(--color-neutral-mediumest, #161A0D);" display="inline" fill="#D7D9D4" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M350,0
            C211.929,0,100,111.928,100,250c0,138.07,111.929,250,250,250c138.07,0,250-111.93,250-250C600,111.929,488.071,0,350,0z
             M481.157,118.843c65.976,65.976,70.564,166.814,20.844,237.536L243.619,98C314.389,48.246,415.218,52.904,481.157,118.843z
             M218.843,381.157c-65.976-65.976-70.564-166.815-20.844-237.537L456.381,402C385.612,451.754,284.782,447.097,218.843,381.157z"/>
    </g>
    <g id="indicators-unknown" display="none" style="display: var(--indicators-unknown, none);">
        <path id="indicator-unknown" style="fill: var(--indicator-unknown-fill, #D7D9D4); stroke: var(--color-neutral-mediumest, #161A0D);" display="inline" fill="#D7D9D4" stroke="#161A0D" stroke-width="7" stroke-miterlimit="10" d="M350.21,0
            c-77.948,0-128.436,31.937-168.073,88.893c-7.19,10.332-4.974,24.498,5.057,32.104l42.127,31.942
            c10.13,7.681,24.543,5.885,32.474-4.051c24.462-30.646,42.607-48.29,80.817-48.29c30.043,0,67.203,19.335,67.203,48.468
            c0,22.023-18.181,33.334-47.845,49.965c-34.593,19.395-80.37,43.531-80.37,103.912v9.559c0,12.943,10.493,23.438,23.438,23.438
            h70.772c12.944,0,23.438-10.494,23.438-23.438v-5.639c0-41.855,122.332-43.598,122.332-156.862C521.58,64.703,433.102,0,350.21,0z
             M340.424,364.705c-37.301,0-67.647,30.348-67.647,67.648c0,37.299,30.347,67.646,67.647,67.646s67.647-30.348,67.647-67.648
            S377.725,364.705,340.424,364.705z"/>
    </g>
</symbol>
</svg>
</svelte:head>
