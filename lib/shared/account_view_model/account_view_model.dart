import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/account_model.dart';

final accountViewModelProvider =
    StateNotifierProvider<AccountViewModel, Account?>(
  (ref) {
    return AccountViewModel();
  },
);

class AccountViewModel extends StateNotifier<Account?> {
  AccountViewModel() : super(null);

  void setAccount(Account account) {
    state = account;
  }

  void clearAccount() {
    state = null;
  }
}
