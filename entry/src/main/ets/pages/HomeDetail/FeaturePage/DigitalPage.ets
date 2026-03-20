import { MedicalRecord } from '../../../models/HomeModels/DigitalMedicalModels';
import { MedicalRecordCard } from '../FeaturePage/DigitalComponents/MedicalRecordCard';
import { AddRecordBottomSheet } from '../FeaturePage/DigitalComponents/AddRecordBottomSheet';
import { fetchMedicalRecords, parseMedicalRecord } from '../../../api/DigitalmockApi';
import router from '@ohos.router';
import picker from '@ohos.file.picker';
import promptAction from '@ohos.promptAction';

// 页面入口组件
@Entry
@Component
struct DigitalPage {
  // 病历列表（响应式状态）
  @State medicalRecords: MedicalRecord[] = [];
  // 控制底部弹窗显示/隐藏
  @State isShowAddSheet: boolean = false;
  // 控制解析中 loading 状态
  @State isParsing: boolean = false;

  // 页面初始化时获取数据
  async aboutToAppear(): Promise<void> {
    try {
      const records = await fetchMedicalRecords();
      this.medicalRecords = records;
    } catch (error) {
      console.error('获取病历列表失败:', error);
      promptAction.showToast({ message: '获取病历失败' });
    }
  }

  // 跳转到病历详情页
  navigateToDetail(record: MedicalRecord): void {
    router.pushUrl({
      url: 'pages/HomeDetail/FeaturePage/DigitalComponents/MedicalRecordDetailPage',
      params: { record: JSON.stringify(record) }
    });
  }

  // 处理拍照上传逻辑
  async handleCameraUpload(): Promise<void> {
    this.isShowAddSheet = false;
    this.isParsing = true;

    try {
      const photoPicker = new picker.PhotoViewPicker();
      const result = await photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE
      });

      if (result.photoUris.length > 0) {
        const imageUri = result.photoUris[0];
        const newRecord = await parseMedicalRecord(imageUri);
        this.medicalRecords = [newRecord, ...this.medicalRecords];
        promptAction.showToast({ message: '病历解析成功' });
      }
    } catch (error) {
      console.error('拍照上传失败:', error);
      promptAction.showToast({ message: '上传失败，请重试' });
    } finally {
      this.isParsing = false;
    }
  }

  // 底部弹窗内容构建器
  @Builder
  buildAddRecordSheet(): void {
    // 关键修改1：移除外层Column的冗余样式（AddRecordBottomSheet内部已包含完整样式）
    AddRecordBottomSheet({
      onManualAdd: (): void => {
        this.isShowAddSheet = false;
        promptAction.showToast({ message: '跳转到手动添加页面' });
      },
      onCameraUpload: (): void => {
        this.handleCameraUpload();
      }
    })
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => router.back());
        Text('电子病历')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 });
        Blank();
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#E8F4F5');

      // 内容区域
      if (this.isParsing) {
        Column() {
          LoadingProgress()
            .width(60)
            .height(60)
            .margin({ bottom: 20 });
          Text('加载相机中，请稍等...')
            .fontSize(16)
            .fontColor('#666666');
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center);
      } else {
        List() {
          ForEach(
            this.medicalRecords,
            (record: MedicalRecord) => {
              ListItem() {
                MedicalRecordCard({
                  record: record,
                  onCardClick: (r: MedicalRecord) => this.navigateToDetail(r)
                });
              }
            },
            (record: MedicalRecord) => record.id
          );
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 12 });
      }

      // 关键修改2：给bindSheet添加height配置，控制弹窗高度
      Button('添加病历', { type: ButtonType.Normal })
        .width('60%')
        .height(44)
        .fontSize(16)
        .fontColor('#333333')
        .backgroundColor('#E8F4F5')
        .border({ width: 1, color: '#B3DADC' })
        .borderRadius(8)
        .margin({ bottom: 20 })
        // 绑定底部弹窗：添加height配置，让弹窗高度自适应内容
        .bindSheet(
          this.isShowAddSheet,
          this.buildAddRecordSheet,
          {
            height: 100, // 核心：弹窗高度由内容决定，不再占满屏幕
            backgroundColor: Color.Transparent // 透明背景，避免和内部样式冲突
          }
        )
        .onClick(() => {
          this.isShowAddSheet = true;
        });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }
}