// 引入路由模块，用于页面跳转（返回上一页）
import router from '@ohos.router';

// 1. 先定义消息项的接口类型，解决"对象字面量不能作为类型"的报错
interface MessageItem {
  content: string; // 消息内容
  hasRedDot: boolean; // 是否显示未读红点
}

/**
 * 消息通知页面组件
 * 页面路径：./pages/HomeDetail/MessagePage.ets

 */
@Entry
  // 标记当前组件为页面入口组件
@Component
  // 声明为自定义组件
struct MessagePage {
  // 2. 使用定义好的接口类型，规范数组元素类型
  @State messageList: Array<MessageItem> = [
    { content: "您有一份新的随访问卷待填写！", hasRedDot: true },
    { content: "您的病历报告已生成完毕！", hasRedDot: false },
    { content: "今日运动量已达标，请继续保持~", hasRedDot: false },
    { content: "您的健康评估报告已生成完毕！", hasRedDot: false }
  ]

  build() {
    // 页面根容器：占满屏幕宽高，背景为浅灰色
    Column() {
      // ---------------------- 顶部导航栏 ----------------------
      Row() {

        // 返回图标
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back();
          })

        // 页面标题
        Text("消息通知")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#E8F4F4') // 导航栏背景色（浅青色）

      // ---------------------- 消息列表区域 ----------------------
      List() {
        ForEach(
          this.messageList,
          (item: MessageItem, index: number) => {
            ListItem() {
              // 4. 给Row加底部边框，替代ListItem不支持的borderBottom属性
              Row() {
                // 消息内容文本
                Text(item.content)
                  .fontSize(20)
                  .fontColor('#000000')
                  .layoutWeight(1)

                // 未读红点：仅当hasRedDot为true时显示
                if (item.hasRedDot) {
                  Circle()
                    .width(15)
                    .height(15)
                    .fill('#FF3B30')
                    .margin({ left: 8 })
                }
              }
              .borderRadius(10)
              .width('100%')
              .padding({
                left: 24,
                right: 24,
                top: 18,
                bottom: 18
              })
              .backgroundColor('#FFFFFF')
              // 给Row添加底部分隔线（解决ListItem不支持borderBottom的问题）
              .border({
                width: { bottom: 1 },
                color: { bottom: '#E5E5E5' }
              })
            }
          },
          (item: MessageItem) => item.content // 唯一标识（用消息内容）
        )
      }
      .width('96%')
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F9F9')
  }
}