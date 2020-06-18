import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_bloc.dart';
import 'package:gisangdo/src/page/forecast.dart';
import 'package:gisangdo/src/page/maps.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  bool isForecast = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserLocationBloc>(context).add(GetUserLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/gisangdo_logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Gisangdo'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Weather forecast on Map'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.cloud),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Weather'),
                  )
                ],
              ),
             onTap: (){
               if(!isForecast){
                 setState(() {
                   isForecast = true;
                 });
               }
               Navigator.pop(context);
             },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.map),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Forecast Map'),
                  )
                ],
              ),
              onTap: (){
                if(isForecast){
                  setState(() {
                    isForecast = false;
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
        appBar: AppBar(
          title: Text("Gisangdo"),
        ),
        body: BlocBuilder<UserLocationBloc, UserLocationState>(
          builder: (context, state) {
            if (state is ShowUserLocation) {
              return isForecast ? Forecast() : Maps();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
