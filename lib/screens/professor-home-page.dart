import 'package:attendo/models/user.dart';
import 'package:attendo/screens/add-course-dialogbox.dart';
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:attendo/screens/professor-course-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../models/database.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/professor-take-attendance.dart';
class ShowCoursesProfessor extends StatefulWidget {
  String uid;
  userinfo user;
  String email;
  ShowCoursesProfessor(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  @override
  _ShowCoursesProfessorState createState() => _ShowCoursesProfessorState(uid,user,email);
}

class _ShowCoursesProfessorState extends State<ShowCoursesProfessor> with SingleTickerProviderStateMixin {
  String uid;
  userinfo user;
  String email;
  _ShowCoursesProfessorState(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 1, vsync: this , initialIndex: 0);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        toolbarHeight: 100,
        title: Text("Your Courses"),
      ),
      drawer: account_drawer(
        Name: user.getname()+", " + user.getenrollno(),
        Email: email,
        ImageURL: "https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
      ),

      body:  TabBarView(
        controller: controller,
        children: <Widget>[
          ShowCardsProfessor(uid,user,email),
        ],
      ),
    );
  }
}



class ShowCardsProfessor extends StatefulWidget {
  String uid;
  userinfo user;
  String email;
  ShowCardsProfessor(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  @override
  _ShowCardsProfessor createState() => _ShowCardsProfessor(uid,user,email);
}

class _ShowCardsProfessor extends State<ShowCardsProfessor> {
  String uid;
  userinfo user;
  String email;
  _ShowCardsProfessor(String temp,userinfo info,String email) {
    uid = temp;
    user = info;
    this.email = email;
  }
  DatabaseService Service =new DatabaseService();
  List<String> CourseName = [
    //'Object Oriented Design and Analysis' ,'Data Structures and Laboratory' , 'Computer Architecture' , 'Signals and Systems' , 'ThermoDynamics' , 'Economics'
  ];
  List<String> ImageURL = [
    /*"https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://avatars3.githubusercontent.com/u/54415525?s=460&u=872ad4fbf1197a4b7ccce5ab7f6a8bca52667b3c&v=4",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300",
    "https://picsum.photos/id/237/200/300"*/
  ];
  var ImageRepo = [
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img1.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img2.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img3.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img4.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img5.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img6.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img7.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img8.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img9.png",
    "https://raw.githubusercontent.com/Attendo-App/CourseImages/master/course-img10.png",
  ];
  List<String> ClassProfessor = [
    //'CSN-261', 'CSN-291' , 'CSN-221' , 'ECN-203' , 'MIN-106' , 'HSN-002'
  ];
  void getcourses(String profname) async{
    List<String> courseName_temp=[],imageurl_temp=[],classprof_temp=[];
    var result=[];
    result=await Service.getProfessorCourses(profname);
    print(result);
    for(int i=0;i<result.length;i++)
    {
      courseName_temp.add(result[i].get("Course_Name"));
      classprof_temp.add(result[i].get("Course_Code"));
      String courseCodeTemp = result[i].get("Course_Code");
      int x = int.parse(courseCodeTemp[courseCodeTemp.length-1] + courseCodeTemp[courseCodeTemp.length-2]);
      x = x % ImageRepo.length;
      imageurl_temp.add(ImageRepo[x]);
      print('done');
    }
    setState(() {
      print('setting state');
      CourseName=courseName_temp;
      print('set course name');
      ImageURL=imageurl_temp;
      print('set image url');
      ClassProfessor=classprof_temp;
      print('set state');
    });
  }
  @override
  Widget build(BuildContext context) {
    bool TappedYes = false;
    final course_name_controller = TextEditingController();
    final course_code_controller = TextEditingController();
    final course_image_controller = TextEditingController();
    if(CourseName.length==0) {
      getcourses(user.getname());
    }
    return Scaffold(
      backgroundColor:PrimaryColor,
      body :
      ListView.builder(
        itemCount: CourseName.length,
        itemBuilder: (BuildContext context, int index) =>
            SingleChildScrollView(
              child: Container (
                width : MediaQuery.of(context).size.width,
                padding : EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5.0),
                child: Card(
                  elevation : 5.0,
                  shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)
                  ),
                  child : Container (
                    width : MediaQuery.of(context).size.width,
                    padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical : 10.0),
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder : (context) => ProfCourseScreen(ClassProfessor[index],uid,user,email)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width : 60,
                                height: 70,
                                // color : LightColor,
                                child : CircleAvatar (
                                  backgroundColor: PrimaryColor,
                                  foregroundColor: LightColor,
                                  backgroundImage: NetworkImage(ImageURL[index]),
                                ),
                              ),
                              SizedBox(width : 10),
                              Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Text(ClassStudent[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  // Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),
                                  Text(ClassProfessor[index], style : TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                                  //Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold,  )),

                                  Text(CourseName[index], style : TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold), textAlign: TextAlign.end ,),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final action =  await DialogProfessor.addCourseDialog(context, 'Add Course', course_name_controller, course_code_controller, course_image_controller);
          if(action == DialogAction.add)
          {
            if(course_image_controller.text == "")
            {
              course_image_controller.text = "https://picsum.photos/id/237/200/300";
            }
            print("Course Name = " + course_name_controller.text + " Course code = " + course_code_controller.text + " Course image = " + course_image_controller.text);
          }
          course_image_controller.text = "";
          course_code_controller.text = "";
          course_name_controller.text = "";
        },
        backgroundColor: PrimaryColor,
        child: Icon(Icons.add,),
      ),
    );
  }
}










