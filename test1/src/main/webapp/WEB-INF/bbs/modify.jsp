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
        td{
            width: 300px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <table>
                <tr>
                    <th>작성자</th>
                    <td>{{info.userid}}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type="text" v-model="info.title"></td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>{{info.hit}}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea cols="30" rows="10" v-model="info.contents"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>{{info.cDateTime}}</td>
                </tr>
            </table>
         </div>
         <div>
            <button @click="fnSave">저장</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                bbsNum : "${bbsNum}",
                info : {
                    userid: "",
                    title: "",
                    hit: 0,
                    contents: "",
                    cDateTime: ""
                }

            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnBbsInfo: function () {
                let self = this;
                let param = {
                    bbsNum : self.bbsNum
                };
                $.ajax({
                    url: "/bbs/postDetails.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        if(data.result == "fail"){
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnSave: function(){
                let self = this;
                let param = {
                    bbsNum: self.bbsNum,
                    title: self.info.title,
                    contents: self.info.contents,
                    userid: self.info.userid
                    };
                $.ajax({
                    url: "/bbs/modify.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("저장되었습니다!");
                            location.href="/bbs/list.do"
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBbsInfo();
        }
    });

    app.mount('#app');
</script>