<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
        #comment{
            color: red;
        }
        #index {
            text-decoration: none;
            color: black;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <select v-model="searchOption">
                <option value="all">:: 전체 :: </option>
                <option value="title">:: 제목 :: </option>
                <option value="id">:: 작성자 :: </option>
            </select>
            <input v-model="keyword">
            <button @click="fnList">검색</button>
         </div>
        <div>

            <select v-model="pageSize" @change="fnList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="20">20개씩</option>
            </select>

            <select v-model="kind" @change="fnList">
                <option value="">:: 전체 ::</option>
                <option value="1">:: 공지사항 ::</option>
                <option value="2">:: 자유게시판 ::</option>
                <option value="3">:: 문의게시판 ::</option>
            </select>

            <select v-model="sort" @change="fnList">
                <option value="1">:: 번호순 ::</option>
                <option value="2">:: 제목순 ::</option>
                <option value="3">:: 조회순 ::</option>
                <option value="4">:: 시간순 ::</option>
            </select>

        </div>
        <div>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                        
                    </th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardno}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.boardno)">{{item.title}}</a>
                        <span id="comment" v-if="item.commentCnt != 0"> [{{item.commentCnt}}]</span>
                    </td>
                    <td>{{item.userid}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cdate}}</td>
                    <td>
                        <button v-if="sessionId == item.userid || sessionStatus == 'A'" @click="fnDelete(item.boardno)">삭제</button>
                    </td>
                </tr>
            </table>
            <div>
                <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                    <span v-if="num == page" style="font-weight: bold;">{{num}}</span>
                    <span v-else>{{num}}</span>
                </a>
            </div>
        </div>
        <div>
            <a href="board-add.do"><button>글쓰기</button></a>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                kind : "",
                sort : "1",
                sessionId : "${sessionId}",
                sessionName : "${sessionName}",
                sessionStatus : "${sessionStatus}",
                keyword : "",
                searchOption : "all",
                pageSize : 5, //  한페이지에 출력할 개수
                page : 1,
                index : 0 // 최대 페이지 값
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    sort : self.sort,
                    keyword : self.keyword,
                    searchOption : self.searchOption,

                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize
                };
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                        console.log(data);

                    }
                });
            },
            fnDelete: function(boardno) {
                let self = this;
                let param = {
                    boardno : boardno
                };
                if(!confirm("정말 삭제하겠습니까?")){
                    return;
                }
                $.ajax({
                    url: "board-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다!");
                        self.fnList();
                    }
                });
            },
            fnView: function(boardno){
                pageChange("board-view.do", {boardno : boardno});

            },
            fnPage : function(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>