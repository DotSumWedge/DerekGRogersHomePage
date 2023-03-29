<script lang="ts">
	import { Canvas, InteractiveObject, OrbitControls, T } from '@threlte/core'
    import * as Threlte from '@threlte/core';
	import * as Three from 'three';
    import { browser } from '$app/environment';
    import { Pane } from 'tweakpane';
    import { spring } from 'svelte/motion'
	import { degToRad } from 'three/src/math/MathUtils'
	import * as Utils from 'three/src/math/MathUtils';
    import Header from '../Header.svelte';

    const gridHelper = new Three.GridHelper(40, 40)
    const axesHelper = new Three.AxesHelper(20)

    const markovChainFile = null;

    // Example of how to create a curve used as an edge to connect nodes
    const startPoint = new Three.Vector3(0, 0, 0);
    const endPoint = new Three.Vector3(-8, 0, 0);
    const curve = new Three.CatmullRomCurve3([startPoint, endPoint]);

    if(browser){
        const pane = new Pane({
            title: 'Markov Chain'
        })
        pane.element.style.position = 'fixed';
        pane.element.style.zIndex = '9000';
        pane.element.style.top = '8px';
        pane.element.style.left = '8px';
    }
	const scale = spring(1)
</script>

<svelte:head>
	<title>Markov Chain Visualization</title>
	<meta name="description" content="Takes in event data and creates a 3d visualzation" />
</svelte:head>

<div class="scene">
	<Threlte.Canvas>
        <!-- Overlay grid and axis elements -->
        <Threlte.Object3DInstance object = {gridHelper} />
        <Threlte.Object3DInstance object = {axesHelper} />

        <!-- Camera -->
        <Threlte.PerspectiveCamera 
            position={{ x: 20, y: 20, z: 20 }} 
            fov={50}>
            <!-- Controls -->
            <Threlte.OrbitControls/>
        </Threlte.PerspectiveCamera>

        <!-- Lights the scene equally -->
        <Threlte.AmbientLight color="white" intensity={0.6} />

        <!-- Light that casts a shadow -->
        <Threlte.DirectionalLight
            color="yellow"
            intensity={0.4}
            position={{ x: 20, y: 5 }}
            shadow={{
                camera: { top: 8},
            }}
        />

        <!-- Sphere -->
        <Threlte.Mesh
            geometry={new Three.SphereGeometry(4, 64, 64)}
            material={new Three.MeshStandardMaterial({ color: 'purple' })}
            position={{ y: 4 }}
            receiveShadow
            castShadow
        />

        <!-- Node -->
        <Threlte.Mesh
            geometry={new Three.SphereGeometry(4, 64, 64)}
            material={new Three.MeshStandardMaterial({ color: 'yellow' })}
            position={{ x: 14, y:4 }}
            receiveShadow
            castShadow
        />

        <!-- Edge -->
        <Threlte.Mesh
            geometry={new Three.TubeGeometry(curve, 20, 1, 8, false)}
            material={new Three.MeshStandardMaterial({ color: 'red' })}
            position={{ x: 11, y:4 }}
            receiveShadow
            castShadow
        />

        <!-- Floor -->
        <Threlte.Mesh
            geometry={new Three.PlaneGeometry(40, 40)}
            material={new Three.MeshStandardMaterial({
            color: 'brown',
            side: Three.DoubleSide,
            })}
            rotation={{ x: Utils.DEG2RAD * 90 }}
            receiveShadow
        />
	</Threlte.Canvas>
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