# AI财经简报 - 报告查看器

## Concept & Vision

一个优雅的财经简报平台，简洁明亮的浅色背景配合精致的排版，营造出专业而现代的阅读体验。支持按日期筛选报告，配以流畅的动画过渡，让查看报告成为一种享受。

## Design Language

### Aesthetic Direction
浅色主题、清晰层次、优雅动效。强调内容优先，减少视觉噪音。参考高端金融终端的设计语言。

### Color Palette
```css
--bg: #fafaf8;                    /* 米白纸张色 */
--bg-sidebar: #1c1917;            /* 深炭黑侧边栏 */
--text: #292524;                  /* 深棕正文 */
--text-light: #78716c;           /* 次级文字 */
--text-muted: #a8a29e;           /* 弱化文字 */
--accent: #b45309;                /* 琥珀色强调 */
--accent-light: #fef3c7;          /* 强调背景 */
--border: #e7e5e4;                /* 边框 */
--border-dark: #44403c;          /* 侧边栏边框 */
--card: #ffffff;                 /* 卡片背景 */
```

### Typography
- 标题: `"Crimson Pro", Georgia, serif` — 优雅衬线字体
- 正文: `"Source Sans 3", -apple-system, BlinkMacSystemFont, sans-serif` — 高可读性
- 数据: `"JetBrains Mono", monospace` — 等宽清晰

### Motion Philosophy
- 入场动画: opacity 0→1, translateY 12px→0, 500ms ease-out
- 悬停反馈: 150ms ease-out, 轻微 border-color 和 transform 变化
- 页面切换: instant（无过渡）

### Visual Assets
- 图标: SVG 商业图标（锁定、日历、警告等）
- 装饰: 极简边框、左侧彩色竖线区块标识
- 无背景纹理

## Layout & Structure

### 页面结构
```
┌─────────────────────────────────────────────────┐
│  [Logo] AI财经简报    [AI ContestTrade] [🔒]   │  Header (深色)
├─────────────────────────────────────────────────┤
│  [📅 日期选择器]  [宏观资讯] [投资信号]        │  Content Toolbar
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌─────────────────────────────────────────┐   │
│  │                                         │   │
│  │           报告内容区域                   │   │
│  │      (Markdown 渲染)                    │   │
│  │                                         │   │
│  └─────────────────────────────────────────┘   │
│                                                 │
│                    [GitHub图标]                  │  Footer
└─────────────────────────────────────────────────┘
```

### 响应式策略
- Desktop (>1024px): 最大宽度 900px，居中布局
- Tablet (768-1024px): 满宽布局
- Mobile (<768px): 单列布局，日历弹出式

## Features & Interactions

### 1. 密码验证
- 首次访问显示密码输入界面
- 密码: `report2026` (可配置)
- 验证成功保存 session token (24小时有效)
- 错误时显示 shake 动画和错误提示

### 2. 日期筛选器
- 日历选择器位于内容区域顶部，与报告类型 tab 并排
- 默认显示今天
- 选择日期后自动加载对应报告
- 有报告的日期高亮显示
- 无报告日期显示空状态，清空之前的内容

### 3. 报告类型切换
- 宏观资讯 (data_reports)
- 投资信号 (research_reports)
- 仅有一种类型时不显示 tab

### 4. 报告加载
- 读取 `data_reports/` 和 `research_reports/` 目录
- 按日期匹配: `*_YYYY-MM-DD_*.md`
- 解析 Markdown 并渲染为 HTML

### 5. 免责声明
- 使用统一默认文本
- 显示报告生成时间和系统版本 v2.0

## Component Inventory

### Password Gate
- 全屏深色渐变背景
- 居中输入卡片
- Logo + 标题
- 密码输入框 (带 placeholder)
- 提交按钮
- States: default, loading, error (shake), success (fade out)

### Header
- Logo/标题 (左侧) - AI财经简报
- 副标题 (右侧) - AI ContestTrade
- 锁定按钮 (右侧)

### Content Toolbar
- 日期触发按钮 (左)
- 报告类型 tab (右)
- 日历弹出层

### Date Picker (日历)
- 月份导航
- 星期标题
- 日期网格
- 图例：有报告、今天
- 选中高亮

### Report Viewer
- 渲染后的 Markdown 内容
- 标题层级样式
- 代码块高亮
- 表格样式
- 引用块样式

### Block Indicator (区块标识)
- 左侧彩色竖线替代图标
- 简洁的视觉分区

### Disclaimer
- 统一默认文本
- 元信息：报告生成时间、系统版本

### Empty State
- 日历图标
- "暂无报告" 文字
- 建议选择其他日期

### Footer
- GitHub 图标链接
- 居中显示

## Technical Approach

### Architecture
- 单 HTML 文件，包含内联 CSS 和 JS
- 无需构建工具，纯浏览器运行
- Marked.js 渲染 Markdown

### 配置项 (文件顶部)
```javascript
const CONFIG = {
  password: "report2026",
  sessionKey: "reportHub_session",
  sessionDuration: 86400000,
  reportDirs: ["data_reports", "research_reports"],
  reportLabels: { data_reports: "宏观资讯", research_reports: "投资信号" }
};
```

### 安全
- 密码使用 SHA-256 哈希验证
- Session token 存储在 localStorage
- 无后端，纯前端验证

### 部署
- 纯静态 HTML，无需构建
- 所有资源内联或 CDN
- 单一 index.html 部署
