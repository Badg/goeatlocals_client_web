<script>
	import { onMount } from 'svelte';
	import Mapsplaining from './Mapsplaining.svelte';
	import SlippyMap from './SlippyMap.svelte';
	import Mapfilters from './Mapfilters.svelte';

	// Component references
	let mapsplainer;
	let slippyMap;

	// Client state
	let highlightedPlace = null;
	let lastPinnedPlace = null;
	let pinnedPlaces;

    function catchMarkerMouseover(event) {
    	highlightedPlace = event.detail.place;
    }

    function catchMarkerMouseout(event) {
    	highlightedPlace = null;
    }

    onMount(() => {
    	// TODO: make place class
    	// TODO: have place class call into child component instead of passing
    	//		 events up the chain
    	slippyMap.addMarker({
    		placeLong: -122.2674272,
    		placeLat: 37.8072493,
    		placeName: 'Drexl'});
    });
</script>

<main>
	<div class="slippymap-container">
		<SlippyMap
		bind:this={slippyMap}
		on:markerMouseover={catchMarkerMouseover}
		on:markerMouseout={catchMarkerMouseout}/>
	</div>
		<div class="slippymap-overlay-container">
		<div class="mapsplaining-container">
			<Mapsplaining
			bind:this={mapsplainer}
			highlightedPlace={highlightedPlace}
			lastPinnedPlace={lastPinnedPlace}/>
		</div>
		<div class="mapfilters-container">
			<Mapfilters/>
		</div>
	</div>
</main>

<style>

	.slippymap-overlay-container {
		box-sizing: border-box;
        pointer-events: none;
		position: absolute;
		left: 0;
		top: 0;
		z-index: 7777;
        height: 100%;
        width: 100%;
		padding: 10px;
	}

	.mapsplaining-container {
		vertical-align: top;
		position: relative;
		display: inline-block;
		margin: 50px;
	}

	.mapfilters-container {
		vertical-align: top;
		position: relative;
		display: inline-block;
		margin: 50px;
	}

	.slippymap-container {
		position: relative;
		width: 100%;
		height: 100%;
	}

	main {
		color: rgb(254, 245, 247);
		position: relative;
		width: 100%;
		height: 100%;
		margin: 0;
		padding: 0;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>
