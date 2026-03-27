// 我的收藏页面
import router from '@ohos.router';

// 定义收藏文章数据类型
interface CollectItem {
  id: string;
  title: string;
}

@Entry
@Component
struct MyCollectPage {
  // 模拟收藏列表数据
  private collectList: CollectItem[] = [
    { id: '1', title: '房颤如何筛查？预防房颤的几种方法' },
    { id: '2', title: '早期房颤如何治理？警惕这几种习惯' },
    { id: '3', title: '房颤患者日常注意事项与饮食建议' },
    { id: '4', title: '心律失常的常见症状与自我判断方式' }
  ]

  build() {
    Column() {
      // 顶部导航栏（点击箭头返回上一页）
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('我的收藏')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#EBF5F5')
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      // ====================== 可滚动列表 ======================
      List({ space: 16 }) {
        ForEach(this.collectList, (item: CollectItem) => {
          ListItem() {
            Row() {
              // 左侧标题
              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontColor('#333333')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('65%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
              .padding({ left: 20 })

              // 右侧图片占位
              Row()
                .width('35%')
                .height('100%')
                .backgroundColor('#C9C9C9')
            }
            .width('98%')
            .height(140)
            .backgroundColor(Color.White)
            .borderRadius(5)
            .justifyContent(FlexAlign.Start)
          }
        }, (item: CollectItem) => item.id)
      }
      .width('97%')
      .padding({ left: 12, right: 12, top: 16 })
      .layoutWeight(1)
      .scrollBar(BarState.Off) // 关闭滚动条

      // ========================================================

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F9F9')
  }
}