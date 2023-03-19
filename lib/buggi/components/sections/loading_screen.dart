import 'package:app/buggi/components/components.dart';
import 'package:flutter/material.dart';

class SectionLoading extends StatelessWidget {
  const SectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 60),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 12),
                child: Container(
                  height: 26,
                  width: 110,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              loadingOffersList(),
            ],
          ),
        );
      },
    );
  }
}

SizedBox loadingOffersList() {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.only(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index2) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 0,
          ),
          child: offerCardBorder(const SizedBox(width: 180)),
        );
      },
    ),
  );
}

class OffersLoading extends StatelessWidget {
  final String sectionName;
  const OffersLoading({super.key, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 12),
            child: Text(
              sectionName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          loadingOffersList(),
        ],
      ),
    );
  }
}
