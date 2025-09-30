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
        #board table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
            height: 50px;
        }
        th{
            background-color: beige;
            width: 100px;
        }
        td {
            width: 300px;
        }
        ul {
            list-style-type: none;
        }
        #input table th{
            width: 100px;
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
                <th>작성일</th>
                <td>{{info.cdate}}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>{{info.contents}}</td>
            </tr>
         </table>
         <hr>
         <div>
            <span style="font-weight: bold;">댓글</span>            
            <ul v-for="item in commentList">
                <li>
                    <span style="font-weight: bold;">{{item.nickName}}</span>
                    <div>{{item.contents}}</div>
                    <div>{{item.cdateTime}}</div>
                    <div><button>삭제</button> <button>수정</button></div>
                </li>
                <hr>
            </ul>
            <table id="input">
                <th>입력</th>
                <td>
                    <textarea cols="40" cols="5"></textarea>
                </td>
                <td><button>저장</button></td>
            </table>
         </div>
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
                commentList : []
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