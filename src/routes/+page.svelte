<script lang="ts">
	import { onMount } from 'svelte'
	let resumeData: string[][] = [];

	onMount(async () => {
		const response = await fetch('/src/lib/DerekRogersResume.csv');
		const text = await response.text();
		const rows = text.split('\n').slice(1);
		resumeData = rows.map(row =>
			row
			.split(',')
			.map(cell =>
			cell
				.replace(/[\u200B-\u200D\uFEFF]/g, '')
				.replace(/▪/g, '')
				.replace(/"/g, '')
				.trim()
			)
		);
		resumeData.pop();
	});
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<section>
	<h1>Derek Rogers</h1>
	{#each resumeData as row}
		{#if row[0] !== '' && row[0] !== 'undefined'}
			{#if row[0] === 'SUMMARY' || row[0] === 'EDUCATION' || row[0] === 'WORK EXPERIENCE'}
				<h1>{row[0]}</h1>
			{:else}
				<p>{row[0]}</p>
			{/if}
		{:else if row[1] !== '' && row[1] !== 'undefined'}
			<h2>{row[1]}</h2>
			{#if row[4] !== '' && row[4] !== 'undefined'}
				<p>{row[4]}</p>
			{/if}
		{:else}
			{#each row.filter(cell => cell !== '' && cell !== 'undefined') as cell}
				<p>{cell}</p>
			{/each}
		{/if}
  	{/each}
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}

	h1 {
		width: 100%;
	}
</style>
