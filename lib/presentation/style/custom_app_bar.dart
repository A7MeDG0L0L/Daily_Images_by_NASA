import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlurredAppBar({
    required this.url,
  });
  final String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(maintainBottomViewPadding: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // To add some elevation shadow
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
          ),
        ]),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      url),
                ),
                borderRadius: BorderRadius.circular(8),
               // color: Colors.white.withOpacity(0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                child: Center(child: Text('Images By Nasa',style: TextStyle
                  (color: Colors.white,fontSize: 22),)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
