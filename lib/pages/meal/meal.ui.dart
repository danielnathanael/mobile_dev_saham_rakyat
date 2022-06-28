import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_saham_rakyat/pages/meal/meal.bloc.dart';
import 'package:mobile_dev_saham_rakyat/pages/meal/meal.event.dart';
import 'package:mobile_dev_saham_rakyat/pages/meal/meal.state.dart';

class MealUI extends StatefulWidget {
  final String title;
  final String id;

  const MealUI({required this.title, required this.id});

  @override
  State<StatefulWidget> createState() => _MealUIState();
}

class _MealUIState extends State<MealUI> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MealBloc>(
      create: (context) => MealBloc()..add(OnLoadMeal(id: widget.id)),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocConsumer<MealBloc, MealState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.isFailed) {
              return Center(
                child: Text('Gagal mendapatkan data'),
              );
            }

            return ListView(
              children: [
                Container(
                  color: Colors.grey.shade200,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Builder(builder: (context) {
                    String? pictureUrl = state.meal?.pictureUrl;

                    if (pictureUrl != null) {
                      return Image.network(
                        pictureUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, obj, trace) {
                          return Center(
                            child: Text('Gagal mendapatkan foto'),
                          );
                        },
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                      );
                    } else {
                      return Center(
                        child: Text('Gagal mendapatkan foto'),
                      );
                    }
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          state.meal?.title ?? '-',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('work in progress...'),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
