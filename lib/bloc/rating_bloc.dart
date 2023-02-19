import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/bloc/events/rating_event.dart';
import 'package:new_app/database.dart';
import 'package:new_app/models/rating.dart';

import 'states/rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  List<Rating> ratings = [];
  RatingBloc() : super(RatingState()) {
    on<GetRatings>(_getRatings);
    on<UploadRating>(_uploadRating);
  }

  void _getRatings(GetRatings event, Emitter<RatingState> emit) async {
    emit(RatingLoadingstate());
    try {
      if (ratings.isEmpty) {
        ratings = await Database.getRatings();
      }
      emit(RatingSuccessState(ratings));
    } catch (error) {
      print("Ratings BloC: $error");
      emit(RatingFailureState());
    }
  }

  void _uploadRating(UploadRating event, Emitter<RatingState> emit) async {
    emit(RatingLoadingstate());
    try {
      await Database.updateRatings(event.ratings);
      // _getRatings(GetRatings(), emit);
    } catch (error) {
      print("Ratings BloC: $error");
      emit(RatingFailureState());
    }
  }
}
