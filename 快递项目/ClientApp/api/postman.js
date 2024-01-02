import http from '@/common/uni.interface.js';

// 查询kdy
export function getPostman(userName) {
  return http.get(
    `/system/postman/userName/`+userName
  )
}

// 查询kdy列表
export function postmanList(params) {
  return http.get(
    '/system/postman/list',params
  )
}

// 查询kdy列表
export function getPostmanById(userId) {
  return http.get(
    `/system/postman/`+userId
  )
}