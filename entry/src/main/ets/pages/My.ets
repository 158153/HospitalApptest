import router from '@ohos.router'
import { CommonListItem } from './MyDetail/components/CommonListItem'

@Entry
@Component
struct MyPage {
  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('个人中心')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E8F4F4')
      .padding({ left: 16 })

      // 用户信息区域
      Row() {

        // 这里可以后续添加用户头像、昵称等组件
        Image($r('app.media.ic_bottom_airobot'))
          .width(50)
          .height(50)
        Text("Admin")
          .margin({ left: 20 })
      }
      .width('100%')
      .height(80)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .margin({ top: 12, left: 12, right: 12 })

      // 功能列表
      Column({ space: 8 }) {
        CommonListItem({
          icon: $r('app.media.center_love'),
          title: '我的关注',
          onItemClick: () => {
            router.pushUrl({ url: 'pages/MyDetail/MyFollowPage' })
          }
        })

        CommonListItem({
          icon: $r('app.media.center_collect'),
          title: '我的收藏',
          onItemClick: () => {
            router.pushUrl({ url: 'pages/MyDetail/MyCollectPage' })
          }
        })

        CommonListItem({
          icon: $r('app.media.center_setting'),
          title: '设置',
          onItemClick: () => {
            router.pushUrl({ url: 'pages/MyDetail/MySettingPage' })
          }
        })

        CommonListItem({
          icon: $r('app.media.center_yijian'),
          title: '意见反馈',
          onItemClick: () => {
            router.pushUrl({ url: 'pages/MyDetail/MyFeedbackTypePage' })
          }
        })

        CommonListItem({
          icon: $r('app.media.center_aboutwe'),
          title: '关于我们',
          onItemClick: () => {
            router.pushUrl({ url: 'pages/MyDetail/MyAboutPage' })
          }
        })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F9F9')
  }
}

// 导出Home组件，供其他模块引用（如路由配置）
export default MyPage;