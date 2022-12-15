
import SwiftUI
import SDWebImageSwiftUI

struct BackdropView: View {
    
    let movie: Movie
    @ObservedObject var viewModel=MovieViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                WebImage(url:URL(string: "\(movie.backdropURL)"))
                    .resizable()
                }
            
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
        }
        .lineLimit(1)

    }
}

struct BackdropView_Previews: PreviewProvider {
    static var previews: some View {
        BackdropView(movie: Movie(id: 0, title: "", overview: "", poster_path: "/tegBpjM5ODoYoM1NjaiHVLEA0QM.jpg", backdrop_path: "/26D4G7okoLYbDf5MFYFlSRM6jMv.jpg", vote_average: 0.3, release_date: "", genres: [Genre]()), viewModel: MovieViewModel())
    }
}
