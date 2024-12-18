import 'package:beauty_store/repository/repository.dart';
import 'package:beauty_store/utils/app_constant.dart';
import 'package:beauty_store/views/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  String? selectedSortOrder;
  @override
  void initState() {
    onLoad();
    super.initState();
  }

  onLoad() async {
    await Repository().getProducts();
    setState(() {});
  }

  void filterProductsByCategory(String category) {
    setState(() {
      AppConstant.isPriceFilter1 = false;
      AppConstant.isPriceFilter2 = false;

      AppConstant.isFilter = true;
      selectedCategory = category;
      AppConstant.filterProducts = AppConstant.products
          .where((product) => product.category == category)
          .toList();
    });
  }

  void sortProducts(String sortOrder) {
    setState(() {
      selectedSortOrder = sortOrder;
      if (sortOrder == "Highest Price First") {
        AppConstant.isPriceFilter2 = true;
        AppConstant.isPriceFilter1 = false;
        AppConstant.filterProducts.sort((a, b) => b.price.compareTo(a.price));
      } else if (sortOrder == "Lowest Price First") {
        AppConstant.isPriceFilter2 = false;
        AppConstant.isPriceFilter1 = true;
        AppConstant.filterProducts.sort((a, b) => a.price.compareTo(b.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appBarColor,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose from any category",
              style: TextStyle(
                  fontFamily: "SF Pro",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 140,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryName(
                    "Electronics",
                    "https://w7.pngwing.com/pngs/454/1021/png-transparent-consumer-electronics-gadget-advanced-electronics-electronic-component-others-electronics-laptop-electronic-device.png",
                    () {
                      filterProductsByCategory("electronics");
                    },
                    selectedCategory == "electronics",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CategoryName(
                    "Jewelery",
                    "https://static.vecteezy.com/system/resources/thumbnails/023/140/237/small_2x/fashionable-premium-designer-ring-jewelry-banner-ai-generated-photo.jpg",
                    () {
                      filterProductsByCategory("jewelery");
                    },
                    selectedCategory == "jewelery",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CategoryName(
                    "Men’s Wear",
                    "https://i.pinimg.com/564x/28/2b/07/282b078d6ef40b600f0d9a10a55b6d2d.jpg",
                    () {
                      filterProductsByCategory("men's clothing");
                    },
                    selectedCategory == "men's clothing",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CategoryName(
                    "Women’s Wear",
                    "https://img.freepik.com/premium-photo/white-polo-shirt-womens-casual-business-wear_1311477-68450.jpg",
                    () {
                      filterProductsByCategory("women's clothing");
                    },
                    selectedCategory == "women's clothing",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            AppConstant.isFilter
                ? Text(
                    "${AppConstant.filterProducts.length.toString()} products to choose from",
                    style: const TextStyle(
                        fontFamily: "SF Pro",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.isPriceFilter1
                            ? AppConstant.appBarColor
                            : AppConstant.containerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      sortProducts("Lowest Price First");
                    },
                    child: Text(
                      "Lowest price first",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppConstant.isPriceFilter1
                              ? Colors.white
                              : Colors.black),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.isPriceFilter2
                            ? AppConstant.appBarColor
                            : AppConstant.containerColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      sortProducts("Highest Price First");
                    },
                    child: Text(
                      "Highest price first",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppConstant.isPriceFilter2
                              ? Colors.white
                              : Colors.black),
                    ))
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Flexible(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: AppConstant.filterProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.78,
                    mainAxisSpacing: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                      productModel: AppConstant.filterProducts[index]);
                },
              ),
            ),
            // Flexible(
            //   child: FutureBuilder(
            //       future: Repository().getProducts(),
            //       builder: (ctx, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return Center(child: const CircularProgressIndicator());
            //         } else if (snapshot.hasError) {
            //           return Center(
            //             child: Text(
            //               '${snapshot.error} occurred',
            //               style: TextStyle(fontSize: 18),
            //             ),
            //           );
            //         } else if (snapshot.hasData) {
            //           final product = snapshot.data;
            //           return GridView.builder(
            //             physics: BouncingScrollPhysics(),
            //             itemCount: product!.length,
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 2,
            //                 crossAxisSpacing: 10.0,
            //                 mainAxisSpacing: 10.0),
            //             itemBuilder: (BuildContext context, int index) {
            //               return ProductCard(productModel: product[index]);
            //             },
            //           );
            //         } else {
            //           return Center(
            //             child: Text("No Products Found"),
            //           );
            //         }
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget CategoryName(
  String name,
  String image,
  VoidCallback,
  bool isSelected,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.all(5), // Border width
        decoration: isSelected
            ? const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4CBACC), // Outer gradient border color
                    Color(0xFF77D28B),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            : null,

        child: InkWell(
          onTap: VoidCallback,
          child: ClipOval(
            child: Image.network(
              image,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        name,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      )
    ],
  );
}
