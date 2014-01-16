
window.Cornery = {}

Cornery.loader = (->

  # camera, scene, renderer, geometry, material, mesh
  stats = new Stats();

  CONST = {
    cubesize : 50,
    hobo : 0x80, # highest order bit only AKA MSB, used for bitshifting down
  }

	initialize: () -> 
    stats.getDomElement().style.position = 'fixed';
    stats.getDomElement().style.right = '0px';
    stats.getDomElement().style.top = '0px';
    
    document.body.appendChild( stats.getDomElement() );
    document.addEventListener( 'mousemove', onDocumentMouseMove, false );

    mouseX = 0
    mouseY = 0
    windowHalfX = window.innerWidth / 2;
    windowHalfY = window.innerHeight / 2;
    
    setInterval( -> 
      stats.update();
    , 1000 / 60 );

    ## start animation
    init();
    animate();

    treeId = 0;
    levelsToGo = 1;

  init: () -> 
    scene = new THREE.Scene()

    camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 10000 );
    camera.position.z = -1000;
    scene.add( camera );

    geometry = new THREE.CubeGeometry( 100, 100, 100 ); #// these params affect the size of the cube, not the position
    # // MeshBasicMaterial default worked well with wireframe
    # // MeshPhongMaterial required options are not clear to me
    material = new THREE.MeshLambertMaterial( { color: 0xCCC0C0 }); #//new THREE.MeshBasicMaterial( { color: 0xfff000, blending: true } );

    oct = new Octree(1, 1);
    
    mesh = new THREE.Mesh( geometry, material );
    # /////////////////////////////////scene.add( mesh );

    # // create a point light
    pointLight = new THREE.PointLight( 0xFFFFFF );
    pointLight2 = new THREE.PointLight( 0xFFFFFF );

    # // set its position
    pointLight.position.x = 10;
    pointLight.position.y = 50;
    pointLight.position.z = 150;
    pointLight2.position.x = -450;
    pointLight2.position.y = 300;
    pointLight2.position.z = -300;

    # // add to the scene
    scene.add(pointLight);
    scene.add(pointLight2);

    renderer = new THREE.WebGLRenderer();#//.CanvasRenderer(); //THREE.WebGLRenderer();
    renderer.setSize( window.innerWidth, window.innerHeight );

    renderer.domElement.style.position = 'fixed';
    document.body.appendChild( renderer.domElement );
  
  loadGrid: ->  
    yggdrasil = new Octree(2, "EF")
    THREE.SceneUtils.traverseHierarchy( yggdrasil, ( octant ) ->
      octant.rotation.x = rx
      octant.rotation.y = ry
      object.rotation.z = rz
    )

  onDocumentMouseMove: (event) ->
    mouseX = ( event.clientX - windowHalfX ) * 10
    mouseY = ( event.clientY - windowHalfY ) * 10
  
  animate: () ->
    # // note: three.js includes requestAnimationFrame shim
    requestAnimationFrame( animate );
    render()

  render: () ->
    # // update camera position based on input
    camera.position.x += ( mouseX - camera.position.x ) * 0.05;
    camera.position.y += ( - mouseY - camera.position.y ) * 0.05;
    camera.lookAt( scene.position );
    
    renderer.render( scene, camera );

)()
