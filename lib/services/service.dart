import 'package:dio/dio.dart';
import 'package:movie_app/model/model.dart';

const apiKey = "6bf40e384be722ab6ce7e14841fd4617";

class APIservices {
  final Dio dio = Dio();
  final String nowShowingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";

  Future<List<MovieModel>?> getShowing() async {
    try {
      final response = await dio.get(nowShowingApi);
      print(response);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];
        List<MovieModel> movies =
            data.map((movie) => MovieModel.fromMap(movie)).toList();
        return movies;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
