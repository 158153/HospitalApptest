// components/topWeatherCard.ets
@Component
export struct TopCard {
  build() {
    Row({ space: 10 }) {
      // 左侧问候语+天气信息
      Column({ space: 8 }) {
        Text("早上好，Admin!")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Text("今日空气质量良好")
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 8 }) {
          Image($r('app.media.ic_gallery_contacts_filled')) // 替换为天气图标
            .width(40)
            .height(40)
          Text("23°C")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Column({ space: 4 }) {
            Text("2025年4月12日")
              .fontSize(14)
              .fontColor('#666666')
            Text("星期四")
              .fontSize(14)
              .fontColor('#666666')
          }
        }
        .margin({ top: 5 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 右侧空气质量信息（优化对齐）
      Column({ space: 8 }) {
        Text("         68")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E6B800')

        // 空气质量等级文字标尺
        Row({ space: 0 }) {
          Text("优").fontSize(10).fontColor('#00C853').width(20).textAlign(TextAlign.Center)
          Text("良").fontSize(10).fontColor('#E6B800').width(20).textAlign(TextAlign.Center)
          Text(" 轻度污染").fontSize(10).fontColor('#FF9800').width(90).textAlign(TextAlign.Center)
          Text(" 中度污染").fontSize(10).fontColor('#F44336').width(90).textAlign(TextAlign.Center)
          Text(" 重度污染").fontSize(10).fontColor('#9C27B0').width(90).textAlign(TextAlign.Center)
          Text(" 严重污染").fontSize(10).fontColor('#7B1FA2').width(90).textAlign(TextAlign.Center)
        }
        .width('100%')

        // 空气质量颜色标尺（优化圆角+宽度适配）
        Row({ space: 0 }) {
          Row().width('16.7%').height(4).backgroundColor('#00C853')
          Row().width('16.7%').height(4).backgroundColor('#E6B800')
          Row().width('16.7%').height(4).backgroundColor('#FF9800')
          Row().width('16.7%').height(4).backgroundColor('#F44336')
          Row().width('16.7%').height(4).backgroundColor('#9C27B0')
          Row().width('16.5%').height(4).backgroundColor('#7B1FA2')
        }
        .width('100%')
        .borderRadius(2)
        .clip(true)

        // 空气质量详情
        Column({ space: 4 }) {
          Text("首要污染物: PM10")
            .fontSize(14)
            .fontColor('#333333')
          Text("空气质量级别: 2级")
            .fontSize(14)
            .fontColor('#333333')
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .margin({ top: 10 })
    .shadow({
      radius: 3,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// 导出组件，方便外部引入
export default TopCard;