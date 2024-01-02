import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询用户列表
export function listParty(query) {
  return request({
    url: '/system/party/list',
    method: 'get',
    params: query
  })
}

// 查询用户详细
export function getParty(partyId) {
  return request({
    url: '/system/party/' + parseStrEmpty(partyId),
    method: 'get'
  })
}

// 查询用户详细
export function getPartyByPhone(phonenumber) {
  return request({
    url: '/system/party/phonenumber/' + parseStrEmpty(phonenumber),
    method: 'get'
  })
}

// 新增用户
export function addParty(data) {
  return request({
    url: '/system/party',
    method: 'post',
    data: data
  })
}

// 修改用户
export function updateParty(data) {
  return request({
    url: '/system/party',
    method: 'put',
    data: data
  })
}

// 删除用户
export function delParty(partyId) {
  return request({
    url: '/system/party/' + partyId,
    method: 'delete'
  })
}

// 用户密码重置
export function resetPartyPwd(partyId, password) {
  const data = {
    partyId,
    password
  }
  return request({
    url: '/system/party/resetPwd',
    method: 'put',
    data: data
  })
}

// 用户状态修改
export function changePartyStatus(partyId, status) {
  const data = {
    partyId,
    status
  }
  return request({
    url: '/system/party/changeStatus',
    method: 'put',
    data: data
  })
}

// 查询用户个人信息
export function getPartyProfile() {
  return request({
    url: '/system/party/profile',
    method: 'get'
  })
}

// 修改用户个人信息
export function updatePartyProfile(data) {
  return request({
    url: '/system/party/profile',
    method: 'put',
    data: data
  })
}

// 用户密码重置
export function updatePartyPwd(oldPassword, newPassword) {
  const data = {
    oldPassword,
    newPassword
  }
  return request({
    url: '/system/party/profile/updatePwd',
    method: 'put',
    params: data
  })
}

// 用户头像上传
export function uploadAvatar(data) {
  return request({
    url: '/system/party/profile/avatar',
    method: 'post',
    data: data
  })
}


