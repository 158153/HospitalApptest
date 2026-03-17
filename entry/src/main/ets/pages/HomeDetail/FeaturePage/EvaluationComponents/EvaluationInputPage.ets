/**
 * 病情描述与AI预测结果页面
 * 核心功能：
 * 1. 输入/编辑病情描述文本
 * 2. 点击"开始评估"触发AI预测流程
 * 3. 模拟API请求，展示加载状态和最终预测结果
 * 4. 评估完成后生成记录（待回写到列表页）
 */

// 导入路由模块：用于页面跳转（返回列表页）
import router from '@ohos.router';
// 导入提示模块：用于展示Toast提示框
import { promptAction } from '@kit.ArkUI';

// 定义评估记录类型接口：约束记录数据结构，避免类型错误
interface EvaluationRecord {
  name: string; // 患者姓名
  gender: string; // 患者性别
  age: number; // 患者年龄
  evaluateTime: string; // 评估时间
  result: string; // 评估核心结果（列表页展示用）
}

// 页面入口组件
@Entry
@Component
struct EvaluationInputPage {
  // ========== 状态变量定义 ==========
  // 病情描述输入框内容（默认填充示例文本）
  @State symptomInput: string = '心悸、乏力、胸痛、眩晕、晕厥、呼吸困难';
  // 预测结果状态：0-初始态 1-加载中 2-已完成
  @State predictStatus: number = 0;
  // 预测结果文本（展示给用户的AI回复）
  @State predictResult: string = '';

  // ========== 核心方法定义 ==========
  /**
   * 模拟调用AI机器人API
   * @param symptom 病情描述文本
   * @returns Promise<string> AI预测结果文本
   */
  async simulateApiRequest(symptom: string): Promise<string> {
    // 返回Promise对象：模拟异步API请求
    return new Promise((resolve) => {
      // 模拟网络请求延迟（2秒）
      setTimeout(() => {
        // 模拟AI回复内容（实际项目中替换为真实API返回值）
        const mockResponse =
          '预测患者房颤可能性较大，可通过自我监测手段进行判断：自测脉搏或通过电子血压计、智能手表等可穿戴设备检测心跳，如有问题建议到正规医院进行心电图检查。';
        // 异步返回结果
        resolve(mockResponse);
      }, 2000);
    });
  }

  /**
   * 格式化当前时间为指定格式
   * @returns string 格式化后的时间（YYYY-MM-DD HH:MM）
   */
  formatCurrentTime(): string {
    const now = new Date(); // 获取当前时间
    const year = now.getFullYear(); // 年
    const month = String(now.getMonth() + 1).padStart(2, '0'); // 月（补0）
    const day = String(now.getDate()).padStart(2, '0'); // 日（补0）
    const hour = String(now.getHours()).padStart(2, '0'); // 时（补0）
    const minute = String(now.getMinutes()).padStart(2, '0'); // 分（补0）
    return `${year}-${month}-${day} ${hour}:${minute}`; // 拼接格式
  }

  /**
   * 开始评估按钮点击事件处理逻辑
   * 流程：1. 校验输入 2. 显示加载状态 3. 调用AI接口 4. 处理结果/异常
   */
  async handleStartEvaluation() {
    // 1. 输入校验：病情描述为空时提示用户
    if (!this.symptomInput.trim()) {
      promptAction.showToast({
        message: '请输入病情描述', // 提示文本
        duration: 2000            // 提示显示时长（2秒）
      });
      return; // 终止后续逻辑
    }

    // 2. 切换为加载中状态
    this.predictStatus = 1; // 更新状态为加载中
    this.predictResult = '预测结果中...'; // 显示加载提示文本

    try {
      // 3. 调用AI接口（异步）
      const aiResponse = await this.simulateApiRequest(this.symptomInput);

      // 4. 接口调用成功：更新状态和结果
      this.predictStatus = 2; // 更新状态为已完成
      this.predictResult = aiResponse; // 展示AI回复结果

      // 5. 生成评估记录（待回写到列表页）
      const newRecord: EvaluationRecord = {
        name: '张三', // 患者姓名（实际项目中替换为动态值）
        gender: '男', // 患者性别（实际项目中替换为动态值）
        age: 78, // 患者年龄（实际项目中替换为动态值）
        evaluateTime: this.formatCurrentTime(), // 评估时间（当前时间）
        result: '房颤可能性较大'           // 核心结果（提取AI回复的关键信息）
      };

      // 6. 提示用户评估完成
      promptAction.showToast({
        message: '评估完成',
        duration: 2000
      });

      // 【扩展】实际项目中：此处需将newRecord回写到列表页（如通过路由传参/全局状态）
      // 示例：router.back({ params: { newRecord: newRecord } });

    } catch (error) {
      // 异常处理：接口调用失败时重置状态并提示用户
      this.predictStatus = 0; // 重置为初始状态
      this.predictResult = ''; // 清空结果文本
      promptAction.showToast({
        message: '预测失败，请重试', // 错误提示
        duration: 2000
      });
    }
  }

  // ========== UI布局构建 ==========
  build() {
    // 根容器：纵向布局，占满全屏
    Column() {
      // 1. 顶部导航栏
      Row() {
        // 返回按钮：点击返回上一页（列表页）
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back(); // 路由返回
          })
        // 页面标题
        Text('健康评估')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(60)
      .padding({ left: 16 })
      .backgroundColor('#E8F4F5') // 浅蓝背景

      // 2. 病情分析模块（输入区）
      Column() {
        // 模块标题 + 上传病历按钮
        Row() {
          Text('病情分析')
            .fontSize(16)
            .fontColor('#006666') // 深绿字体
            .fontWeight(FontWeight.Medium)
          Blank() // 空白占位：推挤按钮到右侧
          Button('上传病历')
            .width(100)
            .height(32)
            .backgroundColor('#F5B7B1') // 浅红背景
            .fontSize(14)
            .fontColor('#FFFFFF')        // 白色字体
            .borderRadius(4) // 圆角
        }
        .width('100%')
        .margin({ bottom: 16 })

        // 病情描述输入框行
        Row() {
          // 标签文本
          Text('病情描述:')
            .fontSize(14)
            .fontColor('#333333')
            .textAlign(TextAlign.Start) // 左对齐
            .margin({ right: 8 })
          // 多行输入框
          TextArea({ text: this.symptomInput })
            .layoutWeight(1)           // 占满剩余宽度
            .height(80)                // 输入框高度
            .border({ width: 0.5, color: '#CCCCCC' }) // 浅灰边框
            .borderRadius(4)           // 圆角
            .padding(8)                // 内边距
            .fontSize(14)
            .borderRadius(10)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              // 实时更新输入内容到状态变量
              this.symptomInput = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top) // 垂直顶部对齐（避免标签和输入框基线对齐）
        .margin({ bottom: 16 })
        .borderRadius(15)

        // 开始评估按钮
        Button('开始评估')
          .width('30%')
          .height(36)
          .backgroundColor('#B4D8D8') // 浅青背景
          .fontSize(14)
          .fontColor('#000000')       // 黑色字体
          .borderRadius(4)            // 圆角
          .onClick(this.handleStartEvaluation.bind(this)) // 绑定点击事件（确保this指向）
      }
      .width('96%')
      .padding({
        top: 12,
        bottom: 12,
        left: 12,
        right: 12
      })
      .margin({ top: 12 })
      .backgroundColor('#F2F9F9') // 极浅绿背景
      .borderRadius(10) // 圆角
      // 新增：边框样式
      .border({
        width: 2,
        color: '#E0E0E0', // 浅灰色边框，和背景柔和搭配
        radius: 10 // 圆角和组件保持一致
      })

      // 3. 预测结果模块（展示区）
      Column() {
        // 模块标题 + 提示文本 + 图标
        Row() {
          Text('预测结果')
            .fontSize(16)
            .fontColor('#006666')
            .fontWeight(FontWeight.Medium)
          // 免责提示
          Text(' 仅为AI辅助预测，如有不适请到正规医院检查')
            .fontSize(12)
            .fontColor('#B38B00') // 暗黄字体
          // 提示图标
          Image($r('app.media.ic_gallery_contacts')) // 替换为实际提示图标
            .width(16)
            .height(16)
            .margin({ left: 4 })
        }
        .width('100%')
        .margin({ bottom: 16 })

        // 结果展示文本区域
        Text(this.predictResult)
          .width('100%')
          .height(250)//预测结果显示的白框
          .fontSize(14)
          .fontColor('#333333')
          .lineHeight(22) // 行高（提升可读性）
          .padding({
            top: 12,
            bottom: 12,
            left: 12,
            right: 12
          })
          .border({ width: 1, color: '#E5E5E5' }) // 浅灰边框
          .borderRadius(15) // 圆角
          .backgroundColor(Color.White)
          // 关键修改：让文本从顶部开始显示，避免垂直居中
          .textAlign(TextAlign.Start)
          .align(Alignment.TopStart)

      }
      .width('96%')
      .layoutWeight(1) // 占满剩余高度
      .padding({
        left: 12,
        right: 12,
        top: 12,
        bottom: 12
      })
      .margin({ top: 12 })
      .backgroundColor('#F2F9F9') // 极浅绿背景
      .borderRadius(10) // 圆角
      // 新增：边框样式
      .border({
        width: 2,
        color: '#E0E0E0', // 浅灰色边框，和背景柔和搭配
        radius: 10 // 圆角和组件保持一致
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // 浅灰背景（页面底色）
  }
}