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
        }
        th{
            background-color: beige;
        }
        input{
            width: 350px;
        }


    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <table id="board">
            <tr>
                <th>제목</th>
                <td>{{info.title}}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>{{info.userid}}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>{{info.cnt}}</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>{{info.cdate}}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <img v-for="item in fileList" :src="item.filePath">
                    {{info.contents}}
                </td>
            </tr>
         </table>
         <hr>
         <table id="comment">
            <tr v-for="item in commentList">
                <th>{{item.nickName}}</th>
                <td>{{item.contents}}</td>
                <td><button>삭제</button></td>
                <td><button>수정</button></td>
            </tr>   
        </table>
        <hr>
        <table id="input">
            <th>댓글 입력</th>
            <td>
                <textarea v-model="contents" cols="40" rows="4"></textarea>
            </td>
            <td><button @click="fnAddComment">저장</button></td>
        </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardno : "${boardno}",
                info : {},
                commentList : [],
                sessionId : "${sessionId}",
                contents : "",
                fileList : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo : function () {
                let self = this;
                let param = {
                    boardno : self.boardno
                };
                $.ajax({
                    url: "board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        self.commentList = data.commentList;
                        self.fileList = data.fileList;
                    }
                });
            },
            fnAddComment: function(){
                let self = this;
                let param = {
                    userid : self.sessionId,
                    boardno : self.boardno,
                    contents : self.contents
                };
                $.ajax({
                    url: "board-addCom.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);
                        // if(data.result == "success"){
                        //     alert("댓글이 등록되었습니다.");
                        // } else {
                        //     alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                        // }
                        self.fnInfo();
                        self.contents = "";
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>