<script lang="ts">
	import { Canvas, InteractiveObject, OrbitControls, T } from '@threlte/core'
    import * as Threlte from '@threlte/core';
	import * as Three from 'three';
    import { browser } from '$app/environment';
    import { Pane } from 'tweakpane';
    import * as PaneEssentials from '@tweakpane/plugin-essentials';
    import { spring } from 'svelte/motion'
	import { degToRad } from 'three/src/math/MathUtils'
	import * as Utils from 'three/src/math/MathUtils';
    import Header from '../Header.svelte';
    import ForceGraph3D from '3d-force-graph';

    const myData = {
        nodes: [
            { id: 'A', name: 'Node A' },
            { id: 'B', name: 'Node B' },
            { id: 'C', name: 'Node C' }
        ],
        links: [
            { source: 'A', target: 'B' },
            { source: 'B', target: 'C' }
        ]
    };

    let myDOMElement: HTMLElement;
    let Graph: ReturnType<typeof ForceGraph3D>;

    // onMount runs after the component is first rendered in the DOM
    import { onMount } from 'svelte';
    onMount(() => {
        Graph = ForceGraph3D()(myDOMElement);
        // pass in your data to the graphData method
        Graph.graphData(myData);
    });

    const gridHelper = new Three.GridHelper(10, 10)
    const axesHelper = new Three.AxesHelper(10)

    const markovChainFile = null;

    // Example of how to create a curve used as an edge to connect nodes
    const startPoint = new Three.Vector3(0, 0, 0);
    const endPoint = new Three.Vector3(-8, 0, 0);
    const curve = new Three.CatmullRomCurve3([startPoint, endPoint]);

    if(browser){
        const pane = new Pane({
            title: 'Markov Chain'
        })

        pane.registerPlugin(PaneEssentials);
        pane.element.style.position = 'fixed';
        pane.element.style.zIndex = '9000';
        pane.element.style.top = '8px';
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
	const scale = spring(1)
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
	inset: 0;
	background: radial-gradient(hsl(220 14% 20%), hsl(220 20% 10%));
	background-attachment: fixed;
}
</style>