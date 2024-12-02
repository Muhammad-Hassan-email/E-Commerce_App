import 'package:e_commerce_app/Provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;
  
  @override
Widget build(BuildContext context) {
  final cartProducts = ref.watch(cartNotifierProvider);
  final total = ref.watch(cardTotalProvider);

  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(111, 228, 225, 225),
      title: Text(
        'Your Cart',
        style: GoogleFonts.oswald(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    ),
    body: total == 0
        ? Center(
            child: Text(
              'Your Cart is Empty',
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.grey,
              ),
            ),
          )
        : Column(
          children: [
            Column(
              children: cartProducts.map((product) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 20,
                    bottom: 15,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        product.image,
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(width: 10),
                      Text('${product.title}...'),
                      const Expanded(child: SizedBox(width: 20)),
                      Text('Rs.${product.price}'),
                      //const SizedBox(width: 0),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .removeProduct(product);
                        },
                        iconAlignment: IconAlignment.start,
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 100)),
                const Text(
                  'TotalPrice',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(width: 140,),
                Text('Rs.$total'),
              ],
            ),
          ],
        ),
  );
}

}