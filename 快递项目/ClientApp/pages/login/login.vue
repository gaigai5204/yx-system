<template>
	<view class="login">
		<view class="title" v-show="type">欢迎登录</view>
		<view class="title_zhuce" v-show="!type">欢迎注册</view>
		  <div class="tab-switch">
			<div class="btn-bg" :class="{bg:type === true}" @click="changeBg(3)">立即登录</div>
			<div class="btn-bg" :class="{bg:type === false}" @click="changeBg(4)">立即注册</div> 
		  </div>
		<view style="height: 120rpx;"></view>
		<view class="login-form" v-show="type">
			<input type="text" placeholder="请输入用户名" v-model="loginForm.username">
			<input type="password" placeholder="请输入密码" v-model="loginForm.password">
			<input type="text" style="width: 66%;float: left;" v-model="loginForm.code" placeholder="请输入验证码" />
			<img :src="codeUrl" @click="getCode" class="login-code-img" />
		</view>
		<view class="login-form" v-show="!type">
			<input type="text" placeholder="请输入用户名" v-model="registerForm.username">
			<input type="password" placeholder="请输入密码" v-model="registerForm.password">
			<input type="password" placeholder="请再次输入密码" v-model="registerForm.confirmPassword">
			<input type="text" placeholder="请输入手机号" v-model="registerForm.phonenumber">
			<input type="text" style="width: 66%;float: left;" v-model="registerForm.code" placeholder="请输入验证码" />
			<img :src="codeUrl" @click="getCode" class="login-code-img" />
		</view>
		
		<view class="privacy-terms" style="float: left;">
			<radio-group @change="checkTermsAccepted">
				<label>
					<radio :checked="termsAccepted" color="#aad540"></radio>
				</label>
			</radio-group>
			<text>我已阅读并接受</text>
			<text class="highlight">《用户协议及隐私政策》</text>
		</view>
		<view class="login-btn" style="float: left;" @click="handleLogin()" v-show="type">
			登 录
		</view>
		<view class="login-btn" style="float: left;" @click="handleRegister()" v-show="!type">
			注 册
		</view>
	</view>
</template>

<script>
	import {
		partyLogin,
		getCodeImg,
		login
	} from "@/api/login.js"
	import {
		postmanRegister,
		partyRegister
	} from "@/api/register.js"
	import {
		listNotice,
		postmanList,
		getPostman
	} from "@/api/postman.js"
	import {
		partyList,
		getParty
	} from "@/api/party.js"

	import Cookies from "js-cookie";
	import app from "@/App.vue"
	export default {
		data() {
			return {
				userName: "",
				password: "",
				userPhone: "",
				termsAccepted: false,
				codeUrl: "",
				type: true,
				loginForm: {
					username: "",
					password: "",
					rememberMe: false,
					code: "4456",
					uuid: "234"
				},
				adminForm: {
					username: "admin",
					password: "admin123",
					code: "4456",
					uuid: "234"
				},
				registerForm: {
					username: "",
					password: "",
					confirmPassword: "",
					phonenumber: "",
					code: "",
					uuid: ""
				},
				queryParams: {
					pageNum: 1,
					pageSize: 10,
					userName: undefined,
					phonenumber: undefined,
					status: undefined,
					deptId: undefined
				},
				loginRules: {
					username: [{
						required: true,
						trigger: "blur",
						message: "请输入您的账号"
					}],
					password: [{
						required: true,
						trigger: "blur",
						message: "请输入您的密码"
					}],
					code: [{
						required: true,
						trigger: "change",
						message: "请输入验证码"
					}]
				},
				loading: false,
				// 验证码开关
				captchaEnabled: true,
				// 注册开关
				register: false,
				redirect: undefined
			}
		},
		onLoad() {
			this.getCode();
			this.getCookie();
		},
		methods: {
			changeBg(index) {
			  if(index=='3') {
			    this.type=true  
			  }
			  if(index=='4') {
			    this.type=false
			  }
			},
			checkTermsAccepted() {
				this.termsAccepted = true
			},
			checkLogin() {
				console.log(this.loginForm)
				if (this.loginForm.username == "") {
					uni.showToast({
						icon: 'error',
						title: "请输入用户名"
					})
					return false
				} else if (this.loginForm.password == "") {
					uni.showToast({
						icon: 'error',
						title: "请输入密码"
					})
					return false
				} else if (this.loginForm.password.length > 0 && this.loginForm.password.length < 6) {
					uni.showToast({
						icon: 'error',
						title: "密码至少为6位",
						success: () => {
							this.loginForm.password = ""
						}
					})
					return false
				} else if (this.loginForm.code == "") {
					uni.showToast({
						icon: 'error',
						title: "请输入验证码"
					})
					return false
				} else if (!this.termsAccepted) {
					uni.showToast({
						icon: 'error',
						title: "请阅读《用户协议及隐私政策》"
					})
					return false
				}
				return true
			},
			checkRegister() {
				console.log(this.registerForm)
				if (this.registerForm.username == "") {
					uni.showToast({
						icon: 'error',
						title: "请输入用户名"
					})
					return false
				} else if (this.registerForm.password == "") {
					uni.showToast({
						icon: 'error',
						title: "请输入密码"
					})
					return false
				} else if (this.registerForm.password.length > 0 && this.registerForm.password.length < 6) {
					uni.showToast({
						icon: 'error',
						title: "密码至少为6位",
						success: () => {
							this.registerForm.password = ""
						}
					})
					return false
				} else if (this.registerForm.password != this.registerForm.confirmPassword) {
					uni.showToast({
						icon: 'error',
						title: "确认密码不一致"
					})
					return false
				} else if (this.registerForm.code == "") {
					uni.showToast({
						icon: 'error',
						title: "请输入验证码"
					})
					return false
				} else if (!this.termsAccepted) {
					uni.showToast({
						icon: 'error',
						title: "请阅读《用户协议及隐私政策》"
					})
					return false
				}
				return true
			},
			getCode() {
				getCodeImg().then(res => {
					this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
					if (this.captchaEnabled) {
						this.codeUrl = "data:image/gif;base64," + res.img;
						this.loginForm.uuid = res.uuid;
						this.adminForm.uuid = res.uuid;
						this.registerForm.uuid = res.uuid;
					}
				});
			},
			getCookie() {
				const username = Cookies.get("username");
				const password = Cookies.get("password");
				const rememberMe = Cookies.get('rememberMe')
				this.loginForm = {
					username: username === undefined ? this.loginForm.username : username,
					password: password === undefined ? this.loginForm.password : decrypt(password),
					rememberMe: rememberMe === undefined ? false : Boolean(rememberMe),
					code: ""
				};
			},
			handleLogin() {
				let checkPass = this.checkLogin()

				if (checkPass) {
					this.adminForm.code = this.loginForm.code;
					console.log(this.loginForm)
					login(this.adminForm).then(res => {
						uni.setStorageSync('token', res.token);
					})
					partyLogin(this.loginForm).then(res => {
						if (res.code == 200) {
							app.globalData.username = this.loginForm.username
							getParty(app.globalData.username).then(res => {
								app.globalData.phone = res.data.phonenumber
								app.globalData.userId = res.data.partyId
								app.globalData.nickName = res.data.nickName
								console.log(app.globalData.nickName)
								uni.switchTab({
									url: "/pages/personal/personal"
								})
							});
						} else if (res.code == 500) {
							uni.showToast({
								title: '账号/密码错误',
								icon: 'none'
							});
						}
					});
				}
			},
			handleRegister() {
				let checkPass = this.checkRegister()
				if(checkPass){
					partyRegister(this.registerForm).then(res => {
						console.log(res)
						if (res.code == 200) {
							uni.showToast({
								title: "注册成功,请去登录!",
								icon: 'none'
							});
						} else {
							uni.showToast({
								title: res.msg,
								icon: 'none'
							});
						}
					})					
				}

			}
		}
	}
</script>

<style lang="scss" scoped>
	.login {
		padding: 50rpx;
			.title {
				text-align: left;
				font-size: 60rpx;
				font-weight: 500;
				margin-bottom: 80rpx;
			}
			.title_zhuce {
				text-align: left;
				font-size: 60rpx;
				font-weight: 500;
				margin-bottom: 50rpx;
			}
		.login-form {
			input {
				background-color: #fff;
				height: 80rpx;
				border-radius: 20rpx;
				margin-bottom: 40rpx;
				padding-left: 30rpx;
			}
		}

		.privacy-terms {
			display: flex;
			align-items: center;
			font-size: 28rpx;
			margin-bottom: 50rpx;

			.highlight {
				background-image: -webkit-linear-gradient(left, #aad540, #5ea55c);
				-webkit-background-clip: text;
				-webkit-text-fill-color: transparent;
			}
		}

		.login-btn {
			height: 80rpx;
			line-height: 80rpx;
			border-radius: 40rpx;
			width: 100%;
			background: linear-gradient(to right, #aad540, #5ea55c);
			color: #fff;
			text-align: center;
		}
	}

	.login-code-img {
		height: 70rpx;
		margin-left: 30rpx;
	}
	
		  .tab-switch {
		  
		    height: 100rpx;
		    font-size: 30rpx;
		
		    border-bottom: 6rpx solid rgba(209, 206, 206, 0.664);
		    margin-bottom: 5rpx;
		    width: 100%;
		    float: left;
		     
		    height: 80rpx;
		  }
		  .btn-bg {
		    float:left;
		    color: rgb(146, 148, 150);
		 
		    text-align: center;
		    line-height: 71rpx;
		    margin-left: 0rpx;
		    margin-right: 20rpx;
		    margin-top: 5rpx;
		    width: 160rpx;
		    height: 33rpx;
		    margin-bottom: 10rpx;
		  }
		  .bg {
		    color:black;
		        
		  }
		  .bg::after {
		    width: 102%;
		    content: '';
		    display: block;
		    border-bottom: 6rpx solid #61d522;
		    padding: 0px;
		  }
</style>
