<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <link rel="stylesheet" href="/css/product-style.css">

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
        button {
            margin-top: 8px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <section class="product-list">
        <!-- 제품 항목 -->
            <div class="product-item">
                <img :src="info.filePath">
            </div>
            <div class="product-item" style="text-align: left;">
                <h3>음식명 : {{info.foodName}}</h3>
                <p>은식 설명 : {{info.foodInfo}}</p>
                <p class="price">가격 : ₩{{info.price}}</p>
                <p>개수 : <input v-model="num"></p>
                <div id="orderBtn">
                    <button @click="fnPayment">주문하기</button>
                </div>
            </div>
        </section>
    </div>
</body>
</html>

<script>
    IMP.init("imp87747305");
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                foodNo : "${foodNo}",
                info : {},
                num : 1,
                sessionId : "${sessionId}"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnProductInfo: function () {
                let self = this;
                let param = {
                    foodNo : self.foodNo
                };
                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                    }
                });
            },
            fnPayment(){
                let self = this;
				IMP.request_pay({
				    pg: "html5_inicis", // we can change the PG provider to use a different payment service (ex: kakaopay or naverpay)
				    pay_method: "card",
				    merchant_uid: "merchant_" + new Date().getTime(),
				    name: self.info.foodName,
				    amount: 1, // the actual price should be here : self.info.price * self.num
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
			   	        // 결제 성공 시
						// alert("성공");
						console.log(rsp);

                        let param = {
                            orderId : rsp.imp_uid,
                            userId : self.sessionId,
                            amount : rsp.paid_amount,
                            productNo : self.foodNo
                        };

                        $.ajax({
                            url: "/payment.dox",
                            dataType: "json",
                            type: "POST",
                            data: param,
                            success: function (data) {
                                if(data.result == "success"){
                                    alert("결제가 되었습니다.");
                                } else {
                                    alert("결제 정보 저장 오류가 발생.");
                                }
                            }
                        });

			   	      } else {
			   	        // 결제 실패 시
						alert("실패");
			   	      }
		   	  	});
			}
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnProductInfo();
        }
    });

    app.mount('#app');
</script>