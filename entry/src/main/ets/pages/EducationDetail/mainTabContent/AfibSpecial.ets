// 导入房颤专题二级Tab组件
import Cognition from '../afibContent/Cognition'
import Screening from '../afibContent/Screening'
import Treatment from '../afibContent/Treatment'
import Nursing from '../afibContent/Nursing'
import Prevention from '../afibContent/Prevention'

@Component
struct AfibSpecial {
  // 二级 Tab 状态（保持可观察性）
  @State subTabIndex: number = 0;
  // 二级 Tab 列表
  private subTabs: string[] = ["认知篇", "筛查篇", "治疗篇", "护理篇", "预防篇"];
  // 新增：Scroll控制器，用于切换Tab时复位滚动位置
  private scrollController: Scroller = new Scroller();

  build() {
    Column() {
      // 二级 TabBar（固定，不滚动）
      Row() {
        ForEach(this.subTabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontColor(this.subTabIndex === index ? '#009999' : '#666666')
              .fontWeight(this.subTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
            // 选中下划线
            if (this.subTabIndex === index) {
              Divider()
                .width(30)
                .height(2)
                .color('#009999')
                .margin({ top: 4 })
            }
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            // 修复：点击时更新索引 + 滚动复位到顶部
            this.subTabIndex = index;
            this.scrollController.scrollTo({ xOffset: 0, yOffset: 0, animation: true });
          })
          // 增加点击区域响应范围
          .width('100%')
          .height('100%')
        })
      }
      .width('100%')
      .height(48)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#F0F7F7')
      .borderRadius(8)
      .margin({ top: 8, left: 12, right: 12 })

      // 房颤专题内容区域（可滚动）
      Scroll(this.scrollController) {
        Column() {
          // 修复：直接基于状态变量渲染，而非通过Builder参数传递
          this.renderSubTabContent()
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F9F9')
      .scrollBar(BarState.Off) // 按需调整：Off=隐藏滚动条，On=显示滚动条
      .scrollable(ScrollDirection.Vertical) // 明确垂直滚动

    }
    .width('95%')
    .layoutWeight(1)
    .backgroundColor('#F5F9F9')
    .margin({
      top: 10,
      left: 20,
      right: 20,
      bottom: 10
    }) //最外一层大卡片
    .shadow({
      radius: 8,
      color: '#3A000000',
      offsetX: 0,
      offsetY: 2
    })
  } // 修复：build方法闭合括号

  // 重构：直接渲染Tab内容，避免Builder参数传递导致的更新问题
  @Builder
  renderSubTabContent() {
    Column() {
      // 根据状态变量直接渲染对应组件，状态变更会触发重建
      if (this.subTabIndex === 0) {
        Cognition() // 认知篇
      } else if (this.subTabIndex === 1) {
        Screening() // 筛查篇
      } else if (this.subTabIndex === 2) {
        Treatment() // 治疗篇
      } else if (this.subTabIndex === 3) {
        Nursing() // 护理篇
      } else if (this.subTabIndex === 4) {
        Prevention() // 预防篇
      }
    }
    .width('96%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .shadow({
      radius: 8,
      color: '#3A000000',
      offsetX: 0,
      offsetY: 2
    })
    .margin({
      top: 10,
      left: 20,
      right: 20,
      bottom: 40
    })
    .alignSelf(ItemAlign.Center)
  }
}

export default AfibSpecial;