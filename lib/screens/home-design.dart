import "package:carousel_slider/carousel_slider.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:er_desk/widgets/screen-appbar.dart";
class HomeDesign extends StatefulWidget {
  const HomeDesign({super.key});

  @override
  State<HomeDesign> createState() => _HomeDesignState();
}

class _HomeDesignState extends State<HomeDesign> {
  List<String> imageUrls = [];
  int currentPage = 1;
  @override
  void initState(){
    super.initState();
    fetchImages();
  }


  Future<void> fetchImages()async{
    for(int i = (currentPage - 1) * 10 + 1; i<=currentPage * 10;i++){
      String imageUrl = await FirebaseStorage.instance.ref('home-design/image-$i').getDownloadURL();
      setState(() {
        imageUrls.add(imageUrl);
      });
    }
  }

  void loadMoreImages(){
    currentPage++;
    fetchImages();
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,"Home Design"),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo){
          if(scrollInfo is ScrollEndNotification && scrollInfo.metrics.extentAfter == 0){
            loadMoreImages();
          }
          return true;
        },
        child: Container(
          child: GridView.builder(
            itemCount: imageUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2
              ), itemBuilder: (context,index){
                return ImageButton(imageUrl:imageUrls[index]);
                  Image.network(imageUrls[index]);
          })
        ),
      ),
    );
  }
}

Future<List> fetchImagesDownloadUrl(int page)async{
  List<String> imageList = [] ;
  try{
    final storageRef = FirebaseStorage.instance.ref();
    final storageDir = storageRef.child("home-design");
    final ListResult result  = await storageDir.listAll();
    const pageLimit = 9;
    final startAt = page * pageLimit ;
    final endAt = startAt + pageLimit;

    final items = result.items;
    for(var i = startAt ; i< endAt && i < items.length;i++){
      final imageUrl = await items[i].getDownloadURL();
      imageList.add(imageUrl);
    }
    return imageList;
  }
  catch(err){
    return [];
  }
}

class ImageButton extends StatelessWidget {
  final String imageUrl;
  const ImageButton({super.key,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return ViewImage(imageUrl: imageUrl);
          }));
        },
        child: Ink.image(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,),
      ),
    );();
  }
}


class ViewImage extends StatelessWidget {
  final String imageUrl;
  const ViewImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,size: 18),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("View image",style: TextStyle(fontSize: 16),),
      ),
      body: GestureDetector(
        onTap: (){
          print('gesture detected');
        },
        child: Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            child: Image.network(imageUrl,fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
