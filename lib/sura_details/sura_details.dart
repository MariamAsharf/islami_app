import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/home/models/sura_model.dart';
import 'package:islami_app/my_theme/my_theme.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = "SuraDetailsScreen";

  SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as SuraModel;
    if (verses.isEmpty) {
      loadSuraFile(model.index + 1);
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Text(model.nameEng, style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/details_bg.png"),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              SizedBox(height: 24),
              Text(model.nameAr, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 32),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: "${verses[index]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  TextSpan(
                                    text: "(${index + 1})",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: MYTheme.thirdColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: verses.length),
                ),
              ),
              SizedBox(height: 92),
            ],
          )
        ],
      ),
    );
  }

  loadSuraFile(int index) async {
    String file = await rootBundle.loadString("assets/files/$index.txt");
    List<String> lines = file.split("\n");
    print(lines);
    verses = lines;
    setState(() {});
  }
}
