import "package:er_desk/utils/get-resource-download-url.dart";
import "package:flutter/material.dart";
import "package:firebase_storage/firebase_storage.dart";
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class PDFViewer extends StatefulWidget {
  final String dir;
  final String fileName;
  const PDFViewer(this.dir,this.fileName,{super.key});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late Future<String> pdfUrl;
  @override
  void initState(){
    super.initState();
    pdfUrl = getResourceDownloadUrl("${widget.dir}/${widget.fileName}.pdf");
  }
  @override
  Widget build(BuildContext context) {
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
        future: pdfUrl,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child:Text("Error:$snapshot.error"));
          }
          else {
            return SfPdfViewer.network(snapshot.data!);
          }
        },
      ),
    );
  }
}

