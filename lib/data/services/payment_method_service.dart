import 'package:template_flutter_provider/data/entities/payment_method.dart';
import 'package:template_flutter_provider/data/repositories/payment_method_repository.dart';

class PaymentMethodService {
  final PaymentMethodRepository repository;

  PaymentMethodService(this.repository);

  Future<void> addPaymentMethod(String name, String description) async {
    final method = PaymentMethod(name: name, description: description);
    await repository.addPaymentMethod(method);
  }

  List<PaymentMethod> getAllPaymentMethods() {
    return repository.getAllPaymentMethods();
  }

  PaymentMethod? getPaymentMethodById(int id) {
    return repository.getPaymentMethodById(id);
  }

  Future<void> updatePaymentMethod(PaymentMethod method) async {
    await repository.updatePaymentMethod(method);
  }

  Future<void> deletePaymentMethod(int id) async {
    await repository.deletePaymentMethod(id);
  }
}
