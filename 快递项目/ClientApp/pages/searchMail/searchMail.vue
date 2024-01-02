<template>
	<view class="search-mail">
		<view class="input-number">
			<input type="number" placeholder="请输入运单号" @tap="gotoSearch" disabled="true">
			<image src="/static/search/saoma.png" @tap="scanQR"></image>
		</view>
		<view class="search-box">
			<view class="search-box-item" v-for="(item,index) in searchBoxContent" :key="index"
				@tap="queryList(item.title)">
				<image :src="item.imgUrl"></image>
				<text>{{item.title}}</text>
			</view>
		</view>
		<view class="result-box">
			<view class="result-box-topBar">
				<view class="topBar-item" v-for="(item,index) in resultBoxTopBar" :key="index" @tap="changeTab(index)">
					<text :class="topBarIndex===index?'topBar-active-color':''">{{item}}</text>
				</view>
			</view>
			<swiper :current="topBarIndex" @change="onChangeTab" :style="`height: ${clientHeight}px;`">
				<!-- 我寄的 -->
				<swiper-item>
					<view class="swiper-item">
						<scroll-view scroll-y="true" style="padding-bottom: 80rpx;"
							:style="`height: ${clientHeight}px;`">
							<!-- 暂无包裹 -->
							<view class="no-package" v-if="packageInfo.length==0">
								<image src="/static/search/lost.png"></image>
								<view class="title">
									暂无包裹
								</view>
							</view>

							<!-- 有包裹 -->
							<view class="package" v-else v-for="(item,index) in packageInfo" :key="index">
								<view class="package-title">
									<view class="package-title-number">
										运单号：{{item.orderNumber}}
									</view>
									<view v-if="item.creatTime" class="package-title-time">
										{{item.creatTime}}
									</view>
								</view>
								<view class="package-content" @tap="gotoDetail(item)">
									<view class="package-content-sender">
										<view class="place">
											{{senderPlace[index]}}
										</view>
										<view class="name">
											{{item.orderFromName}}
										</view>
									</view>
									<view class="direction-arrow">
										<image src="/static/search/arrow.png" mode=""></image>
									</view>
									<view class="package-content-reciver">
										<view class="place">
											{{reciverPlace[index]}}
										</view>
										<view class="name">
											{{item.orderToName}}
										</view>
									</view>
								</view>
								<view class="package-footer">
									<view class="comment" @tap="gotoComment">
										评价
									</view>
									<view class="share" @tap="sharePackage">
										分享
									</view>
									<view class="delivery" @tap="gotoDelivery">
										寄件
									</view>
								</view>
							</view>
						</scroll-view>
					</view>
				</swiper-item>

				<!-- 我收的 -->
				<swiper-item>
					<view class="swiper-item">
						<scroll-view scroll-y="true" style="padding-bottom: 80rpx;"
							:style="`height: ${clientHeight}px;`">
							<!-- 暂无包裹 -->
							<view class="no-package" v-if="recivedPackageInfo.length==0">
								<image src="/static/search/lost.png"></image>
								<view class="title">
									暂无包裹
								</view>
							</view>

							<!-- 有包裹 -->
							<view class="package" v-else v-for="(item,index) in recivedPackageInfo" :key="index">
								<view class="package-title">
									<view class="package-title-number">
										运单号：{{item.orderNumber}}
									</view>
									<view v-if="item.creatTime" class="package-title-time">
										{{item.creatTime}}
									</view>
								</view>
								<view class="package-content" @tap="gotoDetail(item)">
									<view class="package-content-sender">
										<view class="place">
											{{reciverPlace[index]}}
										</view>
										<view class="name">
											{{item.orderToName}}
										</view>
									</view>
									<view class="direction-arrow">
										<image src="/static/search/arrow.png" mode=""></image>
									</view>
									<view class="package-content-reciver">
										<view class="place">
											{{senderPlace[index]}}
										</view>
										<view class="name">
											{{item.orderFromName}}
										</view>
									</view>
								</view>
								<view class="package-footer">
									<view class="comment" @tap="gotoComment">
										评价
									</view>
									<view class="share" @tap="sharePackage">
										分享
									</view>
									<view class="delivery" @tap="getPickingCode(item.orderTakenum)">
										取件码
									</view>
								</view>
							</view>
						</scroll-view>
					</view>
				</swiper-item>

				<swiper-item>
					<view class="swiper-item">
						<view class="no-package">
							<image src="/static/search/lost.png"></image>
							<view class="title">
								暂无包裹
							</view>
						</view>
					</view>
				</swiper-item>
			</swiper>
		</view>
	</view>
</template>

<script>
	import {partyList,getParty} from "@/api/party.js"
	import {listOrder,updateOrder} from "@/api/order";
	import app from "@/App.vue"
	export default {
		data() {
			return {
				searchBoxContent: [{
						imgUrl: "/static/search/yunfei.png",
						title: "运费查询"
					},
					{
						imgUrl: "/static/search/wangdian.png",
						title: "网点查询"
					},
					{
						imgUrl: "/static/search/weijin.png",
						title: "违禁查询"
					}
				],
				resultBoxTopBar: ['我寄的', '我收的', '驿站自寄'],
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
				senderPlace:[],
				reciverPlace:[],
				packageInfo: [],
				recivedPackageInfo: [],
				topBarIndex: 0,
				clientHeight: 0
			}
		},
		onReady() {
			uni.getSystemInfo({
				success: (res) => {
					// 获取可视区域高度 windowHeight
					this.clientHeight = res.windowHeight - uni.upx2px(540)
				}
			})
		},
		onShow() {
			
			try {
				const result = uni.getStorageSync("searchPageTopBarIndex")
				if (result == 0 || result == 1) {
					this.topBarIndex = Number(result)
					uni.removeStorage({
						key: "searchPageTopBarIndex"
					})
				}
			} catch (e) {
console.log('666')
			}
			if(app.globalData.nickName){
			    let self=this
				this.queryParams.orderToPhone=app.globalData.phone
				console.log(this.queryParams)
				listOrder(this.queryParams).then(res => {
					console.log(res)
				  self.recivedPackageInfo = res.rows;
				  self.recivedPackageInfo.forEach(function(item,index){
				  var temp=item.orderToAddress.split("市")[0]+'市'
				  self.reciverPlace[index]=temp.split("省")[1]
				  }.bind(self));
				  
				})
				
				this.queryParams.orderFromPhone=app.globalData.phone
				console.log(this.queryParams)
				listOrder(this.queryParams).then(res => {
					console.log(res)
				  self.packageInfo = res.rows;
				  self.packageInfo.forEach(function(item,index){
				  var temp=item.orderFromAddress.split("市")[0]+'市'
				  self.senderPlace[index]=temp.split("省")[1]
				  }.bind(self));
				})
			
				
			}	
		},

		methods: {

			cutPlace(str){
				this.infoForm.place=str.split("市")[0]+'市'
			},
			changeTab(index) {
				this.topBarIndex = index
			},
			onChangeTab(e) {
				this.topBarIndex = e.detail.current
			},
			scanQR() {
				uni.scanCode({
					onlyFromCamera: true,
					success: function(res) {
						uni.showModal({
							title: "扫描结果",
							content: res.result
						})
					}
				});
			},
			sharePackage() {
				uni.share({
					provider: "weixin",
					type: 0,
					// provider为微信时必填
					scene: 'WXSceneSession',
					title: "快来查看你的快递包裹~~",
					href: `http://169.254.172.199:8080/#/pages/detail/detail`,
					imageUrl: "/static/search/share.png",
					success: function(res) {
						uni.showToast({
							title: "分享成功",
							icon: "success"
						})
					},
					fail: function(err) {
						uni.showToast({
							title: "分享失败",
							icon: "error"
						})
					}
				})
			},
			gotoDelivery() {
				uni.navigateTo({
					url: "/pages/sendMailDetail/sendMailDetail"
				})
			},
			gotoComment() {
				uni.navigateTo({
					url: "/pages/comment/comment"
				})
			},
			gotoSearch() {
				uni.navigateTo({
					url: "/pages/searchWithPackageID/searchWithPackageID"
				})
			},
			gotoDetail(item) {
				uni.navigateTo({
					url: `/pages/packageDetail/packageDetail?packageid=${item.orderNumber}`,
					success: (res) => {
						// 通过eventChannel向被打开页面传送数据
						res.eventChannel.emit('acceptDataFromOpenerPage', {
							data: item
						})
					}
				})
			},
			queryList(title) {
				if (title == '违禁查询') {
					uni.navigateTo({
						url: "/pages/forbidList/forbidList"
					})
				} else if (title === "网点查询") {
					uni.navigateTo({
						url: "/pages/chooseStage/chooseStage"
					})
				} else if (title === "运费查询") {
					uni.navigateTo({
						url: "/pages/priceQuery/priceQuery"
					})
				}
			},
			getPickingCode(orderTakenum) {
				if(orderTakenum!=undefined){
					uni.showModal({
						title: "取件码",
						content: orderTakenum,
						confirmText: "确认",
						confirmColor: "#5ea55c",
						showCancel: false
					})					
				}else{
					uni.showModal({
						title: "取件码",
						content: '还在路上，暂无取件码',
						confirmText: "确认",
						confirmColor: "#5ea55c",
						showCancel: false
					})						
				}

			}
		}
	}
</script>

<style scoped lang="scss">
	.search-mail {

		.input-number {
			height: 300rpx;
			background: linear-gradient(to right, #aad540, #5ea55c);
			border-radius: 0 0 58rpx 58rpx;
			display: flex;
			justify-content: center;
			align-items: center;

			input {
				background-color: #fff;
				width: 550rpx;
				height: 70rpx;
				border-radius: 50rpx;
				padding: 0 30rpx;
				margin-right: 30rpx;
			}

			image {
				width: 64rpx;
				height: 64rpx;
			}
		}

		.search-box {
			height: 200rpx;
			width: 650rpx;
			margin: -40rpx auto 0;
			background-color: #fff;
			border-radius: 20rpx;
			display: flex;
			justify-content: space-around;
			align-items: center;
			font-size: 32rpx;
			box-shadow: 4rpx 4rpx 4rpx #ccc;

			.search-box-item {
				display: flex;
				flex-direction: column;
				align-items: center;

				image {
					width: 60rpx;
					height: 60rpx;
					margin-bottom: 20rpx;
				}
			}
		}

		.result-box {
			width: 650rpx;
			margin: 36rpx auto 0;

			.result-box-topBar {
				display: flex;
				font-size: 34rpx;

				.topBar-item {
					margin-right: 30rpx;
				}

				.topBar-active-color {
					border-bottom: 4rpx solid #5ea55c;
					border-image: radial-gradient(#aad540 70%, #5ea55c 130%) 4;
					font-weight: bold;
					background-image: -webkit-linear-gradient(left, #aad540, #5ea55c);
					-webkit-background-clip: text;
					-webkit-text-fill-color: transparent;
				}
			}

			.swiper-item {
				padding-top: 30rpx;
				font-size: 32rpx;

				.package {
					background-color: #fff;
					border-radius: 20rpx;
					margin-bottom: 40rpx;
					padding: 20rpx 26rpx;

					.package-title {
						display: flex;
						justify-content: space-between;
						align-items: center;
						margin-bottom: 10rpx;

						.package-title-number {
							font-weight: bold;
						}

						.package-title-time {
							color: #bbb;
							font-size: 24rpx;
						}
					}

					.package-content {
						border-top: 1px solid #eee;
						border-bottom: 1px solid #eee;
						display: flex;
						justify-content: space-around;
						align-items: center;
						padding: 30rpx 0;

						.package-content-sender,
						.package-content-reciver {
							display: flex;
							flex-direction: column;
							align-items: center;

							.place {
								font-weight: bold;
								font-size: 36rpx;
								line-height: 60rpx;
							}

							.name {
								font-size: 28rpx;
							}
						}

						.direction-arrow {
							image {
								width: 60rpx;
								height: 60rpx;
							}
						}
					}

					.package-footer {
						display: flex;
						align-items: center;
						// right在移动端不能用
						justify-content: flex-end;
						margin-top: 20rpx;

						view {
							border: 1px solid #eee;
							border-radius: 24rpx;
							padding: 6rpx 20rpx;
							margin-left: 20rpx;
							font-size: 28rpx;
						}
					}
				}

				.no-package {
					text-align: center;
					color: #bbb;
					font-size: 34rpx;

					image {
						width: 400rpx;
						height: 400rpx;
					}
				}
			}
		}
	}
</style>
