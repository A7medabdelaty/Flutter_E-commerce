import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

Widget mySeparatorBuilder({double startSpace = 0}) => Padding(
      padding: EdgeInsetsDirectional.only(
        start: startSpace,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultInputField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  var onSubmit,
  required String label,
  var onChange,
  IconData? prefixIcon,
  IconData? suffixIcon,
  var onTap,
  bool readOnly = false,
  validator,
  var suffixAction,
  bool obscureText = false,
}) =>
    TextFormField(
      onChanged: onChange,
      onTap: onTap,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      obscureText: obscureText ? true : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
            onPressed: suffixAction,
            icon: Icon(
              suffixIcon,
            )),
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  required String text,
  Color color = Colors.blue,
  var onPressed,
  double radius = 0.0,
}) =>
    Container(
        height: 50.0,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ));

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndReplace(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

void Logout(context) {
  CacheHelper.removeData(key: 'token')
      .then((value) => navigateAndReplace(context, ShopLoginScreen()));
}
