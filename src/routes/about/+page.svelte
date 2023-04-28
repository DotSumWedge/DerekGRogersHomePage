<script lang="ts">
	import Image from '$lib/images/skillGraph.png';
</script>

<svelte:head>
	<title>About</title>
	<meta name="description" content="About this app" />
</svelte:head>


<img src={Image} alt="image" />

  
<style>
	img {
		transform: scale(1.3);
		transform-origin: top center;
	}
</style>
