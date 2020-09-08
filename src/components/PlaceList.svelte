<style>
    ul {
        list-style-type: none;
        padding: 0;
        display: flex;
        flex-wrap: wrap;
        justify-content: stretch;
        align-items: center;
        align-content: center;
    }
</style>

<script>
    import { tick, onMount } from 'svelte';

    import PlaceListItem from '@/components/PlaceListItem.svelte';

    export let places = [];
    const placeChunkSize = 25;
    let placesToRender = [];

    async function chunkPlaces(places) {
        placesToRender = [];
        let windowStart = 0;
        let windowEnd;

        while (placesToRender.length < places.length) {
            windowEnd = Math.max(windowStart + placeChunkSize, places.length);
            placesToRender.push(...places.slice(windowStart, windowEnd));
            await tick();
            windowStart = windowEnd;
        }
    }

    $: chunkPlaces(places);


</script>

<ul>
{#each placesToRender as place}
    <PlaceListItem place={place} />
{/each}
</ul>
