//关注页面

import router from '@ohos.router'
import { FollowItem, mockApi } from '../../api/Myapi'

@Entry
@Component
struct MyFollowPage {
  @State followList: FollowItem[] = []

  aboutToAppear() {
    mockApi.getFollowList().then(data => {
      this.followList = data
    })
  }

  handleUnfollow(id: string) {
    mockApi.unfollow(id).then(success => {
      if (success) {
        this.followList = this.followList.filter(item => item.id !== id)
      }
    })
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('我的关注')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E8F4F4')
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Start)


      // 关注列表
      Column({ space: 8 }) {
        ForEach(this.followList, (item: FollowItem) => {
          Row() {
            Image(item.avatar)
              .width(36)
              .height(36)
              .borderRadius(18)
              .margin({ right: 12 })
            Text(item.name)
              .fontSize(16)
              .fontColor(Color.Black)
              .layoutWeight(1)
            Button('取消关注')
              .width(96)
              .height(32)
              .backgroundColor('#F5C6C6')
              .fontSize(14)
              .fontColor(Color.White)
              .borderRadius(16)
              .onClick(() => {
                this.handleUnfollow(item.id)
              })
          }
          .width('100%')
          .height(64)
          .padding({ left: 16, right: 16 })
          .backgroundColor(Color.White)
          .borderRadius(8)

        }, (item: FollowItem) => item.id) // 必须加key生成函数
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