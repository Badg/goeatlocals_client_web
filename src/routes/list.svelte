<svelte:head>
    <title>eat locals!</title>
</svelte:head>


<style>
</style>


<script>
    import { onMount } from 'svelte';

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
    <PlaceList places={filteredPlaces} />
</div>
