import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_model.dart';
import 'sample_random_data_gen.dart';

/// **EVENTS**
abstract class PostFeedEvent {}

class LoadMorePosts extends PostFeedEvent {}

/// **STATE**
class PostFeedState {
  final List<PostEvent> posts;
  final bool isLoadingMore;

  PostFeedState({required this.posts, this.isLoadingMore = false});
}

/// **BLoC**
class PostFeedBloc extends Bloc<PostFeedEvent, PostFeedState> {
  PostFeedBloc() : super(PostFeedState(posts: [])) {
    on<LoadMorePosts>((event, emit) {
      if (state.isLoadingMore) return; // Prevent duplicate loading

      final newPosts = List<PostEvent>.from(state.posts);
      for (int i = 0; i < 10; i++) {
        newPosts.add(SampleDataGenerator.generateRandomPost());
      }

      emit(PostFeedState(posts: newPosts, isLoadingMore: false));
    });
  }
}
