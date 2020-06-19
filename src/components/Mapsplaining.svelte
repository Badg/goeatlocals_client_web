<script>
    import Icon from 'svelte-awesome';
    import {search} from 'svelte-awesome/icons';

    export let highlightedPlace;
    export let lastPinnedPlace;

    const defaultPlaceName =  'Select a marker to begin';
</script>

<style>
    .mapsplaining {
        pointer-events: auto;
        height: 600px;
        width: 300px;
        background-color: rgb(254, 245, 247);
        color: rgb(40, 15, 0);
/*        background-color: rgb(40, 15, 0);
        color: rgb(254, 245, 247);*/
        padding: 15px;
        border-radius: 10px;
        box-shadow: 7px 7px 15px 5px rgba(0, 0, 0, 0.3);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

/*    .branding {
        display: block;
    }
*/
    .branding h1 {
        color: rgb(146, 26, 29);
        font-size: 3em;
        font-weight: 100;
        margin-top: 0;
    }

    .venue-search-input {
        position: relative;
    }

    .venue-search-input input {
        width: 100%;
        border-radius: 7px;
        padding: .4em 30px .4em .4em;
        margin: 0;
    }

    .venue-search-input .venue-search-button {
        position: absolute;
        right: 10px;
        bottom: .4em;
    }

    h2 {
        color: rgb(100, 22, 0);
        font-weight: 400;
    }

</style>

<div class="mapsplaining">
    <div class="branding"><h1>eat locals!</h1></div>
    <div class="venue-search">
        <div class="venue-search-input">
            <input placeholder="Search (name, food type, whatevs)"/>
            <div class="venue-search-button"><Icon data={search}/></div>
        </div>
        <div class="venue-search-fields">
        </div>
    </div>
    <div class="venue-details">
    {#if
        highlightedPlace !== null && (
            lastPinnedPlace === null ||
            lastPinnedPlace.placeID != highlightedPlace.placeID
        )
    }
        <p>Highlighed: {highlightedPlace.name}</p>
    {:else if lastPinnedPlace !== null}
        <p>Pinned: {lastPinnedPlace.name}</p>
    {:else}
        <ul>
            <li>{defaultPlaceName}</li>
            <li>Neighborhood</li>
            <li>Address <span class="venue-distance">(distance)</span></li>
            <li>URL, phone</li>
            <li>Hours</li>
        </ul>
    {/if}
    </div>
    <div class="anti-exploit">
        <h4>Why <a href="#">no Caviar/Doordash/Postmates/etc.</a> links?</h4>
    </div>
    <div class="feedback">
        <h3><a href="#">Suggestions</a> or <a href="#">corrections?</a></h3>
    </div>
</div>
