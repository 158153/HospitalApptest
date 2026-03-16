// LoadingView.ets
@Component
export struct LoadingView {
  // 接收外部传入的标题（默认空）
  private title: string = '';

  build() {
    Column() {
      // 标题：绑定设备
      Text(this.title)
        .fontSize(25)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 25, left: 85 })

      // 加载动画容器（居中显示）
      Column() {
        // 循环生成4个环形（模拟加载动画）
        Stack() {
          ForEach([80, 100, 120, 140], (radius: number) => {
            Circle()
              .width(radius * 2)
              .height(radius * 2)
              .stroke('#E0F2F1')
              .strokeWidth(8)
              .fill(Color.Transparent)
          })
          Circle()
            .width(100)
            .height(100)
            .fill('#B2DFDB')
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
  }
}