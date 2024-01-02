// axios 配置
import axios from 'axios'
// 创建axios实例
const service = axios.create({
    //baseURL: process.env.API_ROOT, // node环境的不同，对应不同的baseURL
    //baseURL: "",
    timeout: 30000, // 请求的超时时间
    // headers: {
    //     "Content-Type": "application/x-www-form-urlencoded"
    // },
    withCredentials: true //允许携带cookie
})
// 发送请求前处理request的数据
axios.defaults.transformRequest = [function (data) {
    let newData = ''
    for (let k in data) {
        newData += encodeURIComponent(k) + '=' + encodeURIComponent(data[k]) + '&'
    }
    console.log(newData);
    return newData
}]
// request拦截器
service.interceptors.request.use(
    config => {
        // 发送请求之前，要做的业务

        return config
    },
    error => {
        // 错误处理代码
        return Promise.reject(error)
    }
)
// response拦截器
service.interceptors.response.use(
    response => {
        // 数据响应之后，要做的业务
        return response
    },
    error => {
        return Promise.reject(error)
    }
)
export default service;