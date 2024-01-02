//如果用uni请求
import http from '@/common/uni.interface.js';


// 登录方法
export function postmanRegister(data) {
  return http.post('/postman/register',data)
}


export function partyRegister(data) {
  return http.post('/party/register',data)
}