import 'package:e_commerce_app/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Notifier Providers
// use when you need to update the state & notify consumers

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  
  @override
  Set<Product> build() {
    return const {};
  }

  // methods to update state
  void addProduct(Product product){
    if(!state.contains(product))
    {
      state = {...state, product};
    }
  }

  void removeProduct(Product product){
    if(state.contains(product)){
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

@riverpod
int cardTotal(ref) {
  final cartProduct = ref.watch(cartNotifierProvider);
  int total = 0;
  for(Product product in cartProduct){
    total += product.price;
  }
  return total; 
}
