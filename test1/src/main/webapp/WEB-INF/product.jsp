<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <script src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="/css/product-style.css">
    <style>
        a {
            text-decoration: none;
        }
    </style>
</head>

<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고">
            </div>
            <nav>
                <ul>
                    <li class="dropdown" v-for="item in menuList" >
                        <a v-if="item.depth == 1" href="#" @click="fnProductList(item.menuNo, '')">{{item.menuName}}</a>
                        <ul class="dropdown-menu" v-if="item.cnt > 0">
                            <span v-for="subItem in menuList">
                                <li>
                                    <a @click="fnProductList('', subItem.menuNo)" v-if="item.menuNo == subItem.menuPart " href="#">{{subItem.menuName}}</a>
                                </li>
                            </span>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="search-bar">
                <input @keyup.enter="fnProductList('', '')" v-model="searchWord" type="text" placeholder="상품을 검색하세요...">
                <button @click="fnProductList('', '')">검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <main>
            
            <section class="product-list">
                <!-- 제품 항목 -->
                    <div class="product-item" v-for="item in productList">
                        <a @click="fnView(item.foodNo)" href="javascript:;">
                            <img :src="item.filePath">
                            <h3>{{item.foodName}}</h3>
                            <p>{{item.foodInfo}}</p>
                            <p class="price">₩{{item.price.toLocaleString()}}</p>
                        </a>
                    </div>
            </section>
            <div id="google_translate_element"></div>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                productList : [],
                searchWord : "",
                menuList : []

            };
        },
        methods: {
            fnProductList: function(menuPart, menuNo) {
                var self = this;
                var nparmap = {
                    searchWord : self.searchWord,
                    menuPart : menuPart,
                    menuNo : menuNo
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.productList = data.list;
                        self.menuList = data.menuList;
                    }
                });
            },
            fnView: function(foodNo){
                pageChange("product/view.do", {foodNo : foodNo});
            }
        },
        mounted() {
            var self = this;
            self.fnProductList('','');
            new google.translate.TranslateElement({pageLanguage: 'ko',autoDisplay: false}, 'google_translate_element');
        }
    });
    app.mount('#app');
</script>