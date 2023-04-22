<script lang="ts">
	import Counter from '../Counter.svelte';
	let files;
	let digit = "01";
	// TODO: pressing a button:
	// - displays 4 random numbers that are 2 digits (ie 04 or 40)
	// - Changes the background color and the digit text color
</script>

<svelte:head>
	<title>About</title>
	<meta name="description" content="About this app" />
</svelte:head>

<div class="text-column">
	<label for="many">Upload markov chain data file (.csv):</label>
	<input id="markovChainDataFile" type="file" bind:files/>
	
	<h1>
		Data Visualization
	</h1>

	<Counter />

	<button>Digit Randomizer</button>
	<h1>{digit}</h1>
</div>
