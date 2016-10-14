//
//  Restaurante.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 13/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import Foundation

public class Horario{
    
    private var id : Int!
    private var dia: String!
    private var horario: String!
    
    func getId() -> Int{
        return self.id
    }
    
    func getDia() -> String{
        return self.dia
    }
    
    func getHorario() -> String{
        return self.horario
    }
    
    func setId(id: Int){
        self.id = id
    }
    
    func setDia(d: String){
        self.dia = d
    }
    
    func setHorario(h :String){
        self.horario = h
    }
    
}