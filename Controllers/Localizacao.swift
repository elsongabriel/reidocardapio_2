//
//  Localizacao.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 27/09/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit
import CoreLocation

var enderecoBusca : EnderecoBusca!
var bairroSelecionado = -1
let cidades = ["Vitória de Santo Antão"]
var userLocation : CLLocation!

class Localizacao: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var btnSelCidade: UIButton!
    @IBOutlet var btnSelBairro: UIButton!
    @IBOutlet var txtEndereco: UITextField!
    @IBOutlet var btnUsarEndereco: UIButton!
    @IBOutlet var btnUsarLocal: UIButton!
    
    var locManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enderecoBusca = EnderecoBusca()
        btnSelCidade.setTitle(cidades[0], forState: UIControlState.Normal)
        btnSelCidade.enabled = false
        enderecoBusca.setCidade(cidades[0])
        enderecoBusca.setBairro("Bairro")

        //serviço de localização
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        userLocation = CLLocation()
        
        //praça da matriz
        //-8.116649, -35.292928
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if bairroSelecionado != -1 {
            btnSelBairro.setTitle(enderecoBusca.getBairro(), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func usarEndereco(sender: AnyObject) {
        
        if validarCampos(){
            
            self.performSegueWithIdentifier("listaRestaurantes", sender: self)
        }else {
            print("Campo errado")
        }
        
    }
    
    func validarCampos() -> Bool{
        if (enderecoBusca.getCidade() != "" && enderecoBusca.getBairro() != ""
            && enderecoBusca.getBairro() != "Bairro"){
                return true
        }
        
        return false
    }
    
    @IBAction func usarLocalizacao(sender: AnyObject) {
//        locManager.delegate = self
//        locManager.desiredAccuracy = kCLLocationAccuracyBest
//        locManager.requestWhenInUseAuthorization()
//        locManager.startUpdatingLocation()
        
        
        
    }

//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if (status == .AuthorizedAlways || status == .AuthorizedWhenInUse){
//            locManager.startUpdatingLocation()
//        }else{
//            print("Localização não foi permitida!")
//        }
//    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
//        userLocation = locations[0] as! CLLocation
//        let coord = userLocation.coordinate
//                    print(coord)
    }
    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)-&gt;Void in
//            if error {
//                println("Reverse geocoder failed with error" + error.localizedDescription)
//                return
//            }
//            
//            if placemarks.count &gt; 0 {
//                let pm = placemarks[0] as CLPlacemark
//                self.displayLocationInfo(pm)
//            } else {
//                println("Problem with the data received from geocoder")
//            }
//        })
//    }
    
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        userLocation = locations[0]
//        
//        if userLocation != nil {
//            locManager.stopUpdatingLocation()
//            let coord = userLocation.coordinate
//            print(coord)
//        }
//        
////        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
////            if error != nil{
////                print(error)
////            }else{
////                let place = placemarks?[0]
////                let userPlacemark = CLPlacemark(placemark: place!)
////                print("endereço: \(userPlacemark.subLocality!) \(userPlacemark.subAdministrativeArea!) \(userPlacemark.postalCode!) \(userPlacemark.country!)")
////            }
////        }
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
