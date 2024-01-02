<template>
	<view class="comment">
		<view class="comment-postman">
			<view class="title">
				<view class="avatar">
					<image src="/static/search/avatar.png" mode=""></image>
				</view>
				<view class="postman-name">
					赵子龙
					<text class="name-decoration">投递</text>
				</view>
			</view>
			<view class="score">
				<view class="score-text">您对该快递员的投递服务是否满意？</view>
				<uniDataCheckbox class="uniDataCheckbox" v-model="radio1" :localdata="score" selectedColor="#5ea55c"
					:wrap="isWrap">
				</uniDataCheckbox>
			</view>
		</view>
		<view class="comment-order">
			<view class="title">
				<view class="avatar">
					<image src="/static/search/avatar.png" mode=""></image>
				</view>
				<view class="postman-name">
					东风快递
				</view>
			</view>
			<view class="score">
				<view class="score-text">您对该单快递的整体业务（价格、包装、时效等）是否满意？</view>
				<uniDataCheckbox class="uniDataCheckbox" v-model="radio2" :localdata="score" selectedColor="#5ea55c"
					:wrap="isWrap">
				</uniDataCheckbox>
			</view>

		</view>
		<view class="submit" v-show="radio1&&radio2" @tap="submitComment">
			提交评价
		</view>
	</view>
</template>

<script>
	import uniDataCheckbox from '@/components/uni_asset/uni-data-checkbox/components/uni-data-checkbox/uni-data-checkbox.vue'
	export default {
		data() {
			return {
				score: [{
						text: "较差",
						value: 1
					},
					{
						text: "一般",
						value: 2
					}, {
						text: "满意",
						value: 3
					}
				],
				radio1: null,
				radio2: null,
				isWrap: false
			};
		},
		methods: {
			submitComment() {
				uni.showToast({
					icon: 'success',
					title: "提交成功",
				})
				setTimeout(() => {
					uni.navigateBack(-1)
				}, 1000)
			}
		},
		components: {
			uniDataCheckbox
		}
	}
</script>

<style lang="scss" scoped>
	.comment {
		font-size: 32rpx;
		padding: 30rpx;

		.comment-postman,
		.comment-order {
			display: flex;
			flex-direction: column;
			background-color: #fff;
			border-radius: 20rpx;
			padding: 30rpx;
			margin-bottom: 40rpx;
			text-align: center;

			.title,
			.score {
				display: flex;
				flex-direction: column;
				align-items: center;

				.avatar image {
					width: 80rpx;
					height: 80rpx;
					border-radius: 50%;
					border: 1px solid #ddd;
				}

				.name-decoration {
					background-color: #aad540;
					color: #3f703e;
					padding: 4rpx 12rpx;
					border-radius: 10rpx;
					font-size: 28rpx;
					margin-left: 20rpx;
				}

				.score-text {
					margin-bottom: 20rpx;
					font-weight: bold;
				}
			}

			.title {
				border-bottom: 1px solid #eee;
				padding-bottom: 30rpx;
				margin-bottom: 30rpx;
			}
		}

		.submit {
			width: 300rpx;
			height: 80rpx;
			line-height: 80rpx;
			background-color: #aad540;
			color: #3f703e;
			border-radius: 20rpx;
			text-align: center;
			margin: 0 auto;
		}
	}
</style>
