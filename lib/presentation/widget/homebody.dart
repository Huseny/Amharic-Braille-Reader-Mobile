import 'package:amharic_braille/application/braille_bloc/braille_bloc.dart';
import 'package:amharic_braille/application/braille_bloc/braille_events.dart';
import 'package:amharic_braille/application/braille_bloc/braille_state.dart';
import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:amharic_braille/presentation/widget/recents_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<TranslationModel> _recentUploads = [];
  late BrailleBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<BrailleBloc>(context);
    bloc.add(GetRecents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrailleBloc, BrailleState>(listener: (context, state) {
      if (state is BrailleRecentsSuccess) {
        setState(() {
          _recentUploads.addAll(state.recents);
        });
      }
    }, builder: ((context, state) {
      return RefreshIndicator(
        onRefresh: () async {
          bloc.add(GetRecents());
        },
        child: _recentUploads.isEmpty
            ? state.runtimeType == BrailleRecentsLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset("assets/images/no_records.jpg"),
                      ),
                      Text(
                        state.runtimeType == BrailleRecentsFailure
                            ? "Error loading upload histoy!"
                            : "No recent uploads!, upload a photo to get started",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bloc.add(GetRecents());
                          },
                          child: Text(state.runtimeType == BrailleRecentsFailure
                              ? "Retry"
                              : "Refresh"))
                    ],
                  )
            : ListView.builder(
                itemCount: _recentUploads.length,
                itemBuilder: (context, index) {
                  return RecentContainer(recent: _recentUploads[index]);
                }),
      );
    }));
  }
}
