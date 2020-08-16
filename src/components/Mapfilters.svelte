<style>
    .mapfilters-flex {
        display: flex;
        align-items: center;
        background-color: var(--color-neutral-lightest);
        color: var(--color-neutral-darkest);
        box-shadow: 7px 7px 15px 5px rgba(0, 0, 0, 0.3);
        border-radius: 0 0 0 10px;
        padding: 5px;
        pointer-events: auto;
    }

    .mapfilters-flex > *:first-child {
        margin-left: 50px;
    }

    .mapfilters-flex > * {
        margin-right: 50px;
    }

    .mapfilter {
        padding: 15px;
        border-radius: 10px;
    }

    .label {
        color: var(--color-red-medium);
    }
</style>

<script>
</script>

<div class="mapfilters-flex">
    <div class="label">Filters:</div>
    <div class="mapfilter">Food</div>
    <div class="mapfilter">Booze</div>
    <div class="mapfilter">Beer/Wine</div>
    <div class="mapfilter">Provisions</div>
</div>
