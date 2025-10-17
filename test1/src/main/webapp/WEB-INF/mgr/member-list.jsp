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
                <option value="15">15개씩</option>
            </select> 
         </div>
         <div>
            검색어 : 
            <input type="text" placeholder="검색어를 입력해주세요." v-model="keyword" @keyup.enter="fnList">
            <button @click="fnList">검색</button>
         </div>
        <div>
            <table>
                <tr>
                    <th>선택</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>닉네임</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>해제</th>
                </tr>
                <tr v-for="item in list">
                    <td>
                        <input type="radio" :value="item.userId" v-model="selectId">
                    </td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.userId)">{{item.userId}}</a>
                    </td>
                    <td>{{item.name}}</td>
                    <td>{{item.nickName}}</td>
                    <td>{{item.cBirth}}</td>
                    <td>{{item.gender}}</td>
                    <td>
                        <button @click="fnRemoveCnt(item.userId)" v-if="item.cnt >= 5">정지해제</button>
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
                selectId : "",
                page : 1,
                pageSize : 5,
                index : 0,
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
                    keyword : self.keyword
                };
                $.ajax({
                    url: "/mgr/member/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data.list);
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                    }
                });
            },
            fnRemoveCnt : function(userId){
                let self = this;
                let param = {
                    id : userId
                };
                $.ajax({
                    url: "/mgr/remove-cnt.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("계정 정지가 해제되었습니다!");
                            self.fnList();
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            fnView : function(userId){
                // /mgr/member/view.do 로 이동
                pageChange("/mgr/member/view.do", {userId : userId});
            },
            fnDelete: function(){
                let self = this;
                let param = {
                    selectId : self.selectId
                };
                console.log(self.selectId);
                $.ajax({
                    url: "/mgr/member/delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("삭제되었습니다.");
                            self.selectId = "";
                            self.page = 1;
                            self.fnList();
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
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