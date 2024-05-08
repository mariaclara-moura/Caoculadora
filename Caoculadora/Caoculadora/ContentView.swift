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

    var body: some View {
        VStack (alignment: .leading) {
            Text("Qual a idade do seu cão?").font(.system(size: 24))
            Text("Anos")
            TextField("Digite quantos anos seu cão tem.", value: $years, format: .number)
            Text("Meses")
            TextField("E quantos meses além disso ele tem.", value: $months, format: .number)
            Text("Porte")
            if let result {
                Text("Seu cachorro tem, em idade humana...")
                Text("\(result) anos")
            } else {
//                EmptyView()
                Image(ImageResource.clarinha).resizable().scaledToFit().frame(maxWidth:.infinity, maxHeight: 150).shadow(radius: 20)
            }
            Button(action:  {result = 23}, label: {
                ZStack{
                    Color.indigo
                    Text("Cãocular").foregroundStyle(.white)

                }
            }).cornerRadius(10).frame(height: 50.0)
        }
        .textFieldStyle(.customRound(strokeSize: 1))
        .keyboardType(.numberPad)
        .bold()
        .fontDesign(.rounded)
        .padding()
        .foregroundStyle(Color.indigo)
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
