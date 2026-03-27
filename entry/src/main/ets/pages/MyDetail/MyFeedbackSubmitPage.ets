// 意见反馈提交页面
import router from '@ohos.router'
import { FeedbackType, mockApi } from '../../api/Myapi'
import promptAction from '@ohos.promptAction'

// 定义路由参数类型接口，用于接收上一页传递的反馈类型
interface FeedbackParams {
  feedbackType: FeedbackType
}

@Entry
@Component
struct MyFeedbackSubmitPage {
  // 反馈类型（默认值为“其他”）
  @State feedbackType: FeedbackType = '其他'
  // 反馈内容
  @State content: string = ''
  // 联系方式
  @State contact: string = ''

  // 页面生命周期：页面即将显示时获取路由参数
  aboutToAppear() {
    const params = router.getParams() as FeedbackParams
    if (params?.feedbackType) {
      this.feedbackType = params.feedbackType
    }
  }

  // 提交反馈逻辑
  handleSubmit() {
    // 校验反馈内容是否为空
    if (!this.content.trim()) {
      promptAction.showToast({ message: '请输入问题和意见', duration: 2000 })
      return
    }

    // 调用模拟接口提交反馈
    mockApi.submitFeedback(this.feedbackType, this.content, this.contact)
      .then(success => {
        if (success) {
          promptAction.showToast({ message: '已收到您的反馈，感谢您的支持！', duration: 2000 })
          // 延迟2秒后返回上一页
          setTimeout(() => {
            router.back()
          }, 2000)
        }
      })
  }

  build() {
    // 根容器：占满全屏，背景色为浅灰
    Column() {
      // 顶部导航栏（对齐UI：浅蓝背景、左对齐返回按钮+标题）
      Row() {
        // 返回箭头图标
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        // 页面标题
        Text('意见反馈')
          .fontSize(18) // UI中标题字号稍小
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#EBF5F5') // 更浅的蓝绿色，对齐UI顶部栏
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      // 表单外容器：带边框、浅背景，包裹所有输入项
      Column() {
        // 1. 问题和意见输入区域
        Column() {
          // 标题（带红色必填标记）
          Row() {
            Text('问题和意见')
              .fontSize(14)
              .fontColor('#333333')
            Text('*')
              .fontSize(14)
              .fontColor(Color.Red)
              .margin({ left: 4 })
          }
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 12 })

          // 多行文本输入框
          TextArea({ placeholder: '请详细描述您遇到的问题或建议' })
            .width('100%')
            .height(120)
            .backgroundColor(Color.White)
            .border({ width: 1, color: '#E8F4F4' }) // 淡边框
            .borderRadius(8)
            .padding(16)
            .fontSize(14)
            .fontColor('#333333')
            .onChange((value: string) => {
              this.content = value
            })
        }
        .width('100%')
        .margin({ bottom: 24 })

        // 2. 反馈图片上传区域
        Column() {
          Text('反馈图片')
            .fontSize(14)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 12 })

          // 图片区域容器（白色背景+圆角）
          Row() {
            // 上传按钮（+号，浅灰背景）
            Row() {
              // 用两条线画十字，更贴近UI
              Column() {
                Row().width(20).height(1).backgroundColor('#CCCCCC')
                Row().width(1).height(20).backgroundColor('#CCCCCC')
                  .position({ x: 9.5, y: -10 })
              }
            }
            .width(64)
            .height(64)
            .backgroundColor('#E8E8E8')
            .borderRadius(6)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(90)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#E8F4F4' })
          .borderRadius(8)
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .padding({ left: 16 })
        }
        .width('100%')
        .margin({ bottom: 24 })

        // 3. 联系方式输入区域
        Column() {
          Text('联系方式')
            .fontSize(14)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 12 })

          // 单行文本输入框
          TextInput({ placeholder: '请输入您的手机号或邮箱' })
            .width('100%')
            .height(48)
            .backgroundColor(Color.White)
            .border({ width: 1, color: '#E8F4F4' })
            .borderRadius(8)
            .padding({ left: 16 })
            .fontSize(14)
            .fontColor('#333333')
            .onChange((value: string) => {
              this.contact = value
            })
        }
        .width('100%')

        // 提交按钮（居中、浅绿背景）

        Button('提交')
          .width('180')
          .height(44)
          .backgroundColor('#C5DDDD') // 更贴近UI的淡绿色
          .fontSize(16)
          .fontColor('#333333') // UI中文字为深色
          .borderRadius(8)
          .margin({ top: 45, bottom: 20 })
          .onClick(() => {
            this.handleSubmit()
          })


      }
      .width('95%')
      .backgroundColor('#F8FBFB') // 极浅的背景色
      .border({ width: 1, color: '#C8E6E6' }) // 淡绿色边框
      .borderRadius(8)
      .padding(24)
      .layoutWeight(1)
      .margin({ top: 16, left: 12, right: 12 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // 页面最外层背景色
  }
}