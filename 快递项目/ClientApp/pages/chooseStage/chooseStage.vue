<template>
	<view class="address-book">
		<view class="address-book-item" v-for="(item,index) in stageList" :key="index">
			<view class="title">
				{{item.name}}
			</view>
			<view class="address">
				{{item.detailPlace}}
			</view>
			<view class="manipulate" @tap="showStagePhone(item.phone)">
				<text>联系网点</text>
				<image src="/static/common/contact.png"></image>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				stageList: [{
						name: "福州大学校内妈妈驿站",
						phone: "13107618121",
						detailPlace: "福建省福州市闽侯县上街镇福州大学",
					}, {
						name: "中国邮政集团有限公司福建省闽侯县福大一区邮政所",
						phone: "13158948121",
						detailPlace: "福建省福州市闽侯县上街镇福州大学",
					},
					{
						name: "闽侯县上街实验学校",
						phone: "13158948121",
						detailPlace: "福建省福州市闽侯县上街镇乌龙江大道3号",
					},
				]
			};
		},
		methods: {
			showStagePhone(phone) {
				uni.showModal({
					content: phone,
					confirmText: "拨打",
					confirmColor: "#5ea55c",
					success: (e) => {
						if (e.confirm) {
							uni.makePhoneCall({
								phoneNumber: phone
							});
						}
					}
				})
			}
		}
	}
</script>

<style lang="scss" scoped>
	.address-book {
		padding: 50rpx 50rpx 120rpx;

		.address-book-item {
			background-color: #fff;
			margin-bottom: 50rpx;
			padding: 30rpx 30rpx 20rpx;
			border-radius: 20rpx;

			.title {
				display: flex;
				align-items: center;
			}

			.address {
				color: #ccc;
				font-size: 28rpx;
				padding: 20rpx 0;
				border-bottom: 2rpx solid #ddd;
			}

			.manipulate {
				display: flex;
				justify-content: center;
				align-items: center;
				margin-top: 20rpx;
				font-size: 30rpx;

				image {
					width: 35rpx;
					height: 35rpx;
					margin-left: 10rpx;
				}
			}
		}
	}
</style>
