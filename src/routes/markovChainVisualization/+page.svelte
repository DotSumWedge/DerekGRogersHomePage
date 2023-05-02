<script lang="ts">
    import { browser } from '$app/environment';
    import { onDestroy } from 'svelte';
    import { Pane } from 'tweakpane';
    import * as PaneEssentials from '@tweakpane/plugin-essentials';
    import ForceGraph3D from '3d-force-graph';

    const myData = {
    nodes: [
        { id: 'A', name: 'Node A' },
        { id: 'B', name: 'Node B' },
        { id: 'C', name: 'Node C' },
        { id: 'D', name: 'Node D' },
        { id: 'E', name: 'Node E' },
        { id: 'F', name: 'Node F' },
        { id: 'G', name: 'Node G' },
        { id: 'H', name: 'Node H' },
        { id: 'I', name: 'Node I' },
        { id: 'J', name: 'Node J' },
        { id: 'K', name: 'Node K' },
        { id: 'L', name: 'Node L' },
        { id: 'M', name: 'Node M' },
        { id: 'N', name: 'Node N' },
        { id: 'O', name: 'Node O' },
        { id: 'P', name: 'Node P' }
    ],
    links: [
        { source: 'A', target: 'B'},
        { source: 'A', target: 'C'},
        { source: 'A', target: 'D'},
        { source: 'B', target: 'C'},
        { source: 'B', target: 'E'},
        { source: 'C', target: 'F'},
        { source: 'D', target: 'G'},
        { source: 'E', target: 'H'},
        { source: 'F', target:'I'},
        { source:'G', target:'J'},
        { source:'H', target:'K'},
        { source:'I', target:'L'},
        { source:'J', target:'M'},
        { source:'K', target:'N'},
        { source:'L', target:'O'},
        { source:'M', target:'P'}
    ]
};

    let myDOMElement: HTMLElement;
    let Graph: ReturnType<typeof ForceGraph3D>;
    let pane;
    const markovChainFile = null;

    // onMount runs after the component is first rendered in the DOM
    import { onMount } from 'svelte';
    onMount(() => {
        Graph = ForceGraph3D()(myDOMElement);
        // pass in your data to the graphData method
        Graph.graphData(myData);
    });

    if(browser){
        pane = new Pane({
            title: 'Markov Chain'
        })

        pane.registerPlugin(PaneEssentials);
        pane.element.style.position = 'fixed';
        pane.element.style.zIndex = '9000';
        pane.element.style.top = '60px';
        pane.element.style.left = '8px';


        const fileSelectionFolder = pane.addFolder({
            title: 'Select File'
        })

        const fileSelectDropDown = fileSelectionFolder.addBlade({
            view: 'list',
            label: 'existing files:',
            options: [
                {text: 'weather.csv', value: ''},
                {text: 'audio.csv', value: ''},
                {text: 'networkState.csv', value: ''},
            ],
            value: 'something',
        })

        const stateAttributesFolder = pane.addFolder({
            title: 'State Attributes'
        })

        const transitionAttributesFolder = pane.addFolder({
            title: 'Transition Attributes and Factors'
        })

        const predictionsFolder = pane.addFolder({
            title: 'Predictions'
        })

        // Provide a link to the github repo
        const documenationButton = pane.addButton({
            title: 'Documentation',
        });

        const homeButton = pane.addButton({
            title: 'Return To Home Page',
        });
    }

    onDestroy(() => {
        if (pane) {
            pane.dispose();
        }
    });
</script>

<svelte:head>
	<title>Markov Chain Visualization</title>
	<meta name="description" content="Takes in event data and creates a 3d visualzation" />
</svelte:head>

<div class="scene" bind:this={myDOMElement}>
</div>

<style>
.scene {
	width: 100%;
	height: 100%;
	position: absolute;
    transform: translate(0px, 50px);
	inset: 0;
	background: radial-gradient(hsl(220 14% 20%), hsl(220 20% 10%));
	background-attachment: fixed;
}
</style>