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
    @State var failedInput: Bool = false
    let tituloPreencherCampos = "Preencha os campos corretamente para poder Cãocular!"
    @State var porteSelecionado: Porte = .pequeno
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack (
                    alignment: .leading,
                    spacing: 20.0
                ) {
                    Text(
                        "Qual a idade do seu cão?"
                    ).font(
                        .header5
                    ).padding(
                        .top,
                        24.0
                    )
                    VStack(
                        alignment: .leading,
                        spacing: 8.0
                    ){
                        Text(
                            "Anos"
                        ).font(
                            .body1
                        )
                        TextField(
                            "Digite quantos anos seu cão tem.",
                            value: $years,
                            format: .number
                        )}
                    VStack(
                        alignment: .leading,
                        spacing: 8.0
                    ){
                        Text(
                            "Meses"
                        ).font(
                            .body1
                        )
                        TextField(
                            "E quantos meses além disso ele tem.",
                            value: $months,
                            format: .number
                        )}
                    VStack(
                        alignment: .leading,
                        spacing: 8.0
                    ){
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
                        )}
                    Divider().background(
                        .indigo600
                    )
                    Spacer()
                    if let result {
                        Text(
                            "Seu cachorro tem, em idade humana..."
                        ).font(
                            .body1
                        ).frame(
                            maxWidth:.infinity
                        )
                        Text(
                            "\(result) anos"
                        ).contentTransition(.numericText()).font(
                            .display
                        ).frame(
                            maxWidth:.infinity
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
                            Color.indigo600
                            Text(
                                "Cãocular"
                            ).foregroundStyle(
                                .white
                            ).font(
                                .body1
                            )
                            
                        }
                    })
                    .cornerRadius(
                        10
                    ).frame(
                        height: 50.0
                    )
                }.containerRelativeFrame(
                    .vertical
                )
                .textFieldStyle(
                    .customRound(
                        strokeSize: 1.5
                    )
                ).alert(tituloPreencherCampos, isPresented: $failedInput)
                {
                    Button("OK", role:.cancel, action: {})
                }
                .keyboardType(
                    .numberPad
                ).bold()
                    .padding()
                    .foregroundStyle(
                        Color.indigo600
                    ).navigationTitle(
                        "Cãoculadora"
                    ).toolbarBackground(
                        .visible,
                        for: .navigationBar
                    ).toolbarBackground(
                        .indigo600,
                        for: .navigationBar
                    ).toolbarColorScheme(
                        .dark,
                        for: .navigationBar
                    )
            }.animation(.easeOut, value: result)
            .scrollDismissesKeyboard(
                .immediately
            )
        }
    }
    func processYears(){
        
        guard let years, let months else {
            //se eu nao consegui desempacotar years e months:
            print(
                "Preencha o campo de entrada."
            )
            failedInput = true
            return
        } 
        guard years > 0 || months > 0 else {
            //se eu nao consegui desempacotar years e months:
            print(
                "Algum dos campos deve ser maior que zero."
            )
            failedInput = true
            return
        }
//        withAnimation(.easeIn.speed(0.5)){
            result = porteSelecionado.idadeConvertida(
                years: years,
                months: months
            )
        //}
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
                    Color.indigo600.opacity(
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
