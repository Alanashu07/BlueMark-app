import 'package:bluemark/Pages/homescreen/category_deals_screen.dart';
import 'package:bluemark/constants/global_variables.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 80,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> CategoryDealsScreen(category: GlobalVariables.categoryImages[index]['title']!)));},
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(GlobalVariables.categoryImages[index]['title']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                  ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
