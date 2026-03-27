//意见反馈类型页面
import router from '@ohos.router'
import { CommonListItem } from '../MyDetail/components/CommonListItem'
import { FeedbackType } from '../../api/Myapi'

@Entry
@Component
struct MyFeedbackTypePage {
  // 反馈类型列表
  private feedbackTypes: FeedbackType[] = ['首页', '智能问答', '科普宣教', '个人中心', '其他']

  build() {
    Column() {
      // 顶部导航栏（链式调用语法已修正）
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('意见反馈')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#E8F4F4')
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)


      // 反馈类型列表
      Column({ space: 8 }) {
        // 修复：ForEach 补充 keyGenerator，CommonListItem 补全 icon 和正确回调名
        ForEach(this.feedbackTypes, (type: FeedbackType) => {
          CommonListItem({
            icon: $r('app.media.center_aboutwe'), // 补全必填参数 icon
            title: type,
            showArrow: true,
            onItemClick: () => { // 修正回调函数名：oniClick → onItemClick
              router.pushUrl({
                url: 'pages/MyDetail/MyFeedbackSubmitPage',
                params: { feedbackType: type }
              })
            }
          })
        }, (type: FeedbackType) => type) // 补充 ForEach 第三个参数：key生成函数
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 12 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F9F9')
  }
}