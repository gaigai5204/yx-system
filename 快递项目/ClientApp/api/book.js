//如果用uni请求
import http from '@/common/uni.interface.js';


// 新增地址簿
export function addAddr(data) {
  return http.post('/system/addr',data)
}

// 查询地址簿列表
export function listAddr(partyId) {
  return http.get('/system/addr/'+partyId)
}

// 查询地址簿列表
export function editAddr(data) {
  return http.put()('/system/addr',data)
}

// 查询地址簿列表
export function removeAddr(addrIds) {
  return http.delete('/system/addr/'+addrIds)
}
