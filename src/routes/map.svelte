<svelte:head>
    <title>eat locals!</title>
</svelte:head>

<script>
	import { onMount } from 'svelte';

    import { Place, getPlacesForBounds } from '../modules/places.mjs';
    import { placesCache } from '../modules/stores.mjs';

	import Mapsplaining from '../components/Mapsplaining.svelte';
	import SlippyMap from '../components/SlippyMap.svelte';
	import Mapfilters from '../components/Mapfilters.svelte';

    const placesEndpoint = '/api/places';

	// Component references
    let slippyMap;
	let mapsplainer;

	// Client state
	let highlightedPlace = null;
	let lastPinnedPlace = null;
	let pinnedPlaces = new Set();


    function unpinAllPlaces() {
        pinnedPlaces.forEach(placeID => {
            let place = placesCache.getPlace(placeID);
            if (place !== undefined) {
                place.unpin();
            }
        });
    }


    async function inboundsPlacesUpdater(bounds) {
        let newPlaces = await getPlacesForBounds({
            north: bounds.getNorth(),
            east: bounds.getEast(),
            south: bounds.getSouth(),
            west: bounds.getWest(),
        });

        newPlaces.forEach(newPlace => { 
            newPlace.mountPlace(slippyMap, mapsplainer, pinnedPlaces);
        });
    }


    onMount(() => {
        let initialBounds = slippyMap.getMapInstance().getBounds();
        inboundsPlacesUpdater(initialBounds);
        slippyMap.addMapBoundsListener(inboundsPlacesUpdater);
    });
</script>

<div class="slippymap-container">
	<SlippyMap
	bind:this={slippyMap}/>
</div>
<div class="slippymap-overlay-container">
	<div class="mapsplaining-container">
		<Mapsplaining
		bind:this={mapsplainer}
        unpinAll={unpinAllPlaces}/>
	</div>
	<div class="mapfilters-container">
		<Mapfilters/>
	</div>
</div>

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
	}

	.mapsplaining-container {
		position: absolute;
        top: 0;
        left: 0;
	}

	.mapfilters-container {
        position: absolute;
        top: 0;
        right: 0;
	}

	.slippymap-container {
		position: relative;
		width: 100%;
		height: 100%;
	}

	:global(main) {
		position: relative;
		width: 100%;
		height: 100%;
		margin: 0;
		padding: 0;
	}

	@media (min-width: 640px) {
		:global(main) {
			max-width: none;
		}
	}
</style>
