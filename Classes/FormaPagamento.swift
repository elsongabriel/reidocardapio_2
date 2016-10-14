//
//  Restaurante.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 13/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import Foundation

public class FormaPagamento{
    
    private var id : Int!
    private var descricao: String!
    private var imagem: String!
    
    func getId() -> Int{
        return self.id
    }
    
    func getDescricao() -> String{
        return self.descricao
    }
    
    func getImagem() -> String{
        return self.imagem
    }
    
    func setId(id: Int){
        self.id = id
    }
    
    func setDescricao(des: String){
        self.descricao = des
    }
    
    func setImagem(img :String){
        self.imagem = img
    }
}