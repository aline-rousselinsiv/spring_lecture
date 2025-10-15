<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div v-if="!authFlg">
            <div>
                <label>아이디 : <input type="text" v-model="userId"></label>
            </div>
            <div>
                <label>이름 : <input type="text" v-model="userName"></label>
            </div>
            <div>
                <label>번호 : <input type="text" placeholder="-를 제외하고 입력해주세요." v-model="userNum"></label>
            </div>
            <div>
                <button @click="fnAuth">인증</button>
            </div>
         </div>
        
         <div v-else>
            <div>
                <label for="">비밀번호 : <input type="text" v-model="newPwd1"></label>
            </div>
            <div>
                <label for="">비밀번호 확인 : <input type="text" v-model="newPwd2"></label>
            </div>
            <div>
                <button @click="fnPwdChange">비밀번호 수정</button>
            </div>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                authFlg : false,
                userId : "",
                userName : "",
                userNum : "",
                newPwd1 : "",
                newPwd2 : ""

            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAuth: function () {
                let self = this;
                // console.log("here ==>" + self.userId); 
                // console.log("here ==>" + self.userId.trim());

                // self.authFlg = true;
                let param = {
                    userId : self.userId.trim(), // it is BETTER to trim whatever input the user enters
                    userName : self.userName.trim(),
                    userNum : self.userNum.trim(),
                };
                $.ajax({
                    url: "/member/pwd.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("인증되었습니다!");
                            self.authFlg = true;
                        } else if (data.result == "fail") {
                            self.authFlg = false;
                            alert("회원 정보를 확인해주세요.");
                        }
                    }
                });
            },
            fnPwdChange: function(){
                let self = this;
                if(self.newPwd1 != self.newPwd2){
                    alert("비밀번호를 확인해주세요.");
                    return;
                }
                let param = {
                    id : self.userId,
                    newPwd1 : self.newPwd1,
                    userId : self.userId.trim()
                };
                $.ajax({
                    url: "/member/pwd/change.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result = "success"){
                            alert(data.message);
                        } else if(data.result == "fail") {
                            alert(data.message);
                        }
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            this.userId = sessionStorage.getItem("userId");
        }
    });

    app.mount('#app');
</script>