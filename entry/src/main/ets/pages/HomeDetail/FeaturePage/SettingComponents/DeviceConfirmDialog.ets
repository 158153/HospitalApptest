
// 1. 先定义设备数据的类型（解决“对象字面量不能作为类型”的问题）
interface DeviceInfo {
  name: string;
  icon: Resource;
}

@Component
export struct DeviceConfirmDialog {
  // 2. 给属性添加 `?` 标记为可选，或赋初始值（解决“未初始化”的问题）
  device?: DeviceInfo; // 可选属性，允许为 undefined
  onCancel?: () => void;
  onConfirm?: () => void;

  build() {
    Column() {
      // 安全访问：避免 device 为 undefined 时崩溃
      if (this.device) {
        Image(this.device.icon)
          .width(150)
          .height(200)
          .margin({ top: 20, bottom: 10 })
        Text(this.device.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 30 })
      }

      // 按钮组
      Row() {
        Button("取消")
          .layoutWeight(1)
          .height(40)
          .margin({ right: 10 })
          .backgroundColor("#E5E5E5")
          .fontColor("#333333")
          .onClick(() => {
            // 安全调用回调函数
            this.onCancel?.();
          })

        Button("确定")
          .layoutWeight(1)
          .height(40)
          .margin({ left: 10 })
          .backgroundColor("#FFE5E5")
          .fontColor("#D83030")
          .onClick(() => {
            // 安全调用回调函数
            this.onConfirm?.();
          })
      }
      .width("90%")
    }
    .width("90%")
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Center)
  }
}