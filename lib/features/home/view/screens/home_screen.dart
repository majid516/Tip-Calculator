import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/core/components/custom_snackbar.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';
import 'package:tip_calculator/core/constants/utils/textfield_hight.dart';
import 'package:tip_calculator/features/home/view/screens/history_screen.dart';

// Custom TextFormField Widget
class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hasInteracted = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          TextfieldHight.textfieldHeight +
          20, // Increased to accommodate error text
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          label: Text(widget.labelText),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: MyColors.primaryColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(widget.prefixIcon, color: MyColors.primaryColor),
          errorStyle: const TextStyle(
            fontSize: 12,
            height: 1.0, // Fixed height for error text
          ),
          errorMaxLines: 1,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
        ),
        validator: widget.validator,
        onChanged: (value) {
          setState(() {
            _hasInteracted = true; // Enable validation only after interaction
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        autovalidateMode:
            _hasInteracted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

// Main Tip Calculator Screen
class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _billController = TextEditingController();
  final _customTipController = TextEditingController();
  final _splitController = TextEditingController();
  double _tipPercentage = 0.15;
  int _splitCount = 1;
  String _currency = 'USD';
  final List<Map<String, dynamic>> _history = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isTipChipSelected = true; // New flag to track tip chip selection

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _billController.dispose();
    _customTipController.dispose();
    _splitController.dispose();
    super.dispose();
  }

  void _calculateTip() {
    setState(() {}); // Refresh UI for calculations
  }

  void _applyCustomTip() {
    double customPercent = double.tryParse(_customTipController.text) ?? 0.0;
    if (customPercent >= 0 && customPercent <= 100) {
      setState(() {
        _tipPercentage = customPercent / 100;
        _isTipChipSelected = false; // Custom tip applied, so chip is not selected
        _calculateTip();
      });
    } else {
      showCustomSnackBar(context, 'Enter a valid tip percentage (0-100)', true);
    }
  }

  void _reset() {
    _billController.clear();
    _customTipController.clear();
    _splitController.clear();
    setState(() {
      _tipPercentage = 0.15;
      _splitCount = 1;
      _isTipChipSelected = true; // Reset to default chip selection
    });
  }

  void _saveHistory() {
    double bill = double.tryParse(_billController.text) ?? 0.0;
    double tip = bill * _tipPercentage;
    double totalPerPerson = (bill + tip) / _splitCount;

    if (formKey.currentState!.validate()) {
      setState(() {
        showCustomSnackBar(context, 'Tip Saved!', false);
        _history.insert(0, {
          'bill': bill,
          'tip': tip,
          'total': totalPerPerson,
          'currency': _currency,
          'date': DateTime.now(),
        });
      });
    } else {
      showCustomSnackBar(context, 'Please Fill Required Fields', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.width = MediaQuery.of(context).size.width;
    double bill = double.tryParse(_billController.text) ?? 0.0;
    double tip = bill * _tipPercentage;
    double totalPerPerson = (bill + tip) / _splitCount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.appBarThemeColor,
        elevation: 0,
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        leadingWidth: 15,
        leading: const SizedBox(width: 15),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Ready to Tip?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: MyColors.blackColor,
              ),
            ),
            Text(
              'Tip Calculator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: MyColors.blackColor,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (ctx) => HistoryScreen(history: _history),
                ),
              );
            },
            icon: const Icon(
              Icons.view_agenda_outlined,
              color: MyColors.blackColor,
            ),
          ),
        ],
      ),
      backgroundColor: MyColors.appBarThemeColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenSize.width,
          decoration: const BoxDecoration(
            color: MyColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Space.hSpace20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  12.0),
                  child: Column(
                    children: [
                      const Text(
                        'You dine, we divide!',
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.darkGreyColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Space.hSpace15,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _billController,
                              labelText: 'Enter Bill Amount',
                              prefixIcon: Icons.attach_money,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Bill Amount';
                                }
                                final bill = double.tryParse(value);
                                if (bill == null || bill <= 0) {
                                  return 'Enter a positive number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _calculateTip();
                              },
                            ),
                          ),
                           Space.wSpace5,
                          Container(
                            height: 47,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 2,
                                color: MyColors.primaryColor,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _currency,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                items: [
                                  'USD',
                                  'EUR',
                                  'GBP',
                                  'INR',
                                  'JPY',
                                  'CAD',
                                  'AUD',
                                  'CHF',
                                  'CNY',
                                  'SGD',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        Text(
                                          {
                                            'USD': '\$',
                                            'EUR': '€',
                                            'GBP': '£',
                                            'INR': '₹',
                                            'JPY': '¥',
                                            'CAD': 'C\$',
                                            'AUD': 'A\$',
                                            'CHF': 'CHF',
                                            'CNY': '¥',
                                            'SGD': 'S\$',
                                          }[value] ??
                                              value,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          value,
                                          style: const TextStyle(
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currency = newValue!;
                                    _calculateTip();
                                  });
                                },
                                style: const TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 16,
                                ),
                                dropdownColor: MyColors.whiteColor,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: MyColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
           
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Tip Percentage',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: [0.15, 0.20, 0.25].map((percent) {
                          return ChoiceChip(
                            label: Text('${(percent * 100).toInt()}%'),
                            selected: _tipPercentage == percent,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _tipPercentage = percent;
                                  _isTipChipSelected = true; // Chip selected
                                  _customTipController.clear();
                                  formKey.currentState?.validate();
                                  _calculateTip();
                                }
                              });
                            },
                            selectedColor: MyColors.primaryColor,
                            backgroundColor: MyColors.lightGreyColor,
                            labelStyle: TextStyle(
                              color: _tipPercentage == percent
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor,
                            ),
                          );
                        }).toList(),
                      ),
                      Space.hSpace10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _customTipController,
                              labelText: 'Custom Tip %',
                              prefixIcon: Icons.percent,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                // Skip validation if a tip chip is selected
                                if (_isTipChipSelected) {
                                  return null;
                                }
                                // Validate only if custom tip is used
                                if (value == null || value.isEmpty) {
                                  return 'Enter a tip percentage';
                                }
                                final tip = double.tryParse(value);
                                if (tip == null || tip < 0 || tip > 100) {
                                  return 'Enter a number between 0 and 100';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  formKey.currentState?.validate();
                                });
                              },
                            ),
                          ),
                          Space.wSpace5,
                          ElevatedButton(
                            onPressed: _applyCustomTip,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(color: MyColors.whiteColor),
                            ),
                          ),
                        ],
                      ),
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return LinearProgressIndicator(
                                  value: _tipPercentage,
                                  backgroundColor: MyColors.primaryColor
                                      .withOpacity(0.3),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    MyColors.primaryColor,
                                  ),
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(8),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: MyColors.primaryColor),
                            ),
                            child: Text(
                              '${(_tipPercentage * 100).toInt()}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Results',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColors.ternaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Tip Amount',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                                Text(
                                  '$_currency ${tip.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total per Person',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                                Text(
                                  '$_currency ${totalPerPerson.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        controller: _splitController,
                        labelText: 'Split between',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final val = int.tryParse(value);
                            if (val == null || val <= 0) {
                              return 'Enter a valid number';
                            }
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _splitCount = int.tryParse(value) ?? 1;
                            if (_splitCount < 1) _splitCount = 1;
                            formKey.currentState?.validate();
                            _calculateTip();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 2,
                          color: MyColors.primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(ScreenSize.width * 0.4, 45),
                        backgroundColor: MyColors.whiteColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: MyColors.blackColor),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _saveHistory,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(ScreenSize.width * 0.4, 45),
                        backgroundColor: MyColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: MyColors.whiteColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}