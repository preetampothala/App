
import SwiftUI

struct splachscreen: View {
    @State private var isActive = false
    @State private var size=0.8
    @State private var opacity=0.5
    var body: some View {
        if isActive{
            ContentView()
        }else{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                ZStack{
                    Image("logo")
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size=1
                        self.opacity=1
                    }
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                    withAnimation{
                        self.isActive=true
                    }
                }
            }
        }
        
    }
}

struct splachscreen_Previews: PreviewProvider {
    static var previews: some View {
        splachscreen()
    }
}
