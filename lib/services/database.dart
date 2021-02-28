import 'package:meta/meta.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/api_path.dart';
import 'package:time_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
}

// date and time to store in to firebase
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  // create or edit the job
  Future<void> setJob(Job job) => _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  // read all jobs
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );
}
