<svelte:head>
    <title>eat locals!</title>
</svelte:head>

<script>
    import LRU from 'lru-cache';
	import { onMount } from 'svelte';

    import Place from '../modules/places.mjs'

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
    let placesCache = new LRU({
        max: 250,
        dispose: (placeID, placeObject) => { placeObject.unmountPlace(); },
    });

    async function getPlacesForBounds(bounds){
        let east = bounds.getEast();
        let south = bounds.getSouth();
        let north = bounds.getNorth();
        let west = bounds.getWest();

        let response = await fetch(placesEndpoint);
        let responseData = await response.json();
        let newPlaces = new Set();

        responseData.forEach(placeJson => {
            let thisPlaceID = placeJson.placeID;

            if (placesCache.has(thisPlaceID)) {
                // This is purely a prod to update the cache position
                placesCache.get(thisPlaceID);
            } else {
                let thisPlace =  new Place(
                    placeJson.name,
                    placeJson.placeID,
                    placeJson.placeLong,
                    placeJson.placeLat,
                    placeJson.placeDetails
                );

                placesCache.set(thisPlaceID, thisPlace);
                thisPlace.mountPlace(slippyMap, mapsplainer, pinnedPlaces);
                newPlaces.add(thisPlace);
            }
        });
    }

    function unpinAllPlaces() {
        pinnedPlaces.forEach(placeID => {
            let place = placesCache.get(placeID);
            if (place !== undefined) {
                place.unpin();
            }
        });
    }

    onMount(() => {
        let initialBounds = slippyMap.getMapInstance().getBounds();
        getPlacesForBounds(initialBounds);
        slippyMap.addMapBoundsListener(getPlacesForBounds);
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

	:global(main) {
		color: rgb(254, 245, 247);
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
