import http from '@/common/uni.interface.js';

// 查询kdy
export function getParty(partyName) {
  return http.get(
    `/system/party/partyName/`+partyName
  )
}

// 查询kdy列表
export function partyList(params) {
  return http.get(
    '/system/party/list',params
  )
}

// 查询kdy列表
export function getPartyById(userId) {
  return http.get(
    `/system/party/`+userId
  )
}