import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tune_wave/shared/constants/app_constants.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final twTextTheme = Theme
        .of(context)
        .textTheme;
    final twColorTheme = Theme
        .of(context)
        .colorScheme;

    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .surface,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(children: [
            Align(
              alignment: const AlignmentDirectional(0, 0.2),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: twColorTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(1, 0.8),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: twColorTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 50.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  /// HEADPHONE IMAGE
                  Image.asset('assets/images/headphone1.png'),

              /// WELCOME MESSAGES
              Image.asset('assets/images/tunewavelogo.png', scale: 2,),

              const SizedBox(
                height: 20,
              ),

              /// LETS GO BUTTON
              Text(
                AppConstants.welcomeMsg2,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(width: 150, height: 55, child: FilledButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                  child: Text('Lets Go >', style: twTextTheme.titleMedium),
              ),),
          ],
          ),
        ),
        ]),)
    );
  }
}
