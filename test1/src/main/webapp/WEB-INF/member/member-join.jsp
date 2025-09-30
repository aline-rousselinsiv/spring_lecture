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
        .phone {
            width: 40px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <label>아이디 : 
                <input v-if="!checkFlg" v-model="id" type="text" id="id">
                <input v-else type="text" disabled :placeholder="id">
            </label>
            <button @click="fnIdCheck">중복체크</button>
        </div>
        <div>
            <label>비밀번호 : <input v-model="pwd" type="password" id="pwd"></label>
        </div>
        <div>
            <label>비밀번호 확인 : <input v-model="pwd2" type="password" id="pwd2"></label>
        </div>
        <div>
            이름 : <input type="text" v-model="name" id="name">
        </div>
        <div>
            주소 : <input v-model="addr" id="addr" disabled> <button @click="fnAddr">주소검색</button>
        </div>
        <div>
            핸드폰 번호 : 
            <input class="phone" v-model="phone1"> -
            <input class="phone" v-model="phone2"> -
            <input class="phone" v-model="phone3">
        </div>
        <div v-if="!joinFlg">
            문자인증 : <input v-model="inputNum" type="text" :placeholder="timer" id="auth">
            <template v-if="!smsFlg">
                <button @click="fnSms">인증번호 전송</button>
            </template> 
            <template v-else>
                <button @click="fnSmsAuth">인증</button>
            </template>
        </div>
        <div v-else style="color : red">
            문자인증이 완료되었습니다.
        </div>
        <div>
            성별 :
            <label for=""><input type="radio" v-model="gender" value="M">남자</label>
            <label for=""><input type="radio" v-model="gender" value="F">여자</label>
        </div>
        <div>
            가입 권한 : 
            <select v-model="status">
                <option value="A">관리자</option>
                <option value="S">판매자</option>
                <option value="C">소비자</option>
            </select>
        </div>
        <div>
            <button @click="fnJoin">회원가입</button>
        </div>
    </div>
</body>
</html>

<script>
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log(roadFullAddr);
            console.log(addrDetail);
            console.log(zipNo);
            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        }
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                id : "",
                pwd : "",
                addr : "",
                pwd2 : "",
                name : "",
                phone1 : "",
                phone2 : "",
                phone3: "",
                gender: "M",
                status: "A",

                checkFlg : false, //  중복체크 여부
                inputNum : "",
                smsFlg : false,
                timer : "",
                count : 180,
                joinFlg : false, // 문자 인증 유무
                ranStr : "" // 문자 인증 번호 
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;
                let param = {
                    id : self.id
                };
                $.ajax({
                    url: "/member/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "true"){
                            alert("사용된 아이디 입니다.");
                            document.querySelector("#id").focus();
                        } else {
                            alert("사용가능한 아이다 입니다.");
                            self.checkFlg = true;
                        }
                    }
                });
            },
            fnAddr: function(){
                window.open("/addr.do", "addr", "width=500, height = 500");
            },
            fnResult: function(roadFullAddr, addrDetail, zipNo){
                let self = this;
                self.addr = roadFullAddr;
            },
            fnSms: function(){
                let self= this;
                let param = {
                };
                $.ajax({
                    url: "/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.res.statusCode == "2000"){
                            alert("문자 전송 완료");
                            self.ranStr = data.ranStr;
                            self.smsFlg = true;
                            self.fnTimer();
                        } else {
                            alert("잠시 후 다시 시도해주세요.");
                        }
                    }
                });
            },
            fnTimer: function(){
                let self = this;
                let interval = setInterval(function(){
                    if(self.count == 0){
                        clearInterval(interval);
                        alert("시간이  만료되었습니다!");
                    } else {
                        let min = parseInt(self.count / 60);
                        let sec = self.count % 60;
                    
                        min = min < 10 ? "0" + min : min;
                        sec = sec < 10 ? "0" + sec : sec;
                        self.timer = min + " : " + sec;

                        self.count--;
                    }
                }, 1000);
            },
            fnJoin: function(){
                let self = this;
                let speChar = /[!@#$%^&*(),.?":{}|<>]/;
                if(!self.checkFlg){
                    alert("아이디 중복체크 후 시도해주세요.");
                    return;
                }
                if(self.id.length < 5){
                    alert("아이디는 5글자로 입력해주세요.");
                    document.querySelector("#id").focus();
                    return;
                    
                }
                if(self.pwd.length < 6){
                    alert("비밀먼호는 6글자로 입력해주세요.");
                    document.querySelector("#pwd").focus();
                    return;
                }
                if(!speChar.test(self.pwd)){
                    alert("비밀번호에는 최소한 하나의 특수 문자가 포함되어야 합니다.");
                    return;
                }
                if(self.pwd != self.pwd2){
                    alert("비밀번호를 다시 확인해주세요.");
                    document.querySelector("#pwd2").focus();
                    return;
                }

                if(self.name == ""){
                    alert("이름을 입력해주세요.");
                    document.querySelector("#name").focus();
                    return;
                }
                if(self.addr.length == 0){
                    alert("주소를 입력해주세요.");
                    return;
                }
                if(self.phone1.length == "" || self.phone2.length == "" || self.phone3.length == ""){
                    alert("전화 번호를 입력해주세요.");
                    return;
                }
                // 문자 인증이 완료되지 않으면
                // 회원가입 불기능 (안내문구 출력)
                if(!self.joinFlg){
                    alert("문자 인증을 진행해주세요.");
                    document.querySelector("#auth").focus();
                    return;
                }
                let param = {
                    id : self.id,
                    pwd : self.pwd,
                    name : self.name,
                    addr : self.addr,
                    phone : self.phone1+"-"+self.phone2+"-"+self.phone3,
                    gender : self.gender,
                    status : self.status
                };
                $.ajax({
                    url: "/member/join.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("가입되었습니다.");
                        location.href="/member/login.do";
                    }
                        
                }); 

            },
            fnSmsAuth: function(){
                let self = this;
                if(self.ranStr == self.inputNum){
                    alert("문자 인증 완료되았습니다");
                    self.joinFlg = true;
                } else {
                    alert("문자인증 실패했습니다.");
                }
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>