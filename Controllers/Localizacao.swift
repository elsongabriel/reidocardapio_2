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

class Localizacao: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var btnSelCidade: UIButton!
    @IBOutlet var btnSelBairro: UIButton!
    @IBOutlet var txtEndereco: UITextField!
    @IBOutlet var btnUsarEndereco: UIButton!
    @IBOutlet var btnUsarLocal: UIButton!
    
    var locManager : CLLocationManager!
    var userLocation : CLLocation!
    
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
            print("validado")
            self.performSegueWithIdentifier("listaRestaurantes", sender: self)
            
            //validar endereço
          // if (1 == 1){
            
            //self.performSegueWithIdentifier("outratela", sender: self)
                
            /*}else {
                print("endereço não localizado")
            }*/
        }else {
            print("Campo errado")
        }
        
    }
    
    func validarCampos() -> Bool{
        if (enderecoBusca.getCidade() != "" && enderecoBusca.getBairro() != ""
            && enderecoBusca.getBairro() != "Bairro" && txtEndereco.text != ""){
                enderecoBusca.setEndereco(txtEndereco.text!)
            return true
        }
        
        return false
    }
    
    @IBAction func usarLocalizacao(sender: AnyObject) {
        //        self.performSegueWithIdentifier("usingLocal", sender: self)
        locManager.requestWhenInUseAuthorization()
        
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedAlways || status == .AuthorizedWhenInUse){
            locManager.startUpdatingLocation()
        }else{
            print("Localização não foi permitida!")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations[0]
        
        if userLocation != nil {
            locManager.stopUpdatingLocation()
        }
        
        let coord = userLocation.coordinate
        //        let coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        //        let latDelta : CLLocationDegrees = 0.005
        //        let lonDelta : CLLocationDegrees = 0.005
        //        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        //        let region : MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        //        self.mapView.setRegion(region, animated: true)
        
        print(coord)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if error != nil{
                print(error)
            }else{
                let place = placemarks?[0]
                let userPlacemark = CLPlacemark(placemark: place!)
                print("endereço: \(userPlacemark.subLocality!) \(userPlacemark.subAdministrativeArea!) \(userPlacemark.postalCode!) \(userPlacemark.country!)")
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
