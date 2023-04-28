<script lang="ts">
	import { SvelteComponentTyped } from 'svelte';
	import Image from 'src/lib/images/bloomSkillGraphVisualization.png';

	interface MyImageProps {
	src: string;
	alt: string;
	}

	class MyImage extends SvelteComponentTyped<MyImageProps> {}
	// let files;
	//<label for="many">Upload markov chain data file (.csv):</label>
	//<input id="markovChainDataFile" type="file" bind:files/>
</script>

<svelte:head>
	<title>About</title>
	<meta name="description" content="About this app" />
</svelte:head>

<MyImage src={Image} alt="image" />
