import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const RopeInspectorApp());
}

// ---------------- КОРПОРАТИВНА ПАЛІТРА СТАЛЬКАНАТ ----------------
class BrandColors {
  static const Color yellow = Color(0xFFFFC000);
  static const Color dark = Color(0xFF1E1E1E);
  static const Color darkHeader = Color(0xFF121212);
  static const Color bgGrey = Color(0xFFF7F8FA);
  static const Color borderGrey = Color(0xFFE0E0E0);
}

enum AppLanguage { uk, en }
enum CoreType { steel, fiber, rotationResistant }
enum LayType { ordinary, lang }
enum SpoolingType { singleLayer, multiLayer }
enum MechanismClass { m1ToM4, m5ToM8 }
enum RopeVerdict { fit, warning, discard }

class Translations {
  static const Map<AppLanguage, Map<String, String>> _strings = {
    AppLanguage.uk: {
      'app_title': 'СТАЛЬКАНАТ | ISO 4309',
      'brand_name': 'СТАЛЬКАНАТ',
      'cert_no': '№ Сертифіката / Протоколу',
      'company': 'Підприємство / Замовник',
      'location': 'Місце встановлення',
      'crane_id': 'ID / Найменування механізму',
      'rope_construct': 'Конструкція каната',
      'd_nom': 'Номінал d (мм)',
      'd_act': 'Факт d (мм)',
      'b_6d': 'Обриви на 6d (шт.)',
      'b_30d': 'Обриви на 30d (шт.)',
      'duty_class': 'Режим роботи механізму (ISO 4301-1):',
      'm1_m4': 'M1 – M4 (стандартний)',
      'm5_m8': 'M5 – M8 (подвійна норма обривів)',
      'lay_ord': 'Хрестова звивка',
      'lay_lang': 'Одностороння звивка',
      'spool_single': '1-шарова намотка',
      'spool_multi': 'Багатошарова намотка',
      'deformations': 'Неприпустимі деформації / заломи каната',
      'btn_calc': 'РОЗРАХУВАТИ СТАТУС',
      'btn_cert': 'СФОРМУВАТИ СЕРТИФІКАТ / ДРУК',
      'fill_all': 'Будь ласка, заповніть усі числові поля',
      'verdict_fit': 'ПРИДАТНИЙ ДО ЕКСПЛУАТАЦІЇ',
      'verdict_warn': 'УВАГА: ПОТРІБЕН ПОСИЛЕНИЙ КОНТРОЛЬ',
      'verdict_disc': 'КРИТИЧНО: КАНАТ ПІДЛЯГАЄ БРАКУВАННЮ ТА ЗАМІНІ!',
      'pdf_title': 'АКТ ІНСПЕКЦІЇ ТА БРАКУВАННЯ СТАЛЬНОГО КАНАТА №',
      'pdf_sub': 'відповідно до вимог стандарту ISO 4309:2017',
      'pdf_date': 'Дата інспекції:',
      'sec_1': '1. СПЕЦИФІКАЦІЯ КАНАТА ТА УМОВИ ЕКСПЛУАТАЦІЇ',
      'sec_2': '2. РЕЗУЛЬТАТИ ВИМІРЮВАНЬ ТА ВІДПОВІДНІСТЬ НОРМАМ',
      'sec_3': '3. ВИСНОВОК ТА ОСТАТОЧНИЙ ВЕРДИКТ',
      'col_param': 'Контрольований параметр',
      'col_meas': 'Фактичне значення',
      'col_limit': 'Норма бракування ISO 4309',
      'param_diam': 'Виміряний діаметр каната',
      'param_loss': 'Зменшення діаметра каната (%)',
      'param_6d': 'Кількість обривів дротів на довжині 6d',
      'param_30d': 'Кількість обривів дротів на довжині 30d',
      'param_def': 'Механічні деформації / заломи',
      'not_perm': 'не допускаються',
      'yes': 'Виявлено',
      'no': 'Відсутні',
      'inspector': 'Компетентна особа / Інспектор: ____________________',
      'signature': 'Підпис / Печатка: ____________________',
    },
    AppLanguage.en: {
      'app_title': 'STALKANAT | ISO 4309',
      'brand_name': 'STALKANAT',
      'cert_no': 'Certificate No.',
      'company': 'Company / Facility',
      'location': 'Location',
      'crane_id': 'Crane / Equipment ID',
      'rope_construct': 'Rope Construction',
      'd_nom': 'Nominal d (mm)',
      'd_act': 'Measured d (mm)',
      'b_6d': 'Broken wires over 6d',
      'b_30d': 'Broken wires over 30d',
      'duty_class': 'Mechanism Duty Class (ISO 4301-1):',
      'm1_m4': 'M1 – M4 (standard)',
      'm5_m8': 'M5 – M8 (doubled limit)',
      'lay_ord': 'Ordinary lay',
      'lay_lang': 'Lang lay',
      'spool_single': 'Single-layer spooling',
      'spool_multi': 'Multi-layer spooling',
      'deformations': 'Severe deformations / kinks',
      'btn_calc': 'EVALUATE ROPE STATUS',
      'btn_cert': 'GENERATE CERTIFICATE / PRINT',
      'fill_all': 'Please fill in all numeric fields',
      'verdict_fit': 'FIT FOR CONTINUED OPERATION',
      'verdict_warn': 'WARNING: INCREASED MONITORING REQUIRED',
      'verdict_disc': 'CRITICAL: ROPE SHALL BE DISCARDED AND REPLACED!',
      'pdf_title': 'WIRE ROPE INSPECTION AND DISCARD CERTIFICATE No.',
      'pdf_sub': 'in accordance with ISO 4309:2017 standard requirements',
      'pdf_date': 'Inspection Date:',
      'sec_1': '1. ROPE SPECIFICATIONS & OPERATING CONDITIONS',
      'sec_2': '2. INSPECTION RESULTS & COMPLIANCE WITH NORMS',
      'sec_3': '3. CONCLUSION & FINAL VERDICT',
      'col_param': 'Monitored Parameter',
      'col_meas': 'Measured',
      'col_limit': 'ISO 4309 Discard Limit',
      'param_diam': 'Measured rope diameter',
      'param_loss': 'Decrease in rope diameter (%)',
      'param_6d': 'Broken wires over 6d length',
      'param_30d': 'Broken wires over 30d length',
      'param_def': 'Severe deformation / Kinks',
      'not_perm': 'not permitted',
      'yes': 'Yes',
      'no': 'No',
      'inspector': 'Competent Person / Inspector: ____________________',
      'signature': 'Signature / Stamp: ____________________',
    }
  };

  static String t(AppLanguage lang, String key) => _strings[lang]?[key] ?? key;
}

class RopeSpec {
  final String name;
  final String rcn;
  final CoreType coreType;

  const RopeSpec({
    required this.name,
    required this.rcn,
    required this.coreType,
  });

  bool get isRotationResistant => coreType == CoreType.rotationResistant;

  double getMaxDiameterLossLimit(bool isMultiLayer) {
    if (isMultiLayer) {
      return isRotationResistant ? 7.5 : 10.0;
    }
    switch (coreType) {
      case CoreType.steel:
        return 7.5;
      case CoreType.fiber:
        return 10.0;
      case CoreType.rotationResistant:
        return 5.0;
    }
  }
}

class RopeDatabase {
  static const List<RopeSpec> catalog = [
    RopeSpec(name: '6x7-FC (ГОСТ 3069 / EN 12385-4)', rcn: '01', coreType: CoreType.fiber),
    RopeSpec(name: '6x7-WSC / IWRC (ГОСТ 3066)', rcn: '02', coreType: CoreType.steel),
    RopeSpec(name: '6x19M-FC / WSC (ГОСТ 2688 / ГОСТ 3070)', rcn: '03', coreType: CoreType.steel),
    RopeSpec(name: '6x19M-WSC', rcn: '04', coreType: CoreType.steel),
    RopeSpec(name: '6x19S-IWRC (ГОСТ 3077)', rcn: '04', coreType: CoreType.steel),
    RopeSpec(name: '6x25F-IWRC / 6x25Fi (ГОСТ 7667)', rcn: '04', coreType: CoreType.steel),
    RopeSpec(name: '6x25TS-IWRC (Трехгранно-прядный)', rcn: '04', coreType: CoreType.steel),
    RopeSpec(name: '8x19S-IWRC (8-прядный Seale)', rcn: '04', coreType: CoreType.steel),
    RopeSpec(name: '8x19S-PWRC (Параллельно-свитый)', rcn: '04', coreType: CoreType.steel),
    RopeSpec(name: '6x26WS-IWRC / FC', rcn: '05', coreType: CoreType.steel),
    RopeSpec(name: '6xK26WS-IWRC (Пластически обжатый)', rcn: '06', coreType: CoreType.steel),
    RopeSpec(name: '8x25F-IWRC', rcn: '06', coreType: CoreType.steel),
    RopeSpec(name: '8xK26WS-IWRC (Обжатые пряди)', rcn: '06', coreType: CoreType.steel),
    RopeSpec(name: '6x31WS-IWRC', rcn: '07', coreType: CoreType.steel),
    RopeSpec(name: '6x36WS-FC (ГОСТ 7668)', rcn: '08', coreType: CoreType.fiber),
    RopeSpec(name: '6x36WS-IWRC (ГОСТ 7669 / EN 12385)', rcn: '09', coreType: CoreType.steel),
    RopeSpec(name: '6xK36WS-IWRC (Пластически обжатый)', rcn: '09', coreType: CoreType.steel),
    RopeSpec(name: '8x36WS-IWRC / FC', rcn: '09', coreType: CoreType.steel),
    RopeSpec(name: '8xK26WS-PWRC (Параллельно-свитый обжатый)', rcn: '09', coreType: CoreType.steel),
    RopeSpec(name: '6x37M-IWRC (ГОСТ 3071 / 3079)', rcn: '10', coreType: CoreType.steel),
    RopeSpec(name: '6x41WS-IWRC (EN 12385-4)', rcn: '11', coreType: CoreType.steel),
    RopeSpec(name: '8x41WS-IWRC / FC', rcn: '12', coreType: CoreType.steel),
    RopeSpec(name: '8x49SWS-IWRC', rcn: '13', coreType: CoreType.steel),
    RopeSpec(name: '4x29F (4-прядный некрутящийся)', rcn: '21', coreType: CoreType.rotationResistant),
    RopeSpec(name: '4xK26WS (4-прядный обжатый)', rcn: '22', coreType: CoreType.rotationResistant),
    RopeSpec(name: 'K3x40 / K4x40 (Обжатый)', rcn: '22', coreType: CoreType.rotationResistant),
    RopeSpec(name: 'K3x48 / K4x48 (Обжатый)', rcn: '22', coreType: CoreType.rotationResistant),
    RopeSpec(name: '17x7-FC (17 прядей)', rcn: '23-1', coreType: CoreType.rotationResistant),
    RopeSpec(name: '18x7-WSC / 19x7 (ГОСТ 3088 / EN 12385-4)', rcn: '23-1', coreType: CoreType.rotationResistant),
    RopeSpec(name: '12xP6:3xQ24 (Paragon)', rcn: '23-1', coreType: CoreType.rotationResistant),
    RopeSpec(name: '34(W)x7-WSC / 35(W)x7', rcn: '23-2', coreType: CoreType.rotationResistant),
    RopeSpec(name: '34(W)xK7-WSC (Обжатые пряди)', rcn: '23-2', coreType: CoreType.rotationResistant),
    RopeSpec(name: '39(W)x7-WSC (Многопрядный)', rcn: '23-3', coreType: CoreType.rotationResistant),
    RopeSpec(name: '39(W)xK7-KWSC (Обжатый)', rcn: '23-3', coreType: CoreType.rotationResistant),
    RopeSpec(name: '18x19S-FC', rcn: '24', coreType: CoreType.rotationResistant),
    RopeSpec(name: '18x19S-IWRC / WSC (ГОСТ 3089)', rcn: '25', coreType: CoreType.rotationResistant),
    RopeSpec(name: '18xK19S-WSC / 19xK19S', rcn: '26', coreType: CoreType.rotationResistant),
    RopeSpec(name: '24wx7 / 28wx7', rcn: '27', coreType: CoreType.rotationResistant),
    RopeSpec(name: '35wxK7 (Высокопрочный крановый)', rcn: '28', coreType: CoreType.rotationResistant),
    RopeSpec(name: '24wx19S-IWRC', rcn: '29', coreType: CoreType.rotationResistant),
    RopeSpec(name: '34(W)xK19-WSC', rcn: '30', coreType: CoreType.rotationResistant),
    RopeSpec(name: '36wx19S / 36wxK19S', rcn: '31', coreType: CoreType.rotationResistant),
  ];
}

class InspectionResult {
  final double diameterLossPercent;
  final double allowedDiameterLossLimit;
  final double minAllowedDiameter;
  final int limitBreaks6d;
  final int limitBreaks30d;
  final double diameterSeverity;
  final double breakSeverity;
  final bool hasDeformations;
  final RopeVerdict verdict;
  final List<String> reasons;

  InspectionResult({
    required this.diameterLossPercent,
    required this.allowedDiameterLossLimit,
    required this.minAllowedDiameter,
    required this.limitBreaks6d,
    required this.limitBreaks30d,
    required this.diameterSeverity,
    required this.breakSeverity,
    required this.hasDeformations,
    required this.verdict,
    required this.reasons,
  });
}

class RopeInspectorEngine {
  static const Map<String, List<int>> _rcnTable = {
    '01': [2, 4, 1, 2],
    '02': [2, 6, 3, 3],
    '03': [4, 8, 2, 4],
    '04': [5, 10, 2, 5],
    '05': [6, 11, 3, 6],
    '06': [6, 13, 3, 6],
    '07': [7, 14, 4, 7],
    '08': [8, 16, 4, 8],
    '09': [9, 18, 4, 9],
    '10': [10, 19, 5, 10],
    '11': [10, 21, 5, 10],
    '12': [11, 22, 6, 11],
    '13': [12, 24, 6, 12],
    '21': [2, 4, 2, 4],
    '22': [2, 4, 2, 4],
    '23-1': [2, 4, 2, 4],
    '23-2': [3, 5, 3, 5],
    '23-3': [3, 5, 3, 5],
    '24': [3, 6, 3, 6],
    '25': [4, 7, 4, 7],
    '26': [4, 8, 4, 8],
    '27': [4, 9, 4, 9],
    '28': [5, 10, 5, 10],
    '29': [5, 10, 5, 10],
    '30': [6, 11, 6, 11],
    '31': [6, 12, 6, 12],
  };

  static InspectionResult evaluate({
    required RopeSpec rope,
    required double nominalDiameter,
    required double actualDiameter,
    required int brokenWires6d,
    required int brokenWires30d,
    required bool hasDeformations,
    required LayType layType,
    required SpoolingType spoolingType,
    required MechanismClass mechClass,
    required AppLanguage lang,
  }) {
    final List<String> reasons = [];
    final bool isOrdinary = layType == LayType.ordinary;
    final bool isMultiLayer = spoolingType == SpoolingType.multiLayer;

    final rcnData = _rcnTable[rope.rcn] ?? [4, 8, 2, 4];
    int limit6d = isOrdinary ? rcnData[0] : rcnData[2];
    int limit30d = isOrdinary ? rcnData[1] : rcnData[3];

    if (!rope.isRotationResistant && mechClass == MechanismClass.m5ToM8) {
      limit6d *= 2;
      limit30d *= 2;
    }

    if (isMultiLayer) {
      limit6d *= 2;
      limit30d *= 2;
    }

    final double sev6d = (brokenWires6d / limit6d) * 100.0;
    final double sev30d = (brokenWires30d / limit30d) * 100.0;
    final double breakSeverity = sev6d > sev30d ? sev6d : sev30d;

    final double allowedDropLimit = rope.getMaxDiameterLossLimit(isMultiLayer);
    final double minAllowedDiameter = nominalDiameter * (1.0 - (allowedDropLimit / 100.0));

    double diameterLossPercent = 0.0;
    if (actualDiameter < nominalDiameter) {
      diameterLossPercent = ((nominalDiameter - actualDiameter) / nominalDiameter) * 100.0;
    }
    final double diameterSeverity = (diameterLossPercent / allowedDropLimit) * 100.0;

    if (hasDeformations) {
      reasons.add(lang == AppLanguage.uk
          ? 'Виявлено неприпустимі механічні деформації / заломи'
          : 'Severe mechanical deformations / kinks detected');
    }
    if (brokenWires6d >= limit6d) {
      reasons.add(lang == AppLanguage.uk
          ? 'Перевищено ліміт обривів на 6d ($brokenWires6d з $limit6d)'
          : 'Broken wires limit exceeded over 6d ($brokenWires6d of $limit6d)');
    }
    if (brokenWires30d >= limit30d) {
      reasons.add(lang == AppLanguage.uk
          ? 'Перевищено ліміт обривів на 30d ($brokenWires30d з $limit30d)'
          : 'Broken wires limit exceeded over 30d ($brokenWires30d of $limit30d)');
    }
    if (diameterLossPercent >= allowedDropLimit) {
      reasons.add(lang == AppLanguage.uk
          ? 'Зменшення діаметра ${diameterLossPercent.toStringAsFixed(1)}% (Ліміт: $allowedDropLimit%)'
          : 'Diameter reduction ${diameterLossPercent.toStringAsFixed(1)}% (Limit: $allowedDropLimit%)');
    }

    RopeVerdict verdict;
    if (hasDeformations || breakSeverity >= 100.0 || diameterSeverity >= 100.0) {
      verdict = RopeVerdict.discard;
    } else if (breakSeverity >= 40.0 || diameterSeverity >= 50.0) {
      verdict = RopeVerdict.warning;
      if (reasons.isEmpty) {
        reasons.add(lang == AppLanguage.uk
            ? 'Потрібен частіший контроль стану каната'
            : 'Increased inspection frequency required');
      }
    } else {
      verdict = RopeVerdict.fit;
    }

    return InspectionResult(
      diameterLossPercent: diameterLossPercent,
      allowedDiameterLossLimit: allowedDropLimit,
      minAllowedDiameter: minAllowedDiameter,
      limitBreaks6d: limit6d,
      limitBreaks30d: limit30d,
      diameterSeverity: diameterSeverity,
      breakSeverity: breakSeverity,
      hasDeformations: hasDeformations,
      verdict: verdict,
      reasons: reasons,
    );
  }
}

// ---------------- ROOT APP ----------------
class RopeInspectorApp extends StatelessWidget {
  const RopeInspectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STALKANAT | Rope Inspector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: BrandColors.bgGrey,
        colorScheme: ColorScheme.fromSeed(
          seedColor: BrandColors.yellow,
          primary: BrandColors.dark,
          secondary: BrandColors.yellow,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: BrandColors.darkHeader,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------------- SPLASH SCREEN (ENGLISH) ----------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 3300), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (context, anim, _) => FadeTransition(
              opacity: anim,
              child: const InspectionScreen(),
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.darkHeader,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  decoration: BoxDecoration(
                    color: BrandColors.yellow,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: BrandColors.yellow.withValues(alpha: 0.35),
                        blurRadius: 28,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.precision_manufacturing, size: 38, color: BrandColors.darkHeader),
                      const SizedBox(width: 14),
                      Text(
                        'STALKANAT',
                        style: GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.2,
                          color: BrandColors.darkHeader,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'WIRE ROPE INSPECTION & DISCARD SYSTEM',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 48),
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(BrandColors.yellow),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading ISO 4309:2017 engineering database...',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- ОСНОВНИЙ ЕКРАН ----------------
class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  AppLanguage _currentLanguage = AppLanguage.uk;
  RopeSpec _selectedRope = RopeDatabase.catalog[3];
  LayType _layType = LayType.ordinary;
  SpoolingType _spoolingType = SpoolingType.singleLayer;
  MechanismClass _mechClass = MechanismClass.m1ToM4;
  bool _hasDeformations = false;

  final _certNoController = TextEditingController(text: '001/2026');
  final _companyController = TextEditingController(text: 'ПрАТ «Стальканат»');
  final _locationController = TextEditingController(text: 'Цех №1 / Ділянка підйому');
  final _equipmentController = TextEditingController(text: 'Кран мостовий №1');
  final _nominalDiamController = TextEditingController(text: '18.0');
  final _actualDiamController = TextEditingController(text: '17.0');
  final _breaks6dController = TextEditingController(text: '2');
  final _breaks30dController = TextEditingController(text: '5');

  InspectionResult? _result;

  String tr(String key) => Translations.t(_currentLanguage, key);

  void _calculate() {
    final double? nomD = double.tryParse(_nominalDiamController.text.replaceAll(',', '.'));
    final double? actD = double.tryParse(_actualDiamController.text.replaceAll(',', '.'));
    final int? b6d = int.tryParse(_breaks6dController.text);
    final int? b30d = int.tryParse(_breaks30dController.text);

    if (nomD == null || actD == null || b6d == null || b30d == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('fill_all')),
          backgroundColor: BrandColors.darkHeader,
        ),
      );
      return;
    }

    setState(() {
      _result = RopeInspectorEngine.evaluate(
        rope: _selectedRope,
        nominalDiameter: nomD,
        actualDiameter: actD,
        brokenWires6d: b6d,
        brokenWires30d: b30d,
        hasDeformations: _hasDeformations,
        layType: _layType,
        spoolingType: _spoolingType,
        mechClass: _mechClass,
        lang: _currentLanguage,
      );
    });
  }

  void _printReport() {
    if (_result == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          language: _currentLanguage,
          certNo: _certNoController.text,
          company: _companyController.text,
          location: _locationController.text,
          equipment: _equipmentController.text,
          rope: _selectedRope,
          layType: _layType,
          spoolingType: _spoolingType,
          mechClass: _mechClass,
          nominalDiameter: _nominalDiamController.text,
          actualDiameter: _actualDiamController.text,
          breaks6d: _breaks6dController.text,
          breaks30d: _breaks30dController.text,
          result: _result!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: BrandColors.yellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tr('brand_name'),
                style: GoogleFonts.inter(
                  color: BrandColors.darkHeader,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('ISO 4309', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SegmentedButton<AppLanguage>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.yellow;
                  return Colors.transparent;
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.darkHeader;
                  return Colors.white;
                }),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.white24)),
              ),
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: AppLanguage.uk, label: Text('UA', style: GoogleFonts.inter(fontWeight: FontWeight.w600))),
                ButtonSegment(value: AppLanguage.en, label: Text('EN', style: GoogleFonts.inter(fontWeight: FontWeight.w600))),
              ],
              selected: {_currentLanguage},
              onSelectionChanged: (set) {
                setState(() {
                  _currentLanguage = set.first;
                  if (_result != null) {
                    _calculate();
                  }
                });
              },
            ),
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _certNoController,
                          decoration: InputDecoration(
                            labelText: tr('cert_no'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _companyController,
                          decoration: InputDecoration(
                            labelText: tr('company'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            labelText: tr('location'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _equipmentController,
                          decoration: InputDecoration(
                            labelText: tr('crane_id'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<RopeSpec>(
                    initialValue: _selectedRope,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: tr('rope_construct'),
                      border: const OutlineInputBorder(),
                    ),
                    items: RopeDatabase.catalog.map((rope) {
                      return DropdownMenuItem(
                        value: rope,
                        child: Text('${rope.name} (RCN ${rope.rcn})', overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedRope = val);
                    },
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nominalDiamController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: tr('d_nom'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _actualDiamController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: tr('d_act'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _breaks6dController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: tr('b_6d'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _breaks30dController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: tr('b_30d'),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(tr('duty_class'), style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  SegmentedButton<MechanismClass>(
                    segments: [
                      ButtonSegment(value: MechanismClass.m1ToM4, label: Text(tr('m1_m4'))),
                      ButtonSegment(value: MechanismClass.m5ToM8, label: Text(tr('m5_m8'))),
                    ],
                    selected: {_mechClass},
                    onSelectionChanged: (set) => setState(() => _mechClass = set.first),
                  ),
                  const SizedBox(height: 14),
                  SegmentedButton<LayType>(
                    segments: [
                      ButtonSegment(value: LayType.ordinary, label: Text(tr('lay_ord'))),
                      ButtonSegment(value: LayType.lang, label: Text(tr('lay_lang'))),
                    ],
                    selected: {_layType},
                    onSelectionChanged: (set) => setState(() => _layType = set.first),
                  ),
                  const SizedBox(height: 10),
                  SegmentedButton<SpoolingType>(
                    segments: [
                      ButtonSegment(value: SpoolingType.singleLayer, label: Text(tr('spool_single'))),
                      ButtonSegment(value: SpoolingType.multiLayer, label: Text(tr('spool_multi'))),
                    ],
                    selected: {_spoolingType},
                    onSelectionChanged: (set) => setState(() => _spoolingType = set.first),
                  ),
                  const SizedBox(height: 6),
                  SwitchListTile(
                    activeTrackColor: BrandColors.yellow,
                    activeThumbColor: BrandColors.darkHeader,
                    title: Text(tr('deformations'), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                    value: _hasDeformations,
                    onChanged: (val) => setState(() => _hasDeformations = val),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: BrandColors.yellow,
                      foregroundColor: BrandColors.darkHeader,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                    ),
                    onPressed: _calculate,
                    child: Text(
                      tr('btn_calc'),
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                    ),
                  ),
                  if (_result != null) ...[
                    const SizedBox(height: 20),
                    _buildResultCard(_result!),
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        foregroundColor: BrandColors.darkHeader,
                        side: const BorderSide(color: BrandColors.darkHeader, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _printReport,
                      icon: const Icon(Icons.picture_as_pdf, color: BrandColors.darkHeader),
                      label: Text(
                        tr('btn_cert'),
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(InspectionResult res) {
    Color cardColor;
    String title;
    IconData icon;

    switch (res.verdict) {
      case RopeVerdict.fit:
        cardColor = Colors.green.shade700;
        title = tr('verdict_fit');
        icon = Icons.check_circle;
        break;
      case RopeVerdict.warning:
        cardColor = Colors.orange.shade800;
        title = tr('verdict_warn');
        icon = Icons.warning;
        break;
      case RopeVerdict.discard:
        cardColor = Colors.red.shade700;
        title = tr('verdict_disc');
        icon = Icons.cancel;
        break;
    }

    return Card(
      color: cardColor.withValues(alpha: 0.08),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cardColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: cardColor, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: cardColor),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Text('• ${tr('param_loss')}: ${res.diameterLossPercent.toStringAsFixed(2)}% (Мін: ${res.minAllowedDiameter.toStringAsFixed(2)} mm)'),
            Text('• ${tr('col_limit')} (6d / 30d): ${res.limitBreaks6d} / ${res.limitBreaks30d} pcs.'),
            if (res.reasons.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...res.reasons.map((r) => Text('— $r', style: GoogleFonts.inter(color: Colors.redAccent, fontWeight: FontWeight.w500))),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------- ЕКСПОРТ СЕРТИФІКАТА (PDF) ----------------
class PdfPreviewScreen extends StatelessWidget {
  final AppLanguage language;
  final String certNo;
  final String company;
  final String location;
  final String equipment;
  final RopeSpec rope;
  final LayType layType;
  final SpoolingType spoolingType;
  final MechanismClass mechClass;
  final String nominalDiameter;
  final String actualDiameter;
  final String breaks6d;
  final String breaks30d;
  final InspectionResult result;

  const PdfPreviewScreen({
    super.key,
    required this.language,
    required this.certNo,
    required this.company,
    required this.location,
    required this.equipment,
    required this.rope,
    required this.layType,
    required this.spoolingType,
    required this.mechClass,
    required this.nominalDiameter,
    required this.actualDiameter,
    required this.breaks6d,
    required this.breaks30d,
    required this.result,
  });

  String tr(String key) => Translations.t(language, key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('btn_cert'))),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  static pw.Widget _buildSectionHeader(String title, PdfColor bgColor, PdfColor textColor) {
    return pw.Container(
      color: bgColor,
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: textColor),
      ),
    );
  }

  static pw.Widget _buildTableCell(String text, {bool isBold = false, bool isCenter = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: pw.Text(
        text,
        textAlign: isCenter ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(fontSize: 9, fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final font = await PdfGoogleFonts.interRegular();
    final fontBold = await PdfGoogleFonts.interSemiBold();

    final pdf = pw.Document();
    final headerYellow = PdfColor.fromHex('FFF4CC');
    final borderDark = PdfColor.fromHex('333333');
    final brandNavy = PdfColor.fromHex('121212');

    final String laySpoolingStr =
        '${layType == LayType.ordinary ? tr('lay_ord') : tr('lay_lang')} / '
        '${spoolingType == SpoolingType.singleLayer ? tr('spool_single') : tr('spool_multi')}';

    final String dutyClassStr =
        mechClass == MechanismClass.m1ToM4 ? 'M1-M4' : 'M5-M8';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(28),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('FFC000'),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                    ),
                    child: pw.Text(
                      'STALKANAT',
                      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: brandNavy),
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        '${tr('pdf_title')} ${certNo.isEmpty ? "_____" : certNo}',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: brandNavy),
                      ),
                      pw.Text(
                        tr('pdf_sub'),
                        style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700),
                      ),
                    ],
                  ),
                  pw.Text(
                    'ISO 4309:2017',
                    style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),

              pw.Table(
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(3),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(3),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(tr('pdf_date'), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5)),
                      pw.Text(DateTime.now().toString().substring(0, 10), style: const pw.TextStyle(fontSize: 9.5)),
                      pw.Text('${tr('location')}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5)),
                      pw.Text(location.isEmpty ? '-' : location, style: const pw.TextStyle(fontSize: 9.5)),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                        child: pw.Text('${tr('company')}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                        child: pw.Text(company.isEmpty ? '-' : company, style: const pw.TextStyle(fontSize: 9.5)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                        child: pw.Text('${tr('crane_id')}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                        child: pw.Text(equipment.isEmpty ? '-' : equipment, style: const pw.TextStyle(fontSize: 9.5)),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),

              _buildSectionHeader(tr('sec_1'), headerYellow, brandNavy),
              pw.Table(
                border: pw.TableBorder.all(color: borderDark, width: 0.7),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1.5),
                  1: const pw.FlexColumnWidth(2.5),
                  2: const pw.FlexColumnWidth(1.2),
                  3: const pw.FlexColumnWidth(1.2),
                  4: const pw.FlexColumnWidth(3.0),
                  5: const pw.FlexColumnWidth(1.2),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: headerYellow),
                    children: [
                      _buildTableCell(tr('cert_no'), isBold: true, isCenter: true),
                      _buildTableCell(tr('rope_construct'), isBold: true, isCenter: true),
                      _buildTableCell('RCN', isBold: true, isCenter: true),
                      _buildTableCell(tr('d_nom'), isBold: true, isCenter: true),
                      _buildTableCell('Lay / Spooling', isBold: true, isCenter: true),
                      _buildTableCell('Duty Class', isBold: true, isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(certNo.isEmpty ? '-' : certNo, isCenter: true),
                      _buildTableCell(rope.name, isCenter: true),
                      _buildTableCell('RCN.${rope.rcn}', isCenter: true),
                      _buildTableCell(nominalDiameter, isCenter: true),
                      _buildTableCell(laySpoolingStr, isCenter: true),
                      _buildTableCell(dutyClassStr, isCenter: true),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),

              _buildSectionHeader(tr('sec_2'), headerYellow, brandNavy),
              pw.Table(
                border: pw.TableBorder.all(color: borderDark, width: 0.7),
                columnWidths: {
                  0: const pw.FlexColumnWidth(4.5),
                  1: const pw.FlexColumnWidth(2.5),
                  2: const pw.FlexColumnWidth(2.5),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: headerYellow),
                    children: [
                      _buildTableCell(tr('col_param'), isBold: true, isCenter: true),
                      _buildTableCell(tr('col_meas'), isBold: true, isCenter: true),
                      _buildTableCell(tr('col_limit'), isBold: true, isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_diam')),
                      _buildTableCell('$actualDiameter mm', isBold: true, isCenter: true),
                      _buildTableCell('min. ${result.minAllowedDiameter.toStringAsFixed(2)} mm', isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_loss')),
                      _buildTableCell('${result.diameterLossPercent.toStringAsFixed(1)}%', isBold: true, isCenter: true),
                      _buildTableCell('max. ${result.allowedDiameterLossLimit.toStringAsFixed(1)}%', isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_6d')),
                      _buildTableCell('$breaks6d pcs.', isBold: true, isCenter: true),
                      _buildTableCell('max. ${result.limitBreaks6d} pcs.', isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_30d')),
                      _buildTableCell('$breaks30d pcs.', isBold: true, isCenter: true),
                      _buildTableCell('max. ${result.limitBreaks30d} pcs.', isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_def')),
                      _buildTableCell(result.hasDeformations ? tr('yes') : tr('no'), isBold: true, isCenter: true),
                      _buildTableCell(tr('not_perm'), isCenter: true),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),

              _buildSectionHeader(tr('sec_3'), headerYellow, brandNavy),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: brandNavy, width: 1.2),
                ),
                child: pw.Center(
                  child: pw.Text(
                    result.verdict == RopeVerdict.discard
                        ? tr('verdict_disc')
                        : result.verdict == RopeVerdict.warning
                            ? tr('verdict_warn')
                            : tr('verdict_fit'),
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: result.verdict == RopeVerdict.discard
                          ? PdfColors.red900
                          : result.verdict == RopeVerdict.warning
                              ? PdfColors.orange900
                              : PdfColors.green900,
                    ),
                  ),
                ),
              ),

              pw.Spacer(),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(tr('inspector'), style: const pw.TextStyle(fontSize: 9.5)),
                  pw.Text(tr('signature'), style: const pw.TextStyle(fontSize: 9.5)),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}