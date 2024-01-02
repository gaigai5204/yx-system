<template>
	<view class="info-form">
		<input type="text" placeholder="姓名" v-model="infoForm.addrName">
		<input type="tel" placeholder="手机" v-model="infoForm.addrPhone">
		<UniDataPicker class="UniDataPicker" :localdata="localdata" placeholder="省市区" @change="bindPickerChange" v-model="infoForm.place">
		</UniDataPicker>
		<input type="text" placeholder="详细地址" v-model="infoForm.justDetail">
		<!-- <input type="text" placeholder="公司名称(选填)" v-model="infoForm.companyName"> -->
		<text class="clear-info" @tap="clearInfo">
			清空当前信息
		</text>
	</view>
</template>

<script>
	import UniDataPicker from '@/components/uni_asset/uni-data-picker/components/uni-data-picker/uni-data-picker.vue'
	import address from '@/common/pickerregion.js'
	export default {
		data() {
			return {

				allowSave: false,
				localdata: [],
			}
		},
		props: {
			infoForm: Object,
		},
		watch: {
			infoForm: {
				handler(newv, oldv) {
					let res = true
					this.infoForm.addrDetail=newv["place"]+newv["justDetail"]
					for (let attr in newv) {
						if (attr == 'companyName') {
							continue
						}
						if (attr == 'place') {
							continue
						}
						if (!newv[attr]) {
							res = false
						}
					}
					this.allowSave = res
					this.$emit("sendToParent", this.allowSave);
				},
				deep: true
			}
		},
		methods: {
			clearInfo() {
				for (let attr in this.infoForm) {
					this.infoForm[attr] = ""
				}
			},
			bindPickerChange(val) {
				let area = val.detail.value
				this.infoForm.place = area[0].text+area[1].text+area[2].text;
			}

		},

		components: {
			UniDataPicker
		},
		mounted(){
			this.localdata = address
		}
	}
</script>

<style lang="scss" scoped>
	.info-form {
		border-radius: 14rpx;
		padding: 10rpx 20rpx;
		height: 700rpx;
		margin-bottom: 100rpx;

		input {
			border: 2rpx solid #e5e5e5;
			margin: 35rpx 0;
			height: 70rpx;
			border-radius: 14rpx;
			padding-left: 20rpx;
			font-size: 24rpx;
			background-color: #fff;
		}

		.UniDataPicker {
			font-size: 24rpx !important;
			border-radius: 14rpx;
			background-color: #fff;
			height: 70rpx;
			line-height: 70rpx;
			border: 2rpx solid #e5e5e5;
		}

		.clear-info {
			background-image: -webkit-linear-gradient(left, #aad540, #5ea55c);
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
			font-size: 30rpx;
			font-weight: bold;
		}
	}
</style>
