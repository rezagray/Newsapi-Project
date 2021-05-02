/*Muhammad Reza Pahlepi(181420069)
Apriyo Fadli(181420091)
Arif Athallah(181420065)
Trima Subhan Perbawa(181420055)

Bagian //Trima Subhan Perbawa(181420055) 
*/

import 'package:newsapi/views/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), //Routing untuk mengarahkan ke Homepage
      },
    ));
