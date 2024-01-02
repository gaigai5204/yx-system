import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询订单列表
export function listOrder(query) {
  return request({
    url: '/system/order/list',
    method: 'get',
    params: query
  })
}

// 订单编号查询订单
export function getOrder(orderId) {
  return request({
    url: '/system/order/' + parseStrEmpty(orderId),
    method: 'get'
  })
}

// 订单编号查询订单
export function getCountByTime(selectType) {
  return request({
    url: '/system/order/timeList/' + parseFloat(selectType),
    method: 'get'
  })
}

// 获取七日内订单数
export function orderByTime(query) {
  return request({
    url: '/system/order/orderTime/',
    method: 'get',
    params: query
  })
}

// 新增订单
export function addOrder(data) {
    return request({
      url: '/system/order',
      method: 'post',
      data: data
    })
  }

  // 修改订单
export function updateOrder(data) {
    return request({
      url: '/system/order',
      method: 'put',
      data: data
    })
  }

  // 删除订单
  export function delOrder(orderId) {
    return request({
      url: '/system/order/' + orderId,
      method: 'delete'
    })
  }

// 查询岗位详细
export function getPost(postId) {
    return request({
      url: '/system/post/' + postId,
      method: 'get'
    })
  }
  
  // 新增岗位
  export function addPost(data) {
    return request({
      url: '/system/post',
      method: 'post',
      data: data
    })
  }
  
  // 修改岗位
  export function updatePost(data) {
    return request({
      url: '/system/post',
      method: 'put',
      data: data
    })
  }
  
  // 删除岗位
  export function delPost(postId) {
    return request({
      url: '/system/post/' + postId,
      method: 'delete'
    })
  }

  