<script lang="ts">
	import { onMount } from 'svelte'
	let resumeData;

	onMount(async () => {
    const response = await fetch('/src/lib/DerekRogersResume.csv');
    const text = await response.text();
    const rows = text.split('\n').slice(1);
    resumeData = rows.map(row => {
      const [name, email, phone] = row.split(',');
      return { name, email, phone };
    });
  });
  console.log(resumeData);
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<section>
	<h1>Derek Rogers</h1>

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
