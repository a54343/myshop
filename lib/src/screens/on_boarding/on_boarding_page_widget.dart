import 'package:flutter/material.dart';

import '../../models/model_on_boarding.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(30),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: size.height * 0.5,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(model.counterText),
          const SizedBox(
            height: 85,
          )
        ],
      ),
    );
  }
}
