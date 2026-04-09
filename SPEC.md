# Report Viewer - 报告查看器

## Concept & Vision

一个优雅的报告查看平台，灵感来自 Claude.ai 的极简主义美学。深邃的暗色调配合精致的渐变和排版，营造出专业而现代的阅读体验。支持按日期筛选报告，配以流畅的动画过渡，让查看报告成为一种享受。

## Design Language

### Aesthetic Direction
参考 Claude.ai 的设计语言：深邃暗色背景、精致渐变、清晰层次、优雅动效。强调内容优先，减少视觉噪音。

### Color Palette
```css
--bg-primary: #0f0f0f;        /* 主背景 */
--bg-secondary: #1a1a1a;       /* 次级背景/卡片 */
--bg-tertiary: #242424;       /* 悬停/激活态 */
--border: #333333;            /* 边框 */
--text-primary: #ffffff;      /* 主文字 */
--text-secondary: #a0a0a0;   /* 次级文字 */
--text-muted: #666666;        /* 弱化文字 */
--accent: #d97706;            /* 琥珀色强调 */
--accent-gradient: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
--success: #22c55e;
--error: #ef4444;
```

### Typography
- 标题: `"Instrument Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif`
- 正文: `"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif`
- 代码/报告: `"JetBrains Mono", "SF Mono", monospace`

### Motion Philosophy
- 入场动画: opacity 0→1, translateY 20px→0, 500ms cubic-bezier(0.16, 1, 0.3, 1)
- 交错延迟: 子元素依次延迟 80ms 进场
- 悬停反馈: 150ms ease-out, 轻微 scale 和 shadow 提升
- 页面切换: crossfade 300ms

### Visual Assets
- 图标: Lucide Icons (内联 SVG)
- 装饰: 微妙的网格背景、渐变光晕
- 纹理: 极淡的噪点叠加增加深度

## Layout & Structure

### 页面结构
```
┌─────────────────────────────────────────────────┐
│  [Logo] 报告查看器              [🔒 锁定] [日期] │  Header
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌─────────────────────────────────────────┐   │
│  │                                         │   │
│  │           报告内容区域                   │   │
│  │      (Markdown 渲染)                    │   │
│  │                                         │   │
│  └─────────────────────────────────────────┘   │
│                                                 │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐  │  报告卡片列表
│  │ 报告1  │ │ 报告2  │ │ 报告3  │ │ 报告4  │  │
│  └────────┘ └────────┘ └────────┘ └────────┘  │
│                                                 │
└─────────────────────────────────────────────────┘
```

### 响应式策略
- Desktop (>1024px): 最大宽度 1200px，居中布局
- Tablet (768-1024px): 满宽布局，卡片 2 列
- Mobile (<768px): 单列布局，简化头部

## Features & Interactions

### 1. 密码验证
- 首次访问显示密码输入界面
- 密码: `report2026` (可配置)
- 验证成功保存 session token (24小时有效)
- 错误时显示 shake 动画和错误提示

### 2. 日期筛选器
- 日历选择器支持选择任意日期
- 默认显示今天
- 选择日期后自动加载对应报告
- 未来日期显示"暂无报告"提示，但保留界面

### 3. 报告加载
- 读取 `data_reports/` 和 `research_reports/` 目录
- 按日期匹配: `*_YYYY-MM-DD_*.md`
- 解析 Markdown 并渲染为 HTML
- 支持代码高亮、表格、列表等

### 4. 报告卡片
- 显示所有可用报告的概览
- 点击快速切换查看
- 当前选中高亮显示

### 5. NAS 迁移
- 纯静态 HTML，无需构建
- 所有资源内联或 CDN
- 配置文件集中管理
- 复制整个目录即可部署

## Component Inventory

### Password Gate
- 全屏覆盖层
- 居中输入卡片
- Logo + 标题
- 密码输入框 (带眼睛图标切换显隐)
- 提交按钮 (gradient background)
- States: default, loading, error (shake), success (fade out)

### Header
- Logo/标题 (左侧)
- 日期选择器 (右侧)
- 锁定按钮 (点击重新锁定)

### Report Card
- 缩略标题
- 日期标签
- 报告类型图标
- States: default, hover (lift + glow), selected (accent border)

### Report Viewer
- 渲染后的 Markdown 内容
- 标题层级样式
- 代码块高亮
- 表格样式
- 引用块样式

### Date Picker
- 原生 date input (样式化)
- 支持手动输入日期

### Empty State
- 日历图标
- "暂无报告" 文字
- 建议选择其他日期

## Technical Approach

### Architecture
- 单 HTML 文件，包含内联 CSS 和 JS
- 无需构建工具，纯浏览器运行
- 使用 Marked.js 渲染 Markdown
- 使用 Highlight.js 代码高亮

### Data Flow
```
用户选择日期 → 查找匹配报告文件 → Fetch 读取 → Markdown 渲染 → 展示
```

### 配置项 (文件顶部)
```javascript
const CONFIG = {
  password: "report2026",
  sessionDuration: 86400000, // 24小时
  reportsPath: "./",
  reportDirs: ["data_reports", "research_reports"]
};
```

### 安全
- 密码使用 SHA-256 哈希验证
- Session token 存储在 localStorage
- 无后端，纯前端验证

### NAS 兼容性
- 文件路径相对引用
- 无外部依赖 (CDN 资源有 fallback)
- 单一 index.html 部署
