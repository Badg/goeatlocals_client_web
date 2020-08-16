<style>
    .display-class-container {
        width: 2em;
        height: 2em;
        background: var(--color-neutral-dark);
        color: var(--color-neutral-lightest);
        border-radius: 50%;
        font-size: 1.75em;
        display: inline-flex;
        justify-content: center;
        align-items: center;
    }

    .twoup {
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: .5em;
        width: 100%;
        height: 100%;
        overflow: show;
    }

</style>

<script>
    import Icon from 'svelte-awesome';
    import { faShoppingCart, faQuestion, faGlass, faWineGlass, faCocktail,
             faUtensilsAlt } from '@fortawesome/pro-solid-svg-icons/';
    import { faSpinner } from '@fortawesome/pro-duotone-svg-icons/';

    export let place;

    const twoferScale = 1.75;
    const normalScale = 2;
</script>

<div class="display-class-container">
    {#if place}
        {#if place.info.identity.displayClass === 'grocery' }
            <Icon data={faShoppingCart} scale="{normalScale}"/>

        {:else if place.info.identity.displayClass === 'prepared_food' }
            <Icon data={faUtensilsAlt} scale="{normalScale}"/>

        {:else if place.info.identity.displayClass === 'light_bar' }
            <span class="twoup">
                <Icon data={faGlass} scale="{twoferScale}"/>
                <Icon data={faWineGlass} scale="{twoferScale}"/>
            </span>

        {:else if place.info.identity.displayClass === 'full_bar' }
            <Icon data={faCocktail} scale="{normalScale}"/>

        {:else}
            <Icon data={faQuestion} scale="{normalScale}"/>

        {/if}

    {:else}
    <Icon data={faSpinner} scale="{normalScale}" pulse/>
    {/if}
</div>
