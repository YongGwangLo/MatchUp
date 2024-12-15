import "package:dio/dio.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

class VworldRepository {
  final Dio _client = Dio(BaseOptions(
    baseUrl: "https://api.vworld.kr/req/data",
    validateStatus: (status) => true,
  ));

  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    final response = await _client.get(
      "",
      queryParameters: {
        "request": "GetFeature",
        "data": "LT_C_ADEMD_INFO",
        "key": dotenv.env['VWORLD_API_KEY'] ?? '',
        "geomfilter": "point($lng $lat)",
        "geometry": "false",
        "size": 100,
      },
    );

    if (response.statusCode == 200 &&
        response.data["response"]["status"] == "OK") {
      return List.of(response.data["response"]["result"]["featureCollection"]
              ["features"])
          .map((e) => e["properties"]["full_nm"].toString())
          .toList();
    }

    return [];
  }
}
