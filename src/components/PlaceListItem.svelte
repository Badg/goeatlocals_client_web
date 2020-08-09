<style>
</style>

<script>
    import Icon from 'svelte-awesome';

    export let place;
    import PlaceAddress from '../components/PlaceAddress.svelte';
    import PlaceContacts from '../components/PlaceContacts.svelte';

    $: website = place.info.locators.website;
    $: phone = place.info.locators.phone;
</script>

{#if place !== undefined}
<li>
    <div class="identity">
        <h2>{place.name}</h2>
        <p>{place.info.identity.displayClass}</p>
    </div>
    <div class="status">
        {#if place.status === null}
        <p class="warning">We don't know if this place is open!</p>

        {:else if place.status === 'open'}
        <p class="info">We think this place is open!</p>

        {:else}
        <p class="admonishment">We think this place is {place.status}</p>

        {/if}
    </div>
    <div class="locators">
        <div class="physical">
            <PlaceAddress place={place} />
            <p class="coords">
                ({place.info.locators.lat.toFixed(5)}, 
                {place.info.locators.lon.toFixed(5)})
            </p>
        </div>
        <div class="contacts">
            <PlaceContacts place={place} />
        </div>
    </div>
</li>
{/if}
