import "package:er_desk/widgets/screen-appbar.dart";
import "package:flutter/material.dart";

class AreaConversion extends StatelessWidget {
  const AreaConversion({super.key});

  @override
  Widget build(BuildContext context) {
    final List areaTypes = [
      {"name":"Bigha", "value":0},
      {"name":"Kattha", "value":0},
      {"name":"Dhur", "value":0},
      {"name":"Ropani", "value":0},
      {"name":"Aana", "value":0},
      {"name":"Paisa","value":0},
      {"name":"Daam","value":0},
      {"name":"Sq.m","value":0},
      {"name":"Sq.feet","value":0},
      {"name":"Khetmuri","value":0},
      {"name":"Matomuri","value":0}
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: Scaffold(
        appBar: appBar(context, "Area Conversion"),
        body: Container(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Row(
                children: [
                  Container(
                    width: 200,
                    child: InputBox(),
                  ),
                  Container(
                    width: 150,
                    child: DropDownButton(),
                  )
                ],
              )),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                      itemCount: areaTypes.length,
                      itemBuilder: (context,index){
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 10),
                                width:200,
                                child: Text(areaTypes[index]["value"].toString())),
                            Container(
                                width:150,
                                padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 10),
                                child: Text(areaTypes[index]["name"],style: TextStyle(
                                  fontSize: 16
                                ),))],
                        );
                      }
                  ),
                ) ,
            ],
          ),
        ),
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController _controller = TextEditingController(text: "1");
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value){
        print(value);
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder()

      ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String selectedValue = "Bigha";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      items: ["Bigha","Kattha","Dhur","Ropani"].map<DropdownMenuItem<String>>((String value) =>
      DropdownMenuItem(
          value: value,
          child: Text(value))
      ).toList(),
      onChanged: (newValue){
        setState(() {
          selectedValue = newValue!;
        });
      },
    );
  }
}

class Area extends StatefulWidget {
  final String areaValue ;
  final String areaType;
  const Area(this.areaType,this.areaValue,{super.key});
  @override
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Row(
        children: [
          Text(widget.areaValue),
          Text(widget.areaType)
        ],
      ),
    );
  }
}
