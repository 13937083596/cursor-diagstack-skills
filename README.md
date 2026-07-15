# Cursor DiagStack Skills

PK2C / Traveo II 诊断栈（DiagStack）相关的 [Cursor Agent Skills](https://cursor.com/docs/agent/skills) 集合。

短调用名（对话里直接说即可）：

| 调用 | 款式 | 行为 |
|------|------|------|
| **`dsc-a`** | A款 | **只加注释**，不改可执行逻辑 |
| **`dsc-b`** | B款 | 先按 A款加注释，再按 **MISRA C** 改码 |

注释规范：`.h` 简写 Service Name；`.c` 完整（含 Arguments / Return Value）；复杂函数体内必写 `a.` / `1.` 步骤注释。

## 仓库结构

```
cursor-diagstack-skills/
├── README.md
├── LICENSE
├── skills/
│   ├── dsc-a/                 # A款：只注释
│   │   ├── SKILL.md
│   │   └── examples.md
│   └── dsc-b/                 # B款：注释 + MISRA 改码
│       ├── SKILL.md
│       └── examples.md
└── scripts/
    ├── install.ps1
    └── install.sh
```

## 发布到 GitHub（维护者）

本地仓库路径：`cursor-diagstack-skills/`（与 FirstBoot 工程同级目录）

**前提**：已安装 [GitHub CLI](https://cli.github.com/) 并完成登录：

```powershell
gh auth login -h github.com -p https -w
```

**一键创建远程仓库并推送：**

```powershell
cd cursor-diagstack-skills
.\scripts\publish.ps1
```

可选参数：`-RepoName`、`-Visibility private`、`-Description "..."`

**手动方式：**

```powershell
cd cursor-diagstack-skills
git branch -M main
gh repo create cursor-diagstack-skills --public --source=. --remote=origin --push
```

创建成功后，仓库地址：https://github.com/13937083596/cursor-diagstack-skills

## 快速安装

### 方式 A：全局安装（推荐，所有工程可用）

**Windows (PowerShell):**

```powershell
git clone https://github.com/13937083596/cursor-diagstack-skills.git
cd cursor-diagstack-skills
.\scripts\install.ps1
```

**macOS / Linux:**

```bash
git clone https://github.com/13937083596/cursor-diagstack-skills.git
cd cursor-diagstack-skills
chmod +x scripts/install.sh
./scripts/install.sh
```

安装目标：

- `~/.cursor/skills/dsc-a/`
- `~/.cursor/skills/dsc-b/`

### 方式 B：仅当前项目

将 skill 目录复制到项目：

```
your-project/.cursor/skills/dsc-a/
your-project/.cursor/skills/dsc-b/
```

## 使用方式

在 Cursor 对话中说例如：

- 「用 **dsc-a** 给 Boot1_Download.c 只加注释」
- 「**A款**：按 DiagStack 风格补注释，别改逻辑」
- 「用 **dsc-b** 给这个函数加注释并按 MISRA 改码」
- 「**B款**：注释 + MISRA 修一下 FinishStep」

Agent 会加载对应 Skill：

**dsc-a（A款）**

- 文件头 / 英文分区 / Service Name 块
- 复杂函数体内 `a.` / `1.` 步骤注释
- **不改**语句、控制流、返回值

**dsc-b（B款）**

- 先完成 A款全部注释
- 再按 MISRA：Yoda 比较、强制大括号、`0U` 后缀、`(void)` 丢弃返回值、`default` 等改码

## Skill 列表

| Skill | 说明 |
|-------|------|
| [dsc-a](skills/dsc-a/SKILL.md) | A款：DiagStack 只加注释 |
| [dsc-b](skills/dsc-b/SKILL.md) | B款：注释 + MISRA C 改码 |

> 旧名 `diagstack-c-comment-style` 已废弃，安装脚本会删除遗留目录。请改用 `dsc-a` / `dsc-b`。

## 参考源码

规范提炼自：

- `Can.h` / `Can.c` — 驱动层实现与 API
- `Can_Cfg.h` — 静态配置与类型
- `Can_PBcfg.c` — Post-Build 过滤器与映射表
- Boot 分步下载等复杂状态机函数（体内步骤注释范例）

典型工程路径：`tviibe1m/src/DiagStack/Can/`

## 贡献

欢迎提交 PR 增加 Dcm、CanTp、CanIf 等模块的注释规范或新 Skill。

1. Fork 本仓库
2. 在 `skills/` 下新建目录，包含 `SKILL.md`（必填）及可选 `examples.md`
3. 更新本 README 的 Skill 列表
4. 提交 Pull Request

## License

MIT — 见 [LICENSE](LICENSE)
