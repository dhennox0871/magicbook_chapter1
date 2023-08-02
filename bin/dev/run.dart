import 'dart:mirrors';
import 'package:dio/dio.dart';
import '../chapter1.dart';
import 'util.dart';

void runChapters({
  required String fullName,
  required String email,
  required String whatsapp,
}) {
  if (fullName.isEmpty) printRed("Nama Lengkap wajib di isi");
  if (whatsapp.isEmpty) printRed("Whatsapp wajib di isi");
  if (email.isEmpty) printRed("Email wajib di isi");

  int point = 0;

  Chapter1 chapter1 = Chapter1();
  InstanceMirror instanceMirror = reflect(chapter1);

  for (var i = 1; i <= 130; i++) {
    var res = instanceMirror.invoke(Symbol("exercise$i"), []).reflectee;
    point += res == true ? 1 : 0;
    res ? printGreen("Soal nomor $i benar!") : printRed("Soal nomor $i salah!");
  }

  print("Point: $point");

  Dio().post(
    "https://capekngoding.com/magicbook/api/scores",
    options: Options(
      headers: {
        "Content-Type": "application/json",
      },
    ),
    data: {
      "name": fullName,
      "email": email,
      "whatsapp": whatsapp,
      "point": point,
    },
  );
}
