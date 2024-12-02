import 'package:e_commerce_app/Provider/cart_provider.dart';
import 'package:e_commerce_app/Provider/product_provider.dart';
import 'package:e_commerce_app/shared/cart_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);
    final buttonstyle = GoogleFonts.merienda(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(111, 228, 225, 225),
        title: Text(
          'QuickPick',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: const [CartIcons()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ), 
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.05),
              child: Column(
                children: [
                  Image.asset(
                    allProducts[index].image, 
                    width: 70, 
                    height: 70,
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  Text(allProducts[index].title,
                  style: GoogleFonts.merienda(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: 3,
                  ),
                ),
                  SizedBox(height: 4,),
                  Text('Rs.${allProducts[index].price}',
                  style: GoogleFonts.merienda(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(height: 4,),

                  if (cartProducts.contains(allProducts[index]))
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: (){
                        ref.read(
                          cartNotifierProvider.notifier).removeProduct(allProducts[index]);
                      },
                      child: Text(
                          'Remove',
                      ),
                    ),
                    
                  if (!cartProducts.contains(allProducts[index]))
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: (){
                        ref.read(
                          cartNotifierProvider.notifier).addProduct(allProducts[index]);
                        }, 
                      child: Text(
                          'Add to Cart',
                          style: buttonstyle,
                        )
                    ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}