<script context="module">
    import { getPlaceDetails } from '../../modules/places.mjs';

    export async function preload({ params, query }) {
        return { placeID: params.placeID };
    }
</script>

<script>
    import { onMount } from 'svelte';

    export let placeID;

    let placeData;
    let placeError;

    onMount(async () => {
        const response = await getPlaceDetails(placeID);

        if (!response.error) {
            placeData = response.placeData;

        } else {
            placeError = response.errorMessage;
        }
    });
</script>


<svelte:head>
    <title>{placeData ? `${placeData.name} | ` : ''}eat locals!</title>
</svelte:head>


<h1>{placeData ? placeData.name : 'Loading...'}</h1>
<p>{placeError ? placeError : ''}</p>


<style>

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
