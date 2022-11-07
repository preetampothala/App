import SwiftUI
 
struct details: View {
     
    let movie: Movie
     
    var body: some View {
         
        VStack {
            Image("user")
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.orange, lineWidth: 4)
                )
                .shadow(radius: 10)
            Text(movie.title)
                .font(.title)
            Divider()
  
            Text(movie.overview)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(50)
        }.padding()
         
    }
}

