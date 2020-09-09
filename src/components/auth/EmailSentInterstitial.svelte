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
    import { createEventDispatcher } from 'svelte';
    import Icon from 'svelte-awesome';
    import { faSpinner } from '@fortawesome/pro-duotone-svg-icons/';

    export let email;
    export let pending = true;

    const dispatch = createEventDispatcher();
    const resendEvent = 'initiateResendEmail';
    const reenterEvent = 'initiateReenterEmail';
</script>

<div class="textbox" class:pending={pending}>
{#if pending}
    <Icon data={faSpinner} scale="2" pulse/>
{:else}
    <h2>Check your email!</h2>
    <p>
        We sent a message with further instructions to
        <span class="email">{email}</span>.
    </p>
    <h3>Didn't get it?
        <a href="#"
            on:click|preventDefault={() => dispatch(resendEvent)}>
            Click here to re-send.</a>
    </h3>
    <h3>Wrong email address?
        <a href="#"
            on:click|preventDefault={() => dispatch(reenterEvent)}>
            Click here to go back.</a>
    </h3>
{/if}
</div>
