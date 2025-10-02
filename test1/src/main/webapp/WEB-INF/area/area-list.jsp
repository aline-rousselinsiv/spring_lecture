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
            width: 150px;
        }
        tr:nth-child(even){
            background-color: azure;
        }
        #index {
            text-decoration: none;
            color: black;
            margin-right: 5px;
        }
        .active{
            color: blue;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            도/특별시 : 
            <select v-model="si" @change="fnGuList">
                <option value="">:: 전체 ::</option>
                <option :value="item.si" v-for="item in siList">:: {{item.si}} ::</option>
            </select>
            구 : 
            <select v-model="gu" @change="fnDongList">
                <option value="">:: 선택 ::</option>
                <option :value="item.gu" v-for="item in guList">{{item.gu}}</option>
            </select>
            동 : 
            <select v-model="dong" >
                <option value="">:: 선택 ::</option>
                <option :value="item.dong" v-for="item in dongList">{{item.dong}}</option>
            </select>
            <label for="">
                <button @click="fnList">검색</button>
            </label>
         </div>
         <div>
            <table>
                <tr>
                    <th>도, 특별시</th>
                    <th>구</th>
                    <th>동</th>
                    <th>NX</th> 
                    <th>NY</th>  
                </tr>
                <tr v-for="item in areaList">
                    <td>{{item.si}}</td>
                    <td>{{item.gu}}</td>
                    <td>{{item.dong}}</td>
                    <td>{{item.nx}}</td>
                    <td>{{item.ny}}</td>
                </tr>
            </table>
         </div>
         <div>
            <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                    <span :class="{active : num == page}">{{num}}</span>
            </a>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                areaList : [],
                page: 1,
                index : 0, 
                pageSize : 20,
                siList : [],
                guList : [],
                dongList : [],
                si : "", //  선택한 시(오)의 값
                gu : "",
                dong : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize,
                    si : self.si,
                    gu : self.gu,
                    dong : self.dong
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.areaList = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                        self.fnGuList();
                        self.fnDongList();
                    }
                });
            },
            fnPage : function(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
            fnSiList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.siList = data.list;

                    }
                });
            },
            fnGuList: function () {
                let self = this;
                let param = {
                    si : self.si
                };
                $.ajax({
                    url: "/area/gu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.gu = "";
                        self.guList = data.guList;
                    }
                });
            },
            fnDongList: function () {
                let self = this;
                let param = {
                    gu : self.gu
                };
                $.ajax({
                    url: "/area/dong.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.dong = "";
                        self.dongList = data.dongList;
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
            self.fnSiList();
            self.fnGuList();
            self.fnDongList();
        }
    });

    app.mount('#app');
</script>