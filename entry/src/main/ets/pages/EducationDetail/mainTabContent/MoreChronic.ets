@Component
struct MoreChronic {
  build() {
    List() {
      ListItem() {
        Column() {
          Text(`当前选中：更多慢病`)
            .fontSize(20)
            .fontColor('#999999')
            .margin({ top: 20 })
          // 占位内容，模拟可滚动效果
          ForEach(Array.from({ length: 20 }), (_: object, index: number) => {
            Text(`更多慢病列表项 ${index + 1}`)
              .fontSize(16)
              .fontColor('#666666')
              .margin({ top: 16 })
          })
        }
        .width('96%')
        .padding(16)
        .backgroundColor(Color.White)
        .borderRadius(8)
        // 阴影加大
        .shadow({
          radius: 8,
          color: '#33000000',
          offsetX: 0,
          offsetY: 4
        })
        .margin({ left: 20, right: 100, top: 12 })
        // 关键：让卡片在父容器里水平居中
        .alignSelf(ItemAlign.Center)
      }
    }
    .layoutWeight(1)
    .width('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off) // 不显示滚动条
    .margin({
      top: 10,
      left: 20,
      right: 20,
      bottom: 10
    }) //最外一层大卡片

  }
}

export default MoreChronic;