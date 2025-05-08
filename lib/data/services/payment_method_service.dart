import 'package:template_flutter_provider/data/entities/payment_method.dart';
import 'package:objectbox/objectbox.dart';

class PaymentMethodService {
  final Store store;

  PaymentMethodService(this.store);

  Future<void> addPaymentMethod(PaymentMethod method) async {
    store.box<PaymentMethod>().put(method);
  }

  List<PaymentMethod> getAllPaymentMethods() {
    return store.box<PaymentMethod>().getAll();
  }

  PaymentMethod? getPaymentMethodById(int id) {
    return store.box<PaymentMethod>().get(id);
  }

  Future<void> updatePaymentMethod(PaymentMethod method) async {
    store.box<PaymentMethod>().put(method);
  }

  Future<void> deletePaymentMethod(int id) async {
    store.box<PaymentMethod>().remove(id);
  }
}
