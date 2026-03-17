// UnboundDeviceView.ets
/**
 * 未绑定设备页面组件
 * 显示"未检测到设备"提示+去绑定按钮
 */
@Component
export struct UnboundDeviceView {
  build() {
    Column() {
      Text('绑定设备')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 20, left: 20 })

      Column() {
        // 提示文本：未检测到设备
        Text('未检测到设备')
          .fontSize(20)
          .fontColor('#666666')
          .margin({ bottom: 30 })
        // 去绑定按钮
        Button('去绑定')
          .width(120)
          .height(44)
          .backgroundColor('#F5C0C0')
          .fontSize(18)
          .fontColor('#000000')
          .borderRadius(22)
          .onClick(this.onBindClick)
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
  }

  private onBindClick: () => void = () => {
  };
}