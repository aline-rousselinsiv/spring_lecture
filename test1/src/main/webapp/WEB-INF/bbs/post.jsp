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
        th{
            width:150px;
        }
        td {
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
                    <th>제목</th>
                    <td>
                        <input v-model="title" type="text">
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>{{sessionId}}</td>
                </tr>
                <tr>
                    <th>파일첨부</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td> 
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea v-model="contents" cols="30" rows="10"></textarea>
                    </td>
                </tr>
            </table>
         </div>
         <div>
            <button @click="fnSavePost">등록</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                sessionId : "${sessionId}",
                title : self.title,
                contents : self.contents
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnSavePost: function () {
                let self = this;
                let param = {
                    title : self.title,
                    contents : self.contents,
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/bbs/save.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            // var form = new FormData();
                            // form.append( "file1",  $("#file1")[0].files[0] );
                            // form.append( "bbsNum",  data.bbsNum); // 임시 pk
                            // self.upload(form); 
                            alert("등록되었습니다!");
                            location.href="/bbs/list.do";
                        } else {
                            alert("오류가 발생했습니다.");
                        }

                    }
                });
            },
            // upload : function(form){
            //     var self = this;
            //     $.ajax({
            //         url : "/picUpload.dox"
            //         , type : "POST"
            //         , processData : false
            //         , contentType : false
            //         , data : form
            //         , success:function(response) { 
            //             console.log(response);
            //         }	           
            //     });
            // }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>