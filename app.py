from flask import Flask, request, jsonify
import requests
from pyngrok import ngrok
from prompt import history_city, history_place

app = Flask(__name__)

endpoint = "https://maps.googleapis.com/maps/api/geocode/json"
api_key = "AIzaSyAiTovt8UIcR81M7EkL0_6jxacmj8aRwO0"
here_endpoint = "https://discover.search.hereapi.com/v1/discover"
here_api_key = "4uqD1yDCefQgdIR8ujNhkB5ISt8Pciobkwy9b3eChNY"


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
                "X-Goog-FieldMask": "places.displayName,places.formattedAddress,places.photos,places.location,places.nationalPhoneNumber,places.rating,places.websiteUri",
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
                    address = place["formattedAddress"]
                    rating = place["rating"]
                    lat = place["location"]["latitude"]
                    long = place["location"]["longitude"]
                    place_info = history_place(name, city)
                    here_params = {
                        "apiKey": here_api_key,
                        "q": name,
                        "at": f"{lat},{long}",
                    }
                    here_res = requests.get(here_endpoint, params=here_params)
                    if here_res.status_code == 200:
                        data3 = here_res.json()
                        if "categories" in data3["items"][0]:
                            tag = data3["items"][0]["categories"][0]["name"]
                        else:
                            tag = "Location"
                        if "contacts" in data3["items"][0]:
                            contacts = data3["items"][0]["contacts"][0]
                            if "www" in contacts:
                                website_uri = contacts["www"][0]["value"]
                            else:
                                website_uri = None
                            if "phone" in contacts:
                                phone = contacts["phone"][0]["value"]
                            else:
                                phone = None
                            if "email" in contacts:
                                email = contacts["email"][0]["value"]
                            else:
                                email = None
                        else:
                            contacts = None
                            website_uri = None
                            phone = None
                            email = None

                    else:
                        print(
                            "HERE request failed with status code:",
                            response.status_code,
                        )
                    if "photos" in place:
                        photo = place["photos"][0]["name"]
                        photo_url = f"https://places.googleapis.com/v1/{photo}/media?maxHeightPx=400&maxWidthPx=400&key={api_key}"
                    else:
                        photo_url = None
                    place_to_append = {
                        "name": name,
                        "info": place_info,
                        "address": address,
                        "website": website_uri,
                        "images": photo_url,
                        "ratings": rating,
                        "tag": tag,
                        "latitude": lat,
                        "longitude": long,
                        "emails": email,
                        "phoneNumber": phone,
                    }
                    places.append(place_to_append)
            return jsonify(
                {"city": city, "country": country, "info": info, "places": places}
            )

    return jsonify({"error": "Invalid latitude and longitude"}), 400


if __name__ == "__main__":
    public_url = ngrok.connect(5000)
    print(" * Running on", public_url)

    app.run()
