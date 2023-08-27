import 'package:flutter/material.dart';


class InputCurrency extends StatelessWidget {
  final String? currency;
  final String? prefixText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const InputCurrency({
    this.prefixText,
    required this.currency,
    super.key,
    this.onChanged,
    this.controller

  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(
            width: 180,
            child: InputDecorator(
              decoration:  InputDecoration(
                border: InputBorder.none,
                prefixText:prefixText,
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                style:const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ), 
          const SizedBox(
            width: 30,
          ),
          Text(currency.toString(), style: const TextStyle(fontSize: 16),)
        ],
      ),
    );
  }
}
