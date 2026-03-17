/**
 * 随访记录页面组件
 * 功能：展示用户的随访记录列表和随访问卷入口，支持Tab切换、数据加载、详情跳转等

 */
import { FollowupRecord } from '../../../models/HomeModels/FollowupModel'; // 导入随访记录数据模型
import { FollowupApi } from '../../../api/FollowupApi'; // 导入随访相关接口请求类
import router from '@ohos.router'; // 导入鸿蒙路由模块，用于页面跳转

// 页面入口组件，@Entry标记当前组件为页面级入口
@Entry
  // @Component标记当前结构体为UI组件
@Component
struct FollowupPage {
  // 状态变量：存储随访记录列表数据，@State标记为响应式状态
  @State records: FollowupRecord[] = [];
  // 状态变量：控制加载中状态显示，true表示加载中，false表示加载完成
  @State isLoading: boolean = true;
  // 修复1：重命名变量，避免与基类 tabIndex 冲突
  // 状态变量：当前选中的Tab索引，0=随访记录 Tab，1=随访问卷 Tab
  @State private currentTabIndex: number = 0;

  /**
   * 生命周期函数：组件即将显示时触发
   * 作用：页面加载时自动调用数据加载方法
   */
  aboutToAppear() {
    this.loadData();
  }

  /**
   * 加载随访记录数据
   * 逻辑：设置加载状态 -> 调用接口获取数据 -> 处理异常 -> 关闭加载状态
   */
  async loadData() {
    // 开启加载中状态，显示加载动画
    this.isLoading = true;
    try {
      // 调用API获取随访记录列表，await等待异步请求结果
      this.records = await FollowupApi.getFollowupRecords();
    } catch (e) {
      // 捕获接口请求异常，打印错误日志
      console.error('加载随访记录失败', e);
    } finally {
      // 无论请求成功/失败，最终都关闭加载状态
      this.isLoading = false;
    }
  }

  /**
   * 构建UI界面（组件核心渲染方法）
   * 整体布局：Column垂直布局，包含导航栏、Tab栏、内容区域三部分
   */
  build() {
    // 页面根容器：垂直布局，占满全屏，背景色为浅灰色
    Column() {
      // ========== 顶部导航栏区域 ==========
      Row() {
        // 返回按钮：点击触发返回上一页
        Image($r('app.media.ic_public_arrow_left'))
          .width(24) // 宽度24px
          .height(24) // 高度24px
          .onClick(() => router.back()) // 点击事件：返回上一页
        // 页面标题
        Text('随访记录')
          .fontSize(20) // 字体大小20px
          .fontWeight(FontWeight.Medium) // 字体粗细：中等
          .margin({ left: 12 }) // 左边距12px
      }
      .width('100%') // 宽度100%
      .height(56) // 高度56px
      .padding({ left: 16 }) // 左内边距16px
      .backgroundColor('#E8F4F4') // 背景色：浅青绿色

      // ========== 修改后的Tab切换栏区域 ==========
      Row() {
        // 左侧：随访记录Tab按钮
        Button('随访记录')
          .width('45%')
          .height(40)
          .borderRadius(20)
          // 选中时为浅青绿色，未选中时为浅灰色
          .backgroundColor(this.currentTabIndex === 0 ? '#E0F2F1' : '#E8E8E8')
          .fontColor(this.currentTabIndex === 0 ? '#00897B' : '#666666')
          .onClick(() => this.currentTabIndex = 0)

        // 右侧：随访问卷Tab（带Badge角标）
        Row() {
          Button('随访问卷')
            .width('100%')
            .height(40)
            .borderRadius(20)
            // 选中时为浅青绿色，未选中时为浅灰色
            .backgroundColor(this.currentTabIndex === 1 ? '#E0F2F1' : '#E8E8E8')
            .fontColor(this.currentTabIndex === 1 ? '#00897B' : '#666666')
            .onClick(() => this.currentTabIndex = 1)

          if (this.currentTabIndex === 1) {
            Badge({
              count: 1,
              position: BadgePosition.RightTop,
              style: {
                badgeColor: '#FF3B30',
                fontSize: 12,
                badgeSize: 16
              }
            })
          }
        }
        .width('45%')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // ========== 内容区域（根据状态动态渲染） ==========
      // 加载中状态：显示加载动画
      if (this.isLoading) {
        LoadingProgress()
          .width(50) // 加载动画宽度50px
          .height(50) // 加载动画高度50px
          .margin({ top: 100 }) // 上边距100px
      } else {
        // 加载完成：根据当前Tab显示对应内容
        // 随访记录Tab（索引0）
        if (this.currentTabIndex === 0) {
          // 随访记录列表容器
          List() {
            // 遍历随访记录数组，渲染列表项
            ForEach(this.records, (item: FollowupRecord) => {
              // 列表项容器
              ListItem() {
                // 单个随访记录卡片
                Column() {
                  // 卡片第一行：时间 + 箭头
                  Row() {
                    Text(item.time) // 随访时间
                      .fontSize(16)
                      .fontColor('#333333')
                    Image($r('app.media.ic_public_arrow_left')) // 右侧箭头图标
                      .width(20)
                      .height(20)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween) // 两端对齐
                  .margin({ bottom: 12 }) // 下边距12px

                  // 卡片第二行：随访类型 + 随访医院
                  Row() {
                    Text(item.type) // 随访类型
                      .fontSize(16)
                      .fontColor('#00897B')
                    Text(`随访医院：${item.hospital}`) // 随访医院
                      .fontSize(14)
                      .fontColor('#666666')
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween) // 两端对齐
                  .margin({ bottom: 8 }) // 下边距8px

                  // 卡片第三行：随访结果/状态
                  if (item.status === '已填写' && item.result) {
                    // 已填写状态：显示随访结果
                    Text(`随访结果：${item.result}`)
                      .fontSize(14)
                      .fontColor('#666666')
                      .alignSelf(ItemAlign.Start) // 左对齐
                      .margin({ bottom: 8 })
                  } else {
                    // 未填写/其他状态：显示随访状态，不同状态不同颜色
                    Text(`随访状态：${item.status}`)
                      .fontSize(14)
                      // 待填写：橙色，已完成：深青绿色
                      .fontColor(item.status === '待填写' ? '#FF6B00' : '#00897B')
                      .alignSelf(ItemAlign.Start) // 左对齐
                      .margin({ bottom: 8 })
                  }

                  // 卡片第四行：随访医生
                  Text(`随访医生：${item.doctor}`)
                    .fontSize(14)
                    .fontColor('#666666')
                    .alignSelf(ItemAlign.Start) // 左对齐
                }
                .width('100%')
                .padding(16) // 内边距16px
                .backgroundColor('#FFFFFF') // 卡片背景色：白色
                .borderRadius(8) // 卡片圆角8px
                .margin({ bottom: 8 }) // 卡片间距8px
                // 卡片点击事件：仅已填写状态可跳转详情页
                .onClick(() => {
                  if (item.status === '已填写') {
                    router.pushUrl({
                      url: 'pages/HomeDetail/FeaturePage/FollowupComponents/FollowupDetailPage', // 详情页路由地址
                      params: { id: item.id } // 传递随访记录ID参数
                    });
                  }
                })
              }
            })
          }
          .width('100%')
          .layoutWeight(1) // 占满剩余高度
          .padding({ left: 16, right: 16 }) // 左右内边距16px
          .margin({ top: 10 })
        } else {
          // 随访问卷Tab（索引1）
          List() {
            // 单个问卷列表项
            ListItem() {
              // 问卷卡片
              Column() {
                Text('随访问卷')
                  .fontSize(16)
                  .fontColor('#00897B')
                  .alignSelf(ItemAlign.Start) // 左对齐
                  .margin({ bottom: 12 }) // 下边距12px
                Text('请完成本次随访问卷填写')
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start) // 左对齐
              }
              .width('100%')
              .padding(16) // 内边距16px
              .backgroundColor('#FFFFFF') // 卡片背景色：白色
              .borderRadius(8) // 卡片圆角8px
              .margin({ bottom: 8 }) // 下边距8px
              // 卡片点击事件：跳转到问卷填写页
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/HomeDetail/FeaturePage/FollowupComponents/FollowupFormPage', // 问卷填写页路由地址
                  params: { id: 'f1' } // 传递问卷ID参数
                });
              })
            }
          }
          .width('100%')
          .layoutWeight(1) // 占满剩余高度
          .padding({ left: 16, right: 16 }) // 左右内边距16px
          .margin({ top: 10 })
        }
      }
    }
    .width('100%') // 页面宽度100%
    .height('100%') // 页面高度100%
    .backgroundColor('#F5F5F5') // 页面背景色：浅灰色
  }
}