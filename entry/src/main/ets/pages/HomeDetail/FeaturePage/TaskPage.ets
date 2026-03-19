// 导入目标卡片组件
import { TargetCard } from '../../HomeDetail/FeaturePage/TaskComponents/TargetCard';
// 导入待办事项卡片组件
import { TodoCard } from '../../HomeDetail/FeaturePage/TaskComponents/TodoCard';
// 导入添加目标弹窗组件
import { AddTargetDialog } from '../../HomeDetail/FeaturePage/TaskComponents/AddTargetDialog';
// 导入添加待办事项弹窗组件
import { AddTodoDialog } from '../../HomeDetail/FeaturePage/TaskComponents/AddTodoDialog';
// 导入任务相关的数据模型类型
import { AddTargetParams, AddTodoParams, TargetItem, TodoItem } from '../../../models/HomeModels/TaskModel';
// 导入任务相关的接口服务
import { TaskService } from '../../../api/TaskService';
// 导入路由模块
import router from '@ohos.router';

// 声明页面入口组件
@Entry
@Component
struct TaskPage {
  // 响应式状态：目标列表数据
  @State targetList: TargetItem[] = [];
  // 响应式状态：待办事项列表数据
  @State todoList: TodoItem[] = [];
  // 响应式状态：控制添加目标弹窗的显示/隐藏
  @State showAddTarget: boolean = false;
  // 响应式状态：控制添加待办事项弹窗的显示/隐藏
  @State showAddTodo: boolean = false;
  // 初始化任务服务实例
  private taskService: TaskService = new TaskService();

  // 页面即将显示时执行的生命周期函数
  async aboutToAppear() {
    // 并行请求目标列表和待办事项列表接口
    const results = await Promise.all([
      this.taskService.getTargetList(),
      this.taskService.getTodoList()
    ]);
    // 将接口返回数据赋值给响应式状态，驱动页面渲染
    this.targetList = results[0];
    this.todoList = results[1];
  }

  // 处理添加目标的逻辑
  async handleAddTarget(params: AddTargetParams): Promise<void> {
    // 调用添加目标接口，传入参数
    const newTarget = await this.taskService.addTarget(params);
    // 不可变更新目标列表（创建新数组），触发页面重新渲染
    this.targetList = [...this.targetList, newTarget];
    // 关闭添加目标弹窗
    this.showAddTarget = false;
  }

  // 处理添加待办事项的逻辑
  async handleAddTodo(params: AddTodoParams): Promise<void> {
    // 调用添加待办事项接口，传入参数
    const newTodo = await this.taskService.addTodo(params);
    // 不可变更新待办事项列表，触发页面重新渲染
    this.todoList = [...this.todoList, newTodo];
    // 关闭添加待办事项弹窗
    this.showAddTodo = false;
  }

  // 页面UI构建函数
  build() {
    // 根容器：Stack实现多层级布局（主体内容 + 弹窗遮罩）
    Stack() {
      // 页面主体内容区域
      Column() {
        // 页面头部导航栏
        Row() {
          // 返回按钮
          Image($r('app.media.ic_public_arrow_left'))
            .width(26)
            .height(26)
            .onClick(() => router.back()) // 点击返回上一页
          // 页面标题
          Text('代办事项')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Start)
          // 占位元素，保证标题居中
          Text('')
            .width(24)
        }
        .width('100%')
        .padding(12)
        .height(60)
        .backgroundColor('#E0F2F1')

        // 内容区域：双列等宽布局（目标列 + 待办列）
        Row({ space: 16 }) {
          // 左侧：目标卡片容器
          Column({ space: 12 }) {
            // 目标区域头部（标题 + 添加按钮）
            Row() {
              Text('目标')
                .fontSize(18)
                .fontColor('#26A69A')
                .fontWeight(FontWeight.Medium)
              // 添加目标按钮
              Button('+', { type: ButtonType.Circle })
                .width(24)
                .height(24)
                .backgroundColor('#26A69A')
                .fontColor(Color.White)
                .fontSize(18)
                .onClick(() => this.showAddTarget = true) // 打开添加目标弹窗
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              left: 12,
              right: 12,
              top: 12,
              bottom: 8
            })

            // 滚动列表：内容从顶部开始排列
            Scroll() {
              Column({ space: 12 }) {
                ForEach(this.targetList, (item: TargetItem) => {
                  TargetCard({ item: item })
                    .padding({ left: 12, right: 12 })
                })
              }
              .width('100%')
              // 关键：让Column高度自适应内容，不占满Scroll
              .constraintSize({ minHeight: 0, maxHeight: Infinity })
              // 内容垂直顶部对齐
              .justifyContent(FlexAlign.Start)
            }
            .layoutWeight(1)
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.Auto)
            // 关键：Scroll内容垂直顶部对齐
            .align(Alignment.TopStart)
          }
          .layoutWeight(1)
          .width('50%')
          .height("90%")
          .backgroundColor(Color.White)
          .borderRadius(12)
          .border({ width: 1, color: '#E0E0E0' })
          .shadow({
            radius: 8,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 2
          })
          .padding({ bottom: 12 })
          // 关键：Column水平方向左对齐，垂直方向顶部对齐
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)

          // 右侧：待办事项卡片容器
          Column({ space: 12 }) {
            // 待办事项区域头部（标题 + 添加按钮）
            Row() {
              Text('事项')
                .fontSize(18)
                .fontColor('#26A69A')
                .fontWeight(FontWeight.Medium)
              // 添加待办事项按钮
              Button('+', { type: ButtonType.Circle })
                .width(24)
                .height(24)
                .backgroundColor('#26A69A')
                .fontColor(Color.White)
                .fontSize(18)
                .onClick(() => this.showAddTodo = true) // 打开添加待办弹窗
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              left: 12,
              right: 12,
              top: 12,
              bottom: 8
            })

            // 滚动列表：内容从顶部开始排列
            Scroll() {
              Column({ space: 12 }) {
                ForEach(this.todoList, (item: TodoItem) => {
                  TodoCard({ item: item })
                    .padding({ left: 12, right: 12 })
                })
              }
              .width('100%')
              // 关键：让Column高度自适应内容，不占满Scroll
              .constraintSize({ minHeight: 0, maxHeight: Infinity })
              // 内容垂直顶部对齐
              .justifyContent(FlexAlign.Start)
            }
            .layoutWeight(1)
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.Auto)
            // 关键：Scroll内容垂直顶部对齐
            .align(Alignment.TopStart)
          }
          .layoutWeight(1)
          .width('50%')
          .height("90%")
          .backgroundColor(Color.White)
          .borderRadius(12)
          .border({ width: 1, color: '#E0E0E0' })
          .shadow({
            radius: 8,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 2
          })
          .padding({ bottom: 12 })
          // 关键：Column水平方向左对齐，垂直方向顶部对齐
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
        }
        .width('100%')
        .padding(12)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // 添加目标弹窗：条件渲染
      if (this.showAddTarget) {
        Stack() {
          Row()
            .width('100%')
            .height('100%')
            .backgroundColor('#00000040')
            .onClick(() => this.showAddTarget = false)
          AddTargetDialog({
            onConfirm: (params: AddTargetParams) => this.handleAddTarget(params),
            onCancel: () => this.showAddTarget = false
          })
        }
        .width('100%')
        .height('100%')
      }

      // 添加待办事项弹窗：条件渲染
      if (this.showAddTodo) {
        Stack() {
          Row()
            .width('100%')
            .height('100%')
            .backgroundColor('#00000040')
            .onClick(() => this.showAddTodo = false)
          AddTodoDialog({
            onConfirm: (params: AddTodoParams) => this.handleAddTodo(params),
            onCancel: () => this.showAddTodo = false
          })
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }
}