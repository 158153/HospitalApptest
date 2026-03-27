//设置页面

import router from '@ohos.router'
import { CommonListItem } from '../MyDetail/components/CommonListItem'

@Entry
@Component
struct MySettingPage {
  build() {
    Column() {
      // 顶部导航栏 → 修复：链式调用必须写在 {} 前面
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('设置')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E8F4F4')
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)


      // 设置选项列表
      Column({ space: 8 }) {
        // 每个 CommonListItem 必须传 icon + onItemClick
        CommonListItem({
          icon: $r('app.media.icon_home_bjsb'), // 必须传！
          title: '个人资料',
          showArrow: true,
          onItemClick: () => { // 回调名必须是 onItemClick
            router.pushUrl({ url: 'pages/MyDetail/MyProfilePage' })
          }
        })

        CommonListItem({
          icon: $r('app.media.icon_home_bjsb'),
          title: '我的病历',
          showArrow: true,
          onItemClick: () => {
          }
        })

        CommonListItem({
          icon: $r('app.media.icon_home_bjsb'),
          title: '消息通知',
          showArrow: true,
          onItemClick: () => {
            router.pushUrl({ url: 'pages/MyDetail/MyNotificationPage' })
          }
        })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12 })
      .layoutWeight(1)

      // 底部操作按钮
      Column({ space: 12 }) {
        Button('切换账号')
          .width(160)
          .height(44)
          .backgroundColor(Color.White)
          .fontSize(16)
          .fontColor(Color.Black)
          .border({ width: 1, color: '#E5E5E5' })
          .borderRadius(8)

        Button('退出登录')
          .width(160)
          .height(44)
          .backgroundColor('#F5C6C6')
          .fontSize(16)
          .fontColor(Color.White)
          .borderRadius(8)
      }
      .width('100%')
      .padding({ bottom: 32 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F9F9')
  }
}