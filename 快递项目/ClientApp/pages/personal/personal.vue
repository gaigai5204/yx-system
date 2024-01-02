<template>
	<view class="personal">
		<view class="user-info">
			<image src="/static/search/avatar.png" mode=""></image>
			<view class="info" @tap="goLogin">
				<view class="name">
					<div class="login-name" v-if="this.nickName">{{nickName}}
						
					</div>
					<div class="login" @click="toLogin()" v-else>登录/注册</div>
				</view>
				<view class="phone">
					{{phone}}
				</view>
			</view>
		</view>
		<view class="send-recive">
			<view class="mySend" @tap="gotoSearch(0)">
				<view class="count">
					<text>我寄的</text>
					<text>{{fromPhoneNum}}</text>
				</view>
				<image src="/static/sendSwiper/news2.png" mode=""></image>
			</view>
			<view class="myRecive" @tap="gotoSearch(1)">
				<view class="count">
					<text>我收的</text>
					<text>{{toPhoneNum}}</text>
				</view>
				<image src="/static/sendSwiper/news1.png" mode=""></image>
			</view>
		</view>
		<view class="coupon" @tap="gotoCoupon">
			<view class="img">
				<image src="/static/sendSwiper/news3.png" mode=""></image>
			</view>
			<view class="content">
				<view class="title">
					我的优惠券
				</view>
				<view class="subTitle">
					优惠宝藏，喊你来省钱
				</view>
			</view>
			<view class="arrow">
				<image src="/static/search/arrow.png" mode=""></image>
			</view>
		</view>
		<view class="other-service">
			<PromtTitle title="其他服务" subTitle="Other Services"></PromtTitle>
			<view class="other-function">
				<view class="func-item" v-for="(item,index) in otherFuncItem" :key="index">
					<view class="func-item-icon">
						<image :src="item.imgUrl"></image>
					</view>
					<view class="func-item-title">
						{{item.title}}
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import PromtTitle from '@/components/PromtTitle.vue'
	import {partyList,getParty} from "@/api/party.js"
	import { listOrder,updateOrder} from "@/api/order";
	import app from "@/App.vue"
	export default {
		data() {
			return {
				nickName:'',
				phone:'',
				toPhoneNum:0,
				fromPhoneNum:0,
				queryParams: {
					pageNum: 1,
					pageSize: 10,
					orderId: undefined,
					orderNumber: undefined,
					postmanPhone: undefined,
					partyPhone: undefined,
					orderParty: undefined,
					orderPostman: undefined,
					orderStatus:undefined,
					orderToPhone:undefined,
					orderDept: undefined
				},
				otherFuncItem: [{
						imgUrl: "/static/sendSwiper/piliang.png",
						title: "批量寄件"
					},
					{
						imgUrl: "/static/sendSwiper/dayin.png",
						title: "在线打印"
					},
					{
						imgUrl: "/static/sendSwiper/wangdian.png",
						title: "网点查询"
					},
					{
						imgUrl: "/static/common/kefu.png",
						title: "在线客服"
					}
				],
			}
		},
		onShow() {
			this.nickName=app.globalData.nickName
			this.phone=app.globalData.phone
			if(app.globalData.nickName){

				this.queryParams.orderToPhone=app.globalData.phone
				console.log(this.queryParams)
				listOrder(this.queryParams).then(res => {
					console.log(res)
				  this.toPhoneNum = res.rows.length;
				    this.queryParams.orderToPhone=undefined
					this.queryParams.orderFromPhone=app.globalData.phone
					console.log(this.queryParams)
					listOrder(this.queryParams).then(res => {
						console.log(res)
					  this.fromPhoneNum = res.rows.length;
					  
					})				  
				})
				


				
			}			
		},
		methods: {
			goLogin() {
				uni.navigateTo({
					url: "/pages/login/login"
				})
			},
			gotoCoupon() {
				uni.navigateTo({
					url: "/pages/couponList/couponList"
				})
			},
			gotoSearch(index) {
				uni.setStorageSync("searchPageTopBarIndex", index)
				uni.switchTab({
					url: `/pages/searchMail/searchMail`,
				})
			}
		},
		components: {
			PromtTitle
		}
	}
</script>

<style lang="scss" scoped>
	.personal {
		.user-info {
			display: flex;
			align-items: center;
			height: 240rpx;
			background: linear-gradient(to right, #aad540, #5ea55c);
			color: #fff;
			padding: 0 50rpx;

			.name {
				font-size: 36rpx;
				margin-bottom: 10rpx;
			}

			.phone {
				font-size: 28rpx;
				color: #888;
			}

			image {
				width: 100rpx;
				height: 100rpx;
				margin-right: 40rpx;
				border: 4rpx solid #fff;
				border-radius: 50%;
				overflow: hidden;
			}
		}

		.send-recive {
			display: flex;

			.mySend,
			.myRecive {
				height: 160rpx;
				width: 330rpx;
				margin: -30rpx auto 0;
				background-color: #fff;
				border-radius: 20rpx;
				display: flex;
				justify-content: space-around;
				align-items: center;
				font-size: 32rpx;
				box-shadow: 4rpx 4rpx 4rpx #ccc;

				.count {
					display: flex;
					flex-direction: column;
					align-items: center;

				}

				image {
					width: 150rpx;
					height: 150rpx;
				}
			}
		}

		.coupon {
			background: linear-gradient(to right, #c2ef46, #fff);
			display: flex;
			align-items: center;
			justify-content: space-around;
			height: 160rpx;
			width: 650rpx;
			border-radius: 20rpx;
			margin: 40rpx auto;

			.img image {
				width: 150rpx;
				height: 150rpx;
			}

			.arrow image {
				width: 40rpx;
				height: 40rpx;
			}

			.content {
				.title {
					font-weight: bold;
					margin-bottom: 10rpx;
					font-size: 32rpx;
				}

				.subTitle {
					color: #aaa;
					font-size: 28rpx;
				}
			}
		}

		.other-service {
			width: 650rpx;
			margin: 0 auto;

			.other-function {
				display: flex;
				justify-content: space-around;
				background-color: #fff;
				border-radius: 20rpx;

				.func-item {
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;
					padding: 30rpx 0;

					.func-item-icon {
						image {
							width: 50rpx;
							height: 50rpx;
						}
					}

					.func-item-title {
						font-size: 30rpx;
						margin-top: 14rpx;
					}
				}
			}
		}
	}
</style>
