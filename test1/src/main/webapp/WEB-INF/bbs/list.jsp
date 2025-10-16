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
        a{
            text-decoration: none;
            text-decoration: underline;
            color: black;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <select v-model="pageSize" @change="fnList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="20">20개씩</option>
            </select>
         </div>
         <div>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조화수</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.bbsNum}}</td>
                    <td>
                        <a @click="fnView(item.bbsNum)" href="javascript:;">{{item.title}}</a>
                    </td>
                    <td>{{item.userid}}</td>
                    <td v-if="item.hit > 25" style="color: red; font-weight: bold;">{{item.hit}}</td>
                    <td v-else>{{item.hit}}</td>
                    <td>
                        <button @click="fnDelete(item.bbsNum)">삭제</button>
                    </td>
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
                pageSize : 5,
                page : 1,
                index : 0
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize
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
            fnDelete: function(bbsNum){
                let self = this;
                let param = {
                    bbsNum : bbsNum
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
                            location.href="/bbs/list.do";
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