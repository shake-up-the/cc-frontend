import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isTermsAgreed = false;
  bool isPrivacyAgreed = false;

  @override
  Widget build(BuildContext context) {
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
        width: 383.0, // 전체 컨테이너의 너비 설정
        margin: EdgeInsets.all(20.0), // 모든 방향으로 마진 추가
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                        decoration: InputDecoration(
                          hintText: '이메일 입력',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // 입력 필드와 버튼 사이의 간격
                    ElevatedButton(
                      onPressed: () {
                        // 인증번호 받기 액션
                      },
                      child: Text('인증번호 받기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // 버튼 배경색
                        foregroundColor: Colors.white, // 버튼의 텍스트 색상
                        textStyle: TextStyle(fontSize: 12), // 버튼 텍스트 스타일
                      ),
                    ),
                  ],
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
