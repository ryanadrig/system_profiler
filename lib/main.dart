import 'package:flutter/material.dart';
import 'dart:io';

var ss = Size(0,0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SI_NS_Home(),
    );
  }
}

class SI_NS_Home extends StatefulWidget {
  const SI_NS_Home({Key? key}) : super(key: key);

  @override
  _SI_NS_HomeState createState() => _SI_NS_HomeState();
}

class _SI_NS_HomeState extends State<SI_NS_Home> {

String sys_name = "error finding system name";
String uptime = "error finding uptime";
String iam_name = "";

  String sys_bins = "error finding binary files";
  bool show_bins= false;

  String printenv = "error getting env";
  bool show_env = false;

  String top = "";
  bool show_top = false;

  String sys_services = "error finding services";
  bool show_services= false;

  String if_conf = "error running ifconf";
  bool show_ifconf = false;

  String sys_mem = "error finding sys mem";
  bool show_sys_mem = false;

  String run_com_input = "";
  bool show_run_com = false;
  bool run_com_enter = false;
  String run_com_out = "";

  @override
  void initState() {

    Process.run('uname',['-a'] ).then((ProcessResult
    rs){
    // {print("uname ns out ~ " + rs.stdout.toString());
    // print("uname ns out ~ " + rs.stderr.toString());
    sys_name = "";
    setState(() {
    sys_name = rs.stdout.toString();
    });
    });

    Process.run('uptime',[], runInShell:false).then((ProcessResult
    rs)
    {
      // print("uptime out ~ " + rs.stdout.toString());
      // print("uptime out ~ " + rs.stderr.toString());
      uptime = "";
      setState(() {
        uptime = rs.stdout.toString();
      });
    });

    Process.run('whoami',[], runInShell:false).then((ProcessResult
    rs)
    {
      // print("uptime out ~ " + rs.stdout.toString());
      // print("uptime out ~ " + rs.stderr.toString());
      iam_name = "";
      setState(() {
        iam_name = rs.stdout.toString();
      });
    });

    Process.run('ls',["/bin"], runInShell:false).then((ProcessResult
        rs){
        // {print("ls home  out ~ " + rs.stdout.toString());
    //   print("ls home err out ~ " + rs.stderr.toString());
      sys_bins = "";
    setState(() {
      sys_bins += rs.stdout;
    });
    });

    Process.run('printenv',[], runInShell:false).then((ProcessResult
    rs){
      // {print("ls home  out ~ " + rs.stdout.toString());
      //   print("ls home err out ~ " + rs.stderr.toString());
      printenv = "";
      setState(() {
        printenv += rs.stdout;
      });
    });

    Process.run('dumpsys',[], runInShell:false).then((ProcessResult
    rs){
    // {print("dumpsys out ~ " + rs.stdout.toString());
    // print("dumpsys err out ~ " + rs.stderr.toString());
    sys_services = "";
    setState(() {
      sys_services += rs.stdout;
    });
    });


    Process.run('free',[], runInShell:false).then((ProcessResult
    rs)
    {
      // print("mem out ~ " + rs.stdout.toString());
    // print("mem err out ~ " + rs.stderr.toString());
    sys_mem = "";
    setState(() {
        sys_mem = rs.stdout.toString();
      });
    });

    Process.run('ifconfig',[], runInShell:false).then((ProcessResult
    rs)
    {
      // print("ifconf out ~ " + rs.stdout.toString());
    // print("ifconf out ~ " + rs.stderr.toString());
    if_conf = "";
    setState(() {
      if_conf = rs.stdout.toString();
    });
    });

    Process.run('top',[], runInShell:false).then((ProcessResult
    rs)
    {
      print("top out ~ " + rs.stdout.toString());
      print("top out ~ " + rs.stderr.toString());
      top = "";
      setState(() {
        top = rs.stdout.toString();
      });
    });


    super.initState();
  }

  run_command(String input){
    print("input ~ " + input);
    List<String> run_com_args = input.split(" ");
    String run_com_com = run_com_args[0];
    print("pre parse args ~ " + run_com_args.toString());
    if (run_com_args.length > 1) {
      run_com_args = run_com_args.sublist(1, run_com_args.length );
    }
    else{
      run_com_args = [];
    }
    print("run com com " + run_com_com);
    print("run com ars " + run_com_args.toString());
    Process.run(run_com_com, run_com_args, runInShell:false).then((ProcessResult
    rs)
    {
      print("com out ~ " + rs.stdout.toString());
      print("com out ~ " + rs.stderr.toString());
      run_com_out = "";
      setState(() {
        run_com_out += rs.stdout.toString() + rs.stderr.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ss = MediaQuery.of(context).size;
    return SafeArea(child:Scaffold(body:
        Container(height:ss.height,
          child: ListView(children: [
            Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom:ss.height * .02),
          child: Container(
              width: ss.width,
              height: ss.height*.08,
              color: Colors.grey[600],
              child:Center(child:Text("System Profile",
              style: TextStyle(color: Colors.white),)))),


              Container(color: Colors.grey[300],
              child:Text("System name :: " + sys_name +
                  " \n Uptime :: " + uptime +
                  " \n User name :: " + iam_name)
              ),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                  child:
                  GestureDetector(
                      onTap:(){
                        setState(() {
                          show_sys_mem = !show_sys_mem;
                        });
                      },
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(ss.width*.04),
                          child:
                          Container(
                              width: ss.width*.88,
                              padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                              color: Colors.blueAccent,
                              child:Center(child:Text("show system memory (free)",
                                style: TextStyle(color: Colors.white),)))))),
              show_sys_mem?Container(child:Text(sys_mem)):Container(),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                  child:
                  GestureDetector(
                      onTap:(){
                        setState(() {
                          show_top = !show_top;
                        });
                      },
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(ss.width*.04),
                          child:
                          Container(
                              width: ss.width*.88,
                              padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                              color: Colors.blueAccent,
                              child:Center(child:Text("show top processes (top)",
                                style: TextStyle(color: Colors.white),)))))),
              show_top?Container(child:Text(top, style: TextStyle(fontSize: 8),)):Container(),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                  child:
                  GestureDetector(
                onTap:(){
                  setState(() {
                    show_bins = !show_bins;
                  });
                },
                  child:
                  ClipRRect(
                      borderRadius: BorderRadius.circular(ss.width*.04),
                      child:
                  Container(
                    width: ss.width*.88,
                      padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                      color: Colors.blueAccent,
              child:Center(child:Text("show available binary files (ls /bin)",
              style: TextStyle(color: Colors.white),)))))),
            show_bins?Container(child:Text(sys_bins)):Container(),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                  child:
                  GestureDetector(
                      onTap:(){
                        setState(() {
                          show_env = !show_env;
                        });
                      },
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(ss.width*.04),
                          child:
                          Container(
                              width: ss.width*.88,
                              padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                              color: Colors.blueAccent,
                              child:Center(child:Text("show environment (printenv)",
                                style: TextStyle(color: Colors.white),)))))),
              show_env?Container(child:Text(printenv)):Container(),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                  child:
                  GestureDetector(
                      onTap:(){
                        setState(() {
                          show_ifconf = !show_ifconf;
                        });
                      },
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(ss.width*.04),
                          child:
                          Container(
                              width: ss.width*.88,
                              padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                              color: Colors.blueAccent,
                              child:Center(child:Text("show network interface config (ifconf)",
                                style: TextStyle(color: Colors.white),)))))),
              show_ifconf?Container(child:Text(if_conf,style: TextStyle(fontSize: 10),)):Container(),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                  child:
                  GestureDetector(
                      onTap:(){
                        setState(() {
                          show_services = !show_services;
                        });
                      },
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(ss.width*.04),
                          child:
                          Container(
                              width: ss.width*.88,
                              padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                              color: Colors.blueAccent,
                              child:Center(child:Text("show system services (sysdump)",
                                style: TextStyle(color: Colors.white),)))))),
              show_services?Container(child:Text(sys_services)):Container(),






            Padding(
                padding: EdgeInsets.symmetric(vertical: ss.width*.02),
                child:
                GestureDetector(
                    onTap:(){
                      setState(() {
                        show_run_com = !show_run_com;
                      });
                    },
                    child:
                    ClipRRect(
                        borderRadius: BorderRadius.circular(ss.width*.04),
                        child:
                        Container(
                            width: ss.width*.88,
                            padding: EdgeInsets.fromLTRB(ss.width*.08, ss.width*.04, ss.width*.08, ss.width*.04),
                            color: Colors.blueAccent,
                            child:Center(child:Text("Run Command",
                              style: TextStyle(color: Colors.white),)))))),
            show_run_com?Container(child:
            Row(children:[
            Container(
                width: ss.width*.8,
                height: ss.height * .1,
                child:
            TextField(
              onChanged: (val){
                setState(() {
                  run_com_input = val;
                });
              },
            )),
            GestureDetector(
              onTap: (){
               run_command(run_com_input);
              },
            child:Container(child:Text("Run")))
            ])):Container(),
              Container(child:Text(run_com_out))

          ]),

          ],)
        )));
  }
}


