<style>
    form.auth {
        display: inline-block;
        text-align: center;
        box-sizing: border-box;
        width: 100%;
    }

    form.auth > * {
        margin-left: auto;
        margin-right: auto;
    }

    .labeledInput {
        text-align: left;
    }

    input {
        /* For the 3% or so of browsers that don't support the ch unit, we'll
            just use the default width as a fallback. Otherwise, use the ch
            unit, which will be an *approximate* number of characters
            to show in the box before sliding out-of-frame*/
        width: 100%;
        box-sizing: border-box;
        font-size: 1.2em;
        z-index: 5;
        display: block;
        text-align: center;
    }

    input[type=text].warn {
        box-shadow: 0 0 5px var(--color-red-medium);
        border: 1px solid var(--color-red-medium);
    }

    label, input {
        background-color: white;
        position: relative;
    }

    label {
        display: inline-block;
        z-index: 7;
        text-align: left;
        font-size: .8em;
        padding: 0 .4em;
        margin-left: 10%;
        bottom: -3px;
    }

    .required::after {
        content: "*";
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
    import { onMount } from 'svelte';
    import EmailValidator from 'email-validator';

    export let email;
    let password;

    const dispatch = createEventDispatcher();
    const submitEvent = 'authSubmit';
    const emailDesc = 'email ("magic link")';
    const passDesc = 'password';

    let emailValid = false;
    // Have this be initially false so that we don't glare in the user's face
    // before they've done anything
    let emailWarn = false;

    $: authStyle = password ? passDesc : emailDesc;

    onMount(async () => {
        if (email) {
            validate();
        }
    });

    function validateAndDispatch(evt) {
        validate();
        if (emailValid){
            dispatch(submitEvent, {
                email: email,
                password: password
            });
        }
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
    <div class="labeledInput">
        <label for="email" class="required">Email:</label>
        <input
            class="email"
            type="text"
            id="email" name="email"
            placeholder="your.email@example.com"
            class:warn={emailWarn}
            bind:value={email}
            on:input={validate}/>
    </div>
    <div class="labeledInput">
        <label for="password">Password:</label>
        <input
            class="password"
            type="password"
            id="password" name="password"
            bind:value={password} />
    </div>
    <button
        type="submit"
        class="submit"
        disabled={!emailValid}
        on:click={validateAndDispatch}>
            <h3 class="actionTitle">Login or register</h3>
            <p class="authStyleDescription">with {authStyle}</p>
    </button>
</form>
