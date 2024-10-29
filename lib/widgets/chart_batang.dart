import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartBatang extends StatefulWidget {
  const ChartBatang({super.key});

  @override
  State<ChartBatang> createState() => _ChartBatangState();
}

class _ChartBatangState extends State<ChartBatang> {
  static const double defaultPadding = 10.0;
  DateTime? selectedDate;
  List<ChartBatangData> filteredData = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _filterDataBySelectedDate();
  }

  void _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now.subtract(const Duration(days: 30)), // 30 days back
      lastDate: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(1000, 49, 103,
                  242), // Warna utama (header, tanggal yang dipilih)
              onPrimary: Colors.white, // Warna teks di header
              onSurface: Color(0xFF718096), // Warna teks di tanggal
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color.fromARGB(1000, 49, 103, 242), // Warna tombol
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
        _filterDataBySelectedDate();
      });
    }
  }

  void _filterDataBySelectedDate() {
    setState(() {
      filteredData = chartData.where((data) {
        return data.realData >= 20000 && data.realData <= 500000;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentDateText = selectedDate == null
        ? DateFormat('d MMM y').format(DateTime.now())
        : DateFormat('d MMM y').format(selectedDate!);

    filteredData.sort((a, b) => b.realData.compareTo(a.realData));

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Grafik Tren Penyakit',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D3748),
                  ),
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: _pickDate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentDateText,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: const Color(0xFF718096),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF718096),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 850,
                child: SfCartesianChart(
                  plotAreaBackgroundColor: Colors.transparent,
                  margin: const EdgeInsets.symmetric(
                    vertical: defaultPadding,
                    horizontal: defaultPadding / 2,
                  ),
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  plotAreaBorderWidth: 0,
                  enableSideBySideSeriesPlacement: true,
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final ChartBatangData chartData = data as ChartBatangData;

                      return Container(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${chartData.x}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Jumlah Penderita: ${chartData.realData}',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Persentase Penyebaran: ${chartData.percentage}%',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  primaryXAxis: CategoryAxis(
                    labelRotation: 45,
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    minimum: 0,
                    maximum: 600000,
                    interval: 100000,
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartBatangData, String>(
                      borderRadius: BorderRadius.circular(15),
                      dataSource: filteredData,
                      width: 1,
                      pointColorMapper: (ChartBatangData data, _) =>
                          _getBarColor(data.realData),
                      xValueMapper: (ChartBatangData data, _) => data.x,
                      yValueMapper: (ChartBatangData data, _) => data.realData,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                        ),
                      ),
                      name: "Jumlah Penderita",
                    ),
                    ColumnSeries<ChartBatangData, String>(
                      borderRadius: BorderRadius.circular(15),
                      dataSource: filteredData,
                      width: 0.4,
                      color: const Color(0xFFE9EDF7).withOpacity(0.6),
                      xValueMapper: (ChartBatangData data, _) => data.x,
                      yValueMapper: (ChartBatangData data, _) =>
                          data.percentage,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                        textStyle: GoogleFonts.lato(
                          color: Colors.black54,
                        ),
                      ),
                      name: "Persentase Peningkatan",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBarColor(double value) {
    double normalizedValue = (value - 0) / (600000 - 0);
    normalizedValue = normalizedValue.clamp(0.0, 1.0);
    int r = (76 + (128 * (1 - normalizedValue))).toInt();
    int g = (81 + (128 * (1 - normalizedValue))).toInt();
    int b = (191 + (64 * normalizedValue)).toInt();

    return Color.fromARGB(255, r, g, b);
  }
}

class ChartBatangData {
  ChartBatangData(this.x, this.percentage, this.realData);
  final String x;
  final double percentage;
  final double realData;
}

final List<ChartBatangData> chartData = <ChartBatangData>[
  ChartBatangData("DBD", 13.0, 500000),
  ChartBatangData("TBC", 10.5, 300000),
  ChartBatangData("Malaria", 9.0, 450000),
  ChartBatangData("COVID-19", 8.5, 250000),
  ChartBatangData("Flu", 7.0, 220000),
  ChartBatangData("Pneumonia", 6.0, 200000),
  ChartBatangData("HIV", 5.5, 150000),
  ChartBatangData("Kolera", 5.0, 120000),
  ChartBatangData("Diare", 4.5, 80000),
  ChartBatangData("Asma", 4.0, 95000),
  ChartBatangData("Hepatitis", 3.5, 70000),
  ChartBatangData("Kusta", 3.0, 60000),
  ChartBatangData("Campak", 2.5, 50000),
  ChartBatangData("Rubella", 2.0, 40000),
  ChartBatangData("Sifilis", 1.5, 30000),
  ChartBatangData("Diphtheria", 1.0, 20000),
];
