from flask import Flask, request, jsonify
import requests
from pyngrok import ngrok
from prompt import history_city

app = Flask(__name__)

endpoint = "https://maps.googleapis.com/maps/api/geocode/json"
api_key = "AIzaSyAiTovt8UIcR81M7EkL0_6jxacmj8aRwO0"


@app.route("/city", methods=["POST"])
def city():
    data = request.get_json()

    if "latitude" in data and "longitude" in data:
        latitude = data["latitude"]
        longitude = data["longitude"]

        params = {"latlng": f"{latitude},{longitude}", "key": api_key}

        response = requests.get(endpoint, params=params)

        if response.status_code == 200:
            data = response.json()
            compound_code = data["plus_code"]["compound_code"]
            index_of_space = compound_code.find(" ")
            if index_of_space != -1:
                compound_code = compound_code[index_of_space + 1 :]
                address = compound_code.split(", ")
            city, state, country = (
                address[0],
                address[1],
                address[2],
            )
            info = history_city(city, state)
            url = "https://places.googleapis.com/v1/places:searchText"

            headers = {
                "X-Goog-Api-Key": api_key,
                "X-Goog-FieldMask": "places.displayName,places.photos,places.location,places.nationalPhoneNumber,places.rating,places.websiteUri",
            }

            body = {
                "textQuery": f"Historical Monuments In {city}",
                "maxResultCount": 3,
                "minRating": 4.5,
            }
            res = requests.post(url, headers=headers, json=body)
            if res.status_code == 200:
                places = []
                data2 = res.json()
                for i in range(3):
                    place = data2["places"][i]
                    name = place["displayName"]["text"]
                    rating = place["rating"]
                    lat = place["location"]["latitude"]
                    long = place["location"]["longitude"]
                    if "photos" in place:
                        photo = place["photos"][0]["name"]
                        photo_url = f"https://places.googleapis.com/v1/{photo}/media?maxHeightPx=400&maxWidthPx=400&key={api_key}"
                    else:
                        photo_url = None
                    place_to_append = [name, rating, lat, long, photo_url]
                    places.append(place_to_append)
            return jsonify(
                {"city": city, "country": country, "info": info, "places": places}
            )

    return jsonify({"error": "Invalid latitude and longitude"}), 400


if __name__ == "__main__":
    public_url = ngrok.connect(5000)
    print(" * Running on", public_url)

    app.run()
