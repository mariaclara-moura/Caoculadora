//
//  ContentView.swift
//  Caoculadora
//
//  Created by Maria Clara Albuquerque Moura on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var years: Int?
    @State var months: Int?
    @State var result: Int?
//    let scales = [
//        "Pequeno",
//        "Médio",
//        "Grande"
//    ]
//    @State var scale: String = "Pequeno"
    @State var porteSelecionado: Porte = .pequeno
    
    var body: some View {
        VStack (
            alignment: .leading
        ) {
            Spacer()
            Text(
                "Qual a idade do seu cão?"
            ).font(
                .header5
            )
            Text(
                "Anos"
            ).font(
                .body1
            )
            TextField(
                "Digite quantos anos seu cão tem.",
                value: $years,
                format: .number
            )
            Text(
                "Meses"
            ).font(
                .body1
            )
            TextField(
                "E quantos meses além disso ele tem.",
                value: $months,
                format: .number
            )
            Text(
                "Porte"
            ).font(
                .body1
            )
            Picker(
                "Porte",
                selection: $porteSelecionado
            ){
                ForEach(
                    Porte.allCases,
                    id: \.self
                ) { scale in
                    Text(
                        scale.rawValue.capitalized
                    ).tag(
                        scale
                    )
                }
            }.pickerStyle(
                .segmented
            ).padding()
            Divider().background(
                .indigo
            )
            Spacer()
            if let result {
                Text(
                    "Seu cachorro tem, em idade humana..."
                ).font(
                    .body1
                )
                Text(
                    "\(result) anos"
                ).font(
                    .display
                )
            } else {
                //                EmptyView()
                Image(
                    ImageResource.clarinha
                ).resizable().scaledToFit().frame(
                    maxWidth:.infinity,
                    maxHeight: 150
                ).shadow(
                    radius: 20
                )
            }
            Spacer()
            Button(action:  processYears,
                   label: {
                ZStack{
                    Color.indigo
                    Text(
                        "Cãocular"
                    ).foregroundStyle(
                        .white
                    ).font(
                        .body1
                    )
                    
                }
            }).cornerRadius(
                10
            ).frame(
                height: 50.0
            )
        }
        .textFieldStyle(
            .customRound(
                strokeSize: 1.5
            )
        )
        //        .textFieldStyle(.roundedBorder)
        .keyboardType(
            .numberPad
        )
        .padding()
        .foregroundStyle(
            Color.indigo
        )
    }
    func processYears(){
        
        guard let years, let months else {
            //se eu nao consegui desempacotar years e months:
            print(
                "Preencha o campo de entrada."
            )
            return
        } 
        guard years > 0 || months > 0 else {
            //se eu nao consegui desempacotar years e months:
            print(
                "Algum dos campos deve ser maior que zero."
            )
            return
        }
        let multiplicador: Int
        result = porteSelecionado.idadeConvertida(
            years: years,
            months: months
        )
    }
}

#Preview {
    ContentView()
}

struct CustomStrokeTextFieldStyle: TextFieldStyle {
    let strokeSize: Double
    
    init(
        strokeSize: Double = 2
    ) {
        self.strokeSize = strokeSize
    }
    func _body(
        configuration: TextField<Self._Label>
    ) -> some View {
        configuration
            .padding(
                10
            )
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style:.continuous
                )
                .stroke(
                    Color.indigo.opacity(
                        0.3
                    ),
                    lineWidth: strokeSize
                )
            )
    }
}

extension TextFieldStyle where Self == CustomStrokeTextFieldStyle {
    static func customRound(
        strokeSize: Double = 2
    ) -> Self {
        CustomStrokeTextFieldStyle(
            strokeSize: strokeSize
        )
    }
}


//(Color(red: 0x4F/0xFF, green: 0x46/0xFF, blue: 0xE5/0xFF))
