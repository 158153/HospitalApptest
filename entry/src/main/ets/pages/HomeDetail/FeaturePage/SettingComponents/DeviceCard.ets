// 设备信息接口：规范设备卡片数据结构
interface DeviceInfo {
  name: string; // 设备名称
  icon: Resource; // 设备图标资源
}

/**
 * 设备卡片组件：展示单条设备信息，提供删除交互
 */
@Component
export struct DeviceCard {
  // 设备信息：赋默认值避免未初始化报错
  device: DeviceInfo = { name: '', icon: $r('app.media.smartwatch') };
  // 删除回调函数：空函数默认值避免未定义报错
  onDelete: () => void = () => {
  };

  build() {
    // 卡片根容器：水平布局
    Row() {
      // 设备图标
      Image(this.device.icon)
        .width(40)
        .height(40)
        .margin({ right: 16 })

      // 设备名称
      Text(this.device.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)

      // 删除设备按钮
      Button("删除设备")
        .fontSize(14)
        .backgroundColor("#FFE5E5")
        .fontColor("#D83030")
        .borderRadius(8)
        .height(35)
        .onClick(this.onDelete)
    }
    .width("100%")
    .height(95)
    .padding({
      left: 16,
      right: 16,
      top: 12,
      bottom: 12
    })
    // 底部边框：实现列表分割线效果
    .border({
      width: { bottom: 0.5 },
      color: { bottom: "#E5E5E5" }
    })
  }
}