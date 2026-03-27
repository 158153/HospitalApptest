//关于我们
import router from '@ohos.router'

@Entry
@Component
struct MyAboutPage {
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
        Text('关于我们')
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

      // 应用信息区域
      Column() {
        // 应用图标与名称
        Column() {
          Image($r('app.media.hospital'))
            .width(80)
            .height(80)
            .borderRadius(16)
            .margin({ bottom: 12 })
          Text('慢病')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Text('Version 2.0')
            .fontSize(14)
            .fontColor('#999999')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 40, bottom: 40 })

        // 版本更新入口
        Row() {
          Text('版本更新')
            .fontSize(16)
            .fontColor(Color.Black)
            .layoutWeight(1)
          Image($r('app.media.ic_public_right'))
            .width(16)
            .height(16)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor(Color.White)
        .borderRadius(8)
        .alignItems(VerticalAlign.Center)

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