<style>
    .contacts span {
        display: block;
    }

    .contacts .unknown {
        color: var(--color-neutral-medium);
        font-style: italic;
    }

    p {
        margin: 0;
    }
</style>

<script>
    export let place;
    export let textAlign = 'left';

    $: website = place.info.locators.website;
    $: phone = place.info.locators.phone;
</script>

{#if place !== undefined}
<p class="contacts" style="text-align:{textAlign};">
    <span
        class="website" class:unknown="{website === null}"
        >{#if website}
            Has a <a href="{website}">website!</a>
        {:else}
            Website unknown
        {/if}</span>
    <span class="phone" class:unknown="{phone === null}">{
        phone || 'Phone unknown'}</span>
</p>
{/if}
