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
        .margin({ top: 25, left: 150 })

      // 加载图片容器（居中显示）
      Column() {
        // 加载图片（替换原有环形动画）
        Image($r('app.media.search')) // 使用指定的图片资源
          .width(400) // 设置图片宽度（可根据需求调整）
          .height(400) // 设置图片高度（可根据需求调整）
          .objectFit(ImageFit.Contain) // 保持图片比例，完整显示
          .margin({ top: 30 }) // 可选：调整图片与上方标题的间距
          // 正确的旋转动画写法（适配ArkTS的AnimateParam类型）
          .rotate({
            angle: 360, // 旋转角度
            centerX: '50%', // 旋转中心X轴
            centerY: '50%' // 旋转中心Y轴
          })
          .animation({
            duration: 2000, // 旋转时长（毫秒）
            iterations: -1, // 无限循环
            curve: Curve.Linear, // 匀速旋转
            playMode: PlayMode.Normal // 播放模式（正向循环）
          })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
  }
}