<style>
</style>

<script>
    import PlaceListItem from '../components/PlaceListItem.svelte';

    export let places;
</script>

<ul>
{#each places as place}
    <PlaceListItem place={place} />
{/each}
</ul>
