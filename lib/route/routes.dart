import 'package:sailor/sailor.dart';
import 'package:tanduran/view/detail.dart';
import 'package:tanduran/view/home.dart';

class Routes {

  static final sailor = Sailor();

  static void createRoutes(){
    sailor.addRoutes([
      SailorRoute(name: '/home', builder: (context, args, params){
        return Home();
      }),
      SailorRoute(name: '/detail', builder: (context, args, params){
        final name = params.param('name');
        return Detail();
      },
      params: [
        SailorParam(name: 'name', isRequired: true)
      ]
      )
    ]);
  }
}