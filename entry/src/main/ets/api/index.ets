import { Http } from '../utils/Http'

//定义"聊天内容"的格式（接口）
export interface ChatData {
  type: number, // 消息类型：1=文本，2=图片，3=语音...
  info: ChatDataInfo // 具体内容（下面定义）
}

export interface ChatDataInfo {
  text: string // 具体的文字消息
}

//把"获取机器人回复"这个复杂过程（拼地址、发请求、处理返回格式），封装成一个简单的函数，你只需要输入关键词，就能得到格式化的回复！
//创建"获取消息"函数getMessageInfo,发送请求Http.get<ChatData>(地址)

export const getMessageInfo = (keyword: string): Promise<ChatData> => {
  return Http.get<ChatData>(`/bot?userid=${Date.now()}&spoken=${keyword}`)
  // return Http.get<ChatData>(`/bot?userid=${Date.now()}&spoken=${keyword}`)
  // return Http.get<ChatData>("/bot", params)
}