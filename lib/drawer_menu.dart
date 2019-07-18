import 'package:flutter/material.dart';
import './fragments/FragmentHome.dart';
import './fragments/FragmentScaffold.dart';
import './fragments/FragmentData.dart';

class DrawerMenu extends StatefulWidget {



  final drawerItems = [
    new DrawerItem("Fragment Home", Icons.rss_feed),
    new DrawerItem("Fragment Scaffold", Icons.local_pizza),
    new DrawerItem("Fragment Data", Icons.info),

  ];

  @override
  State<StatefulWidget> createState() {
    return new DrawerMenuState();
  }


}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DrawerMenuState extends State<DrawerMenu> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FragmentHome();
      case 1:
        return new FragmentScaffold();
      case 2:
        return new FragmentData();

      default:
        return new Text("Error");
    }
  }



  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }



    return new Scaffold(

      key: _scaffoldKey,
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),



      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[

            new UserAccountsDrawerHeader(
                accountName: new Text('Fistep Eapl Astimen'),
                accountEmail: new Text('astimen@gmail.com'),
                currentAccountPicture: new GestureDetector(
                  onTap: () => pesan("Astimen"),
                  child : new CircleAvatar(
                    backgroundImage: new ExactAssetImage('assets/images/photo_astimen.png'),
                  ),
                ),

              otherAccountsPictures: <Widget>[
                new GestureDetector(
                  onTap: () => pesan("Ilmi"),
                  child: new CircleAvatar(
                      //backgroundImage: new NetworkImage("")
                      backgroundImage: new ExactAssetImage('assets/images/ilmi.png'),
                  ),

                ),
                new GestureDetector(
                  onTap: () => pesan("Roihan"),
                  child: new CircleAvatar(
                    //backgroundImage: new NetworkImage("")
                    backgroundImage: new ExactAssetImage('assets/images/roihan.png'),
                  ),

                ),
              ],

                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        //image: new NetworkImage("https://xyz.png")
                        image: new ExactAssetImage('assets/images/flutter_logo.png')
                    )
                )

            ),
            new Column(children: drawerOptions)
          ],

        ),


      ),


      body: _getDrawerItemWidget(_selectedDrawerIndex),

    );
  }

  void pesan(String value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: new Text(value),
        duration: Duration(seconds: 3),
    ));
  }



}

