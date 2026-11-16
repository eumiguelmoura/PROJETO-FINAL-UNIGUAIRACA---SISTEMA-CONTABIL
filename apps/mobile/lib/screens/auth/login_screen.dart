import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../core/utils/validators.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/next_brand_mark.dart';

class LoginScreen extends StatefulWidget {
  final AuthService auth;
  const LoginScreen({super.key, required this.auth});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool loading = false;
  bool showPassword = false;
  String? error;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!form.currentState!.validate()) return;
    setState(() { loading = true; error = null; });
    try {
      await widget.auth.login(username.text.trim(), password.text);
      if (mounted) context.go(AppRoutes.home);
    } catch (e) {
      if (mounted) setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: NextBrandMark(size: 70)),
                    const SizedBox(height: 17),
                    const Center(child: NextBrandName(fontSize: 31)),
                    const SizedBox(height: 11),
                    const Text(
                      'GESTÃO CONTÁBIL E FISCAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.subdued, fontWeight: FontWeight.w700, letterSpacing: 2, fontSize: 10),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('Bem-vindo de volta.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.navy)),
                            const SizedBox(height: 8),
                            const Text('Acesse sua conta para continuar.', style: TextStyle(color: AppColors.subdued)),
                            const SizedBox(height: 26),
                            TextFormField(
                              controller: username,
                              validator: Validators.required,
                              decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.alternate_email)),
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.username],
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: password,
                              validator: Validators.required,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => showPassword = !showPassword),
                                  icon: Icon(showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                                  tooltip: showPassword ? 'Ocultar senha' : 'Mostrar senha',
                                ),
                              ),
                              obscureText: !showPassword,
                              autofillHints: const [AutofillHints.password],
                            ),
                            if (error != null) Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Text(error!, style: const TextStyle(color: Colors.red)),
                            ),
                            const SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: loading ? null : submit,
                              icon: loading
                                ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Icon(Icons.arrow_forward),
                              label: const Text('Acessar NextContábil'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Acesso protegido • Projeto acadêmico',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.subdued, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
