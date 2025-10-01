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
            <select v-model="si">
                <option value="">:: 전체 ::</option>
                <option :value="item.si" v-for="item in siList">:: {{item.si}} ::</option>
            </select>
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
                index : 0, // 178 pages >> 178 / 10
                pageSize : 20,
                siList : [],
                si : "" //  선택한 시(오)의 값
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize,
                    si : self.si
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
                        self.fnList();
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
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>