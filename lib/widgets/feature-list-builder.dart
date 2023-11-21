import "package:er_desk/utils/fetch-items-in-directory.dart";
import "package:flutter/material.dart";
import "package:er_desk/screens/pdf-viewer.dart";

FutureBuilder featureListBuilder(String dir){
  return FutureBuilder(
    future: fetchItemsInDirectory(dir),
    builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      else if(snapshot.hasError){
        return Center(
          child: Text("Error: ${snapshot.error}"),
        );
      }
      else if(!snapshot.hasData){
        return const Center(
          child: Text("No data available."),
        );
      }else {
        final data = snapshot.data;
        return ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context,index){
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PDFViewer(dir,data[index])));
                },
                leading: const Icon(Icons.picture_as_pdf,color:Color(0xAA7B5FEB)),
                title: Text(data![index],
                  style: const TextStyle(
                    // overflow: TextOverflow.ellipsis,
                      fontSize: 11
                  ),
                ),
                tileColor: const Color(0x087B5FEB),

              ),
            );
          },
        );
      }
    },
  );
}