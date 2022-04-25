import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/Model/job.dart';
import 'package:job/Network/authenticating_client.dart';
import 'package:job/Repository/JobRepository.dart';

class JobListBloc extends Bloc<JobListEvent, JobListState> {
  final JobRepository repository;

  JobListBloc(this.repository) : super(InitState()) {
    on<InitEvent>((event, emit) async {
      emit(ReadyState(await repository.getJobs()));
    });
  }

}


abstract class JobListEvent {}

class InitEvent extends JobListEvent {}



abstract class JobListState {}

class InitState extends JobListState {}
class ReadyState extends JobListState {
  final List<Job> jobs;

  ReadyState(this.jobs);
}
