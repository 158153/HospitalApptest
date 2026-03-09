/**
 * 首页组件（Home）
 * 功能说明：应用主页面，整合天气卡片、功能按钮、健康目标，健康工具等核心模块
 * 技术栈：HarmonyOS ArkTS + 声明式UI
 * 组件依赖：TopCard（天气卡片组件）、promptAction（提示弹窗API）
 */
// 导入提示弹窗API，用于按钮点击后的Toast提示
import promptAction from '@ohos.promptAction';
// 导入路由API，用于页面跳转
import router from '@ohos.router';
// 导入抽离的天气卡片组件（路径根据实际项目结构调整）
import TopCard from '../pages/HomeDetail/TopCard';

// 声明为页面入口组件
@Entry
@Component
struct Home {
  /**
   * 页面UI构建方法
   * 整体布局：Column垂直布局，包含以下模块：
   * 1. 天气日期卡片组件
   * 2. 功能按钮行（健康监测+消息提醒处理）
   * 3. 健康目标，健康工具模块
   * 4. 底部空白占位（防止内容被遮挡）
   */
  build() {
    Column() {
      // 1. 引入独立的天气卡片组件（展示核心天气信息）
      TopCard()

      // 2. 健康监测 & 消息提醒 功能按钮行
      this.FunctionButtonRow()

      // 3.健康目标-模块标题
      Text("健康目标")
        .fontSize(16) // 字体大小
        .fontWeight(FontWeight.Medium) // 字体粗细
        .width('100%') // 宽度占满父容器
        .margin({ left: 15, top: 15, bottom: 10 }) // 外边距：左15，上15，下10
        .textAlign(TextAlign.Start) // 文字左对齐

      // 3.健康目标模块（第一组：待办事项、随访记录）
      this.HealthToolsGroup1()

      // 3.健康工具模块标题（第二组）
      Text("健康工具")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ left: 15, top: 15, bottom: 10 })
        .textAlign(TextAlign.Start)

      // 4. 健康工具模块（第二组：我的设备、健康数据、健康评估）
      this.HealthToolsGroup2()

      // 底部空白占位，保证内容不被底部导航栏/系统栏遮挡
      Blank()
    }
    .width('100%') // 列布局宽度占满屏幕
    .height('100%') // 列布局高度占满屏幕
    .backgroundColor('#F5F5F5') // 页面背景色（浅灰）
    .padding({ left: 5, right: 5 }) // 整体左右留白，适配不同屏幕宽度
  }

  /**
   * 【@Builder装饰器】功能按钮行构建方法
   * 包含：报警预备按钮、任务处理按钮（水平Row布局）
   * 按钮样式：差异化配色+图标+文字，点击触发Toast提示+页面跳转
   */
  @Builder
  FunctionButtonRow() {
    // 水平布局，按钮间间距10vp
    Row({ space: 10 }) {
      // 健康数据按钮（红色系样式）
      Button() {
        Row({ space: 8 }) { // 按钮内部：图标+文字水平排列，间距8vp
          // 健康监测专属图标
          Image($r('app.media.icon_home_jingbao'))
            .width(30) // 图标宽
            .height(30) // 图标高
            .fillColor('#D32F2F') // 图标颜色（红色）
          // 按钮文字
          Text("健康监测")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#D32F2F') // 文字颜色（红色）
        }
      }
      .width('49%') // 按钮宽度（父容器48%）
      .height(60) // 按钮高度
      .backgroundColor('#FFE4E1') // 按钮背景色（浅红）
      .borderRadius(20) // 核心修改：圆角改为20vp，与健康工具按钮一致
      // 添加阴影效果，参数与健康工具按钮保持一致
      .shadow({
        radius: 8, // 阴影模糊半径
        color: '#1F000000', // 阴影颜色（半透明黑）
        offsetX: 0, // 水平偏移
        offsetY: 1 // 垂直偏移
      })
      .onClick(() => { // 点击事件：跳转到健康监测页面
        promptAction.showToast({ message: '进入健康监测页面', duration: 1500 });
        // 页面跳转 - 请根据实际项目路径修改
        this.navigateToPage('pages/HomeDetail/FeaturePage/WatchPage', '健康监测');
      })

      // 消息提醒按钮（蓝色系样式）
      Button() {
        Row({ space: 8 }) { // 按钮内部：图标+文字水平排列，间距8vp
          // 消息通知专属图标
          Image($r('app.media.icon_home_xiaoxi'))
            .width(30)
            .height(30)
            .fillColor('#0288D1') // 图标颜色（蓝色）
          // 按钮文字
          Text("消息通知")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0288D1') // 文字颜色（蓝色）
        }
      }
      .width('48%') // 按钮宽度（父容器48%）
      .height(60) // 按钮高度
      .backgroundColor('#E0F7FA') // 按钮背景色（浅蓝）
      .borderRadius(20) // 核心修改：圆角改为20vp，与健康工具按钮一致
      // 核心修改：添加阴影效果，参数与健康工具按钮保持一致
      .shadow({
        radius: 8, // 阴影模糊半径
        color: '#1F000000', // 阴影颜色（半透明黑）
        offsetX: 0, // 水平偏移
        offsetY: 1 // 垂直偏移
      })
      .onClick(() => { // 点击事件：跳转到消息通知页面
        promptAction.showToast({ message: '进入消息通知页面', duration: 1500 });
        // 页面跳转 - 请根据实际项目路径修改
        this.navigateToPage('pages/HomeDetail/FeaturePage/MessagePage', '消息通知');
      })
    }
    .width('100%') // 行布局宽度占满父容器
    .margin({ top: 15, left: 20 }) // 上边距15vp，与天气卡片分隔
  }

  /**
   * 【@Builder装饰器】健康工具第一组构建方法
   * 包含：待办事项、随访记录（2个工具项）
   */
  @Builder
  HealthToolsGroup1() {
    Row({ space: 10 }) { // 水平布局，工具项间距10vp
      // 待办事项：专属图标 + 绿色系 + 页面跳转
      this.HealthToolItem("待办事项", '#4CAF50', 'app.media.icon_home_hljl', 'pages/HomeDetail/FeaturePage/TaskPage')
      // 随访记录：专属图标 + 紫色系 + 页面跳转
      this.HealthToolItem("随访记录", '#9C27B0', 'app.media.icon_home_hlrw',
        'pages/HomeDetail/FeaturePage/FollowupPage')
    }
    // 给健康目标模块添加左右内边距+上下外边距，让内容与边框有距离
    .padding({ left: 15, right: 15 })
    .margin({
      top: 5,
      bottom: 5,
      left: 0,
      right: 0
    })
    .width('100%') // 行布局宽度占满父容器
  }

  /**
   * 【@Builder装饰器】健康工具第二组构建方法
   * 包含：我的设备、健康数据、健康评估、设置（四个工具项）
   */
  @Builder
  HealthToolsGroup2() {
    Row({ space: 10 }) { // 水平布局，工具项间距10vp
      // 设备绑定：专属图标 + 蓝色系
      this.HealthToolItem("设备绑定", '#03A9F4', 'app.media.icon_home_wdsb', 'pages/HomeDetail/FeaturePage/SettingPage')
      // 电子病历：专属图标 + 黄色系
      this.HealthToolItem("电子病历", '#FFC107', 'app.media.icon_home_sbkz', 'pages/HomeDetail/FeaturePage/DigitalPage')
      // 健康评估：专属图标 + 红色系
      this.HealthToolItem("健康评估", '#F44336', 'app.media.icon_home_sbaz',
        'pages/HomeDetail/FeaturePage/EvaluationPage')
    }
    // 给健康工具模块添加左右内边距+上下外边距，统一间距风格
    .padding({ left: 15, right: 15 })
    .margin({
      top: 5,
      bottom: 10,
      left: 0,
      right: 0
    })
    .width('100%') // 行布局宽度占满父容器
  }

  /**
   * 【@Builder装饰器】健康工具单个按钮项（复用组件）
   * @param text 工具项文字（如：每日目标、我的设备）
   * @param iconColor 图标颜色（差异化区分不同工具）
   * @param iconPath 图标资源路径（新增参数，指定专属图标）
   * @param pageUrl 跳转页面路径（为空则不跳转）
   * 功能：统一封装健康工具按钮样式，减少重复代码
   */
  @Builder
  HealthToolItem(text: string, iconColor: string, iconPath: string, pageUrl: string = '') {
    Button() {
      // 按钮内部：图标+文字垂直排列，间距8vp
      Column({ space: 8 }) {
        // 图标（使用外部传入的专属图标路径）
        Image($r(iconPath))
          .width(30) // 图标宽
          .height(30) // 图标高
          .fillColor(iconColor) // 图标颜色（外部传入）
        // 工具项文字
        Text(text)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333') // 文字颜色（深灰）
      }
      // 给按钮内部内容添加内边距，让图标文字不贴按钮边框
      .padding({
        top: 10,
        bottom: 10,
        left: 15,
        right: 15
      })
    }
    .layoutWeight(1) // 权重布局：自动均分父容器宽度
    .height(85) // 按钮高度
    .backgroundColor(Color.White) // 按钮背景色（白色）
    .borderRadius(20) // 圆角20vp
    // 阴影效果：增强视觉层次感
    .shadow({
      radius: 8, // 阴影模糊半径
      color: '#1F000000', // 阴影颜色（半透明黑）
      offsetX: 0, // 水平偏移
      offsetY: 1 // 垂直偏移
    })
    .onClick(() => { // 点击事件：提示点击的工具项名称 + 页面跳转
      promptAction.showToast({ message: `进入${text}`, duration: 1500 });

      // 如果传入了页面路径，则执行跳转
      if (pageUrl && pageUrl.trim() !== '') {
        this.navigateToPage(pageUrl, text);
      }
    })
  }

  /**
   * 通用页面跳转方法
   * @param pageUrl 目标页面路径
   * @param pageName 页面名称（用于错误提示）
   */
  private navigateToPage(pageUrl: string, pageName: string) {
    router.pushUrl({
      url: pageUrl
    }).catch((err: Error) => {
      promptAction.showToast({
        message: `${pageName}页面跳转失败：${err.message}`,
        duration: 2000
      });
    });
  }
}

// 导出Home组件，供其他模块引用（如路由配置）
export default Home;