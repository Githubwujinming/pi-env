# pi-env

多 pi 环境管理工具。创建、克隆、导入导出、切换多个独立的 pi-coding-agent 环境。

## 安装

```bash
# 方式一：一键安装
curl -sL https://raw.githubusercontent.com/Githubwujinming/pi-env/main/install.sh | bash

# 方式二：从仓库安装
git clone https://github.com/Githubwujinming/pi-env.git
cd pi-env
./install.sh
```

## 快速开始

```bash
# 创建一个空白环境
pi-env create test

# 启动它
pi-test

# 从当前环境克隆一份
pi-env create rpiv-test --clone current

# 创建并设为默认
pi-env create work --use

# 导出包列表
pi-env export

# 从文件导入包
pi-env import test pi-packages.txt
```

## 推荐包

推荐安装包列表见 [`vibecoding_pkgs.txt`](vibecoding_pkgs.txt)。

一行命令创建新环境并安装全部推荐包：

```bash
pi-env create vibe --use --import vibecoding_pkgs.txt
```

## 命令

| 命令 | 说明 |
|------|------|
| `create <名称>` | 创建空白新环境 |
| `create <名称> --clone <来源>` | 从指定环境克隆 |
| `create <名称> --use` | 创建后立即设为默认 |
| `create <名称> --import <文件>` | 创建后导入包列表 |
| `use <名称>` | 设置默认 pi 指向的环境 |
| `delete <名称>` | 删除环境 |
| `export [名称] [文件]` | 导出环境包列表 |
| `import <名称> [文件]` | 从文件导入包到指定环境 |
| `list` | 列出所有环境 |
| `status` | 查看当前状态 |

## 环境管理

每个环境对应一个配置目录 `~/.pi/agent-<名称>/`，互不干扰。

- `pi` 命令默认读取 `~/.pi/agent/`（软链指向当前环境）
- `pi-<名称>` 命令通过 `PI_CODING_AGENT_DIR` 直接启动指定环境
- `pi-env use <名称>` 切换软链指向，改变 `pi` 的默认环境

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `PI_ENV_DIR` | `~/.pi` | pi 配置根目录 |
| `PI_ENV_BIN` | `~/.local/bin` | 命令安装目录 |

## 依赖

| 依赖 | 必须 | 用于 | 备注 |
|------|------|------|------|
| **pi-coding-agent** | 是 | 所有命令 | 被管理的目标工具。安装脚本会检测，不存在则报错退出。 |
| **Node.js** (`node`) | 是 | `pi-env export` | 解析 `settings.json`。pi 本身就需要 Node.js，通常已具备。 |
| **Perl** | 仅 macOS | `abs_path()` 回退实现 | macOS 预装。Linux 直接使用 `readlink -f`。 |
| **curl** 或 **wget** | 远程安装 | `install.sh` | 一键安装方式至少需要其一。 |

## 许可证

MIT
