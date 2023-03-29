<script lang="ts">
	import Counter from '../Counter.svelte';
	let files;
</script>

<svelte:head>
	<title>About</title>
	<meta name="description" content="About this app" />
</svelte:head>

<div class="text-column">
	<h1>Place to learn about and test ideas</h1>

	<label for="many">Upload markov chain data file (.csv):</label>
	<input id="markovChainDataFile" type="file" bind:files/>
	
	<h1>
		Data Visualization
	</h1>
	<Counter />
</div>
