import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:job/Network/authenticating_client.dart';
import 'package:job/Network/constants.dart';

import '../Model/job.dart';

class JobRepository {
  JobRepository(this.client);

  final AuthenticatingClient client;

  Future<List<Job>> getJobs() async {
    const url = "$baseUrl/api/v1/listing/fetch";
    final uri = Uri.parse(url);
    final response = await client.get(uri);
    return compute(_parseJobs, response.body);
  }

  static List<Job> _parseJobs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Job>((json) => Job.fromJson(json)).toList();
  }
}