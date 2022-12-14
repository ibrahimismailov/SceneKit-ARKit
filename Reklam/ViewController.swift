//
//  ViewController.swift
//  Reklam
//
//  Created by Abraam on 22.11.2022.
//

import UIKit
import SceneKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsPapperImages", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
            configuration.maximumNumberOfTrackedImages = 1
        }
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let videoNode = SKVideoNode(fileNamed: "levis.mp4")
            videoNode.play()
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            videoScene.addChild(videoNode)
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            videoNode.yScale = -1.0
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = videoScene
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            print("hello")
        }
        return node
    }
}
