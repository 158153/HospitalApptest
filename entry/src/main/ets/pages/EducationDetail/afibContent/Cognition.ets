@Component
struct Cognition {
  build() {
    Column({ space: 16 }) {
      // 房颤的定义
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Circle()
            .width(12)
            .height(12)
            .fill('#FFF2CC')
            .stroke('#E6B89C')
            .strokeWidth(1)
          Text("房颤的定义")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        // 关键修改1：移除垂直居中，确保行内元素左对齐
        .width('100%')

        Text("心房颤动，简称房颤，是一种常见的心律失常。正常情况下，心脏的心房和心室会规律地收缩和舒张，将血液泵送到全身。但在房颤时，心房会以每分钟350-600次的频率快速且不规则地颤动，失去有效的收缩功能。")
          .fontSize(15)
          .fontColor('#555555')
          .lineHeight(24)
          .margin({ left: 20 })
          // 关键修改2：明确设置文本左对齐
          .textAlign(TextAlign.Start)
      }
      .width('100%')

      // 房颤的分类
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Circle()
            .width(12)
            .height(12)
            .fill('#FFE6CC')
            .stroke('#E6B89C')
            .strokeWidth(1)
          Text("房颤的分类")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        // 移除垂直居中，确保左对齐
        .width('100%')

        Column({ space: 12 }) {
          Text("阵发性房颤：持续时间不超过7天，可自行终止或经治疗后终止。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("持续性房颤：持续时间超过7天，未经药物或手术治疗不能自行终止。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("长程持续性房颤：持续时间超过1年，常伴有心脏扩大和心功能下降。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("永久性房颤：患者无意愿恢复正常心律，或医生认为难以恢复正常心律的长程持续性房颤。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
        }
        .margin({ left: 20 })
      }
      .width('100%')

      // 房颤的病因
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Circle()
            .width(12)
            .height(12)
            .fill('#CCE5FF')
            .stroke('#99C2E6')
            .strokeWidth(1)
          Text("房颤的病因")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        // 移除垂直居中，确保左对齐
        .width('100%')

        Column({ space: 12 }) {
          Text("心脏疾病：如冠心病、高血压心脏病、心肌病、风湿性心脏病、充血性心力衰竭、心包炎等。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("非心脏原因：包括肺部疾病、甲状腺疾病、感染、手术、中毒等。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("其他因素：正常人在情绪激动、运动、急性酒精中毒时也可能发生房颤。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("孤立性房颤：无心脏病变的中青年也可能发生房颤。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
        }
        .margin({ left: 20 })
      }
      .width('100%')

      // 房颤的危害
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Circle()
            .width(12)
            .height(12)
            .fill('#B3E6E6')
            .stroke('#66CCCC')
            .strokeWidth(1)
          Text("房颤的危害")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        // 移除垂直居中，确保左对齐
        .width('100%')

        Column({ space: 12 }) {
          Text("卒中风险：房颤患者发生卒中的风险比正常人群高5倍，约20%-30%的脑卒中由房颤引起。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("心力衰竭：20%-30%的房颤患者会出现心衰，表现为气喘、活动能力下降、下肢浮肿等。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
          Text("认知功能下降：房颤患者痴呆风险升高1.4-1.6倍。死亡风险：房颤患者的死亡风险是正常人的3.5倍。")
            .fontSize(15)
            .fontColor('#555555')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
        }
        .margin({ left: 20 })
      }
      .width('100%')

      // 新增更多内容，确保可以滚动
      Text("房颤的临床表现：房颤的临床表现因人而异，部分患者可无明显症状，仅在体检时发现。常见症状包括心悸、胸闷、气短、头晕、乏力等，严重者可出现黑朦、晕厥、胸痛、呼吸困难等。")
        .fontSize(15)
        .fontColor('#555555')
        .lineHeight(24)
        .margin({ left: 20, top: 16 })
        .textAlign(TextAlign.Start)

      Text("房颤的诊断：房颤的诊断主要依靠心电图检查，包括常规心电图、动态心电图等。此外，还需要结合患者的病史、症状、体格检查以及相关的辅助检查，如心脏超声、血液检查等，以明确房颤的类型、病因和合并症。")
        .fontSize(15)
        .fontColor('#555555')
        .lineHeight(24)
        .margin({ left: 20, top: 8 })
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(16)

  }
}

export default Cognition;