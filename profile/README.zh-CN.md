<p align="center">
  <img src="https://avatars.githubusercontent.com/u/309981672?v=4" alt="ByteFolk 组织头像" width="72" height="72">
</p>

<h1 align="center">ByteFolk</h1>

<p align="center">
  <strong>你的团队，你的数据，你的基础设施。</strong><br>
  让人与 AI Agent 一起工作的开源、自托管工具。
</p>

<p align="center">
  <a href="https://github.com/bytefolk/roleweave/releases/latest">下载 RoleWeave</a> ·
  <a href="https://github.com/bytefolk/digital-employee-quickstart/blob/main/README.zh-CN.md">体验 CLI</a> ·
  <a href="https://github.com/bytefolk/.github/blob/main/profile/README.md">English</a>
</p>

ByteFolk 帮助你组织 AI 员工、积累有用的知识并协作文档。
从桌面应用或可移植的 CLI 员工包开始，再按需接入团队需要的服务。

## 从你要做的事开始

### 想直接使用桌面工作台 → [RoleWeave](https://github.com/bytefolk/roleweave)

创建项目、组织数字员工，按岗位发起对话。在本地工作区里管理组织、文档和任务历史。

**桌面预览版已发布。** [macOS Apple Silicon](https://github.com/bytefolk/roleweave/releases/download/v0.1.1/roleweave-0.1.1-arm64.dmg) · [Windows x64](https://github.com/bytefolk/roleweave/releases/download/v0.1.1/roleweave-0.1.1-x64.exe) · [版本说明](https://github.com/bytefolk/roleweave/releases/tag/v0.1.1)

> 当前 v0.1.1 安装包面向 macOS Apple Silicon 和 Windows x64。安装包尚无
> Apple Developer ID 签名/公证或 Windows Authenticode 签名，安装或首次启动
> 可能出现安全提示。默认桌面 Host 需要本机安装 Qoder CLI 1.1.x，并具备可用的账号权限。

[开始使用](https://github.com/bytefolk/roleweave#get-started) · [最新版本](https://github.com/bytefolk/roleweave/releases/latest)

### 想从命令行构建员工 → [Digital Employee](https://github.com/bytefolk/digital-employee)

把岗位指令、已审核的知识和验收用例封装成可复用的员工包。
先在本地校验，再交给已配置、受支持的 Agent Host 执行。

**无需凭据即可开始：** [运行官方示例](https://github.com/bytefolk/digital-employee-quickstart/blob/main/README.zh-CN.md)。
快速开始固定使用已发布的 CLI 版本，通过离线用例检查包契约，不调用模型。
运行真实任务需要配置 AI Host。

[CLI 版本](https://github.com/bytefolk/digital-employee/releases/latest) · [示例库](https://github.com/bytefolk/digital-employee-quickstart#cases)

## 按需选择组件

各项目均有独立的配置指引，可以单独探索。

| 项目 | 帮你做什么 | 从这里开始 |
| --- | --- | --- |
| [mem](https://github.com/bytefolk/mem) | 保存文件、记忆和任务检查点，并保留来源。 | [MCP 下载](https://github.com/bytefolk/mem/releases/latest) · [服务部署](https://github.com/bytefolk/mem/blob/main/docs/RUN_LOCAL.md) |
| [doc](https://github.com/bytefolk/doc) | 让人和 Agent 编写、分享、协作文档。 | [本地启动](https://github.com/bytefolk/doc/blob/main/docs/RUN_LOCAL.md) |
| [design-system](https://github.com/bytefolk/design-system) | 用共享设计变量和组件构建一致的界面。 | [开发指引](https://github.com/bytefolk/design-system#develop-and-verify) |

**可用范围：** mem 仍为实验性项目，已发布的 MCP 适配器需要连接运行中的 mem 服务，
Web/API 部署方法见仓库文档。doc 与 design-system 目前提供源码启动指引，
尚无 GitHub Release。

[Ordane](https://github.com/bytefolk/ordane) 仓库提供静态宣传站源码。
使用已发布的桌面应用，请从上面的 RoleWeave 入口开始。

## 面向开发者和 AI 助手

按能力找到负责它的仓库：

- **员工包与执行：** [Digital Employee CLI 与契约](https://github.com/bytefolk/digital-employee)。
- **桌面工作流与本地自动化：** [RoleWeave API 参考](https://github.com/bytefolk/roleweave/blob/main/docs/api-contract-v0.md)。
- **文件、记忆与检索：** [mem 配置与接口](https://github.com/bytefolk/mem)。
- **文档编辑与协作：** [doc 能力说明](https://github.com/bytefolk/doc/blob/main/docs/CAPABILITIES.md)。

使用 API 或描述能力前，先核对已安装版本与其发布说明。`main` 中的源码可能领先于
已发布的包。凭据放在对应服务的配置环境中，不写入提示词或提交到仓库。
本地存储工作区不代表模型离线执行：已配置的 AI Host 可能将任务内容发送给模型服务商。

## 一起改进

- **体验产品：** 下载 RoleWeave，或运行上面的 CLI 示例。
- **反馈问题：** 到所用项目的 Issues 提供复现步骤和脱敏输出，不上传 token 或私有工作区数据。
- **参与开发：** 从 Issue 开始，提交小而清晰的 PR 和可复现检查，经过 CI 与独立评审。
- **报告漏洞：** 使用对应仓库的 **Security** 私密报告入口，不提交到公开 Issue。

[贡献指南](https://github.com/bytefolk/.github/blob/main/CONTRIBUTING.md) · [治理规则](https://github.com/bytefolk/.github/blob/main/GOVERNANCE.md) · [安全](https://github.com/bytefolk/.github/blob/main/SECURITY.md) · [支持](https://github.com/bytefolk/.github/blob/main/SUPPORT.md) · [行为准则](https://github.com/bytefolk/.github/blob/main/CODE_OF_CONDUCT.md)
