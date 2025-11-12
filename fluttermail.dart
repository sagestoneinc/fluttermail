# SageStone Flutter Starter (Ultra Admin CRM Style)

Below is a minimal but production-leaning Flutter app scaffold aligned to the Ultra Admin CRM visual language. Copy this into a new repo and run.

---

## Repo Tree
```
.
├─ pubspec.yaml
├─ analysis_options.yaml
├─ lib/
│  ├─ main.dart
│  ├─ theme/
│  │  ├─ tokens.dart
│  │  └─ theme.dart
│  ├─ shell/
│  │  └─ app_shell.dart
│  ├─ widgets/
│  │  ├─ kpi_card.dart
│  │  ├─ audience_table.dart
│  │  └─ activity_feed.dart
│  └─ screens/
│     ├─ dashboard_screen.dart
│     ├─ campaign_builder_screen.dart
│     └─ automations_screen.dart
├─ web/
│  └─ index.html (auto from flutter create)
└─ README.md
```

---

## pubspec.yaml
```yaml
name: sagestone_flutter
description: SageStone Email Marketing App – Ultra Admin CRM inspired UI
publish_to: "none"
version: 0.1.0+1

environment:
  sdk: ">=3.4.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^2.0.9
  data_table_2: ^2.5.12
  fl_chart: ^0.69.0
  cached_network_image: ^3.4.1
  intl: ^0.19.0

  # Add later when wiring state & API
  # flutter_riverpod: ^2.5.1
  # dio: ^5.5.0
  # go_router: ^14.2.0
  # freezed_annotation: ^2.4.1
  # json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  # build_runner: ^2.4.11
  # freezed: ^2.5.2
  # json_serializable: ^6.9.0

flutter:
  uses-material-design: true
```

---

## analysis_options.yaml
```yaml
include: package:flutter_lints/flutter.yaml
linter:
  rules:
    avoid_print: true
    prefer_single_quotes: true
    curly_braces_in_flow_control_structures: true
```

---

## lib/theme/tokens.dart
```dart
import 'package:flutter/material.dart';

class SSTokens {
  // Ultra Admin inspired palette
  static const primary = Color(0xFF4F46E5); // indigo-600
  static const primaryDark = Color(0xFF4338CA); // indigo-700
  static const accent = Color(0xFF22D3EE); // cyan-400
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);

  static const gray50 = Color(0xFFF9FAFB);
  static const gray100 = Color(0xFFF3F4F6);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray300 = Color(0xFFD1D5DB);
  static const gray600 = Color(0xFF4B5563);
  static const gray700 = Color(0xFF374151);
  static const gray900 = Color(0xFF0F172A);

  static BorderRadius get radiusLg => BorderRadius.circular(16);
  static double get gutter => 16;
  static EdgeInsets get cardPad => const EdgeInsets.all(16);
}
```

---

## lib/theme/theme.dart
```dart
import 'package:flutter/material.dart';
import 'tokens.dart';

ThemeData buildTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: SSTokens.primary,
    brightness: Brightness.light,
    primary: SSTokens.primary,
    secondary: SSTokens.accent,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: SSTokens.gray50,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: SSTokens.gray900,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: SSTokens.radiusLg,
        side: const BorderSide(color: SSTokens.gray200),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SSTokens.gray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SSTokens.gray200),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: SSTokens.gray100,
      selectedColor: SSTokens.primary.withOpacity(.12),
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: const BorderSide(color: SSTokens.gray200),
      ),
    ),
    dividerColor: SSTokens.gray200,
    useMaterial3: true,
  );
}
```

---

## lib/shell/app_shell.dart
```dart
import 'package:flutter/material.dart';
import '../theme/tokens.dart';
import '../screens/dashboard_screen.dart';
import '../screens/campaign_builder_screen.dart';
import '../screens/automations_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final destinations = const [
    NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
    NavigationRailDestination(icon: Icon(Icons.people_alt_outlined), selectedIcon: Icon(Icons.people_alt), label: Text('Audience')),
    NavigationRailDestination(icon: Icon(Icons.email_outlined), selectedIcon: Icon(Icons.email), label: Text('Campaigns')),
    NavigationRailDestination(icon: Icon(Icons.auto_awesome_mosaic_outlined), selectedIcon: Icon(Icons.auto_awesome_mosaic), label: Text('Automations')),
    NavigationRailDestination(icon: Icon(Icons.outlined_flag), selectedIcon: Icon(Icons.flag), label: Text('Deliverability')),
    NavigationRailDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: Text('Settings')),
  ];

  Widget _page(int i) {
    switch (i) {
      case 0:
        return const DashboardScreen();
      case 2:
        return const CampaignBuilderScreen();
      case 3:
        return const AutomationsScreen();
      default:
        return const Center(child: Text('Coming soon'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final rail = NavigationRail(
      backgroundColor: Colors.white,
      selectedIndex: index,
      groupAlignment: -1,
      onDestinationSelected: (i) => setState(() => index = i),
      labelType: NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CircleAvatar(radius: 18, backgroundColor: SSTokens.primary, child: const Text('SS', style: TextStyle(color: Colors.white))),
      ),
      destinations: destinations,
    );

    final topBar = AppBar(
      title: const Text('SageStone CRM'),
      actions: [
        SizedBox(
          width: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(decoration: const InputDecoration(hintText: 'Search…', prefixIcon: Icon(Icons.search))),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        const SizedBox(width: 8),
        const CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/64')),
        const SizedBox(width: 12),
      ],
    );

    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth > 1100;
        return Scaffold(
          appBar: topBar,
          body: Row(
            children: [
              if (isWide) rail else const SizedBox.shrink(),
              if (isWide) const VerticalDivider(width: 1),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(SSTokens.gutter),
                  child: _page(index),
                ),
              ),
            ],
          ),
          drawer: isWide ? null : Drawer(child: ListView(children: const [DrawerHeader(child: Text('SageStone'))])),
        );
      },
    );
  }
}
```

---

## lib/widgets/kpi_card.dart
```dart
import 'package:flutter/material.dart';
import '../theme/tokens.dart';
import 'package:fl_chart/fl_chart.dart';

class KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final double delta; // positive good
  final List<double> sparkline;

  const KpiCard({super.key, required this.label, required this.value, required this.delta, required this.sparkline});

  @override
  Widget build(BuildContext context) {
    final positive = delta >= 0;
    final chipColor = (positive ? SSTokens.success : SSTokens.danger).withOpacity(.12);
    final chipText = TextStyle(color: positive ? SSTokens.success : SSTokens.danger, fontWeight: FontWeight.w600);

    return Card(
      child: Padding(
        padding: SSTokens.cardPad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: SSTokens.gray600)),
            const SizedBox(height: 6),
            Row(children: [
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(color: chipColor, borderRadius: BorderRadius.circular(999)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('${delta > 0 ? '▲' : '▼'} ${delta.abs().toStringAsFixed(1)}%', style: chipText),
              ),
            ]),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: LineChart(LineChartData(
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [for (var i = 0; i < sparkline.length; i++) FlSpot(i.toDouble(), sparkline[i])],
                    isCurved: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: true, applyCutOffY: true, cutOffY: 0),
                    barWidth: 2,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## lib/widgets/audience_table.dart
```dart
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class AudienceTable extends StatelessWidget {
  final List<Map<String, dynamic>> rows;
  const AudienceTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: SSTokens.cardPad,
        child: DataTable2(
          columnSpacing: 16,
          horizontalMargin: 8,
          columns: const [
            DataColumn2(label: Text('Contact'), size: ColumnSize.L),
            DataColumn(label: Text('Tags')),
            DataColumn(label: Text('Status')),
            DataColumn2(label: Text('Last Activity'), size: ColumnSize.S),
          ],
          rows: rows.map((r) {
            return DataRow(cells: [
              DataCell(Row(children: [
                CircleAvatar(radius: 12, backgroundImage: NetworkImage(r['avatar'] as String)),
                const SizedBox(width: 8),
                Text(r['name']),
              ])),
              DataCell(Wrap(spacing: 6, runSpacing: -8, children: [
                for (final t in (r['tags'] as List)) Chip(label: Text(t.toString())),
              ])),
              DataCell(Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (r['status'] == 'Active' ? SSTokens.success : SSTokens.warning).withOpacity(.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(r['status'], style: const TextStyle(fontWeight: FontWeight.w600)),
              )),
              DataCell(Text(r['last'])),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
```

---

## lib/widgets/activity_feed.dart
```dart
import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class ActivityFeed extends StatelessWidget {
  final List<ActivityItem> items;
  const ActivityFeed({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: SSTokens.cardPad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            for (final i in items) _Tile(i),
          ],
        ),
      ),
    );
  }
}

class ActivityItem {
  final String title;
  final String subtitle;
  final DateTime time;
  final IconData icon;
  ActivityItem(this.title, this.subtitle, this.time, this.icon);
}

class _Tile extends StatelessWidget {
  final ActivityItem item;
  const _Tile(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: SSTokens.primary.withOpacity(.08), borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(8),
            child: Icon(item.icon, size: 18, color: SSTokens.primary),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(item.subtitle, style: const TextStyle(color: SSTokens.gray600)),
          ])),
          Text(_timeAgo(item.time), style: const TextStyle(color: SSTokens.gray600)),
        ],
      ),
    );
  }

  String _timeAgo(DateTime t) {
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${d.inDays}d ago';
  }
}
```

---

## lib/screens/dashboard_screen.dart
```dart
import 'package:flutter/material.dart';
import '../theme/tokens.dart';
import '../widgets/kpi_card.dart';
import '../widgets/audience_table.dart';
import '../widgets/activity_feed.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kpis = const [
      KpiCard(label: 'Total Subscribers', value: '42,310', delta: 3.2, sparkline: [2,3,2.5,3.4,3.2,3.9,4.2]),
      KpiCard(label: 'Open Rate', value: '36.8%', delta: 0.9, sparkline: [30,32,31,35,34,36,36.8]),
      KpiCard(label: 'Click Rate', value: '4.1%', delta: -0.3, sparkline: [4.4,4.2,4.5,4.3,4.0,4.2,4.1]),
      KpiCard(label: 'Bounces', value: '0.41%', delta: -0.1, sparkline: [0.7,0.6,0.5,0.48,0.45,0.42,0.41]),
    ];

    final audienceRows = List.generate(6, (i) => {
      'avatar': 'https://i.pravatar.cc/64?img=${i+12}',
      'name': 'Contact ${i+1}',
      'tags': ['Prospect', if (i.isEven) 'VIP', 'Newsletter'],
      'status': i.isEven ? 'Active' : 'Pending',
      'last': '${(i+1) * 3}h ago',
    });

    final activities = List.generate(5, (i) => ActivityItem(
      'Campaign “Q${i+1} Promo” sent',
      '4,2${i}k delivered • 37% open • 4% click',
      DateTime.now().subtract(Duration(hours: i * 3 + 1)),
      Icons.campaign_outlined,
    ));

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Wrap(
            spacing: SSTokens.gutter,
            runSpacing: SSTokens.gutter,
            children: kpis.map((k) => SizedBox(width: 320, child: k)).toList(),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: LayoutBuilder(builder: (context, c) {
            final isTwoCol = c.maxWidth > 1200;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: AudienceTable(rows: audienceRows)),
                if (isTwoCol) const SizedBox(width: 16),
                if (isTwoCol) Expanded(flex: 4, child: ActivityFeed(items: activities)),
              ],
            );
          }),
        ),
      ],
    );
  }
}
```

---

## lib/screens/campaign_builder_screen.dart
```dart
import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class CampaignBuilderScreen extends StatelessWidget {
  const CampaignBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: Block library
        SizedBox(
          width: 280,
          child: Card(
            child: Padding(
              padding: SSTokens.cardPad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Blocks', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  for (final b in ['Hero','Text','Image','Button','Columns','Product Grid','Divider','Footer'])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(b),
                        onPressed: () {},
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Center: Editor surface (placeholder)
        Expanded(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: SSTokens.gray200)),
                  ),
                  child: Row(children: [
                    const Text('Campaign Editor', style: TextStyle(fontWeight: FontWeight.w700)),
                    const Spacer(),
                    FilledButton(onPressed: () {}, child: const Text('Preview')),
                    const SizedBox(width: 8),
                    OutlinedButton(onPressed: () {}, child: const Text('Save Draft')),
                  ]),
                ),
                const Expanded(
                  child: Center(
                    child: Text('Drag blocks here to build your email…'),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Right: Properties panel
        SizedBox(
          width: 320,
          child: Card(
            child: Padding(
              padding: SSTokens.cardPad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Properties', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  TextField(decoration: const InputDecoration(labelText: 'Subject')),
                  const SizedBox(height: 8),
                  TextField(decoration: const InputDecoration(labelText: 'Preheader')),
                  const SizedBox(height: 8),
                  DropdownButtonFormField(
                    items: const [DropdownMenuItem(value: 'Default', child: Text('Default'))],
                    onChanged: (_) {},
                    decoration: const InputDecoration(labelText: 'Template Theme'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

---

## lib/screens/automations_screen.dart
```dart
import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class AutomationsScreen extends StatelessWidget {
  const AutomationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: SSTokens.gray200)),
            ),
            child: Row(children: [
              const Text('Automation Builder', style: TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              OutlinedButton(onPressed: () {}, child: const Text('Validate')),
              const SizedBox(width: 8),
              FilledButton(onPressed: () {}, child: const Text('Publish')),
            ]),
          ),
          const Expanded(
            child: Center(child: Text('Canvas placeholder (zoom, pan, nodes, edges)…')),
          ),
        ],
      ),
    );
  }
}
```

---

## lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'shell/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SageStoneApp());
}

class SageStoneApp extends StatelessWidget {
  const SageStoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SageStone Email Marketing',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const AppShell(),
    );
  }
}
```

---

## README.md
```md
# SageStone Flutter Starter (Ultra Admin CRM Style)

Ultra Admin–inspired Flutter app scaffold for the SageStone Email Marketing Tool (web-first, mobile ready).

## Quickstart
```bash
flutter --version           # Flutter 3.x recommended
flutter pub get
flutter run -d chrome       # Web
# or
flutter run -d macos        # Desktop (if enabled)
```

## What’s inside
- App shell (left rail + top bar)
- Dashboard with KPI tiles, audience table, activity feed
- Campaign Builder skeleton (blocks, preview CTA, properties)
- Automation Builder placeholder (canvas area)
- Theme & tokens mirroring Ultra Admin look

## Next steps
- Add routing (go_router) & state (Riverpod)
- Wire backend via dio and generated Dart SDK
- Replace mock data with API widgets
- Add dark mode and responsive polish
