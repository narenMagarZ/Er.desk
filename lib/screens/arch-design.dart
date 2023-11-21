import "package:flutter/material.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "package:er_desk/screens/pdf-viewer.dart";
class ArchitecturalDesign extends StatefulWidget {
  const ArchitecturalDesign({super.key});

  @override
  State<ArchitecturalDesign> createState() => _ArchitecturalDesignState();
}

class _ArchitecturalDesignState extends State<ArchitecturalDesign> {
  @override
  Widget build(BuildContext context) {
    final basicDesignList = [
      {
        "title":"10.9*15m design"
      },
      {
        "title":"10.9*15m design"
      },
      {
        "title":"10.9*15m design"
      }
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: appBar(context,"Architectural Design"),
          body:  TabBarView(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: ListView.separated(
                  separatorBuilder: (context,index)=>const SizedBox(height: 10),
                    itemCount: basicDesignList.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFViewer("Title","test")));
                        },
                        child: SizedBox(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color(0x087B5FEB)
                            ),
                            child: const Text("10.9 * 15m design",style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                        ),
                      );
                })
                // ListView(
                //   children: [
                //
                //   ],
                // ),
              ),
              Center(child:Text("second tab"))
            ],
          ),
        ),
      ),

    );
  }
}

ListView basicDesigns(){
  return ListView(
    children: [],
  );
}



ListView detailsDesign(){
  return ListView(
    children: [],
  );
}



