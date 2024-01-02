import request from '@/utils/request'

// 查询地址簿列表
export function listAddr(partyId) {
  return request({
    url: '/system/addr/'+partyId,
    method: 'get',
  })
}

// 查询地址簿列表
export function addAddr(data) {
  return request({
    url: '/system/addr/',
    method: 'post',
    data: data
  })
}