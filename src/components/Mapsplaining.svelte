<style>
    .unpin-all {
        pointer-events: auto;
    }

    .mapsplaining {
        pointer-events: auto;
        height: 600px;
        width: 300px;
        background-color: rgb(254, 245, 247);
        color: rgb(40, 15, 0);
/*        background-color: rgb(40, 15, 0);
        color: rgb(254, 245, 247);*/
        padding: 15px;
        border-radius: 0 0 10px 0;
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

<script>
    import Icon from 'svelte-awesome';
    import {search} from 'svelte-awesome/icons';

    export let unpinAll;

    export function highlightPlace(place) {
        let overriddenHighlightedPlace = highlightedPlace;
        highlightedPlace = place;
        return overriddenHighlightedPlace;
    };

    export function unhighlightPlace() {
        highlightedPlace = null;
    };

    export function pinPlace(place) {
        // Updating the value will trigger a DOM update, so only do this if
        // we actually updated
        if (
            lastPinnedPlace === null ||
            lastPinnedPlace.placeID !== place.placeID
        ) {
            lastPinnedPlace = place;

            // With touch events, sometimes the place we just pinned wasn't the
            // same as the one we have highlighted. In that case, we want to go
            // ahead and reset the highlight on the other place.
            if (
                highlightedPlace !== null &&
                place.placeID !== highlightedPlace.placeID
            ) {
                // Note that this will chain-call into unhighlightPlace() above
                // so we don't need to call it directly. This is admittedly a
                // bit gross
                highlightedPlace.unhighlight();
            }
        }
    };

    export function unpinPlace(place) {
        if ( 
            lastPinnedPlace !== null &&
            lastPinnedPlace.placeID === place.placeID
        ) {
            lastPinnedPlace = null;
        }
    };

    const defaultPlaceName =  'Select a marker to begin';

    let highlightedPlace = null;
    let lastPinnedPlace = null;
</script>

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
<div class="unpin-all">
    <button on:click={unpinAll}>Unpin all</button>
</div>
