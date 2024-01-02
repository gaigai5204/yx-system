<template>
	<view class="price-query">
		<view class="place-info">
			<view class="sender">
				<view class="title-icon">
					寄
				</view>
				<view class="content">
					<view class="title">
						寄件城市
					</view>
					<view class="sub-title">
						<uni-data-picker class="data-picker" :localdata="items" placeholder="请选择寄件城市"
							popup-title="请选择地区" v-model="fromCity">
						</uni-data-picker>
					</view>
				</view>
			</view>
			<view class="reciver">
				<view class="title-icon">
					收
				</view>
				<view class="content">
					<view class="title">
						收件城市
					</view>
					<view class="sub-title" v-model="toCity">
						<uni-data-picker class="data-picker" :localdata="items" placeholder="请选择收件城市"
							popup-title="请选择地区" v-model="toCity">
						</uni-data-picker>
					</view>
				</view>
			</view>
		</view>
		<view class="weight-info">
			<view class="weight-left">
				<image src="/static/search/weight.png"></image>
				<view class="weight-left-text">
					预估重量(KG)
				</view>
			</view>
			<view class="weight-right">
				<uniNumberBox :min="1" v-model="weight"></uniNumberBox>
			</view>
		</view>

		<view class="price">
			<view class="price-left">
				<view class="price-left-top">
					<view class="price-left-text">
						预估运费
					</view>
					<view class="price-number">
						￥{{finalPrice}}
					</view>
				</view>
				<view class="price-left-bottom">
					最终费用以快递员核实为准
				</view>
			</view>
			<view class="price-right" @click="renewPage">
				查询
			</view>
		</view>
	</view>
</template>

<script>
	import uniDataPicker from '@/uni_modules/uni-data-picker/components/uni-data-picker/keypress.js';
	import address from '@/common/pickerregion.js'
	import uniNumberBox from '@/components/uni_asset/uni-number-box/uni-number-box.vue'
	export default {
		data() {
			return {
				items: [],
				fromCity: '',
				toCity: '',
				weight: 1,
				// 跨省加10块
				locationPrice: 0,
				finalPrice: 0,
			}
		},
		methods: {
			weightChange(e) {
				console.log(e.detail)
				this.weight = e.detail.value;
			},
			renewPage() {

			}
		},
		components: {
			uniNumberBox
		},
		watch: {
			weight(oldvalue, newvalue) {
				this.finalPrice = this.locationPrice + oldvalue * 2
			},
			fromCity(oldvalue, newvalue) {
				if (oldvalue.slice(0, 2) != this.toCity.slice(0, 2)) {
					this.locationPrice = 10;
				} else {
					this.locationPrice = 0;
				}
				this.finalPrice = this.locationPrice + this.weight * 2;
			},
			toCity(oldvalue) {
				if (oldvalue.slice(0, 2) != this.fromCity.slice(0, 2)) {
					this.locationPrice = 10;
				} else {
					this.locationPrice = 0;
				}
				this.finalPrice = this.locationPrice + this.weight * 2;
			}
		},
		onLoad() {
			this.items = address
		}
	}
</script>

<style lang="scss" scpoed>
	.price-query {
		padding: 30rpx 50rpx;

		.place-info {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: space-around;
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
					width: 500rpx;
					display: flex;
					flex-direction: column;
					align-items: flex-start;
					justify-content: space-around;

					.title {
						font-weight: bold;
						padding-left: 20rpx;
					}

					.sub-title {
						height: 40rpx;
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

		.weight-info {
			height: 100rpx;
			display: flex;
			align-items: center;
			justify-content: space-between;
			background-color: #fff;
			padding: 0 36rpx;
			margin-top: 40rpx;
			border-radius: 20rpx;
			font-size: 32rpx;

			.weight-left {
				display: flex;
				align-items: center;

				image {
					width: 50rpx;
					height: 50rpx;
					margin-right: 20rpx;
				}
			}

			// .weight-left {
			// 	display: inline-block;
			// 	margin-left: 30rpx;

			// 	.weight-left-text {
			// 		float: right;
			// 		margin-top: 5rpx;
			// 		margin-left: 20rpx;
			// 	}
			// }

			// .weight-right {
			// 	float: right;

			// 	.weight-select {
			// 		margin-right: 20rpx;
			// 	}
			// }
		}

		.price {
			position: fixed;
			bottom: 0;
			left: 0;
			height: 150rpx;
			width: 100%;
			background-color: #fff;
			padding: 20rpx 50rpx;
			display: flex;
			align-items: center;
			justify-content: space-between;
			font-size: 32rpx;

			.price-left {
				.price-left-top {
					display: flex;
					align-items: center;
					margin-bottom: 10rpx;

					.price-number {
						margin-left: 20rpx;
						color: #5ea55c;
						font-weight: bold;
					}
				}

				.price-left-bottom {
					color: #888;
					font-size: 28rpx;
				}
			}
			.price-right{
				background: linear-gradient(to right, #aad540, #5ea55c);
				color: #fff;
				width: 150rpx;
				height: 70rpx;
				line-height: 70rpx;
				text-align: center;
				border-radius: 20rpx;
			}
		}
	}
</style>
