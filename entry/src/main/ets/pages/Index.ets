import { TabBarClass } from '../models/AiQmodels/tab'
import AIQ from './AIQ'
import Home from './Home'
import Education from './Education'

@Entry
@Component
struct Index {
  /**
   * @State 装饰器：声明响应式状态变量
   * tabBarList: 底部导航栏的配置数据数组
   * 包含每个标签页的图标、名称、标题和选中图标
   */
  @State
  tabBarList: TabBarClass[] = [
    {
      icon: $r('app.media.ic_bottom_home'), // 未选中时的图标
      name: 'home', // 标签页的唯一标识名
      title: '首页', // 标签页显示的标题
      selectIcon: $r('app.media.ic_bottom_home_filled')// 选中时的图标
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
  /**
   * @State 装饰器：声明当前选中的标签页索引
   * 默认值为0，即第一个标签页（首页）
   */
  @State
  currentIndex: number = 0

  /**
   * @Builder 自定义构建函数装饰器
   * 作用：用于封装重复使用的UI元素，避免代码冗余
   * 此处用于构建底部导航栏的每个标签项的UI结构
   * @param item - 接收一个标签页配置对象，类型为TabBarClass
   * 包含属性：icon(图标)、name(标识)、title(标题)、selectIcon(选中图标)
   */
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

  /**
   * build 方法：组件的UI构建入口
   * 定义整个页面的布局结构
   */

  build() {
    Column() {
      /**
       * Tabs 组件：标签页容器
       * index: 当前选中的标签页索引，使用 $$ 实现双向绑定
       */
      Tabs({ index: $$this.currentIndex }) {
        ForEach(this.tabBarList, (item: TabBarClass) => {
          TabContent() {
            if (item.name === "home") {
              Home()
            } else if (item.name === "aiquestion") {
              AIQ()
            } else if (item.name === "discover") {
              Education()
            } else if (item.name === "my") {
              Text("我的")
            }
          }.tabBar(this.CommonTabBar(item))
        })
      }
      .barBackgroundColor($r("app.color.tab_green"))
      .barPosition(BarPosition.End) // 设置标签栏位置在底部
      .animationDuration(300) // 设置标签切换动画时长300毫秒
    }
    .width("100%")
    .height("100%")

  }
}

