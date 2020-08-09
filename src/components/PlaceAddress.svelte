<style>
</style>

<script>
    export let place;

    // TODO: unitNumber, neighborhood, country
    $: streetNumber = place.info.locators.address.streetNumber;
    $: streetName = place.info.locators.address.streetName;
    $: city = place.info.locators.address.city;
    $: state = place.info.locators.address.state;
    $: postalCode = place.info.locators.address.postalCode;
</script>

{#if place !== undefined}
<p class="address">
    <span class="line1">
        <span class:unknown="{streetNumber === null}">{streetNumber || '???'}</span>
        <span class:unknown="{streetName === null}">{streetName || 'Unknown St'}</span>
    </span>
    <!-- <span class="line2"></span> -->
    <span class="line3">
        <span class:unknown="{city === null}">{city || 'Unknown city'}</span>,
        <span class:unknown="{state === null}">{state || 'Unknown state'}</span> 
        <span class:unknown="{postalCode === null}">{postalCode || '?????'}</span>
    </span>
</p>
{/if}
