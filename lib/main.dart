import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const RopeMasterApp());
}

// ==========================================
// 1. ГОЛОВНИЙ КЛАС ДОДАТКУ (ROOT APP)
// ==========================================
class RopeMasterApp extends StatefulWidget {
  const RopeMasterApp({super.key});

  @override
  RopeMasterAppState createState() => RopeMasterAppState();

  static RopeMasterAppState of(BuildContext context) =>
      context.findAncestorStateOfType<RopeMasterAppState>()!;
}

class RopeMasterAppState extends State<RopeMasterApp> {
  AppThemeMode _themeMode = AppThemeMode.light;

  void setThemeMode(AppThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  AppThemeMode get themeMode => _themeMode;

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == AppThemeMode.dark;

    return MaterialApp(
      title: 'ROPE GUARD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: isDark ? Brightness.dark : Brightness.light).textTheme,
        ),
        scaffoldBackgroundColor: BrandColors.deepNavy,
        colorScheme: ColorScheme.fromSeed(
          brightness: isDark ? Brightness.dark : Brightness.light,
          seedColor: BrandColors.yellow,
          primary: BrandColors.graphiteAppBar,
          secondary: BrandColors.yellow,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: BrandColors.graphiteAppBar,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 2. КОНСТАНТИ ТА ПАЛІТРА ROPE GUARD
// ==========================================
class BrandColors {
  static const Color yellow = Color(0xFFFFC000);
  static const Color deepNavy = Color(0xFF00264C);
  static const Color graphiteAppBar = Color(0xFF1E2229);
  
  static const Color lightCardBg = Color(0xFFF0F4F8);
  static const Color lightCardInner = Color(0xFFE2E8F0);
  static const Color lightTextMain = Color(0xFF0F172A);
  static const Color lightTextSub = Color(0xFF475569);
  
  static const Color darkCardBg = Color(0xFF0F2537);
  static const Color darkCardInner = Color(0xFF132F4C);

  static const Color borderGrey = Color(0xFFCBD5E1);
}

enum AppLanguage { uk, en }
enum AppThemeMode { light, dark }

enum CoreType { steel, fiber, rotationResistant }
enum LayType { ordinary, lang }
enum SpoolingType { singleLayer, multiLayer }
enum MechanismClass { m1ToM4, m5ToM8 }
enum RopeVerdict { fit, warning, discard }
enum RopeCategoryGroup { nonRotationResistant, rotationResistant, nonRotating }
enum WavinessZone { sheaveOrDrum, straightSection }
enum SheaveGrooveStatus { none, fitA, tightB, wideC }

enum EquipmentCategory {
  generalCranes,
  mobileCranes,
  stationary
}

enum RopeRotationType { standard, rotationResistant }

enum StrandCountOption {
  strands3,
  strands4to5,
  strands6to10,
  strands8to10Plast,
  strands10PlusRR
}

// ==========================================
// 3. БІЛІНГВАЛЬНІ ПЕРЕКЛАДИ (UA / EN)
// ==========================================
class Tr {
  static const Map<AppLanguage, Map<String, String>> _s = {
    AppLanguage.uk: {
      'app_title': 'ROPE GUARD',
      'suite_name': 'ROPE GUARD',
      'hub_title': 'ОБЕРІТЬ ІНЖЕНЕРНИЙ МОДУЛЬ',
      'hub_subtitle': 'Професійні інструменти розрахунку та експертизи сталевих канатів',
      'mod1_title': 'МОДУЛЬ 1: ISO 4309',
      'mod1_desc': 'Інспекція, оцінка зносу, норми обривів дротів, контроль хвилястості та бракування канатів',
      'mod2_title': 'МОДУЛЬ 2: ISO 16625',
      'mod2_desc': 'Підбір каната, перевірка коефіцієнта запасу міцності Zp та мінімальних діаметрів блоків і барабанів D/d',
      'btn_open': 'ВІДКРИТИ МОДУЛЬ',
      'btn_back_hub': 'Головне меню',
      'cert_no': '№ Сертифіката / Протоколу',
      'company': 'Підприємство / Замовник',
      'location': 'Місце встановлення',
      'crane_id': 'ID / Найменування механізму',
      'rope_construct': 'Конструкція каната',
      'category_group': 'Тип каната за стійкістю до кручення',
      'cat_non_rot_res': 'Крутні (Звичайні)',
      'cat_rot_res': 'Малокрутні',
      'cat_non_rot': 'Некрутні / Спеціальні',
      'd_nom': 'Номінал d (мм)',
      'd_act': 'Факт d (мм)',
      'b_6d': 'Обриви на 6d (шт.)',
      'b_30d': 'Обриви на 30d (шт.)',
      'duty_class': 'Режим роботи механізму (ISO 4301-1):',
      'm1_m4': 'M1 – M4',
      'm5_m8': 'M5 – M8',
      'lay_ord': 'Хрестова звивка',
      'lay_lang': 'Одностороння звивка',
      'spool_single': '1-шарова намотка',
      'spool_multi': 'Багатошарова намотка',
      'deformations': 'Неприпустимі деформації / заломи каната',
      'waviness_title': 'Хвилястість каната',
      'waviness_check': 'Зафіксовано хвилястість (деформацію осі)',
      'waviness_zone_sheave': 'Робоча ділянка (блоки / барабан, g ≥ d/10)',
      'waviness_zone_straight': 'Пряма ділянка (без блоків, g ≥ d/3)',
      'gap_label': 'Виміряний зазор хвилі g (мм)',
      'sheave_title': 'Контроль канавок блоків (Шаблон радіуса)',
      'sheave_p5': 'Калібр-шаблон +5% (Номінал/Мінімум)',
      'sheave_p10': 'Калібр-шаблон +10% (Максимум зносу)',
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
      'param_wav': 'Хвилястість каната (зазор g)',
      'param_sheave': 'Стан канавки шківа/блока (+5% / +10%)',
      'not_perm': 'не допускаються',
      'yes': 'Виявлено',
      'no': 'Відсутні',
      'inspector': 'Компетентна особа / Інспектор: ____________________',
      'signature': 'Підпис / Печатка: ____________________',
      'iso16625_title': 'КАЛЬКУЛЯТОР ЗАПАСУ МІЦНОСТІ ТА ГЕОМЕТРІЇ БЛОКІВ (ISO 16625)',
      'eq_type': 'Тип обладнання (Категорія крана):',
      'eq_gen': 'Усі крани і талі, крім мобільних',
      'eq_mob': 'Мобільні крани',
      'eq_stat': 'Ванти та монтажні канати',
      'group_class': 'Група класифікації (M1-M8 або A1-A8):',
      'duty_mode': 'Призначення каната / Режим:',
      'rot_type': 'Тип каната за ступенем крутимости:',
      'rot_std': 'Стандартний канат',
      'rot_rr': 'Малокрутний / некрутильний канат',
      'swl_kn': 'Максимальний натяг гілки канату (SWL), кН:',
      'mbl_kn': 'Фактичне розривне зусилля каната (MBL), кН:',
      'strands_label': 'Кількість зовнішніх сталок (коефіцієнт t):',
      'str_3': '3 сталки (t = 1.25)',
      'str_4_5': 'від 4 до 5 сталок (t = 1.15)',
      'str_6_10': 'від 6 до 10 сталок (t = 1.00)',
      'str_8_10_p': 'від 8 до 10 сталок з полімером - EPIWRC (t = 0.95)',
      'str_10_rr': '10 і більше сталок — малокрутний/некрутильний (t = 1.00)',
      'drum_d1': 'Фактичний діаметр барабана (D1), мм:',
      'sheave_d2': 'Фактичний діаметр блока (D2), мм:',
      'calc_zp_min': 'Мін. коефіцієнт Zp (ISO 16625):',
      'calc_z_fact': 'Фактичний запас міцності (Z_факт):',
      'calc_d1_min': 'Мін. діаметр барабана D1 (по осях):',
      'calc_d2_min': 'Мін. діаметр блока D2 (по осях):',
      'status_ok': 'ВІДПОВІДАЄ: МІЦНІСТЬ ТА ГЕОМЕТРІЯ В НОРМІ',
      'status_fail': 'НЕ ВІДПОВІДАЄ: ПОРУШЕНІ НОРМИ ISO 16625!',
      'pdf_16625_title': 'ПРОТОКОЛ РОЗРАХУНКУ ТА ПЕРЕВІРКИ КАНАТА №',
      'pdf_16625_sub': 'відповідно до вимог стандарту ISO 16625 (Вибір та перевірка канатів)',
    },
    AppLanguage.en: {
      'app_title': 'ROPE GUARD',
      'suite_name': 'ROPE GUARD',
      'hub_title': 'SELECT ENGINEERING MODULE',
      'hub_subtitle': 'Professional wire rope inspection, selection, and verification tools',
      'mod1_title': 'MODULE 1: ISO 4309:2017',
      'mod1_desc': 'Wire rope inspection, broken wire limits, diameter reduction, waviness & discard criteria',
      'mod2_title': 'MODULE 2: ISO 16625',
      'mod2_desc': 'Rope selection, minimum safety coefficient Zp, drum and sheave diameters D/d calculation',
      'btn_open': 'OPEN MODULE',
      'btn_back_hub': 'Main Menu',
      'cert_no': 'Certificate / Protocol No.',
      'company': 'Company / Customer',
      'location': 'Installation Location',
      'crane_id': 'Crane / Equipment ID',
      'rope_construct': 'Rope Construction',
      'category_group': 'Rope Rotation Characteristic',
      'cat_non_rot_res': 'Non Rotation Resistant',
      'cat_rot_res': 'Rotation Resistant',
      'cat_non_rot': 'Non Rotation / Special',
      'd_nom': 'Nominal d (mm)',
      'd_act': 'Measured d (mm)',
      'b_6d': 'Broken wires over 6d',
      'b_30d': 'Broken wires over 30d',
      'duty_class': 'Mechanism Duty Class (ISO 4301-1):',
      'm1_m4': 'M1 – M4',
      'm5_m8': 'M5 – M8',
      'lay_ord': 'Ordinary lay',
      'lay_lang': 'Lang lay',
      'spool_single': 'Single-layer spooling',
      'spool_multi': 'Multi-layer spooling',
      'deformations': 'Severe deformations / kinks',
      'waviness_title': 'Rope Waviness',
      'waviness_check': 'Waviness detected (helix deformation)',
      'waviness_zone_sheave': 'Running zone (sheave / drum, g ≥ d/10)',
      'waviness_zone_straight': 'Straight zone (no sheaves, g ≥ d/3)',
      'gap_label': 'Measured wave gap g (mm)',
      'sheave_title': 'Sheave Groove Inspection (Radius Gauge)',
      'sheave_p5': 'Gauge +5% (Nominal / Minimum)',
      'sheave_p10': 'Gauge +10% (Maximum wear limit)',
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
      'param_wav': 'Rope Waviness (gap g)',
      'param_sheave': 'Sheave groove profile (+5% / +10%)',
      'not_perm': 'not permitted',
      'yes': 'Yes',
      'no': 'No',
      'inspector': 'Competent Person / Inspector: ____________________',
      'signature': 'Signature / Stamp: ____________________',
      'iso16625_title': 'SAFETY COEFFICIENT & SHEAVE GEOMETRY CALCULATOR (ISO 16625)',
      'eq_type': 'Equipment Category (Crane Type):',
      'eq_gen': 'All Cranes & Hoists except Mobile Cranes',
      'eq_mob': 'Mobile Cranes',
      'eq_stat': 'Stationary & Erection Ropes',
      'group_class': 'Classification Group (M1-M8 or A1-A8):',
      'duty_mode': 'Rope Application / Operating Mode:',
      'rot_type': 'Rope Rotation Type:',
      'rot_std': 'Standard Rope',
      'rot_rr': 'Rotation-resistant / Non-rotating',
      'swl_kn': 'Maximum Line Pull (SWL), kN:',
      'mbl_kn': 'Minimum Breaking Force (MBL), kN:',
      'strands_label': 'Number of Outer Strands (Factor t):',
      'str_3': '3 strands (t = 1.25)',
      'str_4_5': '4 to 5 strands (t = 1.15)',
      'str_6_10': '6 to 10 strands (t = 1.00)',
      'str_8_10_p': '8 to 10 strands — plastic filled (t = 0.95)',
      'str_10_rr': '10 or more strands — RR (t = 1.00)',
      'drum_d1': 'Actual Drum Diameter (D1), mm:',
      'sheave_d2': 'Actual Sheave Diameter (D2), mm:',
      'calc_zp_min': 'Minimum Coefficient Zp (ISO 16625):',
      'calc_z_fact': 'Actual Safety Factor (Z_actual):',
      'calc_d1_min': 'Min. Drum Diameter D1 (pitch):',
      'calc_d2_min': 'Min. Sheave Diameter D2 (pitch):',
      'status_ok': 'COMPLIANT: SAFETY FACTOR & GEOMETRY IN SPEC',
      'status_fail': 'NON-COMPLIANT: FAILS ISO 16625 CRITERIA!',
      'pdf_16625_title': 'WIRE ROPE CALCULATION & VERIFICATION PROTOCOL No.',
      'pdf_16625_sub': 'in accordance with ISO 16625 (Selection and verification of wire ropes)',
    }
  };

  static String get(AppLanguage lang, String key) => _s[lang]?[key] ?? key;
}

// ==========================================
// 4. БАЗА ДАНИХ КАНАТІВ
// ==========================================
class RopeSpec {
  final String name;
  final String rcn;
  final CoreType coreType;
  final RopeCategoryGroup group;
  final int outerWires;

  const RopeSpec({
    required this.name,
    required this.rcn,
    required this.coreType,
    required this.group,
    this.outerWires = 200,
  });

  bool get isRotationResistant => coreType == CoreType.rotationResistant;

  double getMaxDiameterLossLimit(bool isMultiLayer) {
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
  static const List<RopeSpec> fullCatalog = [
    RopeSpec(name: '6x7-FC (ГОСТ 3069)', rcn: '01', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 42),
    RopeSpec(name: '6x7-WSC (ГОСТ 3066)', rcn: '01', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 42),
    RopeSpec(name: '6x19S-FC (ГОСТ 3077)', rcn: '02', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 54),
    RopeSpec(name: '6x19S-IWRC (ГОСТ 3081)', rcn: '02', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 54),
    RopeSpec(name: '6xK19S-FC', rcn: '02', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 54),
    RopeSpec(name: '6xK19S-IWRC', rcn: '02', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 54),
    RopeSpec(name: '6x19W-FC (ГОСТ 2688)', rcn: '04', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 114),
    RopeSpec(name: '6x19W-IWRC (ГОСТ 14954)', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 114),
    RopeSpec(name: '6x19W-WSC', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 114),
    RopeSpec(name: '6x19M-FC (ГОСТ 3070)', rcn: '04', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 114),
    RopeSpec(name: '6x19M-IWRC', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 114),
    RopeSpec(name: '6x19M-WSC (ГОСТ 3067)', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 114),
    RopeSpec(name: '6x25F-FC (ГОСТ 7665)', rcn: '04', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 120),
    RopeSpec(name: '6x25F-IWRC (ГОСТ 7667)', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 120),
    RopeSpec(name: '6x25TS-IWRC (Тригранносталковий)', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 120),
    RopeSpec(name: '6x26WS-FC', rcn: '06', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 156),
    RopeSpec(name: '6x26WS-IWRC', rcn: '06', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 156),
    RopeSpec(name: '6xK26WS-FC', rcn: '06', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 156),
    RopeSpec(name: '6xK26WS-IWRC', rcn: '06', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 156),
    RopeSpec(name: '6x31WS-FC (ГОСТ 16853)', rcn: '08', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 186),
    RopeSpec(name: '6x31WS-IWRC (ГОСТ 16853)', rcn: '08', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 186),
    RopeSpec(name: '6xK31WS-FC', rcn: '08', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 186),
    RopeSpec(name: '6xK31WS-IWRC', rcn: '08', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 186),
    RopeSpec(name: '6x36WS-FC (ГОСТ 7668)', rcn: '09', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 216),
    RopeSpec(name: '6x36WS-IWRC (ГОСТ 7669)', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 216),
    RopeSpec(name: '6x36WS-EPIWRC', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 216),
    RopeSpec(name: '6xK36WS-FC', rcn: '09', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 216),
    RopeSpec(name: '6xK36WS-IWRC', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 216),
    RopeSpec(name: '6xK36WS-EPIWRC', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 216),
    RopeSpec(name: '6x37M-FC (ГОСТ 3071)', rcn: '10', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 222),
    RopeSpec(name: '6x37M-IWRC', rcn: '10', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 222),
    RopeSpec(name: '6x37M-WSC (ГОСТ 3068)', rcn: '10', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 222),
    RopeSpec(name: '6x37NS-FC (ГОСТ 3079)', rcn: '10', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 222),
    RopeSpec(name: '8x19S-FC', rcn: '04', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 112),
    RopeSpec(name: '8x19S-IWRC', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 112),
    RopeSpec(name: '8xK19S-IWRC', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 112),
    RopeSpec(name: '8x19S-PWRC', rcn: '04', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 112),
    RopeSpec(name: '8x19W-FC', rcn: '06', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 152),
    RopeSpec(name: '8x19W-IWRC', rcn: '06', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 152),
    RopeSpec(name: '8x25F-IWRC', rcn: '06', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 160),
    RopeSpec(name: '8x26WS-IWRC', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 208),
    RopeSpec(name: '8xK26WS-IWRC', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 208),
    RopeSpec(name: '8xK26WS-EPIWRC', rcn: '09', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 208),
    RopeSpec(name: '8x31WS-FC', rcn: '11', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 248),
    RopeSpec(name: '8x31WS-IWRC', rcn: '11', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 248),
    RopeSpec(name: '8xK31WS-FC', rcn: '11', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 248),
    RopeSpec(name: '8xK31WS-IWRC', rcn: '11', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 248),
    RopeSpec(name: '8xK31WS-EPIWRC', rcn: '11', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 248),
    RopeSpec(name: '8x36WS-FC', rcn: '13', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 288),
    RopeSpec(name: '8x36WS-IWRC', rcn: '13', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 288),
    RopeSpec(name: '8xK36WS-FC', rcn: '13', coreType: CoreType.fiber, group: RopeCategoryGroup.nonRotationResistant, outerWires: 288),
    RopeSpec(name: '8xK36WS-IWRC', rcn: '13', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 288),
    RopeSpec(name: '8xK36WS-EPIWRC', rcn: '13', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 288),
    RopeSpec(name: '8x37M-FC', rcn: '13', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 296),
    RopeSpec(name: '8x37M-IWRC', rcn: '13', coreType: CoreType.steel, group: RopeCategoryGroup.nonRotationResistant, outerWires: 296),
    RopeSpec(name: '17x7-FC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 84),
    RopeSpec(name: '17x7-WSC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 84),
    RopeSpec(name: '18x7-FC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 84),
    RopeSpec(name: '18x7-WSC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 84),
    RopeSpec(name: '18x7-KWSC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 84),
    RopeSpec(name: '18x19S-FC', rcn: '26', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 180),
    RopeSpec(name: '18x19W-FC', rcn: '28', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 228),
    RopeSpec(name: '18x19W-WSC', rcn: '28', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 228),
    RopeSpec(name: '18x19S-WSC', rcn: '26', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 180),
    RopeSpec(name: '18xK19-WSC', rcn: '26', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 180),
    RopeSpec(name: '24x7-FC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 96),
    RopeSpec(name: '24x7-WSC', rcn: '23-1', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.rotationResistant, outerWires: 96),
    RopeSpec(name: '35x(W)x7', rcn: '23-2', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 112),
    RopeSpec(name: '35x(W)xK7', rcn: '23-2', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 112),
    RopeSpec(name: '39(W)x7-WSC', rcn: '23-3', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 126),
    RopeSpec(name: '39(W)xK7-KWSC', rcn: '23-3', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 126),
    RopeSpec(name: '34(W)xK19-WSC', rcn: '31', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 290),
    RopeSpec(name: '4x31WS-FC', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 124),
    RopeSpec(name: 'K4x24S', rcn: '21', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 96),
    RopeSpec(name: 'K4x18S', rcn: '21', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 72),
    RopeSpec(name: '4x29F', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 116),
    RopeSpec(name: 'K3x40', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 120),
    RopeSpec(name: '4(W)x39', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 156),
    RopeSpec(name: 'K4x40', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 160),
    RopeSpec(name: 'K3x48', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 144),
    RopeSpec(name: 'K4x48', rcn: '22', coreType: CoreType.rotationResistant, group: RopeCategoryGroup.nonRotating, outerWires: 192),
  ];
}

// ==========================================
// 5. МОДЕЛІ ДАНИХ ТА ДВИЖКИ РОЗРАХУНКУ
// ==========================================
class InspectionResult {
  final double diameterLossPercent;
  final double allowedDiameterLossLimit;
  final double minAllowedDiameter;
  final int limitBreaks6d;
  final int limitBreaks30d;
  final double diameterSeverity;
  final double breakSeverity;
  final bool hasDeformations;
  final bool hasWaviness;
  final double? measuredGap;
  final double? allowedGapLimit;
  final SheaveGrooveStatus sheaveStatusP5;
  final SheaveGrooveStatus sheaveStatusP10;
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
    required this.hasWaviness,
    this.measuredGap,
    this.allowedGapLimit,
    required this.sheaveStatusP5,
    required this.sheaveStatusP10,
    required this.verdict,
    required this.reasons,
  });
}

class Iso16625Result {
  final double zpMin;
  final double zActual;
  final double? d1Min;
  final double? d2Min;
  final double? h1;
  final double? h2;
  final double factorT;
  final bool isZpPass;
  final bool isD1Pass;
  final bool isD2Pass;
  final bool isOverallPass;
  final List<String> notes;

  Iso16625Result({
    required this.zpMin,
    required this.zActual,
    this.d1Min,
    this.d2Min,
    this.h1,
    this.h2,
    required this.factorT,
    required this.isZpPass,
    required this.isD1Pass,
    required this.isD2Pass,
    required this.isOverallPass,
    required this.notes,
  });
}

class RopeInspectorEngine {
  static const Map<String, List<int>> _rcnTable = {
    '01': [2, 4, 1, 2, 4, 8],
    '02': [3, 6, 2, 3, 6, 12],
    '03': [4, 8, 2, 4, 8, 16],
    '04': [5, 10, 2, 5, 10, 20],
    '05': [6, 11, 3, 6, 12, 22],
    '06': [6, 13, 3, 6, 12, 26],
    '07': [7, 14, 4, 7, 14, 28],
    '08': [8, 16, 4, 8, 16, 32],
    '09': [9, 18, 4, 9, 18, 36],
    '10': [10, 19, 5, 10, 20, 38],
    '11': [10, 21, 5, 10, 20, 42],
    '12': [11, 22, 6, 11, 22, 44],
    '13': [12, 24, 6, 12, 24, 48],
    '21': [2, 4, 2, 4, 2, 4],
    '22': [2, 4, 2, 4, 4, 8],
    '23-1': [2, 4, 2, 4, 4, 8],
    '23-2': [3, 5, 3, 5, 5, 10],
    '23-3': [3, 5, 3, 5, 6, 11],
    '24': [3, 6, 3, 6, 6, 13],
    '25': [4, 7, 4, 7, 7, 14],
    '26': [4, 8, 4, 8, 8, 16],
    '27': [4, 9, 4, 9, 9, 18],
    '28': [5, 10, 5, 10, 10, 19],
    '29': [5, 10, 5, 10, 10, 21],
    '30': [6, 11, 6, 11, 11, 22],
    '31': [6, 12, 6, 12, 12, 24],
  };

  static InspectionResult evaluate({
    required RopeSpec rope,
    required double nominalDiameter,
    required double actualDiameter,
    required int brokenWires6d,
    required int brokenWires30d,
    required bool hasDeformations,
    required bool hasWaviness,
    required WavinessZone wavinessZone,
    required double? measuredGap,
    required SheaveGrooveStatus sheaveP5,
    required SheaveGrooveStatus sheaveP10,
    required LayType layType,
    required SpoolingType spoolingType,
    required MechanismClass mechClass,
    required AppLanguage lang,
  }) {
    final List<String> reasons = [];
    final bool isOrdinary = layType == LayType.ordinary;
    final bool isMultiLayer = spoolingType == SpoolingType.multiLayer;
    final int n = rope.outerWires;

    int limit6d;
    int limit30d;

    if (n > 300) {
      if (rope.isRotationResistant) {
        limit6d = isMultiLayer ? 12 : 6;
        limit30d = isMultiLayer ? 24 : 12;
      } else {
        if (isMultiLayer) {
          limit6d = (0.08 * n).round();
          limit30d = (0.16 * n).round();
        } else {
          limit6d = isOrdinary ? (0.04 * n).round() : (0.02 * n).round();
          limit30d = isOrdinary ? (0.08 * n).round() : (0.04 * n).round();

          if (mechClass == MechanismClass.m5ToM8) {
            limit6d *= 2;
            limit30d *= 2;
          }
        }
      }
    } else {
      final rcnData = _rcnTable[rope.rcn] ?? [4, 8, 2, 4, 8, 16];

      if (isMultiLayer) {
        limit6d = rcnData[4];
        limit30d = rcnData[5];
      } else {
        limit6d = isOrdinary ? rcnData[0] : rcnData[2];
        limit30d = isOrdinary ? rcnData[1] : rcnData[3];

        if (!rope.isRotationResistant && mechClass == MechanismClass.m5ToM8) {
          limit6d *= 2;
          limit30d *= 2;
        }
      }
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

    double? allowedGapLimit;
    bool wavinessDiscard = false;
    if (hasWaviness && measuredGap != null) {
      allowedGapLimit = wavinessZone == WavinessZone.sheaveOrDrum
          ? nominalDiameter / 10.0
          : nominalDiameter / 3.0;

      if (measuredGap >= allowedGapLimit) {
        wavinessDiscard = true;
        reasons.add(lang == AppLanguage.uk
            ? 'Хвилястість: зазор g=${measuredGap.toStringAsFixed(2)} мм перевищує норму (${allowedGapLimit.toStringAsFixed(2)} мм)'
            : 'Waviness: gap g=${measuredGap.toStringAsFixed(2)} mm exceeds discard limit (${allowedGapLimit.toStringAsFixed(2)} mm)');
      }
    }

    if (sheaveP5 == SheaveGrooveStatus.tightB) {
      reasons.add(lang == AppLanguage.uk
          ? 'Канавка блока завужена (+5% зазор знизу) — ризик защемлення каната'
          : 'Sheave groove tight (+5% bottom gap) — rope pinching risk');
    }
    if (sheaveP10 == SheaveGrooveStatus.wideC) {
      reasons.add(lang == AppLanguage.uk
          ? 'Канавка блока надмірно зношена (+10% зазор з боків) — ризик сплющування'
          : 'Sheave groove over-sized/worn (+10% side gaps) — flattening risk');
    }

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
    if (hasDeformations || wavinessDiscard || breakSeverity >= 100.0 || diameterSeverity >= 100.0) {
      verdict = RopeVerdict.discard;
    } else if (breakSeverity >= 40.0 ||
        diameterSeverity >= 50.0 ||
        (hasWaviness && !wavinessDiscard) ||
        sheaveP5 == SheaveGrooveStatus.tightB ||
        sheaveP10 == SheaveGrooveStatus.wideC) {
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
      hasWaviness: hasWaviness,
      measuredGap: measuredGap,
      allowedGapLimit: allowedGapLimit,
      sheaveStatusP5: sheaveP5,
      sheaveStatusP10: sheaveP10,
      verdict: verdict,
      reasons: reasons,
    );
  }
}

class Iso16625Engine {
  static double getZp({
    required EquipmentCategory category,
    required String group,
    required String mode,
    required RopeRotationType rotType,
  }) {
    final String rotStr = (category == EquipmentCategory.stationary)
        ? 'Стандартний канат'
        : (rotType == RopeRotationType.standard ? 'Стандартний канат' : 'Опірний крученню / некрутильний канат');

    String catStr;
    switch (category) {
      case EquipmentCategory.generalCranes:
        catStr = 'Усі крани і талі, окрім мобільних кранів';
        break;
      case EquipmentCategory.mobileCranes:
        catStr = 'Мобільні крани';
        break;
      case EquipmentCategory.stationary:
        catStr = 'Ванти і монтажні канати';
        break;
    }

    final key = '$catStr|$group|$mode|$rotStr';

    final Map<String, double> db = {
      'Усі крани і талі, окрім мобільних кранів|M1|Підіймальний канат — Одношарове навивання|Стандартний канат': 3.15,
      'Усі крани і талі, окрім мобільних кранів|M1|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 3.15,
      'Усі крани і талі, окрім мобільних кранів|M1|Підіймальний канат — Багатошарове навивання|Стандартний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M1|Підіймальний канат — Багатошарове навивання|Опірний крученню канат / некрутильний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M1|Механізм підйому (изменения вылета) стрелы|Стандартний канат канат': 3.55,
      'Усі крани і талі, окформ мобільних кранів|M1|Механізм підйому (изменения вылета) стрелы|Опірний крученню канат / некрутильний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M2|Підіймальний канат — Одношарове навивання|Стандартний канат': 3.35,
      'Усі крани і талі, окрім мобільних кранів|M2|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 3.35,
      'Усі крани і талі, окрім мобільних кранів|M2|Підіймальний канат — Багатошарове навивання|Стандартний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M2|Підіймальний канат — Багатошарове навивання|Опірний крученню канат / некрутильний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M2|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 3.55,
      'Усі крани і талі, окформ мобільних кранів|M2|Механізм підйому (изменения вылета) стрелы|Опірний крученню канат / некрутильний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M3|Підіймальний канат — Одношарове навивання|Стандартний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M3|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M3|Підіймальний канат — Багатошарове навивання|Стандартний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M3|Підіймальний канат — Багатошарове навивання|Опірний крученню канат / некрутильний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M3|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 3.55,
      'Усі крани і талі, окрім мобільних кранів|M3|Механізм підйому (изменения вылета) стрелы|Опірний крученню канат / некрутильний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M4|Підіймальний канат — Одношарове навивання|Стандартний канат': 4.0,
      'Усі крани і талі, окрім мобільних кранів|M4|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 4.0,
      'Усі крани і талі, окрім мобільних кранів|M4|Підіймальний канат — Багатошарове навивання|Стандартний канат': 4.0,
      'Усі крани і талі, окрім мобільних кранів|M4|Підіймальний канат — Багатошарове навивання|Опірний крученню канат / некрутильний канат': 4.0,
      'Усі крани і талі, окрім мобільних кранів|M4|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 4.0,
      'Усі крани і талі, окрім мобільних кранів|M4|Механізм підйому (изменения вылета) стрелы|Опірний крученню канат / некрутильний канат': 4.5,
      'Все краны и тали, среднее|M5|Підіймальний канат — Одношарове навивання|Стандартний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M5|Підіймальний канат — Одношарове навивання|Стандартний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M5|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M5|Підіймальний канат — Багатошарове навивання|Стандартний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M5|Підіймальний канат — Багатошарове навивання|Опірний крученню канат / некрутильний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M5|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M5|Механізм підйому (изменения вылета) стрелы|Опірний крученню канат / некрутильний канат': 4.5,
      'Усі крани і талі, окрім мобільних кранів|M6|Підіймальний канат — Одношарове навивання|Стандартний канат': 5.6,
      'Усі крани і талі, окрім мобільних кранів|M6|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 5.6,
      'Усі крани і талі, окрім мобільних кранів|M6|Підіймальний канат — Багатошарове навивання|Стандартний канат': 5.6,
      'Усі крани і талі, окрім мобільних кранів|M6|Підіймальний канат — Багатошарове навивання|Опірний крученню канат / некрутильний канат': 5.6,
      'Усі крани і талі, окрім мобільних кранів|M6|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 5.6,
      'Усі крани і талі, окрім мобільних кранів|M6|Механізм підйому (изменения вылета) стрелы|Опірний крученню канат / некрутильний канат': 5.6,
      'Усі крани і талі, окрім мобільних кранів|M7|Підіймальний канат — Одношарове навивання|Стандартний канат': 7.1,
      'Усі крани і талі, окрім мобільних кранів|M7|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 7.1,
      'Усі крани і талі, окрім мобільних кранів|M7|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 7.1,
      'Усі крани і талі, окрім мобільних кранів|M8|Підіймальний канат — Одношарове навивання|Стандартний канат': 9.0,
      'Усі крани і талі, окрім мобільних кранів|M8|Підіймальний канат — Одношарове навивання|Опірний крученню канат / некрутильний канат': 9.0,
      'Усі крани і талі, окрім мобільних кранів|M8|Механізм підйому (изменения вылета) стрелы|Стандартний канат': 9.0,

      // Mobile Cranes
      'Мобильные краны|M1|Підіймальний канат|Стандартний канат': 3.55,
      'Мобильные краны|M1|Підіймальний канат|Опірний крученню канат / некрутильний канат': 4.5,
      'Мобильные краны|M1|Підйом стріли — Робочий режим|Стандартний канат': 3.35,
      'Мобильные краны|M1|Підйом стріли — Робочий режим|Опірний крученню канат / некрутильний канат': 4.5,
      'Мобильные краны|M1|Підйом стріли — Монтажний режим|Стандартний канат': 3.05,
      'Мобильные краны|M1|Підйом стріли — Монтажний режим|Опірний крученню канат / некрутильний канат': 4.5,
      'Мобильные краны|M1|Висування секцій стріли|Стандартний канат': 3.15,
      'Мобильные краны|M1|Висування секцій стріли|Опірний крученню канат / некрутильний канат': 3.15,
      'Мобильные краны|M2|Підіймальний канат|Стандартний канат': 3.55,
      'Мобильные краны|M2|Підіймальний канат|Опірний крученню канат / некрутильний канат': 4.5,
      'Мобильные краны|M2|Підйом стріли — Робочий режим|Стандартний канат': 3.35,
      'Мобильные краны|M2|Підйом стріли — Робочий режим|Опірний крученню канат / некрутильний канат': 4.5,
      'Мобильные краны|M2|Підйом стріли — Монтажний режим|Стандартний канат': 3.05,
      'Мобильные краны|M2|Підйом стріли — Монтажний режим|Опірний крученню / некрутильний канат': 4.5,
      'Мобильные краны|M2|Висування секцій стріли|Стандартний канат': 3.35,
      'Мобильные краны|M2|Висування секцій стріли|Опірний крученню канат / некрутильний канат': 3.35,
      'Мобильные краны|M3|Підіймальний канат|Стандартний канат': 3.55,
      'Мобильные краны|M3|Підіймальний канат|Опірний крученню канат / некрутильний канат': 4.5,
      'Мобильные краны|M3|Підйом стріли — Робочий режим|Стандартний канат': 3.35,
      'Мобильные краны|M3|Підйом стріли — Робочий режим|Опірний крученню  / некрутильний канат': 4.5,
      'Мобильные краны|M3|Підйом стріли — Монтажний режим|Стандартний канат': 3.05,
      'Мобильные краны|M3|Підйом стріли — Монтажний режим|Опірний крученню канат  / некрутильний канат': 4.5,
      'Мобильные краны|M3|Висування секцій стріли|Стандартний канат': 3.35,
      'Мобильные краны|M3|Висування секцій стріли|Опірний крученню канат  / некрутильний канат': 3.35,
      'Мобильные краны|M4|Підіймальний канат|Стандартний канат': 4.0,
      'Мобильные краны|M4|Підіймальний канат|Опірний крученню канат  / некрутильний канат': 4.5,
      'Мобильные краны|M4|Підйом стріли — Робочий режим|Стандартний канат': 3.35,
      'Мобильные краны|M4|Підйом стріли — Робочий режим|Опірний крученню канат  / некрутильний канат': 4.5,
      'Мобильные краны|M4|Підйом стріли — Монтажний режим|Стандартний канат': 3.05,
      'Мобильные краны|M4|Підйом стріли — Монтажний режим|Опірний крученню канат  / некрутильний канат': 4.5,
      'Мобильные краны|M4|Висування секцій стріли|Стандартний канат': 3.35,
      'Мобильные краны|M4|Висування секцій стріли|Опірний крученню канат  / некрутильний канат': 3.35,
      'Мобильные краны|M5|Підіймальний канат|Стандартний канат': 4.5,
      'Мобильные краны|M5|Підіймальний канат|Опірний крученню канат  / некрутильний канат': 4.5,
      'Мобильные краны|M5|Підйом стріли — Робочий режим|Стандартний канат': 3.35,
      'Мобильные краны|M5|Підйом стріли — Робочий режим|Опірний крученню канат  / некрутильний канат': 4.5,
      'Мобильные краны|M6|Підіймальний канат|Стандартний канат': 5.6,
      'Мобильные краны|M6|Підіймальний канат|Опірний крученню канат / некрутильний канат': 5.6,
      'Мобильные краны|M6|Підйом стріли — Робочий режим|Стандартний канат': 3.35,
      'Мобильные краны|M6|Підйом стріли — Робочий режим|Опірний крученню канат  / некрутильний канат': 5.6,

      // Stationary
      'Ванти і монтажні канати|A1|Ванти|Стандартний канат': 3.0,
      'Ванти і монтажні канати|A1|Монтажні канати|Стандартний канат': 2.73,
      'Ванти і монтажні канати|A2|Ванти|Стандартний канат': 3.0,
      'Ванти і монтажні канати|A2|Монтажні канати|Стандартний канат': 2.73,
      'Ванти і монтажні канати|A3|Ванти|Стандартний канат': 3.0,
      'Ванти і монтажні канати|A3|Монтажні канати|Стандартний канат': 2.73,
      'Ванти і монтажні канати|A4|Ванти|Стандартний канат': 3.5,
      'Ванти і монтажні канати|A4|Монтажні канати|Стандартний канат': 2.73,
      'Ванти і монтажні канати|A5|Ванти|Стандартний канат': 4.0,
      'Ванти і монтажні канати|A5|Монтажні канати|Стандартний канат': 2.73,
      'Ванти і монтажні канати|A6|Ванти|Стандартний канат': 4.5,
      'Ванти і монтажні канати|A7|Ванти|Стандартний канат': 5.0,
      'Ванти і монтажні канати|A8|Ванти|Стандартний канат': 5.0,
    };

    return db[key] ?? 3.55;
  }

  static double getFactorT(StrandCountOption option) {
    switch (option) {
      case StrandCountOption.strands3:
        return 1.25;
      case StrandCountOption.strands4to5:
        return 1.15;
      case StrandCountOption.strands6to10:
        return 1.00;
      case StrandCountOption.strands8to10Plast:
        return 0.95;
      case StrandCountOption.strands10PlusRR:
        return 1.00;
    }
  }

  static Map<String, double?> getHFactors({
    required EquipmentCategory category,
    required String group,
    required String mode,
    required RopeRotationType rotType,
  }) {
    if (category == EquipmentCategory.stationary) {
      return {'h1': null, 'h2': null};
    }

    if (category == EquipmentCategory.mobileCranes) {
      final isStd = rotType == RopeRotationType.standard;
      if (mode == 'Підіймальний канат') {
        return {'h1': isStd ? 16.0 : 18.0, 'h2': 18.0};
      } else if (mode.startsWith('Підйом стріли')) {
        return {'h1': isStd ? 14.0 : 16.0, 'h2': 16.0};
      } else if (mode == 'Висування секцій стріли') {
        return {'h1': 14.0, 'h2': 14.0};
      }
      return {'h1': 16.0, 'h2': 18.0};
    } else {
      final Map<String, List<double>> t4 = {
        'M1': [11.2, 12.5],
        'M2': [12.5, 14.0],
        'M3': [14.0, 16.0],
        'M4': [16.0, 18.0],
        'M5': [18.0, 20.0],
        'M6': [20.0, 22.4],
        'M7': [22.4, 25.0],
        'M8': [25.0, 28.0],
      };
      final row = t4[group] ?? [16.0, 18.0];
      return {'h1': row[0], 'h2': row[1]};
    }
  }

  static Iso16625Result calculate({
    required EquipmentCategory category,
    required String group,
    required String mode,
    required RopeRotationType rotType,
    required StrandCountOption strandOption,
    required double ropeDiamD,
    required double swlKn,
    required double mblKn,
    required double actualDrumD1,
    required double actualSheaveD2,
    required AppLanguage lang,
  }) {
    final double zpMin = getZp(category: category, group: group, mode: mode, rotType: rotType);
    final double zActual = swlKn > 0 ? (mblKn / swlKn) : 0.0;
    final double factorT = getFactorT(strandOption);

    final hFactors = getHFactors(category: category, group: group, mode: mode, rotType: rotType);
    final double? h1 = hFactors['h1'];
    final double? h2 = hFactors['h2'];

    final double? d1Min = h1 != null ? (h1 * factorT * ropeDiamD) : null;
    final double? d2Min = h2 != null ? (h2 * factorT * ropeDiamD) : null;

    final double? limitD1 = d1Min;
    final double? limitD2 = d2Min;

    final bool isZpPass = zActual >= zpMin;
    final bool isD1Pass = (category == EquipmentCategory.stationary || limitD1 == null)
        ? true
        : (actualDrumD1 >= limitD1);
    final bool isD2Pass = (category == EquipmentCategory.stationary || limitD2 == null)
        ? true
        : (actualSheaveD2 >= limitD2);

    final bool isOverallPass = isZpPass && isD1Pass && isD2Pass;
    final List<String> notes = [];

    if (!isZpPass) {
      notes.add(lang == AppLanguage.uk
          ? 'Фактичний запас міцності Z=${zActual.toStringAsFixed(2)} менший за мінімальний нормативний Zp=$zpMin'
          : 'Actual safety factor Z=${zActual.toStringAsFixed(2)} is lower than ISO 16625 required Zp=$zpMin');
    }
    if (limitD1 != null && actualDrumD1 < limitD1) {
      notes.add(lang == AppLanguage.uk
          ? 'Діаметр барабана D1=${actualDrumD1.toStringAsFixed(1)} мм менший за допустимий (${limitD1.toStringAsFixed(1)} мм)'
          : 'Drum diameter D1=${actualDrumD1.toStringAsFixed(1)} mm is below minimum required (${limitD1.toStringAsFixed(1)} mm)');
    }
    if (limitD2 != null && actualSheaveD2 < limitD2) {
      notes.add(lang == AppLanguage.uk
          ? 'Діаметр блока D2=${actualSheaveD2.toStringAsFixed(1)} мм менший за допустимий (${limitD2.toStringAsFixed(1)} мм)'
          : 'Sheave diameter D2=${actualSheaveD2.toStringAsFixed(1)} mm is below minimum required (${limitD2.toStringAsFixed(1)} mm)');
    }

    return Iso16625Result(
      zpMin: zpMin,
      zActual: zActual,
      d1Min: d1Min,
      d2Min: d2Min,
      h1: h1,
      h2: h2,
      factorT: factorT,
      isZpPass: isZpPass,
      isD1Pass: isD1Pass,
      isD2Pass: isD2Pass,
      isOverallPass: isOverallPass,
      notes: notes,
    );
  }
}

// ==========================================
// 6. ВЕКТОРНИЙ ПЕРЕРІЗ КАНАТА (1 + 6 ДРОТІВ)
// ==========================================
class RopeCrossSectionPainter extends CustomPainter {
  final Color strokeColor;
  final Color fillColor;

  const RopeCrossSectionPainter({
    this.strokeColor = const Color(0xFFFFC000),
    this.fillColor = const Color(0x33FFC000),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 6.0;
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, strokePaint);

    final double orbitRadius = 2.0 * radius;
    for (int i = 0; i < 6; i++) {
      final double angle = i * (math.pi / 3.0);
      final Offset wireCenter = Offset(
        center.dx + orbitRadius * math.cos(angle),
        center.dy + orbitRadius * math.sin(angle),
      );
      canvas.drawCircle(wireCenter, radius, fillPaint);
      canvas.drawCircle(wireCenter, radius, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 7. СПЛЕШ-СКРИН
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _entranceController;
  late AnimationController _zoomOutController;

  late Animation<double> _titleScale;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;

  late Animation<double> _flyThroughScale;
  late Animation<double> _flyThroughOpacity;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _titleFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.85, curve: Curves.easeIn),
    );

    _titleScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.05, 0.95, curve: Curves.easeOutCubic),
      ),
    );

    _zoomOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _flyThroughScale = Tween<double>(begin: 1.0, end: 3.8).animate(
      CurvedAnimation(
        parent: _zoomOutController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _flyThroughOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _zoomOutController,
        curve: const Interval(0.45, 1.0, curve: Curves.easeInOut),
      ),
    );

    _entranceController.forward();

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        _zoomOutController.forward().then((_) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 950),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
                  ),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.94, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: const MainHubScreen(),
                  ),
                );
              },
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _entranceController.dispose();
    _zoomOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.deepNavy,
      body: Center(
        child: AnimatedBuilder(
          animation: _zoomOutController,
          builder: (context, child) {
            return Opacity(
              opacity: _flyThroughOpacity.value,
              child: Transform.scale(
                scale: _flyThroughScale.value,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _rotationController,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: BrandColors.yellow.withValues(alpha: 0.35),
                        blurRadius: 48,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const CustomPaint(
                    painter: RopeCrossSectionPainter(
                      strokeColor: BrandColors.yellow,
                      fillColor: Color(0x33FFC000),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 38),

              FadeTransition(
                opacity: _titleFade,
                child: SlideTransition(
                  position: _titleSlide,
                  child: ScaleTransition(
                    scale: _titleScale,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                          decoration: BoxDecoration(
                            color: BrandColors.yellow,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: BrandColors.yellow.withValues(alpha: 0.4),
                                blurRadius: 24,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Text(
                            'ROPE GUARD',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.8,
                              color: BrandColors.deepNavy,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'WIRE ROPE ENGINEERING SUITE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ISO 4309  •  ISO 16625',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.8,
                            color: BrandColors.yellow.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              const SizedBox(
                width: 6,
                height: 6,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: BrandColors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 8. СТАРТОВИЙ ЕКРАН ВИБОРУ МОДУЛІВ
// ==========================================
class MainHubScreen extends StatefulWidget {
  const MainHubScreen({super.key});

  @override
  State<MainHubScreen> createState() => _MainHubScreenState();
}

class _MainHubScreenState extends State<MainHubScreen> {
  AppLanguage _lang = AppLanguage.uk;

  String tr(String key) => Tr.get(_lang, key);

  @override
  Widget build(BuildContext context) {
    final themeMode = RopeMasterApp.of(context).themeMode;
    final isDark = themeMode == AppThemeMode.dark;

    final cardBg = isDark ? BrandColors.darkCardBg : BrandColors.lightCardBg;
    final textColor = isDark ? Colors.white : BrandColors.lightTextMain;
    final subtitleColor = isDark ? Colors.white70 : BrandColors.lightTextSub;
    final borderCol = BrandColors.borderGrey;

    return Scaffold(
      backgroundColor: BrandColors.deepNavy,
      appBar: AppBar(
        backgroundColor: BrandColors.graphiteAppBar,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CustomPaint(
                painter: RopeCrossSectionPainter(
                  strokeColor: BrandColors.yellow,
                  fillColor: Color(0x44FFC000),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'ROPE GUARD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: BrandColors.yellow),
            tooltip: 'Змінити тему',
            onPressed: () {
              setState(() {
                RopeMasterApp.of(context).setThemeMode(
                  isDark ? AppThemeMode.light : AppThemeMode.dark,
                );
              });
            },
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SegmentedButton<AppLanguage>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.yellow;
                  return Colors.transparent;
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.graphiteAppBar;
                  return Colors.white;
                }),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.white24)),
              ),
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: AppLanguage.uk, label: const Text('UA', style: TextStyle(fontWeight: FontWeight.w700))),
                ButtonSegment(value: AppLanguage.en, label: const Text('EN', style: TextStyle(fontWeight: FontWeight.w700))),
              ],
              selected: {_lang},
              onSelectionChanged: (set) => setState(() => _lang = set.first),
            ),
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr('hub_title'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  tr('hub_subtitle'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
                const SizedBox(height: 28),

                _buildModuleCard(
                  title: tr('mod1_title'),
                  desc: tr('mod1_desc'),
                  icon: Icons.search,
                  badge: 'ISO 4309:2017',
                  cardBg: cardBg,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  borderCol: borderCol,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Iso4309ModuleScreen(initialLang: _lang)),
                    ).then((_) => setState(() {}));
                  },
                ),

                const SizedBox(height: 18),

                _buildModuleCard(
                  title: tr('mod2_title'),
                  desc: tr('mod2_desc'),
                  icon: Icons.calculate_outlined,
                  badge: 'ISO 16625',
                  cardBg: cardBg,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  borderCol: borderCol,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Iso16625ModuleScreen(initialLang: _lang)),
                    ).then((_) => setState(() {}));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required String title,
    required String desc,
    required IconData icon,
    required String badge,
    required Color cardBg,
    required Color textColor,
    required Color subtitleColor,
    required Color borderCol,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderCol),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 18,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BrandColors.deepNavy.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 34, color: BrandColors.deepNavy),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: BrandColors.deepNavy, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          badge,
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: BrandColors.yellow),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 12.5, color: subtitleColor, height: 1.35),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.arrow_forward_ios, size: 18, color: subtitleColor.withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 9. МОДУЛЬ 1: ISO 4309 (ІНСПЕКЦІЯ ТА БРАКУВАННЯ)
// ==========================================
class Iso4309ModuleScreen extends StatefulWidget {
  final AppLanguage initialLang;
  const Iso4309ModuleScreen({super.key, required this.initialLang});

  @override
  State<Iso4309ModuleScreen> createState() => _Iso4309ModuleScreenState();
}

class _Iso4309ModuleScreenState extends State<Iso4309ModuleScreen> {
  late AppLanguage _lang;
  RopeCategoryGroup _currentGroup = RopeCategoryGroup.nonRotationResistant;
  late RopeSpec _selectedRope;

  LayType _layType = LayType.ordinary;
  SpoolingType _spoolingType = SpoolingType.singleLayer;
  MechanismClass _mechClass = MechanismClass.m1ToM4;
  bool _hasDeformations = false;

  bool _hasWaviness = false;
  WavinessZone _wavinessZone = WavinessZone.sheaveOrDrum;
  final _wavinessGapController = TextEditingController(text: '2.0');

  SheaveGrooveStatus _sheaveP5 = SheaveGrooveStatus.fitA;
  SheaveGrooveStatus _sheaveP10 = SheaveGrooveStatus.none;

  final _certNoController = TextEditingController(text: '001/2026');
  final _companyController = TextEditingController(text: '');
  final _locationController = TextEditingController(text: '');
  final _equipmentController = TextEditingController(text: '');
  final _nominalDiamController = TextEditingController(text: '18.0');
  final _actualDiamController = TextEditingController(text: '17.0');
  final _breaks6dController = TextEditingController(text: '2');
  final _breaks30dController = TextEditingController(text: '5');

  InspectionResult? _result;

  @override
  void initState() {
    super.initState();
    _lang = widget.initialLang;
    _selectedRope = RopeDatabase.fullCatalog.firstWhere(
      (r) => r.name.startsWith('6x19S-IWRC'),
      orElse: () => RopeDatabase.fullCatalog.first,
    );
  }

  String tr(String key) => Tr.get(_lang, key);

  List<RopeSpec> get _filteredRopes =>
      RopeDatabase.fullCatalog.where((r) => r.group == _currentGroup).toList();

  void _calculate() {
    final double? nomD = double.tryParse(_nominalDiamController.text.replaceAll(',', '.'));
    final double? actD = double.tryParse(_actualDiamController.text.replaceAll(',', '.'));
    final int? b6d = int.tryParse(_breaks6dController.text);
    final int? b30d = int.tryParse(_breaks30dController.text);
    final double? waveGap = _hasWaviness
        ? double.tryParse(_wavinessGapController.text.replaceAll(',', '.'))
        : null;

    if (nomD == null || actD == null || b6d == null || b30d == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('fill_all')), backgroundColor: BrandColors.graphiteAppBar),
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
        hasWaviness: _hasWaviness,
        wavinessZone: _wavinessZone,
        measuredGap: waveGap,
        sheaveP5: _sheaveP5,
        sheaveP10: _sheaveP10,
        layType: _layType,
        spoolingType: _spoolingType,
        mechClass: _mechClass,
        lang: _lang,
      );
    });
  }

  void _printReport() {
    if (_result == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          language: _lang,
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

  Widget _buildSheaveOption(String label, SheaveGrooveStatus status, SheaveGrooveStatus current, Function(SheaveGrooveStatus) onSelect, bool isDark) {
    final bool isSelected = current == status;
    return InkWell(
      onTap: () => onSelect(status),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? BrandColors.yellow.withValues(alpha: 0.22) : (isDark ? BrandColors.darkCardInner : Colors.white),
          border: Border.all(
            color: isSelected ? BrandColors.yellow : BrandColors.borderGrey,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 86,
              height: 96,
              child: CustomPaint(painter: SheaveGaugePainter(type: status)),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isSelected ? BrandColors.yellow : (isDark ? Colors.white : BrandColors.lightTextMain),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = RopeMasterApp.of(context).themeMode;
    final isDark = themeMode == AppThemeMode.dark;

    final cardBg = isDark ? BrandColors.darkCardBg : BrandColors.lightCardBg;
    final cardInner = isDark ? BrandColors.darkCardInner : BrandColors.lightCardInner;
    final textColor = isDark ? Colors.white : BrandColors.lightTextMain;
    final subtitleColor = isDark ? Colors.white70 : BrandColors.lightTextSub;

    return Scaffold(
      backgroundColor: BrandColors.deepNavy,
      appBar: AppBar(
        backgroundColor: BrandColors.graphiteAppBar,
        title: Text(tr('mod1_title'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: BrandColors.yellow),
            tooltip: 'Змінити тему',
            onPressed: () {
              setState(() {
                RopeMasterApp.of(context).setThemeMode(
                  isDark ? AppThemeMode.light : AppThemeMode.dark,
                );
              });
            },
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SegmentedButton<AppLanguage>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.yellow;
                  return Colors.transparent;
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.graphiteAppBar;
                  return Colors.white;
                }),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.white24)),
              ),
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: AppLanguage.uk, label: const Text('UA', style: TextStyle(fontWeight: FontWeight.w700))),
                ButtonSegment(value: AppLanguage.en, label: const Text('EN', style: TextStyle(fontWeight: FontWeight.w700))),
              ],
              selected: {_lang},
              onSelectionChanged: (set) {
                setState(() {
                  _lang = set.first;
                  if (_result != null) _calculate();
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
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: BrandColors.borderGrey),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.22), blurRadius: 22, offset: const Offset(0, 8))
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: subtitleColor),
                    hintStyle: TextStyle(color: subtitleColor.withValues(alpha: 0.5)),
                    filled: true,
                    fillColor: isDark ? BrandColors.darkCardInner : Colors.white,
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: BrandColors.borderGrey)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: BrandColors.yellow, width: 2)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _certNoController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(labelText: tr('cert_no'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _companyController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(labelText: tr('company'), border: const OutlineInputBorder()),
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
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(labelText: tr('location'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _equipmentController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(labelText: tr('crane_id'), border: const OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    Text(tr('category_group'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: subtitleColor)),
                    const SizedBox(height: 8),
                    SegmentedButton<RopeCategoryGroup>(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return BrandColors.yellow.withValues(alpha: 0.3);
                          return cardInner;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return isDark ? BrandColors.yellow : BrandColors.deepNavy;
                          return textColor;
                        }),
                      ),
                      segments: [
                        ButtonSegment(value: RopeCategoryGroup.nonRotationResistant, label: Text(tr('cat_non_rot_res'), style: const TextStyle(fontSize: 12))),
                        ButtonSegment(value: RopeCategoryGroup.rotationResistant, label: Text(tr('cat_rot_res'), style: const TextStyle(fontSize: 12))),
                        ButtonSegment(value: RopeCategoryGroup.nonRotating, label: Text(tr('cat_non_rot'), style: const TextStyle(fontSize: 12))),
                      ],
                      selected: {_currentGroup},
                      onSelectionChanged: (set) {
                        setState(() {
                          _currentGroup = set.first;
                          _selectedRope = _filteredRopes.first;
                          if (_result != null) _calculate();
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<RopeSpec>(
                      key: ValueKey(_currentGroup),
                      initialValue: _filteredRopes.contains(_selectedRope) ? _selectedRope : _filteredRopes.first,
                      isExpanded: true,
                      dropdownColor: cardBg,
                      style: TextStyle(color: textColor, fontSize: 14),
                      decoration: InputDecoration(labelText: tr('rope_construct'), border: const OutlineInputBorder()),
                      items: _filteredRopes.map((rope) {
                        return DropdownMenuItem(
                          value: rope,
                          child: Text(
                            '${rope.name} (RCN ${rope.rcn})',
                            style: TextStyle(color: textColor, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedRope = val;
                            if (_result != null) _calculate();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nominalDiamController,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('d_nom'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _actualDiamController,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('d_act'), border: const OutlineInputBorder()),
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
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('b_6d'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _breaks30dController,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('b_30d'), border: const OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(tr('duty_class'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: subtitleColor)),
                    const SizedBox(height: 6),
                    SegmentedButton<MechanismClass>(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return BrandColors.yellow.withValues(alpha: 0.3);
                          return cardInner;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return isDark ? BrandColors.yellow : BrandColors.deepNavy;
                          return textColor;
                        }),
                      ),
                      segments: [
                        ButtonSegment(value: MechanismClass.m1ToM4, label: Text(tr('m1_m4'))),
                        ButtonSegment(value: MechanismClass.m5ToM8, label: Text(tr('m5_m8'))),
                      ],
                      selected: {_mechClass},
                      onSelectionChanged: (set) => setState(() => _mechClass = set.first),
                    ),
                    const SizedBox(height: 14),
                    SegmentedButton<LayType>(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return BrandColors.yellow.withValues(alpha: 0.3);
                          return cardInner;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return isDark ? BrandColors.yellow : BrandColors.deepNavy;
                          return textColor;
                        }),
                      ),
                      segments: [
                        ButtonSegment(value: LayType.ordinary, label: Text(tr('lay_ord'))),
                        ButtonSegment(value: LayType.lang, label: Text(tr('lay_lang'))),
                      ],
                      selected: {_layType},
                      onSelectionChanged: (set) => setState(() => _layType = set.first),
                    ),
                    const SizedBox(height: 10),
                    SegmentedButton<SpoolingType>(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return BrandColors.yellow.withValues(alpha: 0.3);
                          return cardInner;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) return isDark ? BrandColors.yellow : BrandColors.deepNavy;
                          return textColor;
                        }),
                      ),
                      segments: [
                        ButtonSegment(value: SpoolingType.singleLayer, label: Text(tr('spool_single'))),
                        ButtonSegment(value: SpoolingType.multiLayer, label: Text(tr('spool_multi'))),
                      ],
                      selected: {_spoolingType},
                      onSelectionChanged: (set) => setState(() => _spoolingType = set.first),
                    ),
                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cardInner,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: BrandColors.borderGrey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.waves, color: BrandColors.yellow, size: 20),
                              const SizedBox(width: 8),
                              Text(tr('waviness_title'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: textColor)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              height: 75,
                              width: double.infinity,
                              constraints: const BoxConstraints(maxWidth: 440),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: CustomPaint(painter: WavinessDiagramPainter()),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            activeTrackColor: BrandColors.yellow,
                            activeThumbColor: BrandColors.deepNavy,
                            title: Text(tr('waviness_check'), style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: textColor)),
                            value: _hasWaviness,
                            onChanged: (val) => setState(() => _hasWaviness = val),
                          ),
                          if (_hasWaviness) ...[
                            const SizedBox(height: 6),
                            SegmentedButton<WavinessZone>(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                  if (states.contains(WidgetState.selected)) return BrandColors.yellow.withValues(alpha: 0.3);
                                  return cardBg;
                                }),
                                foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                  if (states.contains(WidgetState.selected)) return BrandColors.yellow;
                                  return subtitleColor;
                                }),
                              ),
                              segments: [
                                ButtonSegment(value: WavinessZone.sheaveOrDrum, label: Text(tr('waviness_zone_sheave'), style: const TextStyle(fontSize: 11.5))),
                                ButtonSegment(value: WavinessZone.straightSection, label: Text(tr('waviness_zone_straight'), style: const TextStyle(fontSize: 11.5))),
                              ],
                              selected: {_wavinessZone},
                              onSelectionChanged: (set) => setState(() => _wavinessZone = set.first),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _wavinessGapController,
                              style: TextStyle(color: textColor),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Зазор хвилі g (мм)',
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: cardInner,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: BrandColors.borderGrey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.radio_button_checked, color: BrandColors.yellow, size: 20),
                              const SizedBox(width: 8),
                              Text(tr('sheave_title'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: textColor)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(tr('sheave_p5'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5, color: subtitleColor)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSheaveOption('A', SheaveGrooveStatus.fitA, _sheaveP5, (s) => setState(() => _sheaveP5 = s), isDark),
                              _buildSheaveOption('B', SheaveGrooveStatus.tightB, _sheaveP5, (s) => setState(() => _sheaveP5 = s), isDark),
                              _buildSheaveOption('C', SheaveGrooveStatus.wideC, _sheaveP5, (s) => setState(() => _sheaveP5 = s), isDark),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(tr('sheave_p10'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5, color: subtitleColor)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSheaveOption('A', SheaveGrooveStatus.fitA, _sheaveP10, (s) => setState(() => _sheaveP10 = s), isDark),
                              _buildSheaveOption('B', SheaveGrooveStatus.tightB, _sheaveP10, (s) => setState(() => _sheaveP10 = s), isDark),
                              _buildSheaveOption('C', SheaveGrooveStatus.wideC, _sheaveP10, (s) => setState(() => _sheaveP10 = s), isDark),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    SwitchListTile(
                      activeTrackColor: BrandColors.yellow,
                      activeThumbColor: BrandColors.deepNavy,
                      title: Text(tr('deformations'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor)),
                      value: _hasDeformations,
                      onChanged: (val) => setState(() => _hasDeformations = val),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: BrandColors.yellow,
                        foregroundColor: BrandColors.deepNavy,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _calculate,
                      child: Text(tr('btn_calc'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                    if (_result != null) ...[
                      const SizedBox(height: 20),
                      _buildResultCard(_result!),
                      const SizedBox(height: 14),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          foregroundColor: textColor,
                          side: const BorderSide(color: BrandColors.yellow, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _printReport,
                        icon: const Icon(Icons.picture_as_pdf, color: BrandColors.yellow),
                        label: Text(tr('btn_cert'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textColor)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(InspectionResult res) {
    Color cardColor = Colors.green.shade700;
    String title = tr('verdict_fit');
    IconData icon = Icons.check_circle;

    switch (res.verdict) {
      case RopeVerdict.fit:
        cardColor = Colors.green.shade600;
        title = tr('verdict_fit');
        icon = Icons.check_circle;
        break;
      case RopeVerdict.warning:
        cardColor = Colors.orange.shade700;
        title = tr('verdict_warn');
        icon = Icons.warning;
        break;
      case RopeVerdict.discard:
        cardColor = Colors.red.shade600;
        title = tr('verdict_disc');
        icon = Icons.cancel;
        break;
    }

    return Card(
      color: cardColor.withValues(alpha: 0.18),
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: cardColor, width: 2), borderRadius: BorderRadius.circular(12)),
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
                  child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.white24),
            Text('• ${tr('param_loss')}: ${res.diameterLossPercent.toStringAsFixed(2)}% (Мін: ${res.minAllowedDiameter.toStringAsFixed(2)} mm)', style: const TextStyle(color: Colors.white70)),
            Text('• ${tr('col_limit')} (6d / 30d): ${res.limitBreaks6d} / ${res.limitBreaks30d} pcs.', style: const TextStyle(color: Colors.white70)),
            if (res.hasWaviness && res.measuredGap != null)
              Text('• ${tr('param_wav')}: g=${res.measuredGap!.toStringAsFixed(2)} mm (Норма: max. ${res.allowedGapLimit?.toStringAsFixed(2)} mm)', style: const TextStyle(color: Colors.white70)),
            if (res.reasons.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...res.reasons.map((r) => Text('— $r', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500))),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 10. МОДУЛЬ 2: ISO 16625 (ПІДБІР ТА ПЕРЕВІРКА КАНАТА)
// ==========================================
class Iso16625ModuleScreen extends StatefulWidget {
  final AppLanguage initialLang;
  const Iso16625ModuleScreen({super.key, required this.initialLang});

  @override
  State<Iso16625ModuleScreen> createState() => _Iso16625ModuleScreenState();
}

class _Iso16625ModuleScreenState extends State<Iso16625ModuleScreen> {
  late AppLanguage _lang;

  EquipmentCategory _category = EquipmentCategory.mobileCranes;
  String _selectedGroup = 'M5';
  String _selectedMode = 'Підйом стріли — Монтажний режим';
  RopeRotationType _rotType = RopeRotationType.standard;
  StrandCountOption _strandOption = StrandCountOption.strands6to10;

  final _dNomController = TextEditingController(text: '18.0');
  final _swlController = TextEditingController(text: '50.0');
  final _mblController = TextEditingController(text: '260.0');
  final _drumD1Controller = TextEditingController(text: '350.0');
  final _sheaveD2Controller = TextEditingController(text: '380.0');

  final _certNoController = TextEditingController(text: '16625-001');
  final _companyController = TextEditingController(text: '');
  final _craneController = TextEditingController(text: '');

  Iso16625Result? _result;

  @override
  void initState() {
    super.initState();
    _lang = widget.initialLang;
    _updateModesAndGroups();
  }

  String tr(String key) => Tr.get(_lang, key);

  List<String> get _availableGroups {
    if (_category == EquipmentCategory.stationary) {
      return ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'];
    } else if (_category == EquipmentCategory.mobileCranes) {
      return ['M1', 'M2', 'M3', 'M4', 'M5', 'M6'];
    } else {
      return ['M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7', 'M8'];
    }
  }

  List<String> get _availableModes {
    if (_category == EquipmentCategory.stationary) {
      return ['Ванти', 'Монтажні канати'];
    } else if (_category == EquipmentCategory.mobileCranes) {
      return [
        'Підіймальний канат',
        'Підйом стріли — Робочий режим',
        'Підйом стріли — Монтажний режим',
        'Висування секцій стріли',
      ];
    } else {
      return [
        'Підіймальний канат — Одношарове навивання',
        'Підіймальний канат — Багатошарове навивання',
        'Механізм підйому (изменения вылета) стрелы',
      ];
    }
  }

  void _updateModesAndGroups() {
    if (!_availableGroups.contains(_selectedGroup)) {
      _selectedGroup = _availableGroups.first;
    }
    if (!_availableModes.contains(_selectedMode)) {
      _selectedMode = _availableModes.first;
    }
  }

  void _calculate() {
    final double? d = double.tryParse(_dNomController.text.replaceAll(',', '.'));
    final double? swl = double.tryParse(_swlController.text.replaceAll(',', '.'));
    final double? mbl = double.tryParse(_mblController.text.replaceAll(',', '.'));
    final double? d1 = double.tryParse(_drumD1Controller.text.replaceAll(',', '.'));
    final double? d2 = double.tryParse(_sheaveD2Controller.text.replaceAll(',', '.'));

    if (d == null || swl == null || mbl == null || d1 == null || d2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('fill_all')), backgroundColor: BrandColors.graphiteAppBar),
      );
      return;
    }

    setState(() {
      _result = Iso16625Engine.calculate(
        category: _category,
        group: _selectedGroup,
        mode: _selectedMode,
        rotType: _rotType,
        strandOption: _strandOption,
        ropeDiamD: d,
        swlKn: swl,
        mblKn: mbl,
        actualDrumD1: d1,
        actualSheaveD2: d2,
        lang: _lang,
      );
    });
  }

  void _printReport() {
    if (_result == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PdfIso16625PreviewScreen(
          language: _lang,
          certNo: _certNoController.text,
          company: _companyController.text,
          craneId: _craneController.text,
          category: _category,
          group: _selectedGroup,
          mode: _selectedMode,
          rotType: _rotType,
          strandOption: _strandOption,
          dNom: _dNomController.text,
          swl: _swlController.text,
          mbl: _mblController.text,
          actualD1: _drumD1Controller.text,
          actualD2: _sheaveD2Controller.text,
          result: _result!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = RopeMasterApp.of(context).themeMode;
    final isDark = themeMode == AppThemeMode.dark;

    final cardBg = isDark ? BrandColors.darkCardBg : BrandColors.lightCardBg;
    final cardInner = isDark ? BrandColors.darkCardInner : BrandColors.lightCardInner;
    final textColor = isDark ? Colors.white : BrandColors.lightTextMain;
    final subtitleColor = isDark ? Colors.white70 : BrandColors.lightTextSub;

    return Scaffold(
      backgroundColor: BrandColors.deepNavy,
      appBar: AppBar(
        backgroundColor: BrandColors.graphiteAppBar,
        title: Text(tr('mod2_title'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: BrandColors.yellow),
            tooltip: 'Змінити тему',
            onPressed: () {
              setState(() {
                RopeMasterApp.of(context).setThemeMode(
                  isDark ? AppThemeMode.light : AppThemeMode.dark,
                );
              });
            },
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SegmentedButton<AppLanguage>(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.yellow;
                  return Colors.transparent;
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) return BrandColors.graphiteAppBar;
                  return Colors.white;
                }),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.white24)),
              ),
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: AppLanguage.uk, label: const Text('UA', style: TextStyle(fontWeight: FontWeight.w700))),
                ButtonSegment(value: AppLanguage.en, label: const Text('EN', style: TextStyle(fontWeight: FontWeight.w700))),
              ],
              selected: {_lang},
              onSelectionChanged: (set) {
                setState(() {
                  _lang = set.first;
                  if (_result != null) _calculate();
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
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: BrandColors.borderGrey),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 22, offset: const Offset(0, 8))
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: subtitleColor),
                    hintStyle: TextStyle(color: subtitleColor.withValues(alpha: 0.5)),
                    filled: true,
                    fillColor: isDark ? BrandColors.darkCardInner : Colors.white,
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: BrandColors.borderGrey)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: BrandColors.yellow, width: 2)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _certNoController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(labelText: tr('cert_no'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _companyController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(labelText: tr('company'), border: const OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _craneController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(labelText: tr('crane_id'), border: const OutlineInputBorder()),
                    ),
                    const SizedBox(height: 18),

                    Text(tr('eq_type'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: subtitleColor)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<EquipmentCategory>(
                      key: ValueKey(_category),
                      initialValue: _category,
                      isExpanded: true,
                      dropdownColor: cardBg,
                      style: TextStyle(color: textColor, fontSize: 14),
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      items: [
                        DropdownMenuItem(
                          value: EquipmentCategory.generalCranes,
                          child: Text(tr('eq_gen'), style: const TextStyle(fontSize: 14)),
                        ),
                        DropdownMenuItem(
                          value: EquipmentCategory.mobileCranes,
                          child: Text(tr('eq_mob'), style: const TextStyle(fontSize: 14)),
                        ),
                        DropdownMenuItem(
                          value: EquipmentCategory.stationary,
                          child: Text(tr('eq_stat'), style: const TextStyle(fontSize: 14)),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _category = val;
                            _updateModesAndGroups();
                            if (_result != null) _calculate();
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            key: ValueKey('${_category}_$_selectedGroup'),
                            initialValue: _availableGroups.contains(_selectedGroup) ? _selectedGroup : _availableGroups.first,
                            dropdownColor: cardBg,
                            style: TextStyle(color: textColor, fontSize: 14),
                            decoration: InputDecoration(labelText: tr('group_class'), border: const OutlineInputBorder()),
                            items: _availableGroups.map((g) => DropdownMenuItem(
                              value: g,
                              child: Text(g, style: TextStyle(color: textColor, fontSize: 14)),
                            )).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedGroup = val;
                                  if (_result != null) _calculate();
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 5,
                          child: DropdownButtonFormField<String>(
                            key: ValueKey('${_category}_$_selectedMode'),
                            initialValue: _availableModes.contains(_selectedMode) ? _selectedMode : _availableModes.first,
                            isExpanded: true,
                            dropdownColor: cardBg,
                            style: TextStyle(color: textColor, fontSize: 14),
                            decoration: InputDecoration(labelText: tr('duty_mode'), border: const OutlineInputBorder()),
                            items: _availableModes.map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(m, style: TextStyle(color: textColor, fontSize: 14), overflow: TextOverflow.ellipsis),
                            )).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedMode = val;
                                  if (_result != null) _calculate();
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    if (_category != EquipmentCategory.stationary) ...[
                      const SizedBox(height: 14),
                      Text(tr('rot_type'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: subtitleColor)),
                      const SizedBox(height: 6),
                      SegmentedButton<RopeRotationType>(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) return BrandColors.yellow.withValues(alpha: 0.3);
                            return cardInner;
                          }),
                          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) return isDark ? BrandColors.yellow : BrandColors.deepNavy;
                            return subtitleColor;
                          }),
                        ),
                        segments: const [
                          ButtonSegment(value: RopeRotationType.standard, label: Text('Стандартний канат', style: TextStyle(fontSize: 12))),
                          ButtonSegment(value: RopeRotationType.rotationResistant, label: Text('Малокрутний / некрутильний канат', style: TextStyle(fontSize: 12))),
                        ],
                        selected: {_rotType},
                        onSelectionChanged: (set) {
                          setState(() {
                            _rotType = set.first;
                            if (_result != null) _calculate();
                          });
                        },
                      ),
                    ],

                    const SizedBox(height: 14),
                    DropdownButtonFormField<StrandCountOption>(
                      key: ValueKey(_strandOption),
                      initialValue: _strandOption,
                      isExpanded: true,
                      dropdownColor: cardBg,
                      style: TextStyle(color: textColor, fontSize: 14),
                      decoration: InputDecoration(labelText: tr('strands_label'), border: const OutlineInputBorder()),
                      items: [
                        DropdownMenuItem(value: StrandCountOption.strands3, child: Text(tr('str_3'), style: TextStyle(color: textColor, fontSize: 14))),
                        DropdownMenuItem(value: StrandCountOption.strands4to5, child: Text(tr('str_4_5'), style: TextStyle(color: textColor, fontSize: 14))),
                        DropdownMenuItem(value: StrandCountOption.strands6to10, child: Text(tr('str_6_10'), style: TextStyle(color: textColor, fontSize: 14))),
                        DropdownMenuItem(value: StrandCountOption.strands8to10Plast, child: Text(tr('str_8_10_p'), style: TextStyle(color: textColor, fontSize: 14))),
                        DropdownMenuItem(value: StrandCountOption.strands10PlusRR, child: Text(tr('str_10_rr'), style: TextStyle(color: textColor, fontSize: 14))),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _strandOption = val;
                            if (_result != null) _calculate();
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _dNomController,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('d_nom'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _swlController,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('swl_kn'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _mblController,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('mbl_kn'), border: const OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _drumD1Controller,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('drum_d1'), border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _sheaveD2Controller,
                            style: TextStyle(color: textColor),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: tr('sheave_d2'), border: const OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: BrandColors.yellow,
                        foregroundColor: BrandColors.deepNavy,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _calculate,
                      child: Text(tr('btn_calc'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    ),

                    if (_result != null) ...[
                      const SizedBox(height: 20),
                      _buildIso16625ResultCard(_result!),
                      const SizedBox(height: 14),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          foregroundColor: textColor,
                          side: const BorderSide(color: BrandColors.yellow, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _printReport,
                        icon: const Icon(Icons.picture_as_pdf, color: BrandColors.yellow),
                        label: Text(tr('btn_cert'), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textColor)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIso16625ResultCard(Iso16625Result res) {
    final Color cardColor = res.isOverallPass ? Colors.green.shade700 : Colors.red.shade700;
    final String title = res.isOverallPass ? tr('status_ok') : tr('status_fail');
    final IconData icon = res.isOverallPass ? Icons.check_circle : Icons.cancel;

    return Card(
      color: cardColor.withValues(alpha: 0.18),
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: cardColor, width: 2), borderRadius: BorderRadius.circular(12)),
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
                  child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.white24),
            Text('• ${tr('calc_zp_min')}: ${res.zpMin.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white70)),
            Text('• ${tr('calc_z_fact')}: ${res.zActual.toStringAsFixed(2)}  ${res.isZpPass ? "✓" : "✗"}', style: const TextStyle(color: Colors.white70)),
            if (res.d1Min != null)
              Text('• ${tr('calc_d1_min')}: ${res.d1Min!.toStringAsFixed(1)} мм  ${res.isD1Pass ? "✓" : "✗"}', style: const TextStyle(color: Colors.white70)),
            if (res.d2Min != null)
              Text('• ${tr('calc_d2_min')}: ${res.d2Min!.toStringAsFixed(1)} мм  ${res.isD2Pass ? "✓" : "✗"}', style: const TextStyle(color: Colors.white70)),
            if (res.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...res.notes.map((n) => Text('— $n', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500))),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 11. ВЕКТОРНЕ КРЕСЛЕННЯ ХВИЛЯСТОСТІ (ISO 4309)
// ==========================================
class WavinessDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..strokeWidth = 1.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final straightEdgePaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final dimPaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    final arrowPaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.fill;

    void drawArrowHead(Offset tip, bool pointsUp) {
      final path = Path();
      const double arrowLength = 4.0;
      const double arrowWidth = 2.4;
      if (pointsUp) {
        path.moveTo(tip.dx, tip.dy);
        path.lineTo(tip.dx - arrowWidth, tip.dy + arrowLength);
        path.lineTo(tip.dx + arrowWidth, tip.dy + arrowLength);
      } else {
        path.moveTo(tip.dx, tip.dy);
        path.lineTo(tip.dx - arrowWidth, tip.dy - arrowLength);
        path.lineTo(tip.dx + arrowWidth, tip.dy - arrowLength);
      }
      path.close();
      canvas.drawPath(path, arrowPaint);
    }

    final double width = size.width;
    final double height = size.height;
    final double startX = 14.0;
    final double endX = width - 14.0;
    final double baseY = height - 16.0;

    canvas.drawLine(Offset(startX - 8, baseY), Offset(endX + 8, baseY), straightEdgePaint);

    const double ropeThickness = 14.0;
    const double waveAmp = 8.5;
    final double crestY = baseY - ropeThickness - 2 * waveAmp;
    final double troughY = baseY;

    final double span = (endX - startX);
    final double p1X = startX + span * 0.25;
    final double p2X = startX + span * 0.50;
    final double p3X = startX + span * 0.75;

    final pathBottom = Path();
    pathBottom.moveTo(startX, baseY - waveAmp * 0.5);
    pathBottom.cubicTo(startX + span * 0.10, crestY + ropeThickness, p1X - span * 0.10, crestY + ropeThickness, p1X, crestY + ropeThickness);
    pathBottom.cubicTo(p1X + span * 0.10, crestY + ropeThickness, p2X - span * 0.10, troughY, p2X, troughY);
    pathBottom.cubicTo(p2X + span * 0.10, troughY, p3X - span * 0.10, crestY + ropeThickness, p3X, crestY + ropeThickness);
    pathBottom.cubicTo(p3X + span * 0.10, crestY + ropeThickness, endX - span * 0.10, baseY - waveAmp * 0.4, endX, baseY - waveAmp * 0.4);

    final pathTop = Path();
    pathTop.moveTo(startX, baseY - ropeThickness - waveAmp * 0.5);
    pathTop.cubicTo(startX + span * 0.10, crestY, p1X - span * 0.10, crestY, p1X, crestY);
    pathTop.cubicTo(p1X + span * 0.10, crestY, p2X - span * 0.10, troughY - ropeThickness, p2X, troughY - ropeThickness);
    pathTop.cubicTo(p2X + span * 0.10, troughY - ropeThickness, p3X - span * 0.10, crestY, p3X, crestY);
    pathTop.cubicTo(p3X + span * 0.10, crestY, endX - span * 0.10, baseY - ropeThickness - waveAmp * 0.4, endX, baseY - waveAmp * 0.4);

    canvas.drawPath(pathTop, linePaint);
    canvas.drawPath(pathBottom, linePaint);

    final double dimDX = p1X;
    canvas.drawLine(Offset(dimDX, crestY - 9), Offset(dimDX, crestY + ropeThickness + 5), dimPaint);
    drawArrowHead(Offset(dimDX, crestY), true);
    drawArrowHead(Offset(dimDX, crestY + ropeThickness), false);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = const TextSpan(
      text: 'd',
      style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 13, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(dimDX - 14, crestY - 14));

    final double dimGX = p3X;
    canvas.drawLine(Offset(dimGX, crestY + ropeThickness), Offset(dimGX, baseY + 13), dimPaint);
    drawArrowHead(Offset(dimGX, crestY + ropeThickness), true);
    drawArrowHead(Offset(dimGX, baseY), false);

    textPainter.text = const TextSpan(
      text: 'g',
      style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 13, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(dimGX - 14, baseY + 1));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 12. ВЕКТОРНІ ШАБЛОНИ КАНАВОК ШКІВІВ (A, B, C)
// ==========================================
class SheaveGaugePainter extends CustomPainter {
  final SheaveGrooveStatus type;

  SheaveGaugePainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;

    final sheaveBodyPaint = Paint()..color = const Color(0xFFB0BEC5)..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final thinOutline = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final gaugeFillPaint = Paint()..color = const Color(0xFFFFC000)..style = PaintingStyle.fill;
    final gaugeOutlinePaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final whiteHolePaint = Paint()..color = Colors.white..style = PaintingStyle.fill;

    final rimPath = Path();
    rimPath.moveTo(2, h - 3);
    rimPath.quadraticBezierTo(cx, h + 3, w - 2, h - 3);
    canvas.drawPath(rimPath, outlinePaint);

    final leftBevel = Path()..moveTo(6, 16)..lineTo(14, 16)..lineTo(14, h - 8)..lineTo(6, h - 8)..close();
    canvas.drawPath(leftBevel, sheaveBodyPaint);
    canvas.drawPath(leftBevel, thinOutline);

    final rightBevel = Path()..moveTo(w - 14, 16)..lineTo(w - 6, 16)..lineTo(w - 6, h - 8)..lineTo(w - 14, h - 8)..close();
    canvas.drawPath(rightBevel, sheaveBodyPaint);
    canvas.drawPath(rightBevel, thinOutline);

    final sheavePath = Path();
    sheavePath.moveTo(6, h - 8);
    sheavePath.lineTo(6, 16);
    sheavePath.cubicTo(6, 6, 16, 6, 18, 16);

    if (type == SheaveGrooveStatus.wideC) {
      sheavePath.lineTo(24, 40);
      sheavePath.arcToPoint(Offset(w - 24, 40), radius: const Radius.circular(16.0), clockwise: false);
      sheavePath.lineTo(w - 18, 16);
    } else {
      sheavePath.lineTo(28, 44);
      sheavePath.arcToPoint(Offset(w - 28, 44), radius: const Radius.circular(14.0), clockwise: false);
      sheavePath.lineTo(w - 18, 16);
    }

    sheavePath.cubicTo(w - 16, 6, w - 6, 6, w - 6, 16);
    sheavePath.lineTo(w - 6, h - 8);
    sheavePath.close();

    canvas.drawPath(sheavePath, sheaveBodyPaint);
    canvas.drawPath(sheavePath, outlinePaint);

    double gaugeCenterY;
    double gaugeRadius;
    double gaugeTopY;

    if (type == SheaveGrooveStatus.tightB) {
      gaugeRadius = 14.0;
      gaugeCenterY = 46.0;
      gaugeTopY = 8.0;
    } else if (type == SheaveGrooveStatus.wideC) {
      gaugeRadius = 11.0;
      gaugeCenterY = 53.0;
      gaugeTopY = 16.0;
    } else {
      gaugeRadius = 14.0;
      gaugeCenterY = 50.0;
      gaugeTopY = 12.0;
    }

    final gaugePath = Path();
    gaugePath.addArc(Rect.fromCircle(center: Offset(cx, gaugeCenterY), radius: gaugeRadius), 0, 3.14159265);
    gaugePath.lineTo(cx - gaugeRadius, gaugeTopY + 6);
    gaugePath.cubicTo(cx - gaugeRadius, gaugeTopY, cx + gaugeRadius, gaugeTopY, cx + gaugeRadius, gaugeTopY + 6);
    gaugePath.close();

    final holeRect = Rect.fromCircle(center: Offset(cx - gaugeRadius * 0.35, gaugeCenterY - 4.0), radius: gaugeRadius * 0.38);

    canvas.drawPath(gaugePath, gaugeFillPaint);
    canvas.drawPath(gaugePath, gaugeOutlinePaint);

    canvas.drawOval(holeRect, whiteHolePaint);
    canvas.drawOval(holeRect, gaugeOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 13. ГЕНЕРАЦІЯ PDF ДЛЯ МОДУЛЯ 1 (ISO 4309)
// ==========================================
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

  String tr(String key) => Tr.get(language, key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('btn_cert'))),
      body: PdfPreview(build: (format) => _generatePdf(format)),
    );
  }

  static pw.Widget _buildSectionHeader(String title, PdfColor bgColor, PdfColor textColor) {
    return pw.Container(
      color: bgColor,
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: pw.Text(title, style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: textColor)),
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
    final brandNavy = PdfColor.fromHex('00264C');

    final String laySpoolingStr =
        '${layType == LayType.ordinary ? tr('lay_ord') : tr('lay_lang')} / '
        '${spoolingType == SpoolingType.singleLayer ? tr('spool_single') : tr('spool_multi')}';

    final String dutyClassStr = mechClass == MechanismClass.m1ToM4 ? 'M1-M4' : 'M5-M8';

    final String sheaveSummary =
        'P5: ${result.sheaveStatusP5.name.toUpperCase().replaceAll('FITA', 'A (Fit)').replaceAll('TIGHTB', 'B (Tight)').replaceAll('WIDEC', 'C (Wide)')} / '
        'P10: ${result.sheaveStatusP10.name.toUpperCase().replaceAll('FITA', 'A (Fit)').replaceAll('TIGHTB', 'B (Tight)').replaceAll('WIDEC', 'C (Wide)').replaceAll('NONE', '-')}';

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
                    child: pw.Text('ROPE GUARD', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: brandNavy)),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        '${tr('pdf_title')} ${certNo.isEmpty ? "_____" : certNo}',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: brandNavy),
                      ),
                      pw.Text(tr('pdf_sub'), style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text('ISO 4309:2017', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
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
                      _buildTableCell(tr('param_wav')),
                      _buildTableCell(
                        result.hasWaviness && result.measuredGap != null ? 'g = ${result.measuredGap!.toStringAsFixed(2)} mm' : tr('no'),
                        isBold: true,
                        isCenter: true,
                      ),
                      _buildTableCell(
                        result.hasWaviness && result.allowedGapLimit != null ? 'max. ${result.allowedGapLimit!.toStringAsFixed(2)} mm' : tr('not_perm'),
                        isCenter: true,
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_sheave')),
                      _buildTableCell(sheaveSummary, isBold: true, isCenter: true),
                      _buildTableCell('A (Good fit)', isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('param_def')),
                      _buildTableCell(result.hasDeformations ? tr('yes') : tr('no'), isBold: true, isCenter: true),
                      _buildTableCell('Not permitted', isCenter: true),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),

              _buildSectionHeader(tr('sec_3'), headerYellow, brandNavy),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: pw.BoxDecoration(border: pw.Border.all(color: brandNavy, width: 1.2)),
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

// ==========================================
// 14. ГЕНЕРАЦІЯ PDF ДЛЯ МОДУЛЯ 2 (ISO 16625)
// ==========================================
class PdfIso16625PreviewScreen extends StatelessWidget {
  final AppLanguage language;
  final String certNo;
  final String company;
  final String craneId;
  final EquipmentCategory category;
  final String group;
  final String mode;
  final RopeRotationType rotType;
  final StrandCountOption strandOption;
  final String dNom;
  final String swl;
  final String mbl;
  final String actualD1;
  final String actualD2;
  final Iso16625Result result;

  const PdfIso16625PreviewScreen({
    super.key,
    required this.language,
    required this.certNo,
    required this.company,
    required this.craneId,
    required this.category,
    required this.group,
    required this.mode,
    required this.rotType,
    required this.strandOption,
    required this.dNom,
    required this.swl,
    required this.mbl,
    required this.actualD1,
    required this.actualD2,
    required this.result,
  });

  String tr(String key) => Tr.get(language, key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('btn_cert'))),
      body: PdfPreview(build: (format) => _generatePdf(format)),
    );
  }

  static pw.Widget _buildSectionHeader(String title, PdfColor bgColor, PdfColor textColor) {
    return pw.Container(
      color: bgColor,
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: pw.Text(title, style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: textColor)),
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
    final brandNavy = PdfColor.fromHex('00264C');

    final String catStr = category == EquipmentCategory.mobileCranes
        ? tr('eq_mob')
        : (category == EquipmentCategory.generalCranes ? tr('eq_gen') : tr('eq_stat'));

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
                    child: pw.Text('ROPE GUARD', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: brandNavy)),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        '${tr('pdf_16625_title')} ${certNo.isEmpty ? "_____" : certNo}',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: brandNavy),
                      ),
                      pw.Text(tr('pdf_16625_sub'), style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700)),
                    ],
                  ),
                  pw.Text('ISO 16625', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800)),
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
                      pw.Text('${tr('crane_id')}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5)),
                      pw.Text(craneId.isEmpty ? '-' : craneId, style: const pw.TextStyle(fontSize: 9.5)),
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
                        child: pw.Text('${tr('eq_type')}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                        child: pw.Text(catStr, style: const pw.TextStyle(fontSize: 9.5)),
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
                  0: const pw.FlexColumnWidth(1.2),
                  1: const pw.FlexColumnWidth(2.8),
                  2: const pw.FlexColumnWidth(1.5),
                  3: const pw.FlexColumnWidth(1.5),
                  4: const pw.FlexColumnWidth(1.5),
                  5: const pw.FlexColumnWidth(1.5),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: headerYellow),
                    children: [
                      _buildTableCell('Group', isBold: true, isCenter: true),
                      _buildTableCell(tr('duty_mode'), isBold: true, isCenter: true),
                      _buildTableCell(tr('d_nom'), isBold: true, isCenter: true),
                      _buildTableCell('SWL (kN)', isBold: true, isCenter: true),
                      _buildTableCell('MBL (kN)', isBold: true, isCenter: true),
                      _buildTableCell('Factor t', isBold: true, isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(group, isCenter: true),
                      _buildTableCell(mode, isCenter: true),
                      _buildTableCell('$dNom mm', isCenter: true),
                      _buildTableCell('$swl kN', isCenter: true),
                      _buildTableCell('$mbl kN', isCenter: true),
                      _buildTableCell('${result.factorT}', isCenter: true),
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
                  3: const pw.FlexColumnWidth(1.5),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: headerYellow),
                    children: [
                      _buildTableCell(tr('col_param'), isBold: true, isCenter: true),
                      _buildTableCell(tr('col_meas'), isBold: true, isCenter: true),
                      _buildTableCell('ISO 16625 Required', isBold: true, isCenter: true),
                      _buildTableCell('Status', isBold: true, isCenter: true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      _buildTableCell(tr('calc_z_fact')),
                      _buildTableCell('Z = ${result.zActual.toStringAsFixed(2)}', isBold: true, isCenter: true),
                      _buildTableCell('Zp >= ${result.zpMin.toStringAsFixed(2)}', isCenter: true),
                      _buildTableCell(result.isZpPass ? 'OK' : 'FAIL', isBold: true, isCenter: true),
                    ],
                  ),
                  if (result.d1Min != null)
                    pw.TableRow(
                      children: [
                        _buildTableCell(tr('drum_d1')),
                        _buildTableCell('$actualD1 mm', isBold: true, isCenter: true),
                        _buildTableCell('D1 >= ${result.d1Min!.toStringAsFixed(1)} mm', isCenter: true),
                        _buildTableCell(result.isD1Pass ? 'OK' : 'FAIL', isBold: true, isCenter: true),
                      ],
                    ),
                  if (result.d2Min != null)
                    pw.TableRow(
                      children: [
                        _buildTableCell(tr('sheave_d2')),
                        _buildTableCell('$actualD2 mm', isBold: true, isCenter: true),
                        _buildTableCell('D2 >= ${result.d2Min!.toStringAsFixed(1)} mm', isCenter: true),
                        _buildTableCell(result.isD2Pass ? 'OK' : 'FAIL', isBold: true, isCenter: true),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 12),

              _buildSectionHeader(tr('sec_3'), headerYellow, brandNavy),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: pw.BoxDecoration(border: pw.Border.all(color: brandNavy, width: 1.2)),
                child: pw.Center(
                  child: pw.Text(
                    result.isOverallPass ? tr('status_ok') : tr('status_fail'),
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: result.isOverallPass ? PdfColors.green900 : PdfColors.red900,
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