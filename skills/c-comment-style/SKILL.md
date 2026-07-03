---
name: c-comment-style
description: >-
  Write C/H function block comments with .h brief (Service Name, Description, Author)
  and .c full (add Arguments, Return Value). Use when adding function comments,
  documenting APIs, or when the user asks for comment style, Service Name blocks,
  or @c-comment-style.
---

# C 函数注释风格（.h 简写 / .c 完整）

适用于 DiagStack 及同类嵌入式 C 驱动代码。与 `diagstack-c-comment-style` 配合使用：本 Skill 专管**函数块注释**的 .h / .c 分工。

## 注释风格分工

| 位置 | 风格 | 包含字段 |
|------|------|----------|
| 头文件 `.h` | **简写** | Service Name、Description、Author |
| 源文件 `.c` | **完整** | Service Name、Description、Arguments、Return Value、Author |
| `.c` 内 `static`（Local Functions） | **完整** | 同上 |

## 头文件 `.h`（简写）

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

## 源文件 `.c`（完整）

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

## Local Functions（`.c` 内 static，完整风格）

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

## 填写规则

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

## 禁止写法

```c
/* 诊断通道 CAN NVIC 再使能 */          /* ❌ 单行注释代替 Service Name 块 */
void Can_ReenableDiagnosticsIrq(void);

// 初始化 CAN                          /* ❌ // 注释 */
void Can_Init(void);
```

## 快速对照

- `.h` → Service Name + Description + Author
- `.c` → Service Name + Description + Arguments + Return Value + Author
