<template>
	<view class="customer-service">
		<view class="service-img">
			<image src="/static/common/kefu.png"></image>
		</view>
		<view class="service-title">
			在线客服
		</view>
	</view>
</template>

<script>
</script>

<style scoped lang="scss">
	.customer-service {
		font-size: 24rpx;
		background-color: #fff;
		width: 180rpx;
		height: 90rpx;
		border-radius: 40rpx 0 0 40rpx;
		border: 1px solid #f3f3f3;
		box-shadow: 4rpx 4rpx 4rpx #bbb;
		display: flex;
		justify-content: space-around;
		align-items: center;
		position: fixed;
		right: 0;
		bottom: 200rpx;
		padding-left: 14rpx;

		.service-img {
			background-color: #eee;
			border-radius: 50%;
			width: 46rpx;
			height: 46rpx;
			display: flex;
			text-align: center;

			image {
				width: 38rpx;
				height: 38rpx;
				margin: auto;
			}
		}
	}
</style>
