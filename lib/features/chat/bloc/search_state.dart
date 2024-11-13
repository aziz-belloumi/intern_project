abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchComplet extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message ;
  SearchError({required this.message});
}