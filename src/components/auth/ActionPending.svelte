<style>
    .textbox {
        min-height: 5em;
        display: inline-block;
        text-align: center;
        box-sizing: border-box;
        width: 100%;
    }

    .pending {
        padding: 1.5em 0;
        font-size: 2em;
    }
</style>

<script>
    import { fly } from 'svelte/transition';
    import Icon from 'svelte-awesome';
    import { faSpinner } from '@fortawesome/pro-duotone-svg-icons/';
</script>

<div class="textbox pending" in:fly="{{ x: 200, duration: 250 }}">
    <Icon data={faSpinner} scale="2" pulse/>
</div>
