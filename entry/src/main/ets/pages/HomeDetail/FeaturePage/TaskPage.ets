/**
 * 随访目标页面 - HealthTargetPage
 * 功能：展示用户每日健康目标（血糖监测、药品记录、饮食记录、每日运动），包含目标完成状态、核心数据展示
 *       支持列表滚动、点击新增按钮添加目标条目、点击任意条目弹出详情弹框
 */
import router from '@ohos.router';
import {
  BloodSugarRecordItem,
  DialogData,
  DietRecordItem,
  ExerciseRecordItem,
  MedicineRecordItem,
  TargetItemParams
} from '../../../models/HomeModels/Task';

// 导入统一模拟数据
import {
  mockTargetItems,
  mockMedicineRecords,
  mockBloodSugarRecords,
  mockDietRecords,
  mockExerciseRecords
} from '../../../models/HomeModels/Task_monidigital';
@Entry
@Component
struct HealthTargetPage {
  // 存储所有健康目标条目数据（增加type标识）

  // 控制弹框显示/隐藏
  @State isDialogVisible: boolean = false;
  // 当前弹框数据
  @State currentDialogData: DialogData = {
    type: 'medicine',
    title: '',
    data: []
  };
  // 各类记录模拟数据
  @State targetItems: TargetItemParams[] = mockTargetItems;
  @State medicineRecords: MedicineRecordItem[] = mockMedicineRecords;
  @State bloodSugarRecords: BloodSugarRecordItem[] = mockBloodSugarRecords;
  @State dietRecords: DietRecordItem[] = mockDietRecords;
  @State exerciseRecords: ExerciseRecordItem[] = mockExerciseRecords;

  build() {
    // 页面根容器：垂直列布局，占满屏幕宽高
    Column() {
      // ========== 标题栏区域 ==========
      Row() {
        // 返回箭头图标：点击返回上一级页面
        Image($r("app.media.ic_public_arrow_left"))
          .width(35)
          .height(35)
          .onClick(() => {
            router.back();
          })
          .margin({ right: 16 })

        // 页面主标题
        Text("待办事项-每日健康目标")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        // 新增目标按钮：点击添加新条目
        Image($r("app.media.task_add"))
          .width(30)
          .height(30)
          .onClick(() => {
            this.addNewTargetItem();
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .padding({
        top: 16,
        bottom: 16,
        left: 16,
        right: 16
      })
      .backgroundColor("#ffb7ecd2")
      .border({ width: { bottom: 2 }, color: { bottom: "#ffc7cbc7" } })
      .borderRadius({ topLeft: 15, topRight: 15 })

      // ========== 滚动列表容器 ==========
      List() {
        ForEach(this.targetItems, (item: TargetItemParams, index: number) => {
          ListItem() {
            // 所有条目都添加点击事件，打开对应弹框
            Row() {
              this.TargetItem(item)
            }
            .width("100%")
            .onClick(() => {
              this.openDialog(item);
            })
          }
          // 移除最后一个条目的底部分割线
          .border({
            width: { bottom: index < this.targetItems.length - 1 ? 2 : 0 },
            color: { bottom: "#ffdddcdc" }
          })
        }, (item: TargetItemParams) => item.title + item.rightText)
      }
      .width("100%")
      .layoutWeight(1)
      .backgroundColor(Color.White)
      .borderRadius({ bottomLeft: 12, bottomRight: 12 })
      .shadow({
        radius: 10,
        color: "#1A000000",
        offsetX: 0,
        offsetY: 2
      })
      .edgeEffect(EdgeEffect.Spring)

      // ========== 通用详情弹框 ==========
      if (this.isDialogVisible) {
        this.CommonDetailDialog()
      }
    }
    .width("100%")
    .height("100%")
    .padding({ left: 40, right: 40, top: 20 })
    .backgroundColor("#F8F8F8")
  }

  /**
   * 打开弹框方法
   * @param item 点击的条目数据
   */
  openDialog(item: TargetItemParams) {
    switch (item.type) {
      case 'medicine':
        this.currentDialogData = {
          type: 'medicine',
          title: '药品记录',
          data: this.medicineRecords
        };
        break;
      case 'bloodSugar':
        this.currentDialogData = {
          type: 'bloodSugar',
          title: '血糖监测',
          data: this.bloodSugarRecords
        };
        break;
      case 'diet':
        this.currentDialogData = {
          type: 'diet',
          title: '饮食记录',
          data: this.dietRecords
        };
        break;
      case 'exercise':
        this.currentDialogData = {
          type: 'exercise',
          title: '每日运动',
          data: this.exerciseRecords
        };
        break;
      default:
        this.currentDialogData = {
          type: 'custom',
          title: item.title,
          data: []
        };
        break;
    }
    this.isDialogVisible = true;
  }

  /**
   * 新增目标条目方法
   */
  addNewTargetItem() {
    const newItem: TargetItemParams = {
      title: `新目标（未完成0/1）`,
      subTitle: "点击编辑目标详情",
      rightText: "待设置",
      rightSubText: "请配置",
      rightSubColor: "#999999",
      type: 'custom'
    };
    this.targetItems.push(newItem);
  }

  /**
   * 健康目标条目构建器
   * @param params 条目数据参数
   */
  @Builder
  TargetItem(params: TargetItemParams) {
    Row() {
      Column() {
        Text(params.title)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor("#000000")
          .margin({ bottom: 8 })
        Text(params.subTitle)
          .fontSize(16)
          .fontColor("#999999")
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        Text(params.rightText)
          .fontSize(18)
          .fontColor("#333333")
          .margin({ bottom: 4 })
        Text(params.rightSubText)
          .fontSize(18)
          .fontColor(params.rightSubColor || "#333333")
      }
      .alignItems(HorizontalAlign.End)
    }
    .width("100%")
    .padding(16)
  }

  /**
   * 通用详情弹框构建器
   * 功能：根据不同类型展示对应的记录详情，统一弹框样式
   */
  @Builder
  CommonDetailDialog() {
    // 半透明遮罩层
    Column() {
      // 弹框内容容器
      Column() {
        // 弹框标题栏
        Row() {
          // 返回箭头：关闭弹框
          Image($r("app.media.ic_public_arrow_left"))
            .width(28)
            .height(28)
            .onClick(() => {
              this.isDialogVisible = false;
            })

          Text(this.currentDialogData.title)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          // 新增按钮
          Image($r("app.media.task_add"))
            .width(30)
            .height(30)
            .onClick(() => {
              // 可扩展新增记录逻辑
            })
        }
        .width("100%")
        .padding(16)

        // 记录列表（根据类型渲染不同内容）
        List() {
          if (this.currentDialogData.type === 'medicine') {
            // 药品记录
            ForEach(this.currentDialogData.data as MedicineRecordItem[],
              (item: MedicineRecordItem, index: number) => {
                ListItem() {
                  this.MedicineRecordItem(item, index);
                }
              }, (item: MedicineRecordItem) => item.time + item.name)
          } else if (this.currentDialogData.type === 'bloodSugar') {
            // 血糖记录
            ForEach(this.currentDialogData.data as BloodSugarRecordItem[],
              (item: BloodSugarRecordItem, index: number) => {
                ListItem() {
                  this.BloodSugarRecordItem(item, index);
                }
              }, (item: BloodSugarRecordItem) => item.time)
          } else if (this.currentDialogData.type === 'diet') {
            // 饮食记录
            ForEach(this.currentDialogData.data as DietRecordItem[],
              (item: DietRecordItem, index: number) => {
                ListItem() {
                  this.DietRecordItem(item, index);
                }
              }, (item: DietRecordItem) => item.mealType)
          } else if (this.currentDialogData.type === 'exercise') {
            // 运动记录
            ForEach(this.currentDialogData.data as ExerciseRecordItem[],
              (item: ExerciseRecordItem, index: number) => {
                ListItem() {
                  this.ExerciseRecordItem(item, index);
                }
              }, (item: ExerciseRecordItem) => item.type)
          } else {
            // 自定义目标
            ListItem() {
              Text("暂无记录，点击右上角+添加")
                .fontSize(18)
                .fontColor("#999999")
                .width("100%")
                .textAlign(TextAlign.Center)
                .padding(30)
            }
          }
        }
        .width("100%")
        .layoutWeight(1)
        .edgeEffect(EdgeEffect.None)
      }
      .width("100%")
      .height("80%")
      .margin({ top: -80 })
      .backgroundColor(Color.White)
      .borderRadius(16)
    }
    .width("100%")
    .height("90%")
    .backgroundColor("#80e3dbdb")
    .justifyContent(FlexAlign.Center)
    .padding({ left: 40, right: 40, top: 50 })
    .onClick(() => {
      this.isDialogVisible = false;
    })
  }

  /**
   * 药品记录项构建器
   */
  @Builder
  MedicineRecordItem(item: MedicineRecordItem, index: number) {
    Row() {
      Column() {
        Text(item.time)
          .fontSize(18)
          .fontColor("#000000")
          .margin({ bottom: 4 })
        Text(`${item.name}\n${item.dosage}`)
          .fontSize(16)
          .fontColor("#999999")
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r("app.media.ic_public_" + (item.isCompleted ? "checked" : "uncheck")))
        .width(24)
        .height(24)
        .onClick(() => {
          this.medicineRecords[index].isCompleted = !item.isCompleted;
        })
    }
    .width("100%")
    .padding(16)
    .border({ width: { bottom: index < this.medicineRecords.length - 1 ? 0.5 : 0 }, color: { bottom: "#F0F0F0" } })
  }

  /**
   * 血糖记录项构建器
   */
  @Builder
  BloodSugarRecordItem(item: BloodSugarRecordItem, index: number) {
    Row() {
      Column() {
        Text(item.time)
          .fontSize(18)
          .fontColor("#000000")
          .margin({ bottom: 4 })
        Text(`${item.value} ${item.unit}`)
          .fontSize(16)
          .fontColor("#999999")
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r("app.media.ic_public_" + (item.isCompleted ? "checked" : "uncheck")))
        .width(24)
        .height(24)
        .onClick(() => {
          this.bloodSugarRecords[index].isCompleted = !item.isCompleted;
        })
    }
    .width("100%")
    .padding(16)
    .border({ width: { bottom: index < this.bloodSugarRecords.length - 1 ? 0.5 : 0 }, color: { bottom: "#F0F0F0" } })
  }

  /**
   * 饮食记录项构建器
   */
  @Builder
  DietRecordItem(item: DietRecordItem, index: number) {
    Row() {
      Column() {
        Text(item.mealType)
          .fontSize(18)
          .fontColor("#000000")
          .margin({ bottom: 4 })
        Text(`${item.intake}\n${item.calorie}`)
          .fontSize(16)
          .fontColor("#999999")
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r("app.media.ic_public_" + (item.isCompleted ? "checked" : "uncheck")))
        .width(24)
        .height(24)
        .onClick(() => {
          this.dietRecords[index].isCompleted = !item.isCompleted;
        })
    }
    .width("100%")
    .padding(16)
    .border({ width: { bottom: index < this.dietRecords.length - 1 ? 0.5 : 0 }, color: { bottom: "#F0F0F0" } })
  }

  /**
   * 运动记录项构建器
   */
  @Builder
  ExerciseRecordItem(item: ExerciseRecordItem, index: number) {
    Row() {
      Column() {
        Text(item.type)
          .fontSize(18)
          .fontColor("#000000")
          .margin({ bottom: 4 })
        Text(`${item.duration}\n消耗${item.calorie}`)
          .fontSize(16)
          .fontColor("#999999")
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r("app.media.ic_public_" + (item.isCompleted ? "checked" : "uncheck")))
        .width(24)
        .height(24)
        .onClick(() => {
          this.exerciseRecords[index].isCompleted = !item.isCompleted;
        })
    }
    .width("100%")
    .padding(16)
    .border({ width: { bottom: index < this.exerciseRecords.length - 1 ? 0.5 : 0 }, color: { bottom: "#F0F0F0" } })
  }
}