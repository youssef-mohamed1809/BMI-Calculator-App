import 'package:flutter/material.dart';

TextEditingController height_controller = TextEditingController();
TextEditingController weight_controller = TextEditingController();
List myList = ["Gender", "Male", "Female"];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF)
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {

  String height_input = "0";
  String weight_input = "0";
  int height = 0;
  int weight = 0;
  String gender = "Gender";
  String output_message = "The Select Gender Result\nBMI Calculated = 0.0\nCurrent Status = ";
  String default_message = "The Select Gender Result\nBMI Calculated = 0.0\nCurrent Status = ";
  String man_path = "Assests/man.png";
  String woman_path = "Assests/woman.png";
  String question_path = "Assests/question.png";
  String current_image = "Assests/question.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        backgroundColor: Color(0xFFC4A484),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Height"),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      // keyboardType: TextInputType.number,
                      onChanged: (var x){
                        this.height_input = x;
                      },
                      controller: height_controller,
                      decoration: InputDecoration(
                        hintText: "Enter your height (cm)",
                        border: OutlineInputBorder(),
        
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Weight"),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (var x){
                        this.weight_input = x;
                      },
                      controller: weight_controller,
                      decoration: InputDecoration(
                          hintText: "Enter your weight (kg)",
                          border: OutlineInputBorder()
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    value: gender,
                      items: myList.map((var x){
                        return DropdownMenuItem(value: x, child: Text(x));
                      }).toList(),
                      onChanged: (var x){
                          setState(() {
                            gender = x as String;
                            if(gender == "Male"){
                              current_image = man_path;
                            }else if(gender == "Female"){
                              current_image = woman_path;
                            }else{
                              current_image = question_path;
                            }
                          });
                      }),
                  CircleAvatar(radius: 100,backgroundImage:  AssetImage(current_image),)
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (){
                        try{
                          height = int.parse(height_input);
                        }catch(e){
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please enter a valid height"))
                              );
                            });
                            return;
                        }
                        print("HI");
                        try{
                          weight = int.parse(weight_input);
                        }catch(e){
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please enter a valid weight"))
                            );
                            return;
                          });
                        }

                        if(gender == "Gender"){
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please choose a gender"))
                            );
                          });
                        }else{
                          setState(() {
                            double bmi = weight / (height * height);
                            String status = "Normal";
                            if(bmi < 18.5){
                              status = "Underweight";
                            }else if(bmi > 24.9){
                              status = "Overweight";
                            }
                            String temp = bmi.toString();
                            temp = bmi.toStringAsFixed(2);
                            bmi = double.parse(temp);
                            output_message = "The $gender result\nBMI calculated = $bmi\nCurrent Status = $status";
                          });
                        }


                      },
                      icon: Icon(Icons.calculate)),
                  IconButton(onPressed: (){
                    setState(() {
                      weight_controller.clear();
                      height_controller.clear();
                      gender = "Gender";
                      current_image = question_path;
                      output_message = default_message;
                    });
                  }, icon: Icon(Icons.refresh)),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                height: 200,
                width: 200,
                child: Text(output_message, textAlign: TextAlign.center,)
              )
            ],
          ),
        ),
      )
    );
  }
}

