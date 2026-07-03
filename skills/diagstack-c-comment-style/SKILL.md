---
name: diagstack-c-comment-style
description: >-
  Write and update C/H comments in tviibe1m/src/DiagStack using the YYH DiagStack
  style from Can/ (file banner, section blocks, Service Name blocks, step comments,
  Doxygen field tags). Use when adding or editing DiagStack modules, documenting
  functions, or when the user asks for Can-style or DiagStack comment style.
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

## 5. 函数注释

### 对外 / 重要 static 函数（完整块）

```c
/*
---------------------------------------------------------------------------------------------------
* Service Name: Can_Init
* Description : CAN 驱动层主初始化入口，遍历并配置所有注册激活的 CAN 硬件控制器
* Arguments   : pstHandle - 指向当前待配置通道静态全局配置结构体的指针
* Return Value: None
* Author      : YYH
---------------------------------------------------------------------------------------------------
*/
```

- `Arguments` / `Return Value`：有则写，无则省略（如 Can_Init 仅 Description + Author）
- 多个参数各占一行，`name - 说明`

### 简短 API（一行说明）

```c
/*
 * 诊断通道 CAN NVIC 再使能（SROM Prepare 后调用，巩固 CPUIntIdx3）。
 */
```

## 6. 函数体内步骤注释

用字母或数字序号 + 中文冒号说明：

```c
    /* a. 安全拦截：防止空指针引发内核硬件异常 */
    /* b. 引脚配置初始化：配置当前通道 TX 和 RX 引脚... */
    /* 1. 动态拓扑反向挂载：将上方的壳函数无缝动态挂载... */
    /* 2. 协议家族选择：配置协议模式 (经典 CAN 或是 CAN-FD 模式) */
```

- 顶层流程：`a.` `b.` `c.` …
- 同层子步骤：`1.` `2.` `3.` …
- MISRA / 边界检查可单独一句注释

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

- 不要用 `//` 替代上述块注释（本风格以 `/* */` 为主）
- 不要省略文件头与 END OF FILE
- 分区标题不要改成纯中文（保持 Header Files 等英文）
- 不要写与代码无关的冗长背景

## 示例

完整片段见 [examples.md](examples.md)（摘自 Can 模块）。
