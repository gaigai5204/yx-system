import setting from "./config.js";

const install = (Vue, vm) => {
	// 初始化请求配置
	
	uni.$u.http.setConfig((config)=>{
		// 域名设置
		config.baseURL = setting.IS_DEV ? setting.DEV_URL : setting.PRO_URL;
		config.header={
			'Content-Type':'application/json;charset=UTF-8',
			'Content-Type':'application/x-www-form-urlencoded'
		};
		// 设置为json，返回后会对数据进行一次JSON.parse()
		config.dataType = 'json';
		config.responseType = 'text';
		// 注：如果局部custom与全局custom有同名属性，则后面的属性会覆盖前面的属性，相当于Object.assign(全局，局部)
		config.custom = {
			// 请求接口展示Loading
			ShowLoading: true,
			// Loading中是否遮罩
			LoadingMask: true,
			// Loading文本
			LoadingText:setting.LOADING_TEXT,
		}; // 全局自定义参数默认值
		// #ifdef H5 || APP-PLUS || MP-ALIPAY || MP-WEIXIN
		config.timeout = setting.TIMEOUT;
		// #endif
		// #ifdef APP-PLUS
		// 验证 ssl 证书 仅5+App安卓端支持（HBuilderX 2.3.3+）
		config.sslVerify = true;
		// #endif
		// #ifdef H5
		// 跨域请求时是否携带凭证（cookies）仅H5支持（HBuilderX 2.6.15+）
		config.withCredentials = false;
		// #endif
		// #ifdef APP-PLUS
		// DNS解析时优先使用ipv4 仅 App-Android 支持 (HBuilderX 2.8.0+)
		config.firstIpv4 = false; 
		// #endif
		// 全局自定义验证器。参数为statusCode 且必存在，不用判断空情况。
		config.validateStatus = (statusCode) => { // statusCode 必存在。此处示例为全局默认配置
			return statusCode >= 200 && statusCode < 300
		};
		return config;
	});

	// 请求拦截部分，如配置，每次请求前都会执行
	uni.$u.http.interceptors.request.use((config) => {
		 console.log('uveiw')
		 if(config.custom.ShowLoading){
		 	uni.showLoading({
		 	    title: config.custom.LoadingText || '正在加载',
		 		mask: config.custom.LoadingMask || false
		 	});
		 }
		config.data = config.data || {}
		
		let _token =uni.getStorageSync('token') || ''
		
		if(_token!=''&&_token!=undefined){
			config.data['token'] = _token
		}
		config.data['timestamp'] = Math.round(new Date() / 1000);//时间戳;
		// 引用token
		// 方式一，存放在vuex的token，假设使用了uView封装的vuex方式
		// 见：https://uviewui.com/components/globalVariable.html
		// config.header.token = vm.token;

		// 方式二，如果没有使用uView封装的vuex方法，那么需要使用$store.state获取
		// config.header.token = vm.$store.state.token;

		// 方式三，如果token放在了globalData，通过getApp().globalData获取
		// config.header.token = getApp().globalData.username;

		// 方式四，如果token放在了Storage本地存储中，拦截是每次请求都执行的
		// 所以哪怕您重新登录修改了Storage，下一次的请求将会是最新值
		// const token = uni.getStorageSync('token');
		// config.header.token = token;
		//config.header.Token = 'xxxxxx';

		// 可以对某个url进行特别处理，此url参数为this.$u.get(url)中的url值
		//if (config.url == '/user/login') config.header.noToken = true;
		
		//是否开启请求日志
		if(setting.REQUEST_LOG){
			_reqlog(config)
		}
		// 最后需要将config进行return
		return config;
		
	},config=>{
		uni.hideLoading();
		if(setting.CATCH_MESS){
			vm.$u.toast("请求时异常");
		}
		return Promise.reject(config)
	})

	// 响应拦截，如配置，每次请求结束都会执行本方法
	uni.$u.http.interceptors.response.use((res) => {
		if(res.config.custom.ShowLoading){
			uni.hideLoading();
		}
		//响应日志
		if(setting.REQUEST_LOG){
			_reslog(res)
		}
		// if 状态码是否正常
		if (res.statusCode == 200) {
			let result = res.data;
			// if 与后台规定code代码进行处理数据返回
			if (result.code == 1) {//后台约定code1为请求成功
				return result.data;
			} else if (result.code == 2) {//后台约定code2为用户被锁定
				vm.$u.toast(result.msg);
				setTimeout(function() {
					uni.navigateTo({
						url:'/pages/login/login'
					})
				}, 1000);
			} else {
				vm.$u.toast(result.msg);
			}
		} else {
			vm.$u.toast(res.statusCode);
		}
		return false;
	},(response) => {
		uni.hideLoading();
		
		if(setting.CATCH_MESS){
			vm.$u.toast("响应时异常！");
		}
		vm.$u.toast(response.data.msg);
		return Promise.reject(response)
		
	});
}
//请求日志
function _reqlog(req) {
	console.log("请求地址："+req.baseURL+req.url)
	console.log("请求参数："+JSON.stringify(req.data))
}
//响应日志
function _reslog(res) {
	 console.log("响应结果：" + JSON.stringify(res))
}
export default {
	install
}
