import 'package:template_flutter_provider/data/entities/payment_method.dart';
import 'package:template_flutter_provider/data/services/payment_method_service.dart';

class PaymentMethodRepository {
  final PaymentMethodService paymentMethodService;

  PaymentMethodRepository(this.paymentMethodService);

  Future<void> addPaymentMethod(String name, String description) async {
    final method = PaymentMethod(name: name, description: description);
    await paymentMethodService.addPaymentMethod(method);
  }

  List<PaymentMethod> getAllPaymentMethods() {
    return paymentMethodService.getAllPaymentMethods();
  }

  PaymentMethod? getPaymentMethodById(int id) {
    return paymentMethodService.getPaymentMethodById(id);
  }

  Future<void> updatePaymentMethod(PaymentMethod method) async {
    await paymentMethodService.updatePaymentMethod(method);
  }

  Future<void> deletePaymentMethod(int id) async {
    await paymentMethodService.deletePaymentMethod(id);
  }
}
