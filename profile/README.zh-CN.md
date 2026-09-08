<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/bytefolk/.github/main/brand/bytefolk/symbol-reversed.svg">
    <img src="https://raw.githubusercontent.com/bytefolk/.github/main/brand/bytefolk/symbol.svg" alt="ByteFolk 标志" width="72" height="72">
  </picture>
</p>

<h1 align="center">ByteFolk</h1>

<p align="center">
  <strong>你的团队，你的数据，你的基础设施。</strong><br>
  让人与 AI Agent 一起工作的开源工具。
</p>

<p align="center">
  <a href="https://github.com/bytefolk/roleweave/releases/latest">下载 RoleWeave</a> ·
  <a href="https://github.com/bytefolk/digital-employee-quickstart/blob/main/README.zh-CN.md">体验 CLI</a> ·
  <a href="https://github.com/bytefolk/.github/blob/main/profile/README.md">English</a>
</p>

## 从你要做的事开始

### 想直接使用桌面工作台 → [RoleWeave](https://github.com/bytefolk/roleweave)

创建项目、组织数字员工，按岗位发起对话。在本地工作区里管理组织、文档和任务历史。

**v0.1.1 已发布。** [macOS Apple Silicon](https://github.com/bytefolk/roleweave/releases/download/v0.1.1/roleweave-0.1.1-arm64.dmg) · [Windows x64](https://github.com/bytefolk/roleweave/releases/download/v0.1.1/roleweave-0.1.1-x64.exe) · [版本说明](https://github.com/bytefolk/roleweave/releases/tag/v0.1.1)

> 当前是早期版本。执行任务需要先配置 Agent Host。安装包尚无 Apple 公证或 Windows
> Authenticode 签名，首次启动可能出现安全提示，请先阅读版本说明。

### 想从命令行构建员工 → [Digital Employee](https://github.com/bytefolk/digital-employee)

把岗位指令、已审核的知识和验收用例封装成可复用的员工包。
先在本地校验，再交给已配置、受支持的 Agent Host 执行。

**无需凭据即可开始：** [运行官方示例](https://github.com/bytefolk/digital-employee-quickstart/blob/main/README.zh-CN.md)。
快速开始使用已发布的 CLI 和离线用例，不调用模型；检查通过说明包契约有效，
不代表 AI 回答质量已经得到验证。

[CLI 版本](https://github.com/bytefolk/digital-employee/releases/latest) · [示例库](https://github.com/bytefolk/digital-employee-quickstart#cases)

## 按需选择组件

各项目可以独立使用。服务之间的连接需要单独配置和授权；列在同一主页上，
不代表所有集成已经开箱即用。

| 项目 | 帮你做什么 | 从这里开始 |
| --- | --- | --- |
| [mem](https://github.com/bytefolk/mem) | 保存文件、记忆和任务检查点，并保留来源。 | [MCP 下载](https://github.com/bytefolk/mem/releases/latest) · [服务部署](https://github.com/bytefolk/mem#快速开始) |
| [doc](https://github.com/bytefolk/doc) | 让人和 Agent 编写、分享、协作文档。 | [本地启动](https://github.com/bytefolk/doc/blob/main/docs/RUN_LOCAL.md) |
| [design-system](https://github.com/bytefolk/design-system) | 用共享设计变量和组件构建一致的界面。 | [开发指引](https://github.com/bytefolk/design-system#develop-and-verify) |

**可用范围：** mem 仍为实验性项目，已发布的 MCP 适配器需要连接运行中的 mem 服务，
Web/API 部署方法见仓库文档。doc 与 design-system 目前提供源码预览，
不是已打包的稳定版本。重要数据请保留备份。

## 一起改进

- **体验产品：** 下载 RoleWeave，或运行上面的 CLI 示例。
- **反馈问题：** 到所用项目的 Issues 提供复现步骤和脱敏输出，不上传 token 或私有工作区数据。
- **参与开发：** 从 Issue 开始，提交小而清晰的 PR 和可复现检查，经过 CI 与独立评审。
- **报告漏洞：** 使用对应仓库的 **Security** 私密报告入口，不提交到公开 Issue。

[贡献指南](https://github.com/bytefolk/.github/blob/main/CONTRIBUTING.md) · [治理规则](https://github.com/bytefolk/.github/blob/main/GOVERNANCE.md) · [安全](https://github.com/bytefolk/.github/blob/main/SECURITY.md) · [支持](https://github.com/bytefolk/.github/blob/main/SUPPORT.md) · [行为准则](https://github.com/bytefolk/.github/blob/main/CODE_OF_CONDUCT.md)
