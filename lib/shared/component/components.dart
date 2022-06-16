

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/web_view/web_view.dart';

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context,  WebViewScreen(article['url']));
  },
  child:   Padding(
  
        padding: const EdgeInsets.all(20.0),
  
        child: Row(
  
          children: [
  
            Container(
  
              width: 120,
  
              height: 120,
  
              decoration: BoxDecoration(
  
                borderRadius: BorderRadius.circular(10),
  
                image: DecorationImage(
  
                  image: NetworkImage('${article['urlToImage']}'),
  
                  fit: BoxFit.cover
  
                )
  
              ),
  
            ),
  
            const SizedBox(width: 20,),
  
            Expanded(
  
              child: Container(
  
                height: 120,
  
                child: Column(
  
                  mainAxisAlignment: MainAxisAlignment.start,
  
                  crossAxisAlignment: CrossAxisAlignment.start,
  
                  children:  [
  
                    Expanded(
  
                      child: Text('${article['title']}',
  
                      style: Theme.of(context).textTheme.bodyText1,
  
                      maxLines: 4,
  
                      overflow: TextOverflow.ellipsis,
  
                      ),
  
                    ),
  
                    Text('${article['publishedAt']}',
  
                     style:const TextStyle(
  
                       color: Colors.grey,
  
                      // fontSize: 18,
  
                      // fontWeight: FontWeight.w600
  
                    ),
  
                    )
  
                  ],
  
                ),
  
              ),
  
            )
  
          ],
  
        ),
  
      ),
);

    Widget myDivider()=>Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
              );


  Widget articleBuilder(list,context ,{isSearch = false})=>ConditionalBuilder(
      condition: list.length>0, 
      builder: (context)=>ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index)=> buildArticleItem(list[index],context), 
        separatorBuilder: (context, index) =>myDivider(), 
        itemCount: list.length
        ), 
      fallback: (context)=> isSearch ? Container():  const Center(child: CircularProgressIndicator())
      ); 

      Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
void Function(String)?onSubmit,
 void Function(String)? onChanged,
 
 VoidCallback? onTap,
 
  required String lable,
  required IconData prefix,
  bool isClicable = true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChanged,
  enabled: isClicable,
  onTap:onTap ,
    validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon:Icon(prefix) ,
    border: OutlineInputBorder(),
  ),
);

void navigateTo(context,widget)=> Navigator.push(context, 
MaterialPageRoute(builder: (context)=>widget),
);

             