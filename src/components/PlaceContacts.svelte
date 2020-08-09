<style>
</style>

<script>
    export let place;

    $: website = place.info.locators.website;
    $: phone = place.info.locators.phone;
</script>

{#if place !== undefined}
<p class="contacts">
    <span class="website" class:unknown="{website === null}">{
        website || 'Website unknown'}</span>
    <span class="phone" class:unknown="{phone === null}">{
        phone || 'Phone unknown'}</span>
</p>
{/if}
