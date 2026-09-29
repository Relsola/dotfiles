;;; completion.el --- 补全 -*- lexical-binding: t; -*-

;; Vertico
(use-package vertico
  :init
  (vertico-mode 1)       ; 全局启用
  :custom
  (vertico-count 10)     ; 补全列表最多显示 10 个候选项
  (vertico-cycle t)      ; 当移动到头/尾时，循环跳转
  (vertico-resize nil))  ; 固定 minibuffer 高度，避免输入时窗口跳动

;; 先用 orderless 模糊匹配，不行再退回 basic 前缀匹配
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

;; 在补全候选右侧显示注释
(use-package marginalia
  :init (marginalia-mode 1))

;; Corfu：在光标处弹出补全菜单
(use-package corfu
  :init
  (global-corfu-mode 1)          ; 全局启用，所有 buffer 生效
  :custom
  (corfu-auto t)                 ; 边打字边弹候选
  (corfu-auto-delay 0.2)         ; 打字后 0.2 秒才弹，避免干扰
  (corfu-auto-prefix 2)          ; 至少输入 1 个字符才触发自动补全
  (corfu-cycle t)                ; 候选列表循环
  (corfu-preview-current t)      ; 预览当前选中的候选
  )

;; Cape：为 Corfu 提供额外的补全后端
;; 把 cape-* 函数注册到 completion-at-point-functions 列表
(use-package cape
  :init
  ;; 全局可用的后端：file（文件名）
  (add-to-list 'completion-at-point-functions #'cape-file)
  :bind
  ;; 也可以手动按键调用特定后端
  (("C-c p d" . cape-dabbrev)         ; 全局补全
   ("C-c p l" . cape-line)            ; 补全整行
   ("C-c p s" . cape-elisp-symbol)))  ; 补全 Elisp 符号

;; 增强命令集
(use-package consult
  :bind (;; 搜索
         ("C-s"       . consult-line)           ; 带预览的全文搜索，替代 isearch
         ("M-y"       . consult-yank-pop)       ; 带预览的 kill-ring 查看
         ;; Buffer 切换
         ("C-x b"     . consult-buffer)         ; 带预览的 buffer 切换
         ;; 项目内查找（需要 consult 配合 ripgrep）
         ("C-c f"     . consult-find)           ; 在项目里找文件
         ("C-c g"     . consult-ripgrep)        ; 在项目里全文搜索
         ("C-c r"     . consult-recent-file)))  ; 最近打开的文件

;; 历史记忆
(use-package savehist
  :init (savehist-mode 1))

(provide 'completion)
