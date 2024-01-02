import http from '@/common/uni.interface.js';



// 查询公告列表
export function listNotice(params) {
  return http.get(
    '/system/notice/list',params)
}

// 查询公告详细
export function getNotice(noticeId) {
  return http.get(
    `/system/notice/`+noticeId)
}