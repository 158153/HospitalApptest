//# 底部弹窗组件
@Component
export struct AddRecordBottomSheet {
  // 手动添加按钮的点击回调函数（可选）
  onManualAdd?: () => void;
  // 拍照上传按钮的点击回调函数（可选）
  onCameraUpload?: () => void;

  build() {
    // 底部弹窗整体容器：高度自适应内容，消除空白
    Column() {
      // 手动添加按钮
      Button('手动添加', { type: ButtonType.Normal })
        .width('100%')          // 改为100%，占满弹窗宽度
        .height(56)             // 按钮高度56vp，符合设计
        .fontSize(18)
        .fontColor(Color.Black)
        .backgroundColor(Color.White)
        .borderRadius(0)
        .margin({ top: 10, bottom: 0.5 }) // 细微分隔线，区分两个按钮
        .onClick(() => {
          if (this.onManualAdd) {
            this.onManualAdd();
          }
        });

      // 拍照上传按钮
      Button('拍照上传', { type: ButtonType.Normal })
        .width('100%')          // 与手动添加按钮保持一致
        .height(56)
        .fontSize(18)
        .fontColor(Color.Black)
        .backgroundColor(Color.White)
        .borderRadius(0)
        .onClick(() => {
          if (this.onCameraUpload) {
            this.onCameraUpload();
          }
        });
    }
    .width('100%')
    .height('auto') // 核心：让高度自适应内容，不再填充空白
    .backgroundColor(Color.White)
    .borderRadius(10) // 顶部圆角
    .padding(0) // 去掉上下padding，让按钮紧贴弹窗边缘
    .alignItems(HorizontalAlign.Center) // 按钮文字居中
  }
}