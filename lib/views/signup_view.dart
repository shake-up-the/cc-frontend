import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http; // http 패키지 임포트
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isTermsAgreed = false;
  bool isPrivacyAgreed = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController =
      TextEditingController(); // 인증 코드를 입력받기 위한 컨트롤러

  // 이메일로 인증 코드를 보내는 메서드
  Future<void> sendEmailCode(String email) async {
    var response = await http.post(
      Uri.parse(
          'https://j9wiqq9lxe.execute-api.ap-northeast-2.amazonaws.com/v1/api/members/send-email-code?type=SIGNUP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // 요청이 성공적으로 처리되었습니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("인증 코드가 이메일로 전송되었습니다.")),
      );
    } else {
      // 요청 처리 실패
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이메일 전송 실패")),
      );
    }
  }

  // 사용자가 입력한 코드를 검증하는 메서드
  Future<void> checkEmailCode(String email, String code) async {
    var response = await http.post(
      Uri.parse(
          'https://j9wiqq9lxe.execute-api.ap-northeast-2.amazonaws.com/v1/api/members/check-email-code?type=SIGNUP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      // 인증 성공
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이메일 인증 성공")),
      );
    } else {
      // 인증 실패
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이메일 인증 실패")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 기존 코드는 유지하고, 인증번호 받기 버튼과 인증하기 버튼의 onPressed를 수정합니다.
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text("회원가입"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: 383.0,
        margin: EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 기존의 회원가입 필드들...
                // 이름
                Text('이름',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: '여기에 이름을 입력하세요',
                  ),
                ),
                SizedBox(height: 20),

                // 성별
                Text('성별',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderDropdown(
                  name: 'gender',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  items: ['남', '여']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),

                // 생년월일
                Text('생년월일',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderDateTimePicker(
                  name: 'birthdate',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  inputType: InputType.date,
                ),
                SizedBox(height: 20),

                // 전화번호
                Text('전화번호',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name:
                      'phoneNumber', // 이 부분을 'customId'에서 'phoneNumber'로 변경합니다.
                  decoration: InputDecoration(
                    hintText: '여기에 전화번호를 입력하세요', // 사용자가 이해하기 쉬운 힌트 텍스트를 추가합니다.
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  // 전화번호 입력 시 키보드 타입을 숫자로 설정합니다. (선택적)
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),

                // 아이디
                Text('아이디',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'customId',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(height: 20),
                // 이메일
                Text('이메일',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'email',
                        controller: _emailController, // 컨트롤러 추가
                        decoration: InputDecoration(
                          hintText: '이메일 입력',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // 인증번호 받기 액션
                        if (_emailController.text.isNotEmpty) {
                          sendEmailCode(_emailController.text);
                        }
                      },
                      child: Text('인증번호 받기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // 인증 코드 입력 필드 추가
                Text('인증 코드',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'code',
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: '인증 코드 입력',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(height: 20),
                // 비밀번호
                Text('비밀번호',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),

                // 비밀번호 확인
                Text('비밀번호 확인',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'confirmPassword',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),

                // 이용약관 동의
                FormBuilderCheckbox(
                  name: 'isTermsAgreed',
                  initialValue: false,
                  title: Text("이용약관 동의"),
                  onChanged: (bool? value) {
                    setState(() {
                      isTermsAgreed = value!;
                    });
                  },
                ),
                InkWell(
                  child: Text('보기',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  onTap: () {
                    // 이용약관 보기 액션
                  },
                ),
                SizedBox(height: 20),

                // 개인정보 이용,수집 동의
                FormBuilderCheckbox(
                  name: 'isPrivacyAgreed',
                  initialValue: false,
                  title: Text("개인정보 이용,수집 동의"),
                  onChanged: (bool? value) {
                    setState(() {
                      isPrivacyAgreed = value!;
                    });
                  },
                ),
                SizedBox(height: 20),

                // 인증하기 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // 인증하기 액션
                      if (_emailController.text.isNotEmpty &&
                          _codeController.text.isNotEmpty) {
                        checkEmailCode(
                            _emailController.text, _codeController.text);
                      }
                    },
                    child: Text("인증하기"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF83947),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
