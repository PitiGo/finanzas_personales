import 'package:finanzas_personales/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'graph_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum GraphType{
  LINES,
  PIE,
}

class MonthWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;
  final GraphType graphType;
  final int month;

   MonthWidget({Key key, this.documents, int days, this.graphType, @required this.month}) : 
    total= documents.map((doc) => doc['value']).fold(0.0, (a,b) => a+b),
    perDay = List.generate(days, (int index){
      return documents.where((doc)=> doc['day'] == (index+1)).map((doc) => doc['value']).fold(0.0, (a,b) => a+b);
    }),
    categories = documents.fold({},(Map <String, double> map,document){
      if(!map.containsKey(document['categories'])){
        map[document['category']] = 0.0;
      }
      map[document['category']] += document['value'];
      return map;
    }),
    super(key: key);

  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Column(
        children: <Widget>[
          _expenses(),
          _graf(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24,
          ),
          _list(),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          "\$${widget.total.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Total expenses",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _graf() {
    if(widget.graphType==GraphType.LINES){
    return Container(
      height: 250, 
      child: LinesGraphWidget(
          data:widget.perDay
      )
    );
    }else{
      var perCategory = widget.categories.keys.map((name) => widget.categories[name] / widget.total).toList();
      return Container(
      height: 250, 
      child: PiesGraphWidget(
          data:perCategory,
      )
    );

    }
  }

  Widget _item(IconData icono, String name, int percentage, double value) {
    return ListTile(
      onTap: (){
        Navigator.of(context).pushNamed("/details",arguments:DetailsParams(name,widget.month));
      },
      leading: Icon(
        icono,
        size: 32.0,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "$percentage\% of expenses",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(

          itemBuilder: (BuildContext context, int index){
              var key = widget.categories.keys.elementAt(index);
              var data = widget.categories[key];
              return _item(FontAwesomeIcons.shoppingCart, key, 100 * data ~/ widget.total, data);
          },
          itemCount: widget.categories.keys.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.blueAccent.withOpacity(0.15),
              height: 2,
            );
          },

          //  children: <Widget>[
          //   _item(FontAwesomeIcons.shoppingCart, "Shopping", 14,145.12),
          //   _item(Icons.local_drink, "Alcohol", 5,155.8),
          //    _item(Icons.fastfood, "Alcohol", 14,155.8),
          //  ],
          ),
    );
  }
}


// class Expense {
//   String category;
//   double expenseValue;
//   Color colorvalue;

//   Expense(this.category, this.expenseValue, this.colorvalue);
// }
