abstract class DetailsState {}

class DetailsEmptyState extends DetailsState {}

class DetailsCheckingLinkState extends DetailsState {}

class DetailsCheckedLinkState extends DetailsState {
  String url;

  DetailsCheckedLinkState({required this.url});
}

class CheckedLinkErrorState extends DetailsState {}
