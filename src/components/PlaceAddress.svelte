<style>
    p {
        margin: 0;
    }

    .line1, .line2, .line3 {
        display: block;
    }

    .unknown {
        color: var(--color-neutral-medium);
        font-style: italic;
    }
</style>

<script>
    export let place;
    export let textAlign = 'left';

    // TODO: unitNumber, neighborhood, country
    $: streetNumber = place.info.locators.address.streetNumber;
    $: streetName = place.info.locators.address.streetName;
    $: city = place.info.locators.address.city;
    $: state = place.info.locators.address.state;
    $: postalCode = place.info.locators.address.postalCode;
</script>

{#if place !== undefined}
<p class="address" style="text-align:{textAlign};">
    <span class="line1">
        <span
            class:unknown="{streetNumber === null}"
            aria-label="{streetNumber || 'Unknown number'}"
            >{streetNumber || '123'}</span>
        <span
            class:unknown="{streetName === null}"
            aria-label="{streetName || 'Unknown street'}"
            >{streetName || 'Example St'}</span>
    </span>
    <!-- <span class="line2"></span> -->
    <span class="line3">
        <span
            class:unknown="{city === null}"
            aria-label="{city || 'Unknown city'}"
            >{city || 'Examplesville'}</span>,
        <span
            class:unknown="{state === null}"
            aria-label="{state || 'Unknown state'}"
            >{state || 'CA'}</span> 
        <span
            class:unknown="{postalCode === null}"
            aria-label="{postalCode || 'Unknown postal code'}"
            >{postalCode || '12345'}</span>
    </span>
</p>
{/if}
