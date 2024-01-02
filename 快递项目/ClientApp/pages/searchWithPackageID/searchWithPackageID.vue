<template>
	<view class="search-with-packageid">
		<view class="search-top">
			<input type="number" placeholder="请输入运单号" v-model="packageid" auto-focus="true">
			<view class="confirm" v-if="packageid" @tap="confirm">
				确定
			</view>
			<view class="cancel" v-else @tap="cancel">
				取消
			</view>
		</view>
		<view class="search-history">
			<view class="search-history-title">
				<view class="name">
					查询历史
				</view>
				<view class="clear" @tap="clearHistory">
					清空
				</view>
			</view>
			<view class="search-history-content">
				<view class="search-history-item" v-for="(item,index) in idList" :key="index" @tap="gotoDetail(item)">
					{{item}}
				</view>
				<view class="none-note" v-if="idList.length==0">
					暂无历史搜索记录
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				packageid: "",
				idList: []
			};
		},
		created() {
			this.keydown()
		},
		methods: {
			confirm() {
				let idx = this.idList.indexOf(this.packageid)
				if (idx !== -1) {
					this.idList.splice(idx, 1)
				}
				this.idList.unshift(this.packageid)
				this.gotoDetail(this.packageid)
				this.packageid = ""
			},
			cancel() {
				uni.navigateBack(-1)
			},
			clearHistory() {
				if (this.idList.length > 0) {
					uni.showModal({
						content: "确定要清空历史记录吗",
						success: () => {
							this.idList = []
						}
					})
				}
			},
			gotoDetail(packageid) {
				uni.navigateTo({
					url: `/pages/packageDetail/packageDetail?packageid=${packageid}`
				})
			},
			keydown() {
				document.onkeydown = (e) => {
					if (e.keyCode === 13 && this.packageid !== "") {
						this.confirm()
					}
				}
			}
		}
	}
</script>

<style lang="scss" scoped>
	.search-with-packageid {
		padding: 20rpx 30rpx;

		.search-top {
			display: flex;
			align-items: center;
			justify-content: space-between;

			input {
				background-color: #fff;
				width: 580rpx;
				height: 70rpx;
				border-radius: 50rpx;
				padding: 0 30rpx;
				margin-right: 30rpx;
			}

			.cancel {
				color: #ccc;
				font-size: 32rpx;
			}

			.confirm {
				font-size: 32rpx;
			}
		}

		.search-history {
			padding-top: 30rpx;
			font-size: 32rpx;

			.search-history-title {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.name {
					font-weight: bold;
				}

				.clear {
					font-size: 30rpx;
					color: #ccc;
				}
			}

			.search-history-content {
				display: flex;
				flex-wrap: wrap;

				.search-history-item {
					background-color: #aad540;
					color: #5ea55c;
					margin: 20rpx;
					padding: 10rpx;
					border-radius: 20rpx;
				}

				.none-note {
					text-align: center;
					color: #ccc;
					margin: 40rpx auto;
				}
			}
		}
	}
</style>
