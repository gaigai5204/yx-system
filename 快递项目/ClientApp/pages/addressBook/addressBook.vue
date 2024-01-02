<template>
	<view class="address-book">
		<view class="address-book-item" v-for="(item,index) in addressBookList" :key="index">
			<view>
				<view class="title" @click="seclectAddr(index)">
					<view class="name">
						{{item.addrName}}
					</view>
					<view class="phone">
						{{item.addrPhone}}
					</view>
				</view>
				<view class="address" @click="seclectAddr(index)">
					{{item.addrDetail}}
				</view>
				<view class="manipulate">
					<view class="set-default">
						<radio-group @change="checkTermsAccepted">
							<label>
								<radio color="#aad540"></radio>
							</label>
						</radio-group>
						<text>设为默认地址</text>
					</view>
					<view class="edit-delete">
						<view class="edit" @tap="editAddress(index,item.addrId)">
							<image src="/static/common/edit.png"></image>
							<text>编辑</text>
						</view>
						<view class="delete" @tap="deleteAddress(index,item.addrId)">
							<image src="/static/common/delete.png"></image>
							<text>删除</text>
						</view>
					</view>
				</view>				
			</view>

		</view>
		<view class="bottom-bar">
			<view class="save" @tap="addNewAddress">
				新增地址
			</view>
		</view>
	</view>
</template>

<script>
	import { listOrder,updateOrder} from "@/api/order";
	import {listAddr,addAddr,removeAddr} from "@/api/book.js"
	import app from "@/App.vue";
	export default {
		data() {
			return {
				termsAccepted: false,
				infoForm: {
					addrName: "",
					addrPhone: "",
					addrParty:null,
					place:"",
					addrDetail: ""
				},
				type:1,
				addressBookList: [{
						addrName: "小明",
						addrPhone: "13107618121",
						addrDetail: "福建省福州市闽侯县上街镇福州大学"
					}
				]
			};
		},
		onShow() {
			listAddr(app.globalData.userId).then(res => {
				console.log(res)
			    this.addressBookList = res.rows;
			  
			})	
		},
		onLoad(e) {
			if(e.type){
				this.type=e.type
			}
		},
		methods: {
			addNewAddress() {
				uni.navigateTo({
					url: "/pages/senderOrReciverInfo/senderOrReciverInfo"
				})
			},
			checkTermsAccepted() {
				this.termsAccepted = true
			},
			deleteAddress(index,addrId) {
				uni.showModal({
					content: "确定要删除该地址吗？",
					confirmColor: "#5ea55c",
					success: (res) => {
						if (res.confirm) {
							this.addressBookList.splice(index, 1)
							let addrList=[]
							addrList.push(addrId)
							console.log(addrList)
							removeAddr(addrList).then(res => {
								console.log(res)						  
							})
						}
					},
				})
			},
			editAddress(index,addrId) {
				uni.navigateTo({
					url: "/pages/senderOrReciverInfo/senderOrReciverInfo?addrId="+addrId,
					success: (res) => {
						// 通过eventChannel向被打开页面传送数据
						res.eventChannel.emit('acceptAddressData', {
							data: this.addressBookList[index]
						})
					}
				})
			},
			seclectAddr(index){
				let self=this
				this.infoForm.addrName=this.addressBookList[index].addrName
				this.infoForm.addrPhone=this.addressBookList[index].addrPhone
				this.infoForm.addrDetail=this.addressBookList[index].addrDetail
			
				uni.navigateTo({
					url: "/pages/sendMailDetail/sendMailDetail?type="+self.type+ '&infoForm=' +JSON.stringify(self.infoForm)
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

				.name {
					margin-right: 30rpx;
				}
			}

			.address {
				color: #ccc;
				font-size: 30rpx;
				padding: 20rpx 0;
				border-bottom: 2rpx solid #ddd;
			}

			.manipulate {
				display: flex;
				justify-content: space-between;
				align-items: center;
				margin-top: 20rpx;
				font-size: 30rpx;

				.set-default,
				.edit-delete {
					display: flex;
					align-items: center;

					.edit {
						margin-right: 40rpx;
					}

					.edit,
					.delete {
						display: flex;
						align-items: center;
					}

					image {
						width: 35rpx;
						height: 35rpx;
						margin-right: 6rpx;
					}
				}
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
				background: linear-gradient(to right, #aad540, #5ea55c) !important;
			}
		}
	}
</style>
