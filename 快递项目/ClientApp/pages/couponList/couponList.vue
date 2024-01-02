<template>
	<view class="result-box">
		<view class="result-box-topBar">
			<view class="topBar-item" v-for="(item,index) in resultBoxTopBar" :key="index" @tap="changeTab(index)">
				<text :class="topBarIndex===index?'topBar-active-color':''">{{item}}</text>
			</view>
		</view>
		<swiper :current="topBarIndex" @change="onChangeTab" :style="`height: ${clientHeight}px;`">
			<swiper-item>
				<view class="swiper-item">
					<view class="no-coupon">
						<image src="/static/common/lost-coupon.png"></image>
						<view class="title">
							暂无优惠券
						</view>
					</view>
				</view>
			</swiper-item>
			<swiper-item>
				<view class="swiper-item">
					<view class="no-coupon">
						<image src="/static/common/lost-coupon.png"></image>
						<view class="title">
							暂无优惠券
						</view>
					</view>
				</view>
			</swiper-item>
			<swiper-item>
				<view class="swiper-item">
					<view class="no-coupon">
						<image src="/static/common/lost-coupon.png"></image>
						<view class="title">
							暂无优惠券
						</view>
					</view>
				</view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				resultBoxTopBar: ['已领取', '已使用', '已过期'],
				topBarIndex: 0,
				clientHeight: 0
			};
		},
		onReady() {
			uni.getSystemInfo({
				success: (res) => {
					// 获取可视区域高度 windowHeight
					this.clientHeight = res.windowHeight - uni.upx2px(50)
				}
			})
		},
		methods: {
			changeTab(index) {
				console.log(index)
				this.topBarIndex = index
			},
			onChangeTab(e) {
				this.topBarIndex = e.detail.current
			},
		}
	}
</script>

<style lang="scss" scoped>
	.result-box {
		.result-box-topBar {
			display: flex;
			justify-content: space-around;
			font-size: 34rpx;
			background-color: #fff;
			height: 80rpx;
			line-height: 80rpx;

			.topBar-active-color {
				padding-bottom: 14rpx;
				border-bottom: 6rpx solid #5ea55c;
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

			.no-coupon {
				text-align: center;
				color: #bbb;
				font-size: 34rpx;
				margin-top: 100rpx;

				image {
					width: 400rpx;
					height: 400rpx;
				}
			}
		}
	}
</style>
