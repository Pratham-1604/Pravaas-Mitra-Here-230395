import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/features/skeleton/widgets/new_city_repository.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

final cityProvider = ChangeNotifierProvider<NewCity>((ref) => NewCity());

class NewCityInput extends StatefulWidget {
  const NewCityInput({Key? key}) : super(key: key);

  @override
  State<NewCityInput> createState() => _NewCityInputState();
}

class _NewCityInputState extends State<NewCityInput> {
  HereMapController hereMapController = HereMapController(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Change your location'),
      ),
      body: Stack(
        children: [
          HereMap(
            onMapCreated: (HereMapController controller) {
              controller.mapScene.loadSceneForMapScheme(MapScheme.hybridNight,
                  (MapError? error) {
                if (error != null) {
                  return;
                }
                hereMapController = controller;
                setState(() {});
              });
            },
          ),
          SearchBar(mapController: hereMapController),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final HereMapController mapController;
  const SearchBar({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  final state = ref.watch(cityProvider);
                  return TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0),
                    ),
                    onChanged: (value) async {
                      // state.isSearching = true;

                      await state.searchPlace(value);
                      // state.isSearching = false;
                    },
                  );
                }),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Consumer(builder: (context, ref, child) {
          final state = ref.watch(cityProvider);
          return Container(
            // height: MediaQuery.of(context).size.height * 0.3,
            height: (state.searchResult.isEmpty)
                ? MediaQuery.of(context).size.height * 0.3
                : MediaQuery.of(context).size.height * 0.2,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: (state.isSearching)
                ? const Center(child: CircularProgressIndicator())
                : (state.searchResult.isEmpty)
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.searchResult.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // city.changeCity(city.searchResults[index]);
                              // Navigator.pop(context);
                              // add a marker to the map
                              mapController.mapScene.addMapMarker(
                                MapMarker(
                                  GeoCoordinates(
                                    state.searchResult[index]['latitude'],
                                    state.searchResult[index]['longitude'],
                                  ),
                                  MapImage.withFilePathAndWidthAndHeight(
                                    'assets/poi.png',
                                    50,
                                    50,
                                  ),
                                ),
                              );
                              // set the map scene to the new location
                              mapController.camera.lookAtPoint(
                                GeoCoordinates(
                                  state.searchResult[index]['latitude'],
                                  state.searchResult[index]['longitude'],
                                ),
                              );
                            },
                            title: Text(
                              state.searchResult[index]['title'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              state.searchResult[index]['address'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
          );
        }),
      ],
    );
  }
}
