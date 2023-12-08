// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:here/features/historical_information/widgets/read_more.dart';
import 'package:here/models/places_model.dart';

import 'widgets/image_widget.dart';
import 'widgets/name_and_map.dart';
import 'widgets/reviews_widget.dart';

class HistoricalInformationPage extends ConsumerWidget {
  const HistoricalInformationPage({
    Key? key,
    required this.plc,
  }) : super(key: key);

  final PlacesModel plc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.01,
              ),
              ImageWidget(size: size, img: plc.images),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    NameAndMap(
                      name: plc.name,
                      lati: plc.latitude,
                      longi: plc.longitude,
                    ),
                    const SizedBox(height: 4),
                    ReviewsWidget(
                      rating: plc.ratings,
                    ),
                    const SizedBox(height: 10),
                    ReadMoreTextWidget(
                      text: plc.info,
                    ),
                    ContactsWidget(k: 'Address', value: plc.address),
                    if (plc.emails != null ||
                        plc.phoneNumber != null ||
                        plc.website != null)
                      if (plc.emails != null)
                        ContactsWidget(
                          k: 'Email',
                          value: plc.emails!,
                        ),
                    if (plc.phoneNumber != null)
                      ContactsWidget(
                        k: 'Phone',
                        value: plc.phoneNumber!,
                      ),
                    if (plc.website != null)
                      ContactsWidget(
                        k: 'Website',
                        value: plc.website!,
                      ),
                    const SizedBox(height: 10),
                    // ElevatedButton(
                    //   onPressed: () async{
                    //     Position curr = await ref
                    //         .read(HomePageControllerProvider)
                    //         .getCurrentPosition();

                    //   },
                    //   child: Text('Route to spot'),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({
    Key? key,
    required this.k,
    required this.value,
  }) : super(key: key);

  final String k;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$k : ',
          style: TextStyle(fontSize: 16),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
