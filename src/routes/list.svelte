<svelte:head>
    <title>eat locals!{city ? ` | ${city}` : ''}</title>
</svelte:head>


<style>
    .list-container {
        max-width: 1280px;
        margin-right: auto;
        margin-left: auto;
        box-sizing: border-box;
        padding: 4em;
    }

    .list-container h1 {
        margin: 0;
        padding: 1em 0 2em 0;
    }

    .list-container .city-name {
        text-transform: capitalize;
    }

    .list-container .loading {
        text-align: center;
        box-sizing: border-box;
        min-height: 7em;
        min-width: 3em;
        padding-top: 2em;
        padding-bottom: 2em;
        margin-left: auto;
        margin-right: auto;
    }

    .placelist {
        border: 1px solid var(--color-neutral-light);
        border-radius: 1em;
        background-color: var(--color-neutral-lightest);
        filter: drop-shadow(7px 7px 5px var(--color-shadows));
    }
</style>


<script>
    import { faSpinner } from '@fortawesome/pro-duotone-svg-icons/';
    import { onMount } from 'svelte';
    import Icon from 'svelte-awesome';

    import { Place, getPlacesForCity } from '../modules/places.mjs';
    import { placesCache } from '../modules/stores.mjs';

    import PlaceList from '../components/PlaceList.svelte';

    let city = 'oakland';
    let filteredPlaces = [];

    onMount(async () => {
        filteredPlaces = await getPlacesForCity(city);
    });
</script>

<div class="list-container">
    <h1>Food and drink in <span class="city-name">{city}</span></h1>
    <div class="placelist">
        {#if !filteredPlaces | filteredPlaces.length === 0}
        <div class="loading">
            <Icon data={faSpinner} scale="3" pulse/>
        </div>
        {/if}
        <PlaceList places={filteredPlaces} />
    </div>
</div>
