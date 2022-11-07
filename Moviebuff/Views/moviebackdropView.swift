
import SwiftUI

struct MovieBackdropCard: View {
    
//    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                    .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text("Movie Title")
        }
        .lineLimit(1)
       
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard()
    }
}
