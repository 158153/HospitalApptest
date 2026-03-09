// 1. 封装http请求
// 2. 封装api接口
// 3. 发送消息的时候,调用Api接口, 将它返回的数据添加到messageList

//封装http请求的步骤
//0.引入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

//1.创建axios的实例对象。service
const service = axios.create({
  baseURL: "https://api.ownthink.com", //公共接口地址
  timeout: 10000
})

// 2.创建请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {

  return config;
}, (error: AxiosError) => {
  // Do something with the request error.
  return Promise.reject(error);
});


// 3.创建响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  return response.data.data;
}, (error: AxiosError) => {
  // Do something with the response error.
  return Promise.reject(error);
});

// 4.封装自定义的请求
export class Http {
  static get<T>(url: string, params?: object) {
    return service.get<null, T>(url, {
      params
    })
  }

  static post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

  static put<T>(url: string, data?: object) {
    return service.put<null, T>(url, data)
  }

  static delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }
}

//5.导出实例对象或者封装的自定义请求方法
export default service

