//
//  ContentView.swift
//  EnvironmentSchemes
//
//  Created by Oniel Rosario on 10/1/20.
//

import SwiftUI

struct APIModel {
    var isFlagged: Bool
    init(isFlagged: Bool) {
        self.isFlagged = isFlagged
    }
}

protocol Flag {
    func isOn() -> Bool
}

class FeatureBuilder<T: Flag> {
    var featureType: T
    init(feature: T) {
        self.featureType = feature
    }
    
    func isApplicable() -> Bool {
        return featureType.isOn()
    }
}


class FirstFeatureModel: Flag {
    private let model = APIModel(isFlagged: true)
    
    func isOn() -> Bool {
        return model.isFlagged
    }
    
    func doSomething() {
        print("Im First")
    }
}

class SecondFeatureModel: Flag {
    private let model = APIModel(isFlagged: false)
    
    func isOn() -> Bool {
        model.isFlagged
    }
    
    func doSomething() {
        print("Im Second")
    }
}

class ThirdFeatureModel: Flag {
    var message = ""
    
    func isOn() -> Bool {
        return true
    }
    
    func doSomething() {
        print("I am Third")
    }
}



class HeaderModel: FeatureBuilder<FirstFeatureModel> {
    
    init() {
        super.init(feature: FirstFeatureModel())
    }
    
    func featureAction() {
        featureType.doSomething()
    }
    
}

struct HeaderView: View {
    let vm = HeaderModel()
    
    var body: some View {
        if vm.isApplicable() {
            Button("Header feature button") {
                self.vm.featureAction()
            }
        } else {
            Text("No header feature")
        }
    }
}


class BodyViewModel: FeatureBuilder<SecondFeatureModel> {
    init() {
        super.init(feature: SecondFeatureModel())
    }
    
    func featureAction() {
        featureType.doSomething()
    }
}


struct BodyView: View {
    let vm = BodyViewModel()
    
    var body: some View {
        if vm.isApplicable() {
            Button("Body feature button") {
                self.vm.featureAction()
            }
        } else {
            Text("No Body feature")
        }
    }
}

class DevBodyViewModel: FeatureBuilder<FirstFeatureModel> {
    private var isLoggedIn = false
    
    init() {
        let test = FirstFeatureModel()
        super.init(feature: test)
    }
    
    override func isApplicable() -> Bool {
        if self.featureType.isOn() && isLoggedIn {
            return true
        }
        return false
    }
    
    func featureAction() {
        featureType.doSomething()
    }
}


struct DevBodyView: View {
    let vm = DevBodyViewModel()
    var body: some View {
        if vm.isApplicable() {
            Button("Body feature button") {
                self.vm.featureAction()
            }
        } else {
            Text("No Body feature")
        }
    }
}



struct LocalView: View {
    var body: some View {
        VStack {
            HeaderView()
                .background(Color.orange)
            Spacer()
            BodyView()
            Spacer()
        }
    }
}

struct DevView: View {
    var body: some View {
        VStack {
            HeaderView()
                .background(Color.pink)
            Spacer()
            DevBodyView()
            Spacer()
        }
    }
}

struct ProdView: View {
    var body: some View {
        Text("Hello, Prod!")
            .padding()
    }
}

struct QAView: View {
    var body: some View {
        Text("Hello, QA!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocalView()
    }
}
