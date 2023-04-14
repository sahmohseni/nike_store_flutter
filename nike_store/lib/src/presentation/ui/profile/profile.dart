import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/domain/repository/auth/auth_repository.dart';
import 'package:nike_store/theme.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('برای خارج شدن از حساب دکمه زیر را فشار دهید'),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 35,
            width: 140,
            child: ElevatedButton.icon(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(LightTheme.primaryColor)),
                onPressed: () async {
                  await KiwiContainer().resolve<AuthRepository>().signOut();
                },
                icon: const Icon(
                  CupertinoIcons.multiply_circle,
                  size: 20,
                ),
                label: const Text(
                  'خروج از حساب',
                  style: TextStyle(fontFamily: 'dana'),
                )),
          )
        ],
      ),
    );
  }
}
