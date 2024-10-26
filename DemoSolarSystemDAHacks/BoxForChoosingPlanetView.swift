import SwiftUI
import SceneKit

struct BoxForChoosingPlanetView: View {
	@State var celestialObject: String
	@State var typeOfView: String

	var body: some View {
		ZStack(alignment: .bottomLeading) {
			PlanetSceneView(typeofView: typeOfView, isZoomed: .constant(false))
				.frame(width: 150 , height: 150)
				.clipShape(Circle())
				.offset(x: 6, y: 35)
			

			Text(celestialObject)
				.font(.title)
				.fontWeight(.bold)
				.frame(width: 100, height: 100, alignment: .topLeading)
				.padding()
				.foregroundStyle(Color.white.opacity(0.8))
				.background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2)))
		}
		.padding()
	}
}

struct PlanetSceneView: UIViewRepresentable {
	@State var typeofView: String
	@Binding var isZoomed: Bool
	func makeUIView(context: Context) -> SCNView {
		let sceneView = SCNView()
		sceneView.scene = createPlanetScene(for: typeofView)
		sceneView.allowsCameraControl = true
		sceneView.backgroundColor = UIColor.clear
		return sceneView
	}
	
	func updateUIView(_ uiView: SCNView, context: Context) {
		if let planetNode = uiView.scene?.rootNode.childNode(withName: "planetNode", recursively: true) {
			let scale = isZoomed ? 1.2 : 1.0 // Scale up when zoomed
			planetNode.runAction(SCNAction.scale(to: scale, duration: 0.2))
		}
	}
	
	func createPlanetScene(for textureName: String) -> SCNScene {
		let scene = SCNScene()
		
		// Add a 3D Planet node
		let planetNode = SCNNode(geometry: SCNSphere(radius: 1.0))
		planetNode.name = "planetNode"
		let planetMaterial = SCNMaterial()
		planetMaterial.diffuse.contents = UIImage(named: typeofView)
		planetNode.geometry?.materials = [planetMaterial]
		
		// Rotate the planet to face California (earth only)
		planetNode.eulerAngles.y = Float(90 * Float.pi / 180)
		
		scene.rootNode.addChildNode(planetNode)
		
		// Add a light source
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light?.type = .omni
		lightNode.light?.intensity = 1500
		lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
		scene.rootNode.addChildNode(lightNode)
		
		// Add a camera
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
		scene.rootNode.addChildNode(cameraNode)
		
		return scene
	}
}

#Preview {
	BoxForChoosingPlanetView(celestialObject: "Earth", typeOfView: "earthTexture")
}

