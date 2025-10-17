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
            margin-top: 5px;
            margin-bottom: 5px;
        }
        th{
            background-color: beige;
        }
        a{
            text-decoration: none;
            text-decoration: underline;
            color: black;
        }
        select {
            margin: 2px;
        }
        input {
            margin : 2px;
        }
        #index, .arrow {
            text-decoration: none;
            margin-right: 2px;
            font-size: large;
        }
        button{
            margin-top: 5px;
        }
        .active {
            color: blue;
            font-weight: bold;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <select v-model="pageSize" @change="fnList">
                <option value="3">3개씩</option>
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
            </select>
            <input v-model="keyword" @keyup.enter="fnList">
            <button @click="fnList">검색</button>
         </div>
         <div>
            <select v-model="searchOption">
                <option value="all">:: 전체 :: </option>
                <option value="title">:: 제목 :: </option>
                <option value="id">:: 작성자 :: </option>
            </select>
         </div>
         <div>
            <table>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조화수</th>
                    <!-- <th>삭제</th> -->
                </tr>
                <tr v-for="item in list">
                    <td>
                        <input type="radio" v-model="selectItem" :value="item.bbsNum">
                    </td>
                    <td>{{item.bbsNum}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.bbsNum)">
                            <span v-if="item.hit >= 25" style="color:red;">{{item.title}}</span>
                            <span v-else>{{item.title}}</span>
                        </a>
                    </td>
                    <td>{{item.userid}}</td>
                    <td>{{item.hit}}</td>
                    <!-- <td>
                        <button @click="fnDelete(item.bbsNum)">삭제</button>
                    </td> -->
                </tr>
            </table>
            <div>
                <a class="arrow" v-if="page != 1" @click="fnMove(-1)" href="javascript:;">◀</a>
                <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                    <span :class="{active : num == page}">{{num}}</span>
                    <!-- <span v-if="num == page" style="font-weight: bold;">{{num}}</span>
                    <span v-else>{{num}}</span> -->
                </a>
                <a class="arrow" v-if="page != index" @click="fnMove(+1)" href="javascript:;">▶</a>
            </div>
         </div>
         <div>
            <a href="/bbs/post.do"><button @click="fnAddPost">글쓰기</button></a>
         </div>
         <div>
            <!-- <button @click="fnDeleteAll">삭제</button> -->
            <button @click="fnDelete">삭제</button>
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
                sessionId : "${sessionId}",
                pageSize : 3,
                page : 1,
                index : 0,
                selectItem : "",
                searchOption : "all",
                keyword : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize,
                    searchOption : self.searchOption,
                    keyword : self.keyword
                };
                $.ajax({
                    url: "/bbs/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                    }
                });
            },
            fnAddPost: function(){
                let self = this;
                let param = {};
                $.ajax({
                    url: "",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;

                    }
                });
            },
            fnDelete: function(){
                let self = this;
                let param = {
                    selectItem : self.selectItem
                }
                if(self.selectItem == ""){
                    alert("게시글을 먼저 선택해주세요!");
                    return;
                }
                if(!confirm("정말 삭제하겠습니까?")){
                    return;
                }
                $.ajax({
                    url: "/bbs/delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("삭제되었습니다.");
                            self.selectItem = "";
                            self.page = 1;
                            location.href="/bbs/list.do";
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnDeleteAll: function(){
                let self = this;
                console.log(self.selectItem);

                var fList = JSON.stringify(self.selectItem); // converting our list into a string to send to the server
                var param = {selectItem : fList};
        
                $.ajax({
                    url: "/bbs/deleteList.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("삭제되었습니다.");
                            self.fnList();
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                        
                    }
                });
            },
            fnView: function(bbsNum){
                pageChange("/bbs/view.do", {bbsNum : bbsNum});

            },
            fnPage : function(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
            fnMove: function(num){
                let self = this;
                self.page += num;
                self.fnList();

            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>