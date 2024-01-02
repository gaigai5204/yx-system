
//如果用uni请求
import http from '@/common/uni.interface.js';

//如果是用uview请求,就用下面这句
//const http = uni.$u.http


//获取用户信息
export function getUserInfo(params){
	return http.get('api/userinfo', params)
}

//用户登录
export function userLogin(params){
	return http.post('api/login', params)
}

export function listUser(query){
	return http.get('/system/user/list', query)
}


 //更改配置项，阻止loading提示
// export function getUserInfo(params){
// 	return http.post('api/login', {custom:{ShowLoading:false}})
// }
