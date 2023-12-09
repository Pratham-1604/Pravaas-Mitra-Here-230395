import google.generativeai as palm

palm.configure(api_key="AIzaSyAmJZX92dPwWWwyWRyPzWukcmbawQiAzGg")

defaults = {
    "model": "models/text-bison-001",
    "temperature": 0.7,
    "candidate_count": 1,
    "top_k": 40,
    "top_p": 0.95,
    "max_output_tokens": 1024,
    "stop_sequences": [],
    "safety_settings": [
        {"category": "HARM_CATEGORY_DEROGATORY", "threshold": 1},
        {"category": "HARM_CATEGORY_TOXICITY", "threshold": 1},
        {"category": "HARM_CATEGORY_VIOLENCE", "threshold": 2},
        {"category": "HARM_CATEGORY_SEXUAL", "threshold": 2},
        {"category": "HARM_CATEGORY_MEDICAL", "threshold": 2},
        {"category": "HARM_CATEGORY_DANGEROUS", "threshold": 2},
    ],
}


def history_place(place, city):
    response = palm.generate_text(
        **defaults,
        prompt=f"I am a tourist. I am currently visiting the place {place} in city {city}. Describe the history of the place to me in a simple paragraph so that I understand the historical value of the place and I feel like exploring lots more.",
    )

    return response.result


def history_city(city, state):
    response = palm.generate_text(
        **defaults,
        prompt=f"I am a tourist. I am currently visiting the city {city} in state {state}. Describe the history of the city to me in a simple paragraph so that I understand the historical value of the place and I feel like exploring lots more.",
    )

    return response.result


# print(history_place("Pataleshwar Cave Temple", "Pune"))
# print(history_city("Agra", "Uttar Pradesh"))
