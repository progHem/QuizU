import 'package:provider/provider.dart';
import 'package:quiz_u/providers/questions.dart';

import 'auth.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<Phone>(create: (_) => Phone()),
  ChangeNotifierProvider<OtpClass>(create: (_) => OtpClass()),
  ChangeNotifierProvider<User>(create: (_) => User()),
  ChangeNotifierProvider<QuestionInfo>(create: (_) => QuestionInfo()),
];
