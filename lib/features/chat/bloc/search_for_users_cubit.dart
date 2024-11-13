import 'package:convergeimmob/features/chat/bloc/search_state.dart';
import 'package:convergeimmob/features/chat/data/models/user_model.dart';
import 'package:convergeimmob/features/chat/data/repositories/search_for_users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForUsersCubit extends Cubit<SearchState>{
   SearchForUsersRepository searchForUsersRepository = SearchForUsersRepository() ;
   List<UserModel> foundedUsers = [];

  SearchForUsersCubit():super(SearchInitial());

  Future<void> getFoundedUsers(String query , String sourceId) async {
    emit(SearchLoading()) ;
    try{
      foundedUsers = await searchForUsersRepository.fetchUsers(query , sourceId);
      emit(SearchComplet());
    }
    catch(e){
      print(" error in searching //////////////////////////////////////// $e");
      emit(SearchError(message: "Something went wrong while searching"));
    }
  }
}