<script context="module">
    import { getPlaceDetails } from '../../modules/places.mjs';

    import IndicatorFivebar from '../../components/IndicatorFivebar.svelte';
    import PlaceAddress from '../../components/PlaceAddress.svelte';
    import PlaceContacts from '../../components/PlaceContacts.svelte';

    export async function preload({ params, query }) {
        return { placeID: params.placeID };
    }
</script>

<script>
    import { onMount } from 'svelte';

    export let placeID;

    let place;
    let placeError;

    onMount(async () => {
        const response = await getPlaceDetails(placeID);

        if (!response.error) {
            place = response.place;

        } else {
            placeError = response.errorMessage;
        }
    });
</script>


<svelte:head>
    <title>{place ? `${place.name} | ` : ''}eat locals!</title>
</svelte:head>

<div class="cover-image"></div>
<div class="content-box-container">
    <div class="content-box">
    {#if placeError}
        <p>{placeError}</p>

    {:else if !place}
        <h1 class="loading">Loading...</h1>

    {:else}
        <div class="place-identity">
            <div class="place-minimap"></div>
            <div class="place-title">
                <h1>{place.name}</h1>
                {#if place.info.registered}
                    <h2 class="tagline">{place.info.tagline}</h2>
                {:else}
                    <h2 class="unregistered">Own this place? Click <a href="#">here!</a></h2>
                {/if}
            </div>
        </div>
        <div class="place-particulars">
            <PlaceAddress place={place} />
            <PlaceContacts place={place} />
        </div>
        <div class="place-media">
            <h2>No menu available</h2>
        </div>
    {/if}
    </div>

    <div class="content-sideline">
    </div>
</div>


<style>

    .content-box-container, .cover-image {
        width: 83.4%;
        margin-left: 8.3%;
        margin-right: 8.3%;
        box-sizing: border-box;
    }

    .cover-image {
        border-radius: 0 0 4.2vw 4.2vw;
        background-color: var(--color-neutral-medium);
        min-height: 8em;
        height: 16.7vh;
    }

    .content-box-container {
        display: flex;
        align-items: flex-start;
        justify-content: flex-end;
        position: relative;
    }

    .content-box {
        min-height: 25em;
        border-radius: 2em 2em 0 0;
        position: relative;
        top: -2em;
        width: 66.7%;
        background-color: var(--color-neutral-lightest);
    }

    .content-sideline {
        width: 16.7%;
        box-sizing: border-box;
        padding: 1em;
    }

    .place-title {
        text-align: right;
        padding: 0 5em;
    }

    .place-title h1, .place-title h2 {
        margin: 0;
    }

    .place-title h1 {
        padding: .75em 0 0;
    }

    .place-title h2 {
        padding: .25em 0;
    }

    .place-title h2.unregistered {
        color: var(--neutral-medium);
    }

    .place-minimap {
        margin-left: -3em;
        margin-top: -3em;
        border-radius: 50%;
        width: 15em;
        height: 15em;
        background-color: var(--color-neutral-dark);
    }

    .place-identity {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        position: relative;
        width: 100%;
        box-sizing: border-box;
    }

    .place-media {
        padding: 2em 5em;
    }

    .place-media h2 {
        font-style: italic;
        color: var(--color-neutral-dark);
    }

    .place-particulars {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        position: relative;
        width: 100%;
        box-sizing: border-box;
        padding: 0 10%;
    }

    .place-address span, .place-contacts span {
        display: block;
    }

    :global(main) {
        position: relative;
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
        display: inline-block;
    }

    @media (min-width: 640px) {
        :global(main) {
            max-width: none;
        }
    }
</style>
