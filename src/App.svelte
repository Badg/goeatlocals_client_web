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
	let pinnedPlaces = new Set();

    function catchMarkerClick(event) {
    	let clickedPlace = event.detail.place;

    	// TODO: update this to source from an internal ID instead of OSM id
    	// NOTE: also update in the Mapsplaining logic
    	if ( 
    		lastPinnedPlace === null ||
    		lastPinnedPlace.placeOsmId != clickedPlace.placeOsmId
		) {
    		lastPinnedPlace = clickedPlace;
    		pinnedPlaces.add(clickedPlace);
    	} else {
    		lastPinnedPlace = null;
    		pinnedPlaces.delete(clickedPlace);
    	}

    	highlightedPlace = event.detail.place;
    }

    function catchMarkerMouseover(event) {
    	highlightedPlace = event.detail.place;
    }

    function catchMarkerMouseout(event) {
    	highlightedPlace = null;
    }

    onMount(() => {
    	// TODO: make place class
    	// TODO: have that place class call into child component instead of
    	//		 passing events up the chain
    	slippyMap.addMarker({
    		placeLong: -122.2674272,
    		placeLat: 37.8072493,
    		placeOsmId: 3056134586,
    		placeName: 'Drexl',
    		hasFood: false,
    		hasBooze: true,
    		hasBeer: true,
    		hasProvisions: false});
    	slippyMap.addMarker({ 
    		placeLong: -122.2669739,
    		placeLat: 37.8068275,
    		placeOsmId: 1079401457,
    		placeName: '355',
    		hasFood: false,
    		hasBooze: true,
    		hasBeer: true,
    		hasProvisions: false});
    	slippyMap.addMarker({ 
    		placeName: 'Itani Ramen',
    		placeOsmId: 4095991379,
    		placeLat: 37.8076042,
    		placeLong: -122.2699126,
    		hasFood: true,
    		hasBooze: false,
    		hasBeer: true,
    		hasProvisions: false});
    	slippyMap.addMarker({ 
    		placeName: 'The Telegraph',
    		placeOsmId: 3470332401,
    		placeLat: 37.8128233,
    		placeLong: -122.2685736,
    		hasFood: true,
    		hasBooze: true,
    		hasBeer: true,
    		hasProvisions: false});
    	slippyMap.addMarker({ 
    		placeName: 'Duende',
    		placeOsmId: 3470332399,
    		placeLat: 37.8081307,
    		placeLong: -122.2695932,
    		hasFood: true,
    		hasBooze: true,
    		hasBeer: true,
    		hasProvisions: false});
    	slippyMap.addMarker({ 
    		placeName: 'The Lunch Box',
    		placeOsmId: 1186413873,
    		placeLat: 37.8065924,
    		placeLong: -122.2680771,
    		hasFood: true,
    		hasBooze: false,
    		// Note: I don't actually know this for sure; I've never been there
    		hasBeer: false,
    		hasProvisions: false});
    	slippyMap.addMarker({ 
    		placeName: 'Howden Market',
    		placeOsmId: 3927998690,
    		placeLat: 37.8055483,
    		placeLong: -122.2672438,
    		hasFood: true,
    		hasBooze: false,
    		hasBeer: true,
    		hasProvisions: true});
    });

</script>

<main>
	<div class="slippymap-container">
		<SlippyMap
		bind:this={slippyMap}
		on:markerMouseover={catchMarkerMouseover}
		on:markerMouseout={catchMarkerMouseout}
		on:markerClick={catchMarkerClick}/>
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
