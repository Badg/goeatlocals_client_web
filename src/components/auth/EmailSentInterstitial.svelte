<style>
    .textbox {
        min-height: 5em;
        display: inline-block;
        text-align: center;
        box-sizing: border-box;
        width: 100%;
    }
</style>

<script>
    import { createEventDispatcher } from 'svelte';
    import { fly } from 'svelte/transition';

    export let email;

    const dispatch = createEventDispatcher();
    const resendEvent = 'initiateResendEmail';
    const reenterEvent = 'initiateReenterEmail';
</script>

<div class="textbox" in:fly="{{ x: 200, duration: 250 }}">
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
    <h3>Wrong email address or password?
        <a href="#"
            on:click|preventDefault={() => dispatch(reenterEvent)}>
            Click here to go back.</a>
    </h3>
</div>
