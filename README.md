# Cursor DiagStack Skills

PK2C / Traveo II 诊断栈（DiagStack）相关的 [Cursor Agent Skills](https://cursor.com/docs/agent/skills) 集合。

当前包含基于 `tviibe1m/src/DiagStack/Can/` 模块提炼的 **C/H 文件注释规范**，供 Cursor Agent 在编写或补全 DiagStack 代码时自动遵循。

## 仓库结构

```
cursor-diagstack-skills/
├── README.md
├── LICENSE
├── skills/
│   └── diagstack-c-comment-style/
│       ├── SKILL.md       # Agent 主规范（YAML frontmatter + 规则）
│       └── examples.md    # Can 模块真实代码摘抄
└── scripts/
    ├── install.ps1        # Windows 安装到 ~/.cursor/skills/
    └── install.sh         # macOS / Linux 安装
```

## 快速安装

### 方式 A：全局安装（推荐，所有工程可用）

**Windows (PowerShell):**

```powershell
git clone https://github.com/YOUR_USER/cursor-diagstack-skills.git
cd cursor-diagstack-skills
.\scripts\install.ps1
```

**macOS / Linux:**

```bash
git clone https://github.com/YOUR_USER/cursor-diagstack-skills.git
cd cursor-diagstack-skills
chmod +x scripts/install.sh
./scripts/install.sh
```

安装目标：`~/.cursor/skills/diagstack-c-comment-style/`

### 方式 B：仅当前项目

将 `skills/diagstack-c-comment-style/` 复制到项目根目录：

```
your-project/.cursor/skills/diagstack-c-comment-style/
```

## 使用方式

在 Cursor 对话中说例如：

- 「按 DiagStack Can 注释风格给 Boot0_Download.c 加注释」
- 「用 diagstack-c-comment-style 规范补全这个头文件」

Agent 会加载 Skill 并按规范生成：

- 文件头（文件名称 / 作者 / 版本 / 修订记录）
- 英文分区标题（Header Files、Static Variables …）
- Service Name 函数块
- `a.` / `1.` 步骤注释
- `/**< */` 成员说明

## Skill 列表

| Skill | 说明 |
|-------|------|
| [diagstack-c-comment-style](skills/diagstack-c-comment-style/SKILL.md) | DiagStack C/H 注释风格（源自 Can 模块） |

## 参考源码

规范提炼自：

- `Can.h` / `Can.c` — 驱动层实现与 API
- `Can_Cfg.h` — 静态配置与类型
- `Can_PBcfg.c` — Post-Build 过滤器与映射表

典型工程路径：`tviibe1m/src/DiagStack/Can/`

## 贡献

欢迎提交 PR 增加 Dcm、CanTp、CanIf 等模块的注释规范或新 Skill。

1. Fork 本仓库
2. 在 `skills/` 下新建目录，包含 `SKILL.md`（必填）及可选 `examples.md`
3. 更新本 README 的 Skill 列表
4. 提交 Pull Request

## License

MIT — 见 [LICENSE](LICENSE)
