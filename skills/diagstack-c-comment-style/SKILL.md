---
name: diagstack-c-comment-style
description: >-
  Write and update C/H comments in tviibe1m/src/DiagStack using the YYH DiagStack
  style from Can/ (file banner, section blocks, Service Name blocks with .h brief
  and .c full, mandatory in-body step comments for complex logic, Doxygen field
  tags). Complex or multi-phase .c functions must include a./1. step comments
  inside the function body, not only the Service Name block. Use when adding or
  editing DiagStack modules, documenting functions, or when the user asks for
  Can-style or DiagStack comment style.
---

# DiagStack C 注释风格（Can 模块规范）

参考基准：`tviibe1m/src/DiagStack/Can/`（Can.h、Can.c、Can_Cfg.h、Can_PBcfg.c）。

## 何时套用

- 新建或修改 `tviibe1m/src/DiagStack/**` 下 `.c` / `.h`
- 用户要求「Can 风格」「DiagStack 注释」「YYH 注释风格」
- 补全函数说明、配置段说明、修订记录

## 语言与语气

- **文件头 / 功能描述 / 步骤注释 / 宏说明**：中文，技术准确、偏 AUTOSAR/驱动层表述
- **分区标题**（Header Files、Static Variables 等）：英文，居中对齐
- **Service Name**：与函数名一致，英文
- 避免口语；可写硬件/协议细节（如 CAN-FD、NVIC、MISRA）

## 1. 文件头（每个 .c / .h 必须有）

```c
/*==============================================================================
* 文件名称 : Can.c
* 作    者 : YYH
* 版    本 : V1.0
* 日    期 : 2026-06-18
==============================================================================
* 功能描述 : 
* [一两句话说明本文件职责；可多行]
*
* 修订记录 :
* V1.0  2026-06-18  YYH  初始发布版本
==============================================================================*/
```

版本升级时在「修订记录」追加一行：`Vx.y  日期  作者  变更摘要`。

## 2. 一级分区（`/*====...====*/`，英文标题居中）

常用分区名（按文件类型选用）：

| 分区 | 用于 |
|------|------|
| Header Files | `#include` 之前 |
| Type Definitions | typedef 前置声明 |
| Data Structure Definitions / Data Types Definition | struct 定义 |
| Macros Definition | `#define` |
| Static Variables | 文件内 static |
| Local Functions | static 函数实现区 |
| Global Variables | 全局变量 |
| Global Function Prototypes | 对外 API 声明 |
| External Declarations | extern |
| Global Functions | 对外 API 实现 |

模板：

```c
/*==================================================================================================
                                        Header Files
==================================================================================================*/
```

## 3. 配置源文件二级分区（Can_PBcfg.c 风格）

大段配置用**编号 + 中英文标题**：

```c
/*==============================================================================
* 1. 硬件过滤器配置 (Rx ID Filters)
==============================================================================*/
/* * 过滤器配置说明:
 * - 采用经典过滤模式...
 */
```

子块用短横线框：

```c
/* ------------------- 句柄2 (M-CAN 0 通道2) 诊断通道过滤器 — 对齐 PK2C BOOT1 ------------------- */
```

## 4. 静态代码块说明（壳函数群、ISR 群等）

```c
/*--------------------------------------------------------------------------------------------------
* 物理通道 Rx 壳函数群 (物理通道 0 ~ 4)
* 由底层硬件中断服务程序(ISR)在成功接收标准/扩展数据帧后直接唤醒。
* 通过强制固化首个参数(0U~4U)，实现面向对象风格的硬件通道标识“自识别”。
--------------------------------------------------------------------------------------------------*/
```

## 5. 函数注释（.h 简写 / .c 完整）

| 位置 | 风格 | 包含字段 |
|------|------|----------|
| 头文件 `.h` | **简写** | Service Name、Description、Author |
| 源文件 `.c` | **完整** | Service Name、Description、Arguments、Return Value、Author |
| `.c` 内 `static`（Local Functions） | **完整** | 同上 |

### 头文件 `.h`（简写）

每个对外 API 原型前必须有块注释，**不写** Arguments / Return Value：

```c
/*==================================================================================================
                                   Global Function Prototypes
==================================================================================================*/
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_Init
* Description : 遍历 g_apstCanCfgTable，初始化所有已注册 CAN 硬件通道
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
void Can_Init(void);
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_ReenableDiagnosticsIrq
* Description : 诊断通道 CAN NVIC 再使能（SROM Prepare 后调用，巩固 CPUIntIdx3）
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
void Can_ReenableDiagnosticsIrq(void);
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_Write
* Description : 发送 CAN 报文到指定硬件通道
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
Std_ReturnType Can_Write(uint8 u8Channel, const Can_PduType* pstPdu);
```

### 源文件 `.c`（完整）

每个函数实现前必须有块注释，**必须写** Arguments / Return Value：

```c
/*==================================================================================================
                                        Global Functions
==================================================================================================*/
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_Init
* Description : 遍历 g_apstCanCfgTable，初始化所有已注册 CAN 硬件通道
* Arguments   : None
* Return Value: None
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
void Can_Init(void)
{
    /* ... */
}
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_ReenableDiagnosticsIrq
* Description : 诊断通道 CAN NVIC 再使能（SROM Prepare 后调用，巩固 CPUIntIdx3）
* Arguments   : None
* Return Value: None
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
void Can_ReenableDiagnosticsIrq(void)
{
    /* ... */
}
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_Write
* Description : 发送 CAN 报文到指定硬件通道
* Arguments   : u8Channel - CAN 通道号
*               pstPdu    - 待发送 PDU 指针
* Return Value: E_OK / E_NOT_OK
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
Std_ReturnType Can_Write(uint8 u8Channel, const Can_PduType* pstPdu)
{
    /* ... */
}
```

### Local Functions（`.c` 内 static，完整风格）

```c
/*==================================================================================================
                                        Local Functions
==================================================================================================*/
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_Internal_ConfigurePins
* Description : 配置当前通道 TX/RX 引脚驱动模式与 HSIOM 复用
* Arguments   : pstIndxMap - 物理引脚映射表项
* Return Value: None
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
static void Can_Internal_ConfigurePins(const Can_PinMapType* pstIndxMap)
{
    /* ... */
}
```

### 填写规则

| 字段 | 头文件 `.h` | 源文件 `.c` |
|------|-------------|-------------|
| Service Name | 必填 | 必填 |
| Description | 必填 | 必填（与 `.h` 一致） |
| Arguments | **不写** | 必填（无参写 `None`） |
| Return Value | **不写** | 必填（`void` 写 `None`） |
| Author | 必填 | 必填 |

**原则**：`.h` 与 `.c` 中同一函数的 Service Name、Description、Author 保持一致；参数和返回值**只在 `.c` 中写**。

- 多个参数各占一行，`name - 说明`，参数名对齐缩进
- **每个函数都要有块注释**，不能只给第一个函数加注释

**禁止写法**：

```c
/* 诊断通道 CAN NVIC 再使能 */          /* ❌ 单行注释代替 Service Name 块 */
void Can_ReenableDiagnosticsIrq(void);

// 初始化 CAN                          /* ❌ // 注释 */
void Can_Init(void);
```

**快速对照**：`.h` → Service Name + Description + Author；`.c` → Service Name + Description + Arguments + Return Value + Author

## 6. 函数体内步骤注释（**必填**）

Service Name 块注释只描述函数职责；**函数体内必须写步骤注释**，让读者无需逐行读代码即可理解控制流。复杂函数（多阶段状态机、分步擦写/下载、长分支、错误回滚路径）**禁止**只写块头、函数体零注释。

### 格式

用字母或数字序号 + 中文冒号说明：

```c
    /* a. 安全拦截：防止空指针引发内核硬件异常 */
    /* b. 引脚配置初始化：配置当前通道 TX 和 RX 引脚... */
    /* 1. 动态拓扑反向挂载：将上方的壳函数无缝动态挂载... */
    /* 2. 协议家族选择：配置协议模式 (经典 CAN 或是 CAN-FD 模式) */
```

- 顶层流程 / 阶段切换：`a.` `b.` `c.` …
- 同阶段子步骤：`1.` `2.` `3.` …
- MISRA / 边界检查 / 失败路径可单独一句注释
- 注释写**阶段意图、守卫条件、失败后果**，不要复述函数名或逐行翻译代码

### 何时必须写

| 函数特征 | 要求 |
|----------|------|
| 多 `if`/`switch` 分支、状态机、分步 PENDING 返回 | 每个阶段/分支入口必须有 `a.` 步骤注释 |
| 阶段内多步校验或硬件操作 | 阶段内用 `1.` `2.` 子步骤 |
| 简单 3 行以内直线逻辑（如 getter） | 可只写一条总述或省略 |
| 错误返回前设置 NRC / Abort | 在对应阶段注释中说明失败语义 |

### 合格 / 不合格对照

**不合格**（只有块头，函数体无步骤）：

```c
/*
---------------------------------------------------------------------------------------------------
* Service Name: Boot1_Download_FinishStep
* Description : 0x37 分步完成：校验、擦活动区、拷贝、更新 FlagPara 元数据
* Arguments   : pnrc - 可选负响应码输出指针
* Return Value: BOOT1_FINISH_OK / BOOT1_FINISH_PENDING / BOOT1_FINISH_FAIL
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
Boot1_FinishResultType Boot1_Download_FinishStep(Dcm_NegativeRespType* pnrc)
{
    if (NULL != pnrc) { *pnrc = DCM_NRC_OK; }
    if (s_eState != BOOT1_DL_TRANSFERRING) { ... }
    if (s_eFinishPhase == BOOT1_FINISH_PHASE_IDLE) { ... }
    ...
}
```

**合格**（块头 + 体内 `a.`/`1.` 步骤，见 [examples.md](examples.md) 中 `Boot1_Download_FinishStep` 完整示例）：

```c
Boot1_FinishResultType Boot1_Download_FinishStep(Dcm_NegativeRespType* pnrc)
{
    /* a. 可选输出初始化：默认 NRC 为 OK */
    ...
    /* b. 时序守卫：仅允许在 Transferring 态进入分步完成 */
    ...
    /* c. IDLE 入口：长度校验、流刷盘、镜像校验，再切入擦除阶段 */
    if (s_eFinishPhase == BOOT1_FINISH_PHASE_IDLE)
    {
        /* 1. 接收长度必须与约定镜像大小一致 */
        ...
    }
    /* e. ERASE：按扇区擦活动 Boot2，单次返回 PENDING */
    ...
}
```

## 7. 结构体 / 宏 / 成员

**结构体成员**（行尾 Doxygen）：

```c
    uint8_t u8UnitId;       /**< 硬件单元物理索引号 (例如: 0=CAN0_CH0, 1=CAN0_CH1...) */
```

**宏**（行尾块注释，说明用途与取值含义）：

```c
#define CAN_DIAG_CONTROLLER_ID              (2U)  /* 诊断 / UDS / FOTA 报文绑定的 CAN 物理通道 ID */
```

**初始化表项**（`.member = value, /* 中文说明 */`）：

```c
        .pfnTxCb        = Can_FD0_TxMsgCallback,            /* 硬件发送完成中断回调函数指针 */
```

## 8. 文件尾

```c
#endif /* CAN_H */
/* [] END OF FILE */
```

## 9. 不要做的事

- 不要用 `//` 或单行 `/* */` 替代 Service Name 块注释（本风格以 `/* */` 块为主）
- 不要在 `.h` 中写 Arguments / Return Value（参数与返回值仅在 `.c` 中写）
- **禁止复杂函数只写 Service Name 块、函数体零步骤注释**（多阶段/多分支 `.c` 必须有 `a.`/`1.` 体内注释）
- 不要省略文件头与 END OF FILE
- 分区标题不要改成纯中文（保持 Header Files 等英文）
- 不要写与代码无关的冗长背景

## 示例

完整片段见 [examples.md](examples.md)（Can 模块 + `Boot1_Download_FinishStep` 复杂分步函数）。
