export interface UserInfo {
  // 用户id
  user_id: string
  // 用户头像
  avatar: string | Resource
  // 用户名称
  username: string
}

//ai聊天对象信息，昵称，头像，id
export const DefaultUserList: UserInfo[] = [
  {
    username: '我是慢病健康小助手-点击开启新对话',
    avatar:  $r('app.media.doctor'),
    user_id: '1'
  },
  {
    username: '慢病有哪些？',
    avatar: '',
    user_id: '2'
  },
  {
    username: '房颤的症状',
    avatar: '',
    user_id: '3'
  },
  {
    username: '糖尿病的病因',
    avatar: '',
    user_id: '4'
  },
  {
    username: '如何合理规划饮食',
    avatar: '',
    user_id: '5'
  },
  {
    username: '运动可以加快恢复吗',
    avatar: '',
    user_id: '6'
  },
  {
    username: '点击查看-更多历史对话',
    avatar: '',
    user_id: '7'
  },

]

// 定义自己的信息，头像，昵称，id
export const currentUser: UserInfo = {
  username: "yangMr",
  avatar: "https://img2.baidu.com/it/u=2778471297,524433918&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
  user_id: "root"
}