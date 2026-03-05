import { TabBarClass } from '../models/tab'
import AIQ from './AIQ'


@Entry
@Component
struct Index {
  @State
  tabBarList: TabBarClass[] = [
    {
      icon: $r('app.media.ic_bottom_home'),
      name: 'home',
      title: '首页',
      selectIcon: $r('app.media.ic_bottom_home_filled')
    },
    {
      icon: $r('app.media.ic_bottom_airobot'),
      name: 'aiquestion',
      title: '智能问答',
      selectIcon: $r('app.media.ic_bottom_airobot_filled')
    },
    {
      icon: $r('app.media.ic_gallery_discover'),
      name: 'discover',
      title: '科普宣教',
      selectIcon: $r('app.media.ic_gallery_discover_filled')
    },
    {
      icon: $r('app.media.ic_gallery_contacts'),
      name: 'my',
      title: '我的',
      selectIcon: $r('app.media.ic_gallery_contacts_filled')
    }
  ]
  @State
  currentIndex: number = 0

  @Builder
  CommonTabBar(item: TabBarClass) {
    Column() {
      Image(this.tabBarList[this.currentIndex].name === item.name ? item.selectIcon : item.icon)
        .width(20)
        .height(20)

      Text(item.title)
        .fontSize(12)
        .fontColor(this.tabBarList[this.currentIndex].name == item.name ? $r("app.color.primary") :
          $r("app.color.text_primary"))
        .margin({
          top: 5
        })
    }
  }

  build() {
    Column() {
      Tabs({ index: $$this.currentIndex }) {
        ForEach(this.tabBarList, (item: TabBarClass) => {
          TabContent() {
            if (item.name === "home") {
              Text("首页")
            } else if (item.name === "aiquestion") {
              AIQ()
            } else if (item.name === "discover") {
              Text("科普宣教")
            } else if (item.name === "my") {
              Text("我的")
            }
          }.tabBar(this.CommonTabBar(item))
        })
      }
      .barPosition(BarPosition.End)
      .animationDuration(300)
    }
    .width("100%")
    .height("100%")

  }
}