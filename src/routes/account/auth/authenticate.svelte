<svelte:head>
    <title>eat locals! | Auth</title>
</svelte:head>

<style>
    .authContainer {
        min-width: 100vw;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>

<script>
    import AuthWidget from '@/components/auth/AuthWidget.svelte'
</script>

<div class="authContainer">
    <AuthWidget />
</div>
