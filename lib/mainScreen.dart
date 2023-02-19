class MainScreen extends StatelessWidget {
 final List<String> items = ['Fire 1', 'Fire 2', 'Fire 3', 'Fire 4', 'Fire 5', 'Crap 1', 'Crap 2', 'Crap 3', 'Crap 4', 'Crap 5'];
 final List<String> desc = ['desc 1', 'desc 2', 'desc 3', 'desc 4', 'desc 5', 'desc 1', 'desc 2', 'desc 3', 'desc 4', 'desc 5'];
 final List<String> rating = ['rating 1', 'rating 2', 'rating 3', 'rating 4', 'rating 5', 'rating 1', 'rating 2', 'rating 3', 'rating 4', 'rating 5'];


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Crap or Fire',
     theme: ThemeData(
       primarySwatch: Colors.green,
     ),
     home: Scaffold(
       appBar: AppBar(
         title: Text('Crap or Fire'),


       ),
       body: Container(
         padding: EdgeInsets.all(16.0),
         child: ListView.builder(
           itemCount: items.length,
           itemBuilder: (BuildContext context, int index) {
              Color backgroundColor = index < 5 ? Colors.green.shade300 : Colors.orange.shade300;
              var rate =
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text(
                   rating[index],
                   style: TextStyle(fontSize: 20.0),
                   ),
                 ],
               );
             return Container(
               decoration: BoxDecoration(
                 color: backgroundColor,
                 borderRadius: BorderRadius.circular(10.0),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.5),
                     spreadRadius: 2,
                     blurRadius: 5,
                     offset: Offset(0, 3),
                   ),
                 ],
               ),
               margin: EdgeInsets.only(bottom: 16.0),
               padding: EdgeInsets.all(16.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 
                 children: [
                   Text(
                     items[index],
                     style: TextStyle(fontSize: 25.0),
                   ),
                   Text(
                     desc[index],
                     style: TextStyle(fontSize: 15.0),
                   ),
                   rate,               
                 ],
               ),
          
             );
           },
         ),
       ),
     ),
   );
 }
}

