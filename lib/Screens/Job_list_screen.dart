import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/Bloc/JobListBloc.dart';
import 'package:job/Model/Job_details.dart';
import 'package:job/Network/authenticating_client.dart';
import 'package:job/Repository/JobRepository.dart';
import 'package:job/Screens/Login_screen.dart';

import '../Widgets/Job_cards.dart';

class JobList extends StatefulWidget {
  static const routeName = "/job_list";
  final JobListArguments arguments;
  JobList(this.arguments, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JobListState();
  }
}

class JobListState extends State<JobList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xffDD5D00)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.arguments.client.username,
                        style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xffFD9601)),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
                    },
                    icon: const Icon(Icons.logout),
                    iconSize: 35,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: JobDetailsInfo().listOfJobs.length,
                itemBuilder: (context, index) {
                  String job_name = JobDetailsInfo().listOfJobs[index].job_name;
                  String company_name =
                      JobDetailsInfo().listOfJobs[index].company_name;
                  String requirements =
                      JobDetailsInfo().listOfJobs[index].requirements;
                  return JobCards(
                      job_name: job_name,
                      company_name: company_name,
                      requirements: requirements);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}

class JobListArguments{
  final AuthenticatingClient client;

  JobListArguments(this.client);
}