import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tip_calculator/core/components/custom_snackbar.dart';
import 'package:tip_calculator/core/components/custom_textformfield.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';
import 'package:tip_calculator/features/home/view/widgets/bottom_controls_widget.dart';
import 'package:tip_calculator/features/home/view/widgets/home_screen_appbar.dart';

final GlobalKey billFieldKey = GlobalKey();
final GlobalKey tipFieldKey = GlobalKey();
final GlobalKey splitPersonKey = GlobalKey();
final GlobalKey saveKey = GlobalKey();
final GlobalKey resetKey = GlobalKey();
final GlobalKey historyIconKey = GlobalKey();

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
  String _currency = 'INR';
  final List<Map<String, dynamic>> _history = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isTipChipSelected = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([
        historyIconKey,
        billFieldKey,
        tipFieldKey,
        splitPersonKey,
        resetKey,
        saveKey,
      ]);
    });
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
    setState(() {});
  }

  void _applyCustomTip() {
    double customPercent = double.tryParse(_customTipController.text) ?? 0.0;
    if (customPercent >= 0 && customPercent <= 100) {
      setState(() {
        _tipPercentage = customPercent / 100;
        _isTipChipSelected = false;
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
      _isTipChipSelected = true;
    });
  }

  void _saveHistory() {
    double bill = double.tryParse(_billController.text) ?? 0.0;
    double tip = bill * _tipPercentage;
    double totalPerPerson = (bill + tip) / _splitCount;

    if (formKey.currentState!.validate()) {
      setState(() {
        showCustomSnackBar(context, 'Tip Successfully Saved!', false);
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
      appBar: PreferredSize(
        preferredSize: Size(ScreenSize.width, 80),
        child: HomeScreenAppbar(history: _history),
      ),
      backgroundColor: MyColors.appBarThemeColor,
      body: Stack(
        children: [
          Container(
            width: ScreenSize.width,
            height: ScreenSize.height - 80,
            decoration: const BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Space.hSpace20,
                      enterBillAmoundWidgetBuilder(),
                      selectTipPercentageWidgetBuilder(),
                      Space.hSpace15,
                      resultWidgetBuilder(tip, bill),
                      splitPerPersonWidgetBuilder(totalPerPerson),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BottomControlsWidget(reset: _reset, saveHistory: _saveHistory),
        ],
      ),
    );
  }

  Column splitPerPersonWidgetBuilder(double totalPerPerson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    'Per Person',
                    style: TextStyle(fontSize: 16, color: MyColors.blackColor),
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
        SizedBox(height: 150),
      ],
    );
  }

  Column resultWidgetBuilder(double tip, double bill) {
    return Column(
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
        Space.hSpace10,
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
                    style: TextStyle(fontSize: 16, color: MyColors.blackColor),
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
              Space.hSpace10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Person',
                    style: TextStyle(fontSize: 16, color: MyColors.blackColor),
                  ),
                  Text(
                    '$_currency ${(bill + tip).toStringAsFixed(2)}',
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
        Space.hSpace20,
        const Text(
          'Split by Friends',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor,
          ),
        ),
        Space.hSpace15,
        Showcase(
          key: splitPersonKey,
          description: 'Split Your Amout Between Person',
          child: CustomTextFormField(
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
        ),
      ],
    );
  }

  Column selectTipPercentageWidgetBuilder() {
    return Column(
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
        Space.hSpace10,
        Wrap(
          spacing: 8.0,
          children:
              [0.15, 0.20, 0.25].map((percent) {
                return ChoiceChip(
                  label: Text('${(percent * 100).toInt()}%'),
                  selected: _tipPercentage == percent,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _tipPercentage = percent;
                        _isTipChipSelected = true;
                        _customTipController.clear();
                        formKey.currentState?.validate();
                        _calculateTip();
                      }
                    });
                  },
                  selectedColor: MyColors.primaryColor,
                  backgroundColor: MyColors.lightGreyColor,
                  labelStyle: TextStyle(
                    color:
                        _tipPercentage == percent
                            ? MyColors.whiteColor
                            : MyColors.blackColor,
                  ),
                );
              }).toList(),
        ),
        Space.hSpace10,
        Showcase(
          key: tipFieldKey,
          description: 'Enter Custom Tip Percentage',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _customTipController,
                  labelText: 'Custom Tip %',
                  prefixIcon: Icons.percent,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isTipChipSelected) {
                      return null;
                    }
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
                child: const Text(
                  'Apply',
                  style: TextStyle(color: MyColors.whiteColor),
                ),
              ),
            ],
          ),
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
                    backgroundColor: MyColors.primaryColor.withValues(
                      alpha: 0.3,
                    ),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      MyColors.primaryColor,
                    ),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(8),
                  );
                },
              ),
            ),

            Space.wSpace15,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }

  Column enterBillAmoundWidgetBuilder() {
    return Column(
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
        Showcase(
          key: billFieldKey,
          description: 'Enter Bill Amount & Select Currency',
          child: Row(
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

              dropdownCurrencySelectorBuilder(),
            ],
          ),
        ),
      ],
    );
  }

  Container dropdownCurrencySelectorBuilder() {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1.2, color: MyColors.primaryColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _currency,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          items:
              currencyList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(
                        currentSymbolsMap[value] ?? value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: MyColors.primaryColor,
                        ),
                      ),
                      Space.wSpace10,
                      Text(
                        value,
                        style: const TextStyle(color: MyColors.primaryColor),
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
          style: const TextStyle(color: MyColors.blackColor, fontSize: 16),
          dropdownColor: MyColors.whiteColor,
          icon: const Icon(Icons.arrow_drop_down, color: MyColors.primaryColor),
        ),
      ),
    );
  }
}

const currencyList = [
  'INR',
  'USD',
  'EUR',
  'GBP',
  'JPY',
  'CAD',
  'AUD',
  'CHF',
  'CNY',
];

const currentSymbolsMap = {
  'INR': '₹',
  'USD': '\$',
  'EUR': '€',
  'GBP': '£',
  'JPY': '¥',
  'CAD': 'C\$',
  'AUD': 'A\$',
  'CHF': 'CHF',
  'CNY': '¥',
  'SGD': 'S\$',
};
