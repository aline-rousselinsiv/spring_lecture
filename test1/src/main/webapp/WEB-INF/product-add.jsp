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
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <table>
                <tr >
                    <th>카테고리</th>
                    <td>
                        <select v-model="menuPart">
                            <option :value="item.menuNo" v-for="item in menuList">{{item.menuName}}</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>제품번호</th>
                    <td>
                        <input type="text" v-model="menuNo">
                    </td>
                </tr>
                <tr >
                    <th>음식명</th>
                    <td>
                        <input type="text" v-model="foodName">
                    </td>
                </tr>
                <tr >
                    <th>음식 설명</th>
                    <td>
                        <textarea v-model="foodInfo" cols="25" rows="5"></textarea>
                    </td>
                </tr>
                <tr >
                    <th>가격</th>
                    <td>
                        <input type="text" v-model="price">
                    </td>
                </tr>
                <tr >
                    <th>이미지</th>
                    <td>
                        <input type="file" id="file1" name="file1" accept=".jpg, .png">
                    </td>
                </tr>
            </table>
         </div>
         <div>
            <button @click="fnAddProduct">제품 등록</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                menuList : [],
                foodName: "",
                foodInfo : "",
                price : "",
                menuPart : "10",
                menuNo : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnMenuList: function() {
                var self = this;
                var param = {
                    depth : 1
                };
                $.ajax({
                    url: "/product/menu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.menuList = data.menuList;
                    }
                });
            },
            fnAddProduct: function(){
                var self = this;
                var param = {
                    menuPart : self.menuPart,
                    menuNo : self.menuNo,
                    foodName : self.foodName,
                    foodInfo : self.foodInfo,
                    price : self.price
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            console.log(data);
                            var form = new FormData();
                            form.append( "file1",  $("#file1")[0].files[0] );
                            form.append( "foodNo",  data.foodNo); // 임시 pk
                            self.upload(form); 

                            alert("제품 등록 되었습니다!");
                            location.href="/product.do";
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/product/fileUpload.dox" // need to change the address
                    , type : "POST"
                    , processData : false
                    , contentType : false
                    , data : form
                    , success:function(response) { 
                        console.log(data);
                    }	           
                });
            }
        },
        mounted() {
            var self = this;
            self.fnMenuList();
        }
    });
    app.mount('#app');
</script>