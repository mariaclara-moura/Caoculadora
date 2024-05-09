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
    let scales = ["Pequeno","Médio","Grande"]
    @State var scale: String = "Pequeno"

    var body: some View {
        VStack (alignment: .leading) {
//            Spacer()
            Text("Qual a idade do seu cão?").font(.system(size: 24))
            Text("Anos")
            TextField("Digite quantos anos seu cão tem.", value: $years, format: .number)
            Text("Meses")
            TextField("E quantos meses além disso ele tem.", value: $months, format: .number)
            Text("Porte")
            Picker("Porte", selection: $scale){
                ForEach(scales, id: \.self) { scale in
                    Text(scale).tag(scale)
                }
            }.pickerStyle(.segmented).padding()
            Divider().background(.indigo)
            Spacer()
            if let result {
                Text("Seu cachorro tem, em idade humana...")
                Text("\(result) anos")
            } else {
//                EmptyView()
                Image(ImageResource.clarinha).resizable().scaledToFit().frame(maxWidth:.infinity, maxHeight: 150).shadow(radius: 20)
            }
            Spacer()
            Button(action:  processYears, label: {
                ZStack{
                    Color.indigo
                    Text("Cãocular").foregroundStyle(.white)

                }
            }).cornerRadius(10).frame(height: 50.0)
        }
        .textFieldStyle(.customRound(strokeSize: 1.5))
//        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
        .bold()
        .fontDesign(.rounded)
        .padding()
        .foregroundStyle(Color.indigo)
    }
    func processYears(){
        
        guard let years, let months else {
            //se eu nao consegui desempacotar years e months:
            print("Preencha o campo de entrada.")
            return
        } 
        guard years > 0 || months > 0 else {
            //se eu nao consegui desempacotar years e months:
            print("Algum dos campos deve ser maior que zero.")
            return
        }

        result = (years * 7) + ( months * 7 / 12)
    }
}

#Preview {
    ContentView()
}

struct CustomStrokeTextFieldStyle: TextFieldStyle {
    let strokeSize: Double
    
    init(strokeSize: Double = 2) {
        self.strokeSize = strokeSize
    }
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
           .padding(10)
           .background(
                RoundedRectangle(cornerRadius: 10, style:.continuous)
                    .stroke(Color.indigo.opacity(0.3), lineWidth: strokeSize)
            )
    }
}

extension TextFieldStyle where Self == CustomStrokeTextFieldStyle {
    static func customRound(strokeSize: Double = 2) -> Self {
        CustomStrokeTextFieldStyle(strokeSize: strokeSize)
    }
}


//(Color(red: 0x4F/0xFF, green: 0x46/0xFF, blue: 0xE5/0xFF))
