/**
 * 模拟数据模型，后续可替换为真实接口
 */

// 我的关注列表数据类型
export interface FollowItem {
  id: string
  name: string
  avatar: Resource
}

// 个人资料数据类型
export interface ProfileData {
  avatar: Resource
  nickname: string
  gender: string
  phone: string
}

// 消息通知开关数据类型
export interface NotificationSettings {
  follow: boolean
  followUp: boolean
  goal: boolean
  todo: boolean
  report: boolean
}

// 意见反馈类型
export type FeedbackType = '首页' | '智能问答' | '科普宣教' | '个人中心' | '其他'

// 模拟数据仓库
class MockApi {
  // 获取我的关注列表
  async getFollowList(): Promise<FollowItem[]> {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve([
          { id: '1', name: '慢病健康小助手', avatar: $r('app.media.icon_home_xiaoxi') },
          { id: '2', name: '慢病科普', avatar: $r('app.media.icon_home_xiaoxi') },
          { id: '3', name: '房颤百科', avatar: $r('app.media.icon_home_xiaoxi') }
        ])
      }, 300)
    })
  }

  // 取消关注
  async unfollow(id: string): Promise<boolean> {
    return new Promise(resolve => {
      setTimeout(() => resolve(true), 200)
    })
  }

  // 获取个人资料
  async getProfile(): Promise<ProfileData> {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve({
          avatar: $r('app.media.icon_home_xiaoxi'),
          nickname: 'Admin',
          gender: '男',
          phone: '180******12'
        })
      }, 300)
    })
  }

  // 获取通知设置
  async getNotificationSettings(): Promise<NotificationSettings> {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve({
          follow: false,
          followUp: true,
          goal: true,
          todo: true,
          report: true
        })
      }, 300)
    })
  }

  // 提交反馈
  async submitFeedback(type: FeedbackType, content: string, contact?: string, image?: string): Promise<boolean> {
    return new Promise(resolve => {
      setTimeout(() => resolve(true), 800)
    })
  }
}

// 导出单例实例
export const mockApi = new MockApi()