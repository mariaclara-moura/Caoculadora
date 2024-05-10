//
//  Porte.swift
//  Caoculadora
//
//  Created by Maria Clara Albuquerque Moura on 10/05/24.
//

import Foundation

enum Porte: String, CaseIterable {
    case pequeno, médio, grande
//    case medio = "Médio"
//    case grande = "Grande"
    func idadeConvertida(years: Int, months: Int) -> Int{
        let multiplicador: Int
        let result: Int
        switch self {
        case .pequeno:
            multiplicador = 6
        case .médio:
            multiplicador = 7
        case .grande:
            multiplicador = 8
        }
        result = (
            years * multiplicador
        ) + (
            months * multiplicador / 12
        )
        return result
    }
}


