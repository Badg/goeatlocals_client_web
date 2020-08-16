<style>

    li.place-list-item {
        display: flex;
        justify-content: space-between;
        align-content: stretch;
        padding: .75em 1em;
        max-width: 100%;
        min-width: 50%;
        box-sizing: border-box;
        /*flex-grow: 1;*/
    }

    .leftside {
        flex-grow: 0;
        text-align: center;
        display: inline-flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        max-width: 5em;
    }

    .rightside {
        position: relative;
        padding: 0 0 0 2em;
        flex-grow: 1;
    }

    .identity h2 {
        margin: 0;
    }

    .identity {
        position: relative;
        left: 0;
        right: 0;
    }

    .status {
        text-align: right;
    }

    .status .confidence {
        color: var(--color-neutral-medium);
        font-style: italic;
        font-size: 0.75em;
    }

    .displayclass-status {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .displayclass-status p {
        margin: 0;
    }

    .coords {
        color: var(--color-neutral-medium);
        font-style: italic;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .coords :global(.fa-icon) {
        font-size: 0.75em;
        padding-right: .25em;
        max-width: 1em;
    }

    .coords ul {
        font-size: 0.6em;
        max-width: 4em;
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .locators {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>

<script>
    import { faMapMarker } from '@fortawesome/pro-duotone-svg-icons/';
    import Icon from 'svelte-awesome';

    export let place;
    import PlaceAddress from '../components/PlaceAddress.svelte';
    import PlaceContacts from '../components/PlaceContacts.svelte';
    import PlaceDisplayClassIcon from '../components/PlaceDisplayClassIcon.svelte';

    $: website = place.info.locators.website;
    $: phone = place.info.locators.phone;
</script>

{#if place !== undefined}
<li class="place-list-item">
    <div class="leftside">
        <PlaceDisplayClassIcon place={place} />
        <div class="coords">
            <Icon data={faMapMarker}/>
            <ul>
                <li class="lat">{place.info.locators.lat.toFixed(5)},</li>
                <li class="lon">{place.info.locators.lon.toFixed(5)}</li>
            </ul>
        </div>
    </div>
    <div class="rightside">
        <div class="identity">
            <h2>{place.name}</h2>
            <div class="displayclass-status">
                <p>{place.info.identity.displayClass}</p>
                {#if place.status === 'open'}
                    <p class="status info">Open for business!
                        <span class="confidence">(maybe)</span></p>
                {:else if place.status === 'closed_temp'}
                    <p class="status admonishment">Temporarily closed
                        <span class="confidence">(maybe)</span></p>
                {:else if place.status === 'closed_indeterminate'}
                    <p class="status admonishment">Closed — permanently?
                        <span class="confidence">(maybe)</span></p>
                {:else if place.status === 'closed_permanent'}
                    <p class="status admonishment">Permanently closed
                        <span class="confidence">(maybe)</span></p>
                {:else}
                    <p class="status warning">Maybe open, maybe closed?</p>
                {/if}
            </div>
        </div>
        <div class="locators">
            <div class="physical">
                <PlaceAddress place={place}/>
            </div>
            <div class="contacts">
                <PlaceContacts place={place} textAlign="right"/>
            </div>
        </div>
    </div>
</li>
{/if}
