<template>
	<view class="sender-reciver-info">
		<PromtTitle title="编辑寄件人信息" subTitle="Edit Sender" v-if="role=='sender'"></PromtTitle>
		<PromtTitle title="编辑收件人信息" subTitle="Edit Reciver" v-if="role=='reciver'"></PromtTitle>
		<InfoFormComponent :infoForm="infoForm" @sendToParent="getChildEvent"></InfoFormComponent>
		<view class="bottom-bar">
			<view :class="allowSave == true ? 'save-active' : 'save'" @tap="saveInfo">
				保存
			</view>
		</view>
	</view>
</template>

<script>
	import PromtTitle from '@/components/PromtTitle.vue'
	import InfoFormComponent from '@/components/InfoForm.vue'
	import {listAddr,addAddr,editAddr,removeAddr} from "@/api/book.js"
	import app from "@/App.vue";
	export default {
		data() {
			return {
				role: "",
				type:1,//1-寄件.2-收件
				flag:0,//0-新增,1-编辑
				allowSave: false,
				infoForm: {
					addrName: "",
					addrPhone: "",
					addrParty:null,
					place:"",
					justDetail: "",
					addrDetail: ""
				}
			};
		},
		onShow() {
			if(this.infoForm.addrDetail.split("县")[1]!=undefined){
				this.infoForm.justDetail=this.infoForm.addrDetail.split("县")[1]
				this.infoForm.place=this.infoForm.addrDetail.split("县")[0]+'县'				
			}else{
				this.infoForm.justDetail=this.infoForm.addrDetail.split("区")[1]
				this.infoForm.place=this.infoForm.addrDetail.split("区")[0]+'区'				
			}

			console.log(this.infoForm)
		},
		methods: {
			cutPlace(str){
				this.infoForm.place=str.split("县")[0]+'县'
			},
			saveInfo() {
				if (this.allowSave) {
					if (this.infoForm.addrPhone.length != 11) {
						uni.showToast({
							title: "手机号错误",
							icon: "error"
						})
					} else {
						let self=this
						if(this.flag==0){
							addAddr(this.infoForm).then(res=>{
							console.log(res);
							uni.showToast({
								title: "地址簿新增成功",
								icon: "success"
							})
		
							uni.navigateTo({
								url: "/pages/sendMailDetail/sendMailDetail?type="+self.type+ '&infoForm=' +JSON.stringify(self.infoForm)
							})
						  })
						}else{
							editAddr(this.infoForm).then(res=>{
							console.log(res);
							uni.showToast({
								title: "地址簿修改成功",
								icon: "success"
							})
				
							uni.navigateTo({
								url: "/pages/sendMailDetail/sendMailDetail?type="+self.type+ '&infoForm=' +JSON.stringify(self.infoForm)
							})
						  })							
						}
						

						console.log(this.infoForm)
					}
				}
			},
			getChildEvent(val) {
				this.allowSave = val
			},
		},
		onLoad(e) {
			
			this.infoForm.addrParty=app.globalData.userId
			this.role = e.role

			try {
				if (this.existInfo.name) {
					this.infoForm = this.existInfo
				}
			} catch (e) {
				//TODO handle the exception
			}

			// 接收数据
			const eventChannel = this.getOpenerEventChannel();
			eventChannel.on('acceptAddressData', (data) => {
				console.log(data.data)
				this.infoForm = data.data
			})
			
			if(e.addrId!=undefined){
				this.infoForm.addrId=e.addrId
				this.flag=1
			}
			
			if(e.type){
				this.type=e.type
			}

		},
		components: {
			PromtTitle,
			InfoFormComponent
		},
	}
</script>

<style lang="scss" scoped>
	.sender-reciver-info {
		padding: 10rpx 50rpx;

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

		.bottom-bar {
			position: fixed;
			bottom: 0;
			left: 0;
			height: 120rpx;
			line-height: 120rpx;
			width: 100%;
			background-color: #fff;
			display: flex;
			justify-content: center;
			align-items: center;
			font-size: 34rpx;
			padding: 0 50rpx;

			.save {
				width: 300rpx;
				height: 70rpx;
				line-height: 70rpx;
				text-align: center;
				color: #fff;
				border-radius: 40rpx;
				background-color: #ccc;
			}

			.save-active {
				width: 300rpx;
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
