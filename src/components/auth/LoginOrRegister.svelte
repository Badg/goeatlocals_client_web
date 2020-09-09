<style>
    form.auth {
        display: inline-block;
        padding: 1em;
        text-align: center;
        box-sizing: border-box;
        max-width: 100%;
    }

    input {
        /* For the 3% or so of browsers that don't support the ch unit, we'll
            just use the default width as a fallback. Otherwise, use the ch
            unit, which will be an *approximate* number of characters
            to show in the box before sliding out-of-frame*/
        width: 50ch;
        box-sizing: border-box;
        max-width: 100%;
    }

    input[type=text].warn {
        box-shadow: 0 0 5px var(--color-red-medium);
        border: 1px solid var(--color-red-medium);
    }

    form.auth > * {
        display: block;
        text-align: center;
        margin-left: auto;
        margin-right: auto;
    }

    label, button {
        text-transform: lowercase;
    }

    button {
        padding: .25em 1em;
    }

    button > * {
        margin: 0;
    }

    p.authStyleDescription {
        font-style: italic;
    }
</style>

<script>
    import { createEventDispatcher } from 'svelte';
    import EmailValidator from 'email-validator';

    export let email;
    export let password;

    const dispatch = createEventDispatcher();
    const submitEvent = 'authSubmit';
    const emailDesc = 'email ("magic link")';
    const passDesc = 'password';

    let emailValid = false;
    // Have this be initially false so that we don't glare in the user's face
    // before they've done anything
    let emailWarn = false;

    $: authStyle = password ? passDesc : emailDesc;

    function validateAndDispatch(evt) {
        validate();
        if (emailValid){ dispatch(submitEvent); }
    }

    function validate() {
        if ( EmailValidator.validate(email) ){
            emailValid = true;
            emailWarn = false;
            return true;

        } else {
            emailWarn = true;
            emailValid = false;
            return false;
        }
    }
</script>

<form class="auth" action="javascript:void(0);">
    <label for="email">Email:</label>
    <input
        class="email"
        type="text"
        id="email" name="email"
        placeholder="your.email@example.com"
        class:warn={emailWarn}
        bind:value={email}
        on:input={validate}/>
    <label for="password">Password:</label>
    <input
        class="password"
        type="password"
        id="password" name="password"
        bind:value={password} />
    <button
        type="submit"
        class="submit"
        disabled={!emailValid}
        on:click={validateAndDispatch}>
            <h3 class="actionTitle">Login or register</h3>
            <p class="authStyleDescription">with {authStyle}</p>
    </button>
</form>
