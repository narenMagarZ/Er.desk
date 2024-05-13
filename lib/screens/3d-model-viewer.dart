import "package:er_desk/utils/get-resource-download-url.dart";
import "package:flutter/material.dart";
import "package:model_viewer_plus/model_viewer_plus.dart";
class ThreeDModelViewer extends StatefulWidget {
  final String dir;
  final String fileName;
  const ThreeDModelViewer(this.dir,this.fileName,{super.key});

  @override
  State<ThreeDModelViewer> createState() => _ThreeDModelViewerState();
}

class _ThreeDModelViewerState extends State<ThreeDModelViewer> {
  late Future<String> modelUrl ;
  @override
  void initState(){
    super.initState();
    modelUrl = getResourceDownloadUrl("${widget.dir}/${widget.fileName}");
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.dir}/${widget.fileName}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B5FEB),
        leading: const BackButton(
          style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.white),
              iconSize: MaterialStatePropertyAll(18)
          ),
        ),
        title: Center(
          child: Text(widget.dir,style: const TextStyle(
              color: Colors.white,
              fontSize: 16
          )),
        ),
      ),
      body: FutureBuilder(
        future: modelUrl,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child:Text("Error:$snapshot.error"));
          }
          else {
            return Container(
                  padding: const EdgeInsets.all(4),
                  child: const Column(
                    children: [
                         Text("3d-model viewer example"),
                        SizedBox(height: 50),
                      Expanded(
                        child: Text(""),
                        // child: O3D.network(
                        //   src: snapshot.data!,
                        //   controller: controller,
                        // ),
                      )
                    ],
                  ),
            );
          }
        },
      ),
    );

  }
}


