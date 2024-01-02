<template>
	<view>
		<!-- 首页走马灯 -->
		<swiper :autoplay="true" :interval="4000" :duration="1000" :circular="true">
			<swiper-item v-for="(item,index) in sendSwiperImg" :key="index">
				<view class="swiper-item">
					<image :src="item"></image>
				</view>
			</swiper-item>
		</swiper>

		<view class="content">
			<!-- 下单、扫码寄件 -->
			<view class="send-mail">
				<view :class="item.className" v-for="(item,i) in sendMailContent" :key="i" @tap="gotosend(item.title)">
					<view class="title">
						{{item.title}}
					</view>
					<view class="sub-title">
						{{item.subTitle}}
					</view>
					<image :src="item.imgUrl"></image>
				</view>
			</view>

			<!-- 其他功能 -->
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

			<!-- 使用指南 -->
			<view class="prompt">
				<PromtTitle title="使用指南" subTitle="User Guide"></PromtTitle>

				<swiper class="prompt-swiper" :previous-margin="'80rpx'" :next-margin="'80rpx'" :autoplay="true"
					:interval="4000" :duration="1000" :circular="true">
					<swiper-item v-for="(item,index) in promptSwiperConent" :key="index">
						<view class="swiper-item">
							<image :src="item.imgUrl" mode=""></image>
							<view class="news-content">
								<view class="news-title">
									{{item.title}}
								</view>
								<view class="news-subTitle">
									{{item.subTitle}}
								</view>
							</view>
						</view>
					</swiper-item>

				</swiper>
			</view>

			<!-- 在线客服 -->
			<CustomerService></CustomerService>
		</view>
	</view>
</template>

<script>
	import CustomerService from '@/components/CustomerService.vue'
	import PromtTitle from '@/components/PromtTitle.vue'
	export default {
		data() {
			return {
				sendSwiperImg: [
					'/static/sendSwiper/1.png',
					'/static/sendSwiper/2.png',
					'/static/sendSwiper/3.png',
				],
				sendMailContent: [{
						className: "drop-in",
						title: "下单寄件",
						subTitle: "点我上门寄",
						imgUrl: "/static/sendSwiper/dropin.png"
					},
					{
						className: "scan-qr",
						title: "扫码寄件",
						subTitle: "一扫就能寄",
						imgUrl: "/static/sendSwiper/scanqr.png"
					}
				],
				otherFuncItem: [{
						imgUrl: "/static/sendSwiper/piliang.png",
						title: "批量寄件"
					},
					{
						imgUrl: "/static/sendSwiper/dayin.png",
						title: "云打印"
					},
					{
						imgUrl: "/static/sendSwiper/wangdian.png",
						title: "网点查询"
					},
					{
						imgUrl: "/static/sendSwiper/suiji.png",
						title: "专属小哥"
					}
				],
				promptSwiperConent: [{
						imgUrl: "/static/sendSwiper/news1.png",
						title: "秒懂查件攻略",
						subTitle: "召唤客服有几招"
					},
					{
						imgUrl: "/static/sendSwiper/news2.png",
						title: "参与纸箱回收",
						subTitle: "共建美好绿色生活"
					},
					{
						imgUrl: "/static/sendSwiper/news3.png",
						title: "参与盲盒抽奖",
						subTitle: "抽iPhone13 Pro"
					},
					{
						imgUrl: "/static/sendSwiper/news4.png",
						title: "寄国际件",
						subTitle: "大陆寄海外70国"
					},
				]
			}
		},
		onPullDownRefresh() {
			setTimeout(() => {
				uni.stopPullDownRefresh()
			}, 1000)
		},
		methods: {
			gotosend(title) {
				if (title == "下单寄件") {
					uni.navigateTo({
						url: "/pages/sendMailDetail/sendMailDetail"
					})
				} else if (title == "扫码寄件") {
					uni.scanCode({
						onlyFromCamera: true,
						success: function(res) {
							uni.showModal({
								title: "扫描结果",
								content: res.result
							})
						}
					});
				}
			}
		},
		components: {
			CustomerService,
			PromtTitle
		}
	}
</script>

<style scoped lang="scss">
	swiper {
		height: 420rpx;

		.swiper-item image {
			width: 100%;
			height: 420rpx;
		}
	}

	.content {
		font-size: 32rpx;
		padding: 0 50rpx 50rpx;
		position: relative;

		.send-mail {
			position: relative;
			top: -40rpx;
			display: flex;
			justify-content: space-between;

			.drop-in,
			.scan-qr {
				width: 300rpx;
				height: 300rpx;
				border-radius: 20rpx;
				background-color: #fff;
				padding: 26rpx;
				position: relative;
				overflow: hidden;
				border: 1px solid #f3f3f3;
				box-shadow: 3rpx 3rpx 2rpx #ddd;

				.title {
					font-size: 40rpx;
					font-weight: bold;
					margin-bottom: 10rpx;
				}

				.sub-title {
					font-size: 28rpx;
					color: #bbb;
				}

				image {
					width: 210rpx;
					height: 210rpx;
					position: absolute;
					right: -50rpx;
					bottom: -50rpx;
				}
			}
		}

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

		.prompt {
			swiper {
				height: 150rpx;
			}

			.swiper-item {
				background-color: #fff;
				margin: 0 22rpx;
				border-radius: 20rpx;
				height: 150rpx;
				display: flex;
				justify-content: space-around;
				align-items: center;

				image {
					width: 140rpx;
					height: 140rpx;
				}

				.news-content {
					display: flex;
					flex-direction: column;
					justify-content: center;
					text-align: center;

					.news-title {
						font-weight: bold;
						margin-bottom: 14rpx;
						font-size: 32rpx;
					}

					.news-subTitle {
						font-size: 24rpx;
						color: #bbb;
						border: 1px solid #aaa;
						border-radius: 16rpx;
						padding: 10rpx;
					}
				}
			}
		}
	}
</style>
