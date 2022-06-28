import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_saham_rakyat/pages/home/home.bloc.dart';
import 'package:mobile_dev_saham_rakyat/pages/home/home.event.dart';
import 'package:mobile_dev_saham_rakyat/pages/home/home.state.dart';
import 'package:mobile_dev_saham_rakyat/pages/meal/meal.ui.dart';

class HomeUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(OnLoadHome()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mobile Dev Test'),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) => {},
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

            print(state.categories.length);

            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    items: state.categories
                        .map((element) => DropdownMenuItem<String>(
                              value: element,
                              child: Text(element),
                            ))
                        .toList(),
                    value: state.selectedCategory,
                    hint: Text('Pilih kategori'),
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<HomeBloc>().add(OnSelectCategory(category: value));
                      }
                    },
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (state.isMealLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.isMealFailed) {
                        return Center(
                          child: Text('Gagal mendapatkan data'),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.meals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.network(
                                state.meals[index].pictureUrl,
                              ),
                            ),
                            title: Text(state.meals[index].title),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MealUI(
                                    id: state.meals[index].id,
                                    title: state.meals[index].title,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
