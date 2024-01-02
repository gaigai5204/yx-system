//如果用uni请求
import http from '@/common/uni.interface.js';

// 修改订单轨迹
export function updateOrderTran(data) {
  return http.put('/system/tran',data)
}


// 查询订单轨迹
export function getOrderTran(orderNumber) {
  return http.get('/system/tran/'+orderNumber)
}

  // 新增订单轨迹
export function insertTran(data) {
  return http.post('/system/tran',data)
}