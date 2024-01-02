//如果用uni请求
import http from '@/common/uni.interface.js';


// 登录方法
export function partyLogin(data) {
  return http.post('/partyLogin',data)
}

// 获取验证码
export function getCodeImg() {
  return http.get(
    '/captchaImage'
  )
}

// 登录方法
export function login(data) {
  return http.post('/login',data)
}