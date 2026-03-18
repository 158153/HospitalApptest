// 1. 导入系统路由模块：用于页面间的跳转和返回操作
import router from '@ohos.router';

// 导入自定义UI组件：页面中需要用到的设备卡片、搜索弹窗、确认弹窗组件
import { DeviceCard } from '../../HomeDetail/FeaturePage/SettingComponents/DeviceCard';
import { DeviceSearchDialog } from '../FeaturePage/SettingComponents/DeviceSearchDialog';
import { DeviceConfirmDialog } from '../FeaturePage/SettingComponents/DeviceConfirmDialog';

// 2. 显式定义接口类型：约束数据结构，避免any类型导致的类型检查报错
/**
 * 设备信息接口：定义设备卡片/弹窗所需的设备基础信息
 */
interface DeviceInfo {
  name: string; // 设备名称（如"华为智能手环"）
  icon: Resource; // 设备图标（鸿蒙资源类型，对应media目录下的图片）
}

/**
 * 搜索弹窗属性接口：约束搜索弹窗的回调函数类型
 */
interface SearchDialogProps {
  onCancel: () => void; // 取消弹窗的回调函数
}

/**
 * 确认弹窗属性接口：约束确认弹窗的参数和回调类型
 */
interface ConfirmDialogProps {
  device: DeviceInfo; // 待确认绑定的设备信息
  onCancel: () => void; // 取消绑定的回调函数
  onConfirm: () => void; // 确认绑定的回调函数
}

// 3. 页面入口组件：@Entry标记当前组件为页面入口，@Component标记为自定义组件
@Entry
@Component
struct SettingPage {
  // 4. 状态变量声明（@State标记为响应式变量，值变化会触发UI刷新）
  /** 已绑定设备列表：显式声明数组类型为DeviceInfo[]，优化类型推断 */
  @State private deviceList: Array<DeviceInfo> = [
    { name: "华为智能手环", icon: $r("app.media.smartwatch") }// 初始化默认设备
  ];
  /** 控制搜索弹窗的显示/隐藏：默认隐藏 */
  @State private showSearchDialog: boolean = false;
  /** 控制确认绑定弹窗的显示/隐藏：默认隐藏 */
  @State private showConfirmDialog: boolean = false;
  /** 待绑定的设备信息：模拟搜索到的血糖仪设备 */
  @State private pendingDevice: DeviceInfo = { name: "血糖仪", icon: $r("app.media.blood") };

  // 5. 构建UI界面：build()方法是组件的UI渲染入口
  build() {

    Column() {
      // ---------- 顶部导航栏区域 ----------
      Row() {
        Image($r("app.media.ic_public_arrow_left"))
          .width(24)    // 图标宽度
          .height(24)   // 图标高度
          .onClick(() => {
            router.back(); // 调用路由模块的返回方法
          })
        // 页面标题
        Text("设备绑定")
          .fontSize(20)          // 字体大小
          .fontWeight(FontWeight.Medium) // 字体粗细
          .margin({ left: 16 }) // 左边距16px
      }
      .width("100%") // 导航栏宽度占满屏幕
      .height(60)
      .padding({ left: 16 }) // 左侧内边距16px
      .backgroundColor("#E0F2F1") // 导航栏背景色

      // ---------- 已绑定设备列表区域 ----------
      // ForEach循环渲染：遍历deviceList生成设备卡片
      // 参数1：待遍历的数组；参数2：遍历项的渲染函数；参数3：唯一key生成函数（确保列表项唯一性）
      ForEach(
        this.deviceList,
        (item: DeviceInfo, index: number) => {
          // 渲染自定义设备卡片组件
          DeviceCard({
            device: item, // 传入当前设备信息
            onDelete: () => this.handleDeleteDevice(index) // 传入删除设备的回调
          })
        },
        (item: DeviceInfo, index: number) => `${item.name}_${index}` // 组合name+index生成唯一key
      );

      // ---------- 添加设备按钮区域 ----------
      Button("添加设备")
        .width("45%")               // 按钮宽度占屏幕
        .height(40)                 // 按钮高度40px
        .margin({ top: 100 })        // 上边距30px
        .backgroundColor("#E0F2F1") // 按钮背景色
        .fontColor("#333333")       // 按钮文字颜色
        .onClick(() => this.handleAddDevice()) // 点击触发添加设备逻辑

      // 空白占位：填充剩余空间，使按钮和弹窗区域分离
      Blank()

      // ---------- 搜索弹窗区域（条件渲染） ----------
      // 当showSearchDialog为true时显示弹窗
      if (this.showSearchDialog) {
        Stack() { // 堆叠布局：用于实现遮罩+弹窗的层叠效果
          // 遮罩层：半透明黑色背景，点击关闭弹窗
          Row()
            .width("100%")
            .height("100%")
            .backgroundColor("#00000033") // 黑色半透明（33是透明度）
            .onClick(() => {
              this.showSearchDialog = false; // 关闭搜索弹窗
            })
          // 搜索弹窗组件：传入取消回调
          DeviceSearchDialog({
            onCancel: () => {
              this.showSearchDialog = false; // 点击弹窗内的取消按钮关闭弹窗
            }
          } as SearchDialogProps) // 显式指定类型，避免类型推断错误
        }
        .width("100%")
        .height("100%")
        .position({ x: 0, y: 0 }) // 弹窗定位到屏幕左上角
      }

      // ---------- 确认绑定弹窗区域（条件渲染） ----------
      // 当showConfirmDialog为true时显示弹窗
      if (this.showConfirmDialog) {
        Stack() { // 堆叠布局：遮罩+确认弹窗
          // 遮罩层：点击关闭弹窗
          Row()
            .width("100%")
            .height("100%")
            .backgroundColor("#00000033")
            .onClick(() => {
              this.showConfirmDialog = false; // 关闭确认弹窗
            })
          // 确认弹窗组件：传入设备信息和回调
          DeviceConfirmDialog({
            device: this.pendingDevice, // 传入待绑定的设备信息
            onCancel: () => {
              this.showConfirmDialog = false; // 取消绑定，关闭弹窗
            },
            onConfirm: () => {
              this.deviceList.push(this.pendingDevice); // 确认绑定，将设备加入列表
              this.showConfirmDialog = false; // 关闭弹窗
            }
          } as ConfirmDialogProps) // 显式指定类型
        }
        .width("100%")
        .height("100%")
        .position({ x: 0, y: 0 })
      }
    }
    .width("100%") // 根容器宽度占满屏幕
    .height("100%") // 根容器高度占满屏幕
    .backgroundColor("#F8F8F8") // 页面背景色
  }

  // ---------- 业务逻辑方法 ----------
  /**
   * 模拟搜索设备的异步方法：显式声明Promise泛型为DeviceInfo，明确返回值类型
   * @returns Promise<DeviceInfo> 搜索到的设备信息
   */
  private simulateSearchDevice(): Promise<DeviceInfo> {
    return new Promise<DeviceInfo>((resolve) => {
      // 模拟2秒的网络请求延迟
      setTimeout(() => {
        resolve(this.pendingDevice); // 成功返回待绑定的设备信息
      }, 2000);
    });
  }

  /**
   * 处理添加设备的逻辑：点击"添加设备"按钮触发
   */
  private handleAddDevice(): void {
    this.showSearchDialog = true; // 显示搜索弹窗
    // 调用模拟搜索方法，搜索完成后关闭搜索弹窗，显示确认弹窗
    this.simulateSearchDevice().then((device: DeviceInfo) => {
      this.showSearchDialog = false; // 关闭搜索弹窗
      this.showConfirmDialog = true; // 显示确认绑定弹窗
    });
  }

  /**
   * 处理删除设备的逻辑：点击设备卡片的删除按钮触发
   * @param index 要删除的设备在deviceList中的索引
   */
  private handleDeleteDevice(index: number): void {
    // 边界检查：确保索引有效（避免数组越界报错）
    if (index >= 0 && index < this.deviceList.length) {
      this.deviceList.splice(index, 1); // 删除对应索引的设备
    }
  }
}