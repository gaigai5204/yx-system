<template>
	<view class="detail">
		<!-- #ifndef H5 -->
		<map style="width: 100%; height: 300px;" :latitude="latitude" :longitude="longitude" :markers="covers"
			:polyline="lines">
		</map>
		<!-- #endif -->

		<view class="main">
			<view class="package-id">
				特快专递：{{packageDetail.orderNumber}}
			</view>
			<view class="from-to">
				<view class="place">
					{{reciverPlace}}
				</view>
				<image src="/static/search/arrow.png" mode=""></image>
				<view class="place">
					{{reciverPlace}}
				</view>
			</view>
			<view class="reciver">
				<view class="name">
					<text class="name-icon">收</text>
					{{packageDetail.orderToName}}
				</view>
				<view class="phone">
					{{packageDetail.orderToPhone}}
				</view>
				<view class="place">
					{{packageDetail.orderToAddress}}
				</view>
			</view>
			<view class="sender">
				<view class="name">
					<text class="name-icon">寄</text>
					{{packageDetail.orderFromName}}
				</view>
				<view class="phone">
					{{packageDetail.orderFromPhone}}
				</view>
				<view class="place">
					{{packageDetail.orderFromAddress}}
				</view>
			</view>
			<view class="package-info">
				<text>物品类型：普货</text>
				<text>物品重量：{{packageDetail.orderWeight}}</text>
				<!-- <text>物品体积：{{packageDetail.packageVolum}}</text> -->
				<text>备注：{{packageDetail.remark}}</text>
			</view>
		</view>

		<view class="postman-info">
			<text>收件员：{{postman.nickName}}</text>
			<text>收件员电话：{{postman.phonenumber}}</text>
			<!-- <text>收寄时间：{{packageDetail.postTime}}</text> -->
			<!-- <text>收寄机构：{{packageDetail.postShop}}</text> -->
		</view>
	</view>
</template>

<script>
	import { listOrder,getOrder} from "@/api/order";
	import { getPostmanById} from "@/api/postman";
	import {updateOrderTran,getOrderTran,insertTran} from "@/api/tran.js"
	import app from "@/App.vue";
	export default {
		data() {
			return {
				packageid: "",
				packageDetail: {},
				senderPlace:'',
				reciverPlace:'',
				postman:{},
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
					orderDept: undefined
				},
				id: 0, // 使用 marker点击事件 需要填写id
				title: 'map',
				latitude: 39.909,
				longitude: 116.39742,
				covers: [{
					latitude: 39.909,
					longitude: 116.39742,
					iconPath: '/static/search/wangdian.png',
					width: 10,
					height: 10
				}, {
					latitude: 34.70,
					longitude: 114.39,
					iconPath: '/static/search/wangdian.png',
					width: 30,
					height: 30
				}],
				lines: [{
					points: [{
							latitude: 39.909,
							longitude: 116.39742
						},
						{
							latitude: 34.70,
							longitude: 114.39,
						}
					],
					color: "#31c27c",
					width: 10,
					arrowLine: true,
					borderWidth: 2
				}]
			};
		},
		onLoad(e) {
			this.packageid = e.packageid
			// 接收数据
			// const eventChannel = this.getOpenerEventChannel();
			// eventChannel.on('acceptDataFromOpenerPage', (data) => {
			// 	this.packageDetail = data.data
			// 	console.log(this.packageDetail)
			// })
			let self=this
			this.queryParams.orderNumber=this.packageid
			console.log(this.queryParams)
			listOrder(this.queryParams).then(res => {
				console.log(res)
			  self.packageDetail = res.rows[0];
	
			  var tempOne=self.packageDetail.orderFromAddress.split("市")[0]+'市'
			  var tempTwo=self.packageDetail.orderToAddress.split("市")[0]+'市'
			  self.senderPlace=tempOne.split("省")[1]
			  self.reciverPlace=tempTwo.split("省")[1]
			  
			  getPostmanById(res.rows[0].orderPostman).then(response => {
				  self.postman=response.data
			  })
			  
			})	
		},
	}
</script>

<style lang="scss" scoped>
	.detail {
		padding: 30rpx 50rpx;
		font-size: 32rpx;
		line-height: 50rpx;

		.main {
			background-color: #fff;
			border-radius: 20rpx;
			padding: 20rpx 30rpx;

			.package-id {
				height: 60rpx;
				line-height: 60rpx;
				border-bottom: 1px solid #ddd;
			}

			.from-to {
				display: flex;
				justify-content: space-around;
				align-items: center;
				height: 150rpx;
				border-bottom: 1px solid #ddd;
				font-weight: bold;

				image {
					width: 60rpx;
					height: 60rpx;
				}
			}

			.reciver,
			.sender {
				padding: 30rpx 0;
				border-bottom: 1px solid #ddd;

				.name {
					display: flex;
					align-items: center;

					.name-icon {
						display: block;
						width: 50rpx;
						height: 50rpx;
						line-height: 50rpx;
						text-align: center;
						border-radius: 50%;
						background-color: #aad540;
						color: #5ea55c;
						margin-right: 20rpx;
					}
				}
			}

			.package-info {
				padding: 30rpx 0 0;
				display: flex;
				flex-direction: column;
			}
		}

		.postman-info {
			background-color: #fff;
			border-radius: 20rpx;
			padding: 20rpx 30rpx;
			margin-top: 50rpx;
			display: flex;
			flex-direction: column;
		}
	}
</style>
