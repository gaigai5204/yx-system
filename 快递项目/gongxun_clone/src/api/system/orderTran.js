import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询订单轨迹
export function getOrderTran(orderNumber) {
    return request({
      url: '/system/tran/' + parseStrEmpty(orderNumber),
      method: 'get'
    })
  }

// 修改订单轨迹
export function updateOrderTran(data) {
    return request({
      url: '/system/tran',
      method: 'put',
      data: data
    })
  }

  // 新增订单轨迹
export function insertTran(data) {
    return request({
      url: '/system/tran',
      method: 'post',
      data: data
    })
  }
  