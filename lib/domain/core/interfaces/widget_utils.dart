import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetUtils {
  static Widget labelText({required String title, dynamic value, bool isUserBorder = true}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: isUserBorder ? const EdgeInsets.symmetric(vertical: 16, horizontal: 16) : null,
      decoration: isUserBorder
          ? BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              '${value ?? '-'}',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static Widget textField({
    Key? key,
    String? labelText,
    required String hint,
    IconData? icon,
    FormFieldValidator<String>? validator,
    TextEditingController? textEditingController,
    bool obscure = false,
    bool readonly = false,
    bool showicon = false,
    Function()? ontap,
    TextInputType keyboardtype = TextInputType.text,
    int? maxlength,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: maxLines,
        maxLength: maxlength,
        readOnly: readonly,
        obscureText: obscure,
        keyboardType: keyboardtype,
        onTap: readonly ? ontap : null,
        controller: textEditingController,
        // style: Get.textTheme.headline1?.copyWith(
        //   fontSize: 12,
        //   color: Colors.black,
        // ),
        decoration: InputDecoration(
            // fillColor: Colors.grey.shade200,
            // filled: true,
            labelText: labelText,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            // hintStyle: Get.textTheme.headline1?.copyWith(
            //   fontSize: 12,
            //   color: Colors.deepPurple,
            // ),
            prefixIcon: showicon
                ? Icon(
                    icon,
                    size: 22,
                    color: Colors.deepPurple,
                  )
                : null,
            suffixIcon: readonly
                ? Icon(
                    icon,
                    size: 22,
                    color: Colors.deepPurple,
                  )
                : null),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }

  static Widget radio<T>({
    String? textLabel,
    required T group,
    required List<T> dataList,
    required Widget Function(T) title,
    required Function(T?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          if (textLabel != null) Expanded(child: Text(textLabel)),
          ...dataList.map(
            (e) => Row(
              children: [
                Radio(
                  value: e,
                  groupValue: group,
                  onChanged: onChanged,
                ),
                title(e),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
