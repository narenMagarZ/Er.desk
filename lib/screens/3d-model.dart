import "package:er_desk/utils/fetch-items-in-directory.dart";
import "package:er_desk/utils/get-resource-download-url.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "../widgets/feature-list-builder.dart";
import "package:model_viewer_plus/model_viewer_plus.dart";
import "../widgets/screen-appbar.dart";
import "package:firebase_storage/firebase_storage.dart";

Future<List<Model>> fetch3dModelDownloadUrl() async{
  List<Model> result = [];
    final ref = FirebaseStorage.instance.ref();
    final dir = ref.child('3d-model');
    final files = await dir.listAll();
    for(final file in files.items){
      final modelName = file.name.replaceAll(".glb", "");
      final downloadUrl = await ref.child('3d-model/${file.name}').getDownloadURL();
      final model = Model(name: modelName,url: downloadUrl);
      result.add(model);
    }
    return result;
}


class ThreeDModel extends StatefulWidget {
  const ThreeDModel({super.key});

  @override
  State<ThreeDModel> createState() => _ThreeDModelState();
}

class _ThreeDModelState extends State<ThreeDModel> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: appBar(context, "3d Model"),
        body: FutureBuilder(
          future: fetch3dModelDownloadUrl(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.hasError){
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }else if(!snapshot.hasData){
              return const Center(
                child: Text("No data available"),
              );
            }else {
              final data = snapshot.data;
              return PageView.builder(
                scrollDirection: Axis.vertical,
                controller: pageController,
                  itemCount:data!.length,
                  itemBuilder:(context,index) {
                    return Center(
                        child:modelPage(data[index], index, pageController, data.length)
                        // ModelItem(model: data[index]!,controller: pageController,pageIndex:index,listCount:data.length)
                    );
              });
            }
          },
        )
      ),
    );
  }
  
}

class Model {
  final String name;
  final String url;
  Model({required this.name,required this.url});
}

class ModelItem extends StatefulWidget {
  final Model model;
  final PageController controller ;
  final int pageIndex;
  final int listCount ;
  const ModelItem({super.key,required this.model,required this.controller, required this.pageIndex, required this.listCount});
  @override
  State<ModelItem> createState() => _ModelItemState();
}

class _ModelItemState extends State<ModelItem> {
  // final O3DController modelController = O3DController();
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final pageIndex = widget.pageIndex;
    final listCount = widget.listCount;
    return Stack(
      children: [
        Center(
            child:
        ModelViewer(
            src: widget.model.url,
            alt: widget.model.name,
            autoRotate: false,
            autoPlay: false,
            loading: Loading.eager,
          cameraControls: false
        )),
        Align(
          alignment: Alignment.bottomRight,
          child:
          Container(
            margin: const EdgeInsets.all(2),
            child:
              pageIndex == 0 ?
                  MoveDownBtn(controller, pageIndex):
              pageIndex == listCount-1?
                  MoveUpBtn(controller, pageIndex):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MoveUpBtn(controller, pageIndex),
                    MoveDownBtn(controller, pageIndex)
                  ],
                  )
    )
        )
      ],
    );
  }
}



Widget MoveUpBtn(controller,pageIndex){
  return SizedBox(
    height: 30,
    width: 30,
    child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0,
        onPressed: (){
      controller.animateToPage(
          pageIndex - 1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease
      );
    },child: const Icon(Icons.arrow_upward,size: 20)),
  );
}
Widget MoveDownBtn(controller,pageIndex){
  return SizedBox(
    height: 30,
    width: 30,
    child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0,
        onPressed: (){
      controller.animateToPage(
          pageIndex + 1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease
      );
    },child:const Icon(Icons.arrow_downward,size: 20,)),
  );
}


Widget modelPage(Model model,int pageIndex,PageController controller,int listCount){
  final url = model.url;
  final title = model.name;
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Civil Works Engineering Consultancy",style: TextStyle(fontSize: 14),),
            Text("Birendranagar 3, surkhet"),
            Text("9742218544, 9812433449")
          ],
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Center(
              child:
              ModelViewer(
                  src: url,
                  alt: title,
                  autoRotate: false,
                  autoPlay: false,
                  loading: Loading.eager,
                  cameraControls: false
              )),
        ]),
      ),
      Align(
          alignment: Alignment.bottomRight,
          child:
          Container(
              margin: const EdgeInsets.all(2),
              child:
              pageIndex == 0 ?
              MoveDownBtn(controller, pageIndex):
              pageIndex == listCount-1?
              MoveUpBtn(controller, pageIndex):
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MoveUpBtn(controller, pageIndex),
                  MoveDownBtn(controller, pageIndex)
                ],
              )
          )
      )
    ],
  );
}