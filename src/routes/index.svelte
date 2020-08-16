<svelte:head>
    <title>eat locals!</title>
</svelte:head>

<script>
    import { onMount } from 'svelte';
    import { goto } from '@sapper/app';
    onMount(() => goto('/list', {replaceState: true}));
</script>
