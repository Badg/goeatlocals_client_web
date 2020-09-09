<style>
    .authWidgetContainer {
        width: 50ch;
        max-width: 100%;
        box-sizing: border-box;
        padding: 1em;
    }
</style>

<script>
    import LoginOrRegister from '@/components/auth/LoginOrRegister.svelte';
    import EmailSentInterstitial from '@/components/auth/EmailSentInterstitial.svelte';

    let email;
    let emailPending;
    let authState;

    function handleAuthSubmit(evt) {
        console.log('Submit pressed!');
        email = evt.detail.email;
        authState = 'emailSent';
        emailPending = false;
    }

    function handleResendEmail(evt) {
        console.log('Need to resend email!');
        emailPending = true;
    }

    function handleReenterEmail(evt) {
        console.log('Need to reenter email!');
        authState = null;
        emailPending = false;
    }
</script>

<div class="authWidgetContainer">
    {#if authState === 'emailSent'}
        <EmailSentInterstitial
            email={email}
            pending={emailPending}
            on:initiateReenterEmail={handleReenterEmail}
            on:initiateResendEmail={handleResendEmail} />
    {:else}
        <LoginOrRegister email={email} on:authSubmit={handleAuthSubmit} />
    {/if}
    
</div>
