<script lang="ts">
	import { onMount } from 'svelte'
	let resumeData: string[][] = [];

	// load in csv file into jsx
	onMount(async () => {
		const response = await fetch('/src/lib/DerekRogersResume.csv');
		const text = await response.text();
		const rows = text.split('\n').slice(1);
		resumeData = rows.map(row => {
			let cells = [];
			let inQuotes = false;
			let currentCell = '';
			for (let i = 0; i < row.length; i++) {
				if (row[i] === '"') {
					inQuotes = !inQuotes;
				} else if (row[i] === ',' && !inQuotes) {
					cells.push(currentCell);
					currentCell = '';
				} else {
					currentCell += row[i];
				}
			}
			cells.push(currentCell);
			// remove unwanted special characters
			return cells.map(cell =>
				cell
					.replace(/[\u200B-\u200D\uFEFF]/g, '')
					.replace(/▪/g, '')
					.replace(/"/g, '')
					.trim()
			);
		});
		// remove the last element as it show up as undefined and the cell that contains links to github and linked in
		resumeData.pop();
		// remove github and linked in line as they are in the header/footer
		resumeData.splice(2, 1);
		// remove trailing commas from the element with the email and phone number
		resumeData[1][0] = resumeData[1][0].replace(/,+$/, "");
		
		//console.log(resumeData);
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
            <div>
                {#if row[4] !== '' && row[4] !== 'undefined'}
                    <h3>{row[4]}</h3>
                {/if}
                <h2>{row[1]}</h2>
            </div>
        {:else}
            {#each row.filter(cell => cell !== '' && cell !== 'undefined') as cell}
                {#if cell.includes(';')}
                    <div>
                        {#each cell.split(';') as item}
                            <p>{item.trim()}</p>
                        {/each}
                    </div>
                {:else}
                    <p>{cell}</p>
                {/if}
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

	h3 {
		margin-right: 10px;
		font-size: 18px;
	}

	p {
		margin-right: 10px;
	}

	div {
		display: flex;
	}
</style>
