<style>
    .authWidgetContainer {
        width: 50ch;
        max-width: 100%;
        box-sizing: border-box;
        padding: 1em;
    }
</style>

<script>
    import {
        Authenticated,
        LoginOrRegister,
        ActionPending,
        EmailSentInterstitial
    } from '@/components/auth/';
    import { awaitSleep } from '@/modules/utils.mjs';

    let email;
    let authState;

    async function handleAuthSubmit(evt) {
        console.log('Submit pressed!');
        email = evt.detail.email;
        authState = 'actionPending';
        await awaitSleep(250);
        authState = 'emailInterstitial';
        await awaitSleep(1400);
        authState = 'authenticated';
    }

    async function handleResendEmail(evt) {
        console.log('Need to resend email!');
        authState = 'actionPending';
        await awaitSleep(1400);
        authState = 'emailInterstitial';
    }

    async function handleReenterEmail(evt) {
        console.log('Need to reenter email!');
        authState = null;
    }

    async function handleLogout(evt) {
        console.log('Logging out!');
        authState = null;
    }
</script>

<div class="authWidgetContainer">
    {#if authState === 'emailInterstitial'}
        <EmailSentInterstitial
            email={email}
            on:initiateReenterEmail={handleReenterEmail}
            on:initiateResendEmail={handleResendEmail} />
    {:else if authState === 'actionPending'}
        <ActionPending />
    {:else if authState === 'authenticated'}
        <Authenticated email={email} on:initiateLogout={handleLogout} />
    {:else}
        <LoginOrRegister email={email} on:authSubmit={handleAuthSubmit} />
    {/if}
    
</div>
