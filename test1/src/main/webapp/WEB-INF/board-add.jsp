<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 10px 20px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        td {
            width: 450px;
        }
        #editor {
            width: 450px;
            height: 350px;
        }
        #textarea {
            height: 400px;
        }
        input {
            width: 250px;
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
                        <input type="text" v-model="title">
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>
                        {{userid}}
                    </td>
                </tr>
                <tr>
                    <th>파일첨부</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td> 
                    <!-- multiple >> can add nultiple files -->
                    <!-- accept >> type of files accepted -->
                </tr>
                <tr>
                    <th>내용</th>
                    <td id="textarea">
                        <div id="editor"></div>
                    </td>
                </tr>
            </table>
            <button @click="fnAdd">등록</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                title : "",
                userid : "${sessionId}",
                contents : "",
                sessionId : "${sessionId}"
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function(){
                let self = this;

                let param = {
                    title : self.title,
                    userid : self.userid,
                    contents : self.contents
                }
                $.ajax({
                    url: "board-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("등록되었습니다!");
                        console.log(data.boardNo);
                        var form = new FormData();
                        form.append( "file1",  $("#file1")[0].files[0] );
                        form.append( "boardNo",  data.boardNo); // 임시 pk
                        self.upload(form); 
                        location.href="board-list.do";
                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/fileUpload.dox"
                    , type : "POST"
                    , processData : false
                    , contentType : false
                    , data : form
                    , success:function(response) { 
                        console.log(data);
                    }	           
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            if(self.sessionId == ""){
                alert("로그인 후 이용해주세요.");
            }
            var quill = new Quill('#editor', {
            theme: 'snow',
            modules: {
                toolbar: [
                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                    ['bold', 'italic', 'underline'],
                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                    ['link', 'image'],
                    ['clean']
                ]
            }
        });

        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
        quill.on('text-change', function() {
            self.contents = quill.root.innerHTML;
        });
        }
    });

    app.mount('#app');
</script>