<template>
	<view class="send-mail-detail">
		<view class="place-info">
			<view class="sender">
				<view class="title-icon">
					寄
				</view>
				<view class="content" @tap="goFillInfo('sender',1)">
					<view class="title">
						寄件人信息
					</view>
					<view v-if="this.infoFormFrom" class="sub-title">
						{{infoFormFrom.addrName}}{{' '}}{{infoFormFrom.addrPhone}}
					</view>
					<view v-else class="sub-title">
						点击填写寄件人信息
					</view>
				</view>
				<view class="address-book" @tap="goAddressBook(1)">
					<image src="/static/common/address.png"></image>
					<text>地址簿</text>
				</view>
			</view>
			<view class="reciver">
				<view class="title-icon">
					收
				</view>
				<view class="content" @tap="goFillInfo('reciver',2)">
					<view class="title">
						收件人信息
					</view>
					<view v-if="this.infoFormTo" class="sub-title">
						{{infoFormTo.addrName}}{{' '}}{{infoFormTo.addrPhone}}
					</view>
					<view v-else class="sub-title">
						点击填写收件人信息
					</view>
				</view>
				<view class="address-book" @tap="goAddressBook(2)">
					<image src="/static/common/address.png"></image>
					<text>地址簿</text>
				</view>
			</view>
		</view>

		<view class="send-mail-topBar">
			<view class="topBar-item" v-for="(item,index) in sendMailTopBar" :key="index" @tap="changeTab(index)"
				:class="topBarIndex===index?'topBar-active-color':''">
				<text>{{item}}</text>
			</view>
		</view>

		<swiper class="send-mail-content" @change="onChangeTab" style="height: 680rpx;" :current="topBarIndex">
			<swiper-item>
				<view class="swiper-item">
					<scroll-view scroll-y="true" style="height: 680rpx;">
						<view class="title">
							物品信息
						</view>
						<view class="type">
							<view class="type-title">
								<view>
									<!-- 选择物品类型 -->
									选择网点
								</view>
								<view class="note" @tap="goForbidList">
									查看《违禁品清单》
								</view>
							</view>
							<view class="type-list">
								<view class="type-list-item " v-for="(item,index) in deptList" :key="index"
									:class="itemIndex == index? 'item-active':''"
									@tap="itemChoosedUser(item.userId,index)">
									{{item.nickName}}
								</view>
							</view>
						</view>
						<view class="weight">
							<view>
								物品重量（单位KG）
							</view>
							<uniNumberBox :min="1" v-model="weight"></uniNumberBox>
						</view>
						<view class="remarks">
							<text>订单备注</text>
							<input type="text" maxlength="10" placeholder="不超过10个字符" v-model="remark">
						</view>
					</scroll-view>
				</view>
			</swiper-item>
			<swiper-item>
				<view class="swiper-item">
					<scroll-view scroll-y="true" style="height: 680rpx;">
						<view class="title">
							选择驿站
						</view>
						<view class="choose-stage" @tap="chooseStage">
							<image src="/static/search/wangdian.png"></image>
							<text>选择附近驿站</text>
						</view>
						<view class="type">
							<view class="type-title">
								<view>
									选择物品类型
								</view>
								<view class="note" @tap="goForbidList">
									查看《违禁品清单》
								</view>
							</view>
							<view class="type-list">
								<view class="type-list-item " v-for="(item,index) in typeList" :key="index"
									:class="itemIndex == index? 'item-active':''" @tap="itemChoosed(index)">
									{{item}}
								</view>
							</view>
						</view>
					</scroll-view>
				</view>
			</swiper-item>
		</swiper>

		<view class="privacy-terms">
			<radio-group @change="checkTermsAccepted">
				<label>
					<radio :checked="termsAccepted" color="#aad540"></radio>
				</label>
			</radio-group>

			<text>我已阅读并接受</text>
			<text class="highlight">《电子运单契约条款》</text>
		</view>

		<view class="bottom-bar">
			<view class="cost">
				预估费用：
				<text class="highlight">{{predictCost}}元</text>
			</view>
			<view :class="allowOrder == true ? 'order-active' : 'order'" @click="placeOrder()">
				下单
			</view>
		</view>
	</view>
</template>

<script>
	import uniNumberBox from '@/components/uni_asset/uni-number-box/uni-number-box.vue'
	import {
		listUser
	} from "@/api/user.js"
	import {
		listOrder,
		updateOrder,
		addOrder
	} from "@/api/order";
	import app from "@/App.vue"
	export default {
		data() {
			return {
				topBarIndex: 0,
				itemIndex: null,
				queryParams: {
					orderParty: undefined,
					orderPostman: undefined,
					orderWeight: undefined,
					orderPrice: undefined,
					orderToName: undefined,
					orderToPhone: undefined,
					orderToAddress: undefined,
					orderFromName: undefined,
					orderFromPhone: undefined,
					orderFromAddress: undefined,
					remark: undefined,
					orderStatus: undefined,
					orderDept: undefined
				},
				infoFormFrom: undefined,
				infoFormTo: undefined,
				weight: 1,
				remark: '',
				predictCost: "--",
				termsAccepted: false,
				allowOrder: false,
				sendMailTopBar: ['上门取件', '驿站自寄'],
				typeList: ['生活用品', '文件资料', '数码产品', '食品生鲜', '服装配饰', '易碎物品', '防疫物资', '美妆用品', '生活药品'],
				deptList: []
			};
		},
		methods: {
			changeTab(index) {
				this.topBarIndex = index
			},
			onChangeTab(e) {
				this.topBarIndex = e.detail.current
			},
			goForbidList() {
				uni.navigateTo({
					url: "/pages/forbidList/forbidList"
				})
			},
			itemChoosed(index) {
				this.itemIndex = index
			},
			itemChoosedUser(userId, index) {
				this.itemIndex = index
				this.queryParams.orderDept = userId
			},
			checkTermsAccepted(e) {
				this.termsAccepted = true
			},
			goFillInfo(role, type) {
				uni.navigateTo({
					url: `/pages/senderOrReciverInfo/senderOrReciverInfo?role=${role}&type=${type}`
				})
			},
			goAddressBook(type) {
				uni.navigateTo({
					url: "/pages/addressBook/addressBook?type=" + type
				})
			},
			chooseStage() {
				uni.navigateTo({
					url: "/pages/chooseStage/chooseStage"
				})
			},
			placeOrder() {
				if (this.allowOrder == true) {
					let self = this
					uni.showModal({
						title: '提示',
						// 提示文字
						content: '确认下单吗？',
						// 取消按钮的文字自定义
						cancelText: "取消",
						// 确认按钮的文字自定义
						confirmText: "确认",
						//删除字体的颜色
						confirmColor: '#00da66',
						//取消字体的颜色
						cancelColor: '#000000',
						success: function(res) {
							// console.log(self.queryParams)
							if (res.confirm) {
								self.queryParams.orderParty = app.globalData.userId
								self.queryParams.orderWeight = self.weight
								self.queryParams.orderPrice = self.predictCost
								self.queryParams.orderToName = self.infoFormTo.addrName
								self.queryParams.orderToPhone = self.infoFormTo.addrPhone
								self.queryParams.orderToAddress = self.infoFormTo.addrDetail
								self.queryParams.orderFromName = self.infoFormFrom.addrName
								self.queryParams.orderFromPhone = self.infoFormFrom.addrPhone
								self.queryParams.orderFromAddress = self.infoFormFrom.addrDetail
								self.queryParams.remark = self.remark
								addOrder(self.queryParams).then(res => {
									console.log(res)
									uni.showToast({
										title: "下单成功",
										icon: "success"
									})
								})
							} else {
								// 执行取消后的操作
							}
						}
					})
				}
			}
		},
		watch: {
			itemIndex(newv, oldv) {
				this.predictCost = 10 + (this.weight - 1) * 2
				if (this.itemIndex != null && this.termsAccepted) {
					this.allowOrder = true
				}
			},
			weight(newv, oldv) {
				if (this.itemIndex) {
					this.predictCost = 10 + (newv - 1) * 2
				}
				if (this.itemIndex != null && this.termsAccepted) {
					this.allowOrder = true
				}
			},
			termsAccepted(newv, oldv) {
				if (this.itemIndex != null && this.termsAccepted) {
					this.allowOrder = true
				}
			}
		},
		onShow() {
			if (this.infoFormFrom != undefined) {
				uni.setStorageSync("addressfrom", JSON.stringify(this.infoFormFrom))
			}
			if (this.infoFormTo != undefined) {
				uni.setStorageSync("addressto", JSON.stringify(this.infoFormTo))
			}
			if (this.infoFormFrom == undefined) {
				var addrdatafrom = uni.getStorageSync("addressfrom")
				if (addrdatafrom) {
					this.infoFormFrom = JSON.parse(addrdatafrom)
				}
			}
			if (this.infoFormTo == undefined) {
				var addrdatato = uni.getStorageSync("addressto")
				if (addrdatato) {
					this.infoFormTo = JSON.parse(addrdatato)
				}
			}
			listUser().then(res => {
				this.deptList = res.rows
			})
		},
		onLoad(e) {
			if (e.infoForm) {
				if (e.type == 1) {
					this.infoFormFrom = JSON.parse(e.infoForm)

				} else {
					this.infoFormTo = JSON.parse(e.infoForm)
				}

			}
		},
		components: {
			uniNumberBox
		}
	}
</script>

<style lang="scss" scoped>
	.send-mail-detail {
		padding: 30rpx 50rpx;

		.place-info {
			display: flex;
			flex-direction: column;
			align-items: center;
			background-color: #fff;
			border-radius: 20rpx;
			font-size: 32rpx;

			.sender,
			.reciver {
				display: flex;
				justify-content: space-between;
				align-items: center;
				height: 150rpx;

				.title-icon {
					width: 50rpx;
					height: 50rpx;
					line-height: 50rpx;
					text-align: center;
					border-radius: 50%;
					background-color: red;
					margin-right: 20rpx;
					background-color: #aad540;
					color: #5ea55c;
				}


				.content {
					width: 450rpx;

					.title {
						font-weight: bold;
						margin-bottom: 10rpx;
					}

					.sub-title {
						font-size: 28rpx;
						color: #bbb;
					}

				}

				.address-book {
					display: flex;
					flex-direction: column;
					align-items: center;
					font-size: 28rpx;

					image {
						width: 50rpx;
						height: 50rpx;
					}
				}
			}

			.sender {
				border-bottom: 1px solid #eee;
			}
		}

		.send-mail-topBar {
			margin-top: 30rpx;
			display: flex;
			justify-content: space-between;
			font-size: 34rpx;
			text-align: center;

			.topBar-item {
				width: 50%;
				min-height: 80rpx;
				line-height: 80rpx;
				border-radius: 30rpx 30rpx 0 0;
			}

			.topBar-active-color {
				background-color: #fff;
				font-weight: bold;
			}
		}

		.send-mail-content {
			background-color: #fff;
			border-radius: 0 0 30rpx 30rpx;
			margin-bottom: 50rpx;
			font-size: 34rpx;

			.swiper-item {
				.title {
					font-weight: bold;
					border-bottom: 1px solid #eee;
					padding: 20rpx 30rpx;
				}

				.type {
					.type-title {
						padding: 20rpx 30rpx 30rpx;
						display: flex;
						justify-content: space-between;
						align-items: center;
						font-size: 30rpx;

						.note {
							font-size: 26rpx;
							background-image: -webkit-linear-gradient(left, #aad540, #5ea55c);
							-webkit-background-clip: text;
							-webkit-text-fill-color: transparent;
						}

					}

					.type-list {
						display: flex;
						flex-wrap: wrap;
						justify-content: space-around;
						align-items: center;
						font-size: 30rpx;

						.type-list-item {
							width: 180rpx;
							border: 1px solid #eee;
							text-align: center;
							padding: 15rpx 10rpx;
							border-radius: 20rpx;
							margin-bottom: 30rpx;
						}

						.item-active {
							background: linear-gradient(to right, #aad540, #5ea55c);
							color: #fff;
						}
					}
				}

				.choose-stage {
					display: flex;
					align-items: center;
					background: linear-gradient(to right, #aad540, #f7f7f7);
					color: #fff;
					height: 100rpx;
					margin: 34rpx 30rpx 20rpx;
					border-radius: 20rpx;
					padding: 0 20rpx;
					font-size: 32rpx;

					image {
						width: 50rpx;
						height: 50rpx;
						margin-right: 20rpx;
					}
				}

				.weight {
					display: flex;
					justify-content: space-between;
					padding: 0 30rpx 30rpx;
					margin-top: 30rpx;
					font-size: 30rpx;
				}

				.remarks {
					display: flex;
					align-items: center;
					justify-content: space-between;
					padding: 0 30rpx 30rpx;
					font-size: 30rpx;

					input {
						background-color: #f5f5f5;
						width: 450rpx;
						height: 50rpx;
						border-radius: 20rpx;
						padding: 0 20rpx;
						font-size: 30rpx;
					}
				}
			}
		}

		.privacy-terms {
			display: flex;
			align-items: center;
			font-size: 28rpx;
			margin-bottom: 120rpx;

			.highlight {
				background-image: -webkit-linear-gradient(left, #aad540, #5ea55c);
				-webkit-background-clip: text;
				-webkit-text-fill-color: transparent;
			}
		}

		.bottom-bar {
			position: fixed;
			bottom: 0;
			left: 0;
			height: 120rpx;
			line-height: 120rpx;
			width: 100%;
			background-color: #fff;
			display: flex;
			justify-content: space-between;
			align-items: center;
			font-size: 34rpx;
			padding: 0 50rpx;

			.highlight {
				font-weight: bold;
				background-image: -webkit-linear-gradient(left, #aad540, #5ea55c);
				-webkit-background-clip: text;
				-webkit-text-fill-color: transparent;
			}

			.order {
				width: 170rpx;
				height: 70rpx;
				line-height: 70rpx;
				text-align: center;
				color: #fff;
				border-radius: 40rpx;
				background-color: #ccc;
			}

			.order-active {
				width: 170rpx;
				height: 70rpx;
				line-height: 70rpx;
				text-align: center;
				color: #fff;
				border-radius: 40rpx;
				background: linear-gradient(to right, #aad540, #5ea55c) !important;
			}
		}
	}
</style>
