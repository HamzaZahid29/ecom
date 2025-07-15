import 'package:ecom/core/services/app_validation_service.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/password_visiblity_provider.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_elevated_button.dart';
import '../../../core/widgets/app_form_field.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Landed on screen');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key:  _formKey,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Login to ${AppConstants.appName}',
                        style: AppTextStyles.heading1Normal,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Login to your account to continue using ${AppConstants.appName}',
                  style: AppTextStyles.bodyText,
                ),
                const SizedBox(height: 10),
                AppFormField(
                  title: 'Username',
                  icon: HugeIcons.strokeRoundedUser,
                  textEditingController: emailController,
                  validator: AppValidationService.validateRequired,

                ),
                // AppFormField(
                //   textEditingController: passwordController,
                //   title: 'Password',
                //   isObsecured: authProvider.isObsecured,
                //   icon: authProvider.isObsecured
                //       ? Icons.visibility_off_outlined
                //       : Icons.visibility_outlined,
                //   validator: AppValidationService.validateRequired,
                //   onTap: () {
                //     authProvider.toggleObsecured();
                //   },
                // ),

                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return AppFormField(
                      textEditingController: passwordController,
                      title: 'Password',
                      isObsecured: authProvider.isObsecured,
                      icon: authProvider.isObsecured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onTap: () {
                        authProvider.toggleObsecured();
                      },
                      validator: AppValidationService.validateRequired,
                    );
                  },
                ),
                const SizedBox(height: 10),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return AppElevatedButton(
                      onTap: authProvider.isLoading ? null : () => _handleLogin(context),
                      lable: authProvider.isLoading ? 'Logging in...' : 'Get Started',
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      await context.read<AuthProvider>().login(
        emailController.text.trim(),
        passwordController.text.trim(),
        context,
      );
    }
  }
}
