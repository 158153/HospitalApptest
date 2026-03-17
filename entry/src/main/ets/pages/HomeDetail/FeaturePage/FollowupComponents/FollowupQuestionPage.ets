import router from '@ohos.router';

@Entry
@Component
struct FollowupQuestionPage {
  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('←')
          .fontSize(24)
          .width(40)
          .onClick(() => {
            // 返回上一页
            router.back();
          })
        Text('随访问卷')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .padding({ left: 12 })
      .backgroundColor('#E8F4F4')

      List() {
        ListItem() {
          Column() {
            Text('房颤随访问卷')
              .fontSize(16)
              .fontColor('#00897B')
              .alignSelf(ItemAlign.Start)
            Text('请如实填写本次随访相关信息')
              .fontSize(14)
              .fontColor('#666666')
              .alignSelf(ItemAlign.Start)
              .margin({ top: 4 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .onClick(() => {
            // 跳转到随访问卷填写页
            router.pushUrl({
              url: 'pages/HomeDetail/FollowupFormPage',
              params: { id: 'f1' }
            });
          })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}