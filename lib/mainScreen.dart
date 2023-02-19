
class MainScreen extends StatelessWidget {
  const MainScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Fire 1')),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Fire 2')),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Fire 3')),
        ),
      ],
      scrollDirection: Axis.vertical,
    );
  }
}
