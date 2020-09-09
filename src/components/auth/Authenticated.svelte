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
    const logoutEvent = 'initiateLogout';
</script>

<div class="textbox" in:fly="{{ x: 200, duration: 250 }}">
    <h2>Successfully authenticated!</h2>
    <p>
        You're logged in as <span class="email">{email}</span>.
    </p>
    <button on:click="{evt => {dispatch(logoutEvent);}}">Logout</button>
</div>
