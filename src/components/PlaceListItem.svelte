<style>

    li.place-list-item {
        background-color: var(--color-background-bright);
        filter: drop-shadow(.2em .2em .3em var(--color-shadows-subtle));
        border-width: 1px 0 0 1px;
        border-style: solid;
        border-color: var(--color-neutral-lightest);
        border-radius: 2px 0 2em 0;
        display: flex;
        justify-content: space-between;
        align-content: stretch;
        padding: .75em 1em;
        max-width: 100%;
        min-width: 48%;
        margin: 0.5em 1%;
        box-sizing: border-box;
        flex-grow: 1;
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

    .status.unknown {
        color: var(--color-neutral-medium);
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

    .display-class-name.unknown {
        color: var(--color-neutral-medium);
    }

    .coords-container {
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

    a.coords {
        font-weight: 400;
        font-style: italic;
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
        <a class="coords" href="https://www.openstreetmap.org/node/{place.osmID}">
            <div class="coords-container">
                <Icon data={faMapMarker}/>
                <ul>
                    <li class="lat">{place.info.locators.lat.toFixed(5)},</li>
                    <li class="lon">{place.info.locators.lon.toFixed(5)}</li>
                </ul>
            </div>
        </a>
    </div>
    <div class="rightside">
        <div class="identity">
            <h2>{place.name}</h2>
            <div class="displayclass-status">
                <p>
                    Primarily a <span class="display-class-name"
                        class:unknown="{!place.info.identity.displayClass}">
                    {#if place.info.identity.displayClass === 'grocery'}
                        grocery store
                    {:else if place.info.identity.displayClass === 'prepared_food'}
                        restaurant
                    {:else if place.info.identity.displayClass === 'light_bar'}
                        bar
                    {:else if place.info.identity.displayClass === 'full_bar'}
                        bar (full)
                    {:else}
                        ...something?
                    {/if}
                </span></p>
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
                    <p class="status warning unknown">Business status unknown</p>
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
