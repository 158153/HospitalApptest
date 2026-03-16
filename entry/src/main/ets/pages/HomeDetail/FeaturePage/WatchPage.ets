/**
 * 健康监测主页面（WatchPage）
 * 核心逻辑：
 * 1. 未绑定设备 → 显示未绑定页面，点击"去绑定"进入加载状态
 * 2. 已绑定设备 → 直接显示加载动画，2秒后显示数据页面
 */
// 导入路由模块，用于页面返回
import router from '@ohos.router';
import { NavBar } from './WatchComponents/NarBar'; // 导航栏组件
import { UnboundDeviceView } from './WatchComponents/UnboundDeviceView'; // 未绑定设备页面组件
import { LoadingView } from './WatchComponents/LoadingView'; // 加载动画组件
import { BoundDeviceDataView } from './WatchComponents/BoundDeviceDataView'; // 已绑定设备数据组件

/**
 * 设备数据项类型定义
 * @param value: 测量值（数字/字符串，适配血糖/血压）
 * @param time: 测量时间
 * @param status: 状态（偏高/空）
 */
export interface DeviceItem {
  value: number | string;
  time: string;
  status: string;
}

/**
 * 所有设备数据类型定义
 * @param bloodSugar: 血糖仪数据列表
 * @param bloodPressure: 测压计数据列表
 * @param bandData: 手环数据列表
 */
export interface DeviceData {
  bloodSugar: DeviceItem[];
  bloodPressure: DeviceItem[];
  bandData: DeviceItem[];
}

@Entry
@Component
struct WatchPage {
  @State isDeviceBound: boolean = false; // 设备绑定状态：false=未绑定，true=已绑定（@State响应式变量，变化时刷新UI）
  @State isLoading: boolean = false; // 加载状态：false=未加载，true=加载中
  // 模拟设备数据（实际项目可从接口/本地存储获取）
  @State deviceData: DeviceData = {
    bloodSugar: [
      { value: 7.4, time: '18:30', status: '偏高' },
      { value: 6.8, time: '12:10', status: '' },
      { value: 7.3, time: '08:10', status: '偏高' }
    ],
    bloodPressure: [
      { value: '145/89', time: '18:30', status: '偏高' },
      { value: '135/85', time: '12:10', status: '' },
      { value: '135/85', time: '08:10', status: '' }
    ],
    bandData: []
  };

  /**
   * 页面即将显示时执行（生命周期钩子）
   * 作用：检查设备绑定状态
   */
  aboutToAppear() {
    this.checkDeviceBindStatus();
  }

  /**
   * 模拟检查设备绑定状态
   * 实际项目中可替换为：从Preferences/蓝牙/接口查询真实绑定状态
   */
  checkDeviceBindStatus() {
    // 测试时可改为 true
    // this.isDeviceBound = true;
  }

  /**
   * 绑定设备触发的逻辑
   * 1. 标记设备为已绑定
   * 2. 显示加载动画
   * 3. 2秒后结束加载，显示数据页面
   */
  bindDevice() {
    this.isDeviceBound = true;
    this.isLoading = true;
    // 模拟2秒绑定过程（实际项目可替换为蓝牙设备搜索逻辑）
    setTimeout(() => {
      this.isLoading = false;
    }, 2000);
  }

  /**
   * 页面UI构建函数（核心）
   * 按状态切换不同组件：未绑定 → 加载中 → 已绑定
   */
  build() {
    Column() {
      // 导航栏组件：传入标题+返回按钮点击事件
      NavBar({
        title: '健康监测',
        onBackClick: () => {
          router.back(); // 点击返回按钮，返回上一页
        }
      })
      // 主内容区域（卡片容器）
      Column() {
        // 状态1：未绑定设备 → 显示未绑定组件v
        if (!this.isDeviceBound) {
          UnboundDeviceView({
            onBindClick: () => {
              this.bindDevice(); // 点击"去绑定"触发绑定逻辑
            }
          })
          //状态2：已绑定但加载中 → 显示加载动画组件
        } else if (this.isLoading) {
          LoadingView({ title: '绑定设备' })
          // 状态3：已绑定且加载完成 → 显示设备数据组件
        } else {
          BoundDeviceDataView({ deviceData: this.deviceData })
        }
      }
      .width('90%') // 宽度占屏幕95%
      .height('86%') // 高度占屏幕90%
      .margin(20) // 外边距20vp
      .border({ width: 1, color: '#ffd6d1d1' }) // 灰色边框，宽度1vp
      .borderRadius(20) // 圆角12vp
      .backgroundColor('#FAFAFA') // 背景色浅灰
    }
    .width('100%') // 根布局宽度占满屏幕
    .height('100%') // 根布局高度占满屏幕
    .backgroundColor('#FFFFFF') // 页面背景色白色
  }
}