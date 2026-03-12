// 导入主Tab子组件
import Follow from '../pages/EducationDetail/mainTabContent/Follow';
import Recommend from '../pages/EducationDetail/mainTabContent/Recommend';
import AfibSpecial from '../pages/EducationDetail/mainTabContent/AfibSpecial';
import MoreChronic from '../pages/EducationDetail/mainTabContent/MoreChronic';

@Component
struct Education {
  // 主 Tab 状态
  @State mainTabIndex: number = 2; // 默认选中"房颤专题"
  // 主 Tab 列表
  private mainTabs: string[] = ["关注", "推荐", "房颤专题", "更多慢病"];

  build() {
    Column() {
      // 1. 顶部标题栏
      Row() {
        Text("科普宣教")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor('#E5F2F2')

      // 2. 主 TabBar（固定在顶部，不滚动）
      Row() {
        ForEach(this.mainTabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(18)
              .fontColor(this.mainTabIndex === index ? '#006666' : '#333333')
              .fontWeight(this.mainTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
            // 选中下划线
            if (this.mainTabIndex === index) {
              Divider()
                .width(40)
                .height(2)
                .color('#006666')
                .margin({ top: 4 })
            }
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.mainTabIndex = index;
          })
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)

      // 3. 主Tab内容区域（根据索引渲染对应组件）
      Column() {
        if (this.mainTabIndex === 0) {
          Follow() // 关注Tab
        } else if (this.mainTabIndex === 1) {
          Recommend() // 推荐Tab
        } else if (this.mainTabIndex === 2) {
          AfibSpecial() // 房颤专题Tab
        } else if (this.mainTabIndex === 3) {
          MoreChronic() // 更多慢病Tab
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F9F9')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F9F9')
  }
}


export default Education;