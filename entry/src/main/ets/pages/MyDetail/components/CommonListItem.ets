/**
 * 通用列表项组件，用于个人中心及子页面的统一样式
 * @param icon 左侧图标资源
 * @param title 列表项标题
 * @param rightText 右侧显示的文本（可选）
 * @param showArrow 是否显示右侧箭头（默认true）
 * @param onItemClick 点击事件回调（重命名避免与系统onClick冲突）
 */
@Component
export struct CommonListItem {
  @Prop icon: Resource
  @Prop title: string
  @Prop rightText?: string
  @Prop showArrow: boolean = true
  onItemClick?: () => void // 重命名为 onItemClick

  build() {
    Row() {
      // 左侧图标
      Image(this.icon)
        .width(24)
        .height(24)
        .margin({ right: 12 })
      // 标题文本
      Text(this.title)
        .fontSize(16)
        .fontColor(Color.Black)
        .layoutWeight(1)
      // 右侧文本（可选）
      if (this.rightText) {
        Text(this.rightText)
          .fontSize(14)
          .fontColor('#666666')
          .margin({ right: 8 })
      }
      // 右侧箭头（可选）
      if (this.showArrow) {
        Image($r('app.media.ic_public_right'))
          .width(16)
          .height(16)
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
    .borderRadius(8)
    .onClick(() => {
      if (this.onItemClick) { // 调用重命名后的回调
        this.onItemClick()
      }
    })
  }
}