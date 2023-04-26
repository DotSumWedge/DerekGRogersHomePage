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
		// remove the last element as it show up as undefined and the cell that contains links to github and linked in
		resumeData.pop();
		resumeData.splice(2, 1);
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
            <div style="display: flex;">
                {#if row[4] !== '' && row[4] !== 'undefined'}
                    <h3 style="margin-right: 10px;">{row[4]}</h3>
                {/if}
                <h2>{row[1]}</h2>
            </div>
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

	h2 {
		color: #174ae4;
	}
</style>
