import fetch from './fetch'

// 请求台风数据
export function getTyphoonData(){
    let url = 'datacache/demo.json';
    return fetch({
        method: 'GET',
        url,
    }).then(res=>{
        return res;
    })
}