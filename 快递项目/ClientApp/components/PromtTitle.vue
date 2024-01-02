<template>
	<view class="prompt-title">
		<view class="title">
			{{title}}
		</view>
		<view class="subTitle">
			{{subTitle}}
		</view>
	</view>
</template>

<script>
	export default {
		props: {
			title: String,
			subTitle: String
		}
	}
</script>

<style lang="scss" scoped>
	.prompt-title {
		margin: 30rpx 0;
		display: flex;
		align-items: center;

		.title {
			font-size: 36rpx;
			font-weight: bold;
			margin-right: 20rpx;
		}

		.subTitle {
			font-size: 28rpx;
			color: #bbb;
		}
	}
</style>
