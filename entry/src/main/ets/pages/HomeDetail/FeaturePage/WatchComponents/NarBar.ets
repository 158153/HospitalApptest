// NavBar.ets
@Component
export struct NavBar {
  // 接收参数，带默认值
  private title: string = '';

  build() {
    Row() {
      // 确保你有 ic_back 图片资源，或者替换成系统图标
      Image($r('app.media.ic_public_arrow_left'))
        .width(24)
        .height(24)
        .onClick(this.onBackClick)
        .margin({ right: 12 })
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16 })
    .backgroundColor('#E8F5F4')
  }

  private onBackClick: () => void = () => {
  };
}