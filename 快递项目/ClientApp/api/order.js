import http from '@/common/uni.interface.js';

// 查询订单列表
export function listOrder(params) {
  return http.get(
    '/system/order/list',params
  )
}
// 修改订单
export function updateOrder(data) {
  return http.put(
    '/system/order',data
  )
}

export function getOrder(orderId) {
  return http.get(
    '/system/order/' + orderId)
}

// 新增订单
  export function addOrder(data) {
    return http.post(
      '/system/order',data)
  }
