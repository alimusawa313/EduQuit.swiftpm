import SwiftUI

struct DrugGameView: View {
    @State private var isImageVisible = true
    @State private var isImage2Visible = true
    @State private var isImage3Visible = true
    @State private var showImages = false
    var body: some View {
        ZStack{
            Color.red
            HStack{
                VStack(alignment:.leading){
                    Text("Mini Game")
                        .font(.system(size: 80))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("Catch the drug as fast as possible\nTap when the all the drugs dissapear")
                        .font(.system(size: 34))
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    
                    HStack(spacing:125){
                        Spacer()
                        if showImages {
                            Image("d1")
                                .opacity(isImageVisible ? 1.0 : 0.0)
                        }
                        if showImages {
                            Image("d2")
                                .opacity(isImage2Visible ? 1.0 : 0.0)
                        }
                        if showImages {
                            Image("d3")
                                .opacity(isImage3Visible ? 1.0 : 0.0)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    Text("High Score: ")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.white)
                }.padding()
                
                Spacer()
            }
        } .onTapGesture {
            print("hello")
            hideImg()
        }
        .onAppear {
        }
    }
    func hideImg(){
        isImageVisible = false
        isImage2Visible = false
        isImage3Visible = false
        startRevealTimer()
    }
    
    func startRevealTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            showImages = true
        }
    }
    
}

#Preview(body: { 
    DrugGameView()
})
