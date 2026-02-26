# Emacs Lisp

```lisp
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
```
' 是引用(`quote`)的简写。

`'package-archives` => `(quote package-archives)`

`"..."` 表示 字符串(`string`)字面量。

`t` 是 `Emacs Lisp` 里的一个特殊符号，代表 `true`，并且它的值永远是它自己。

`cons cell` 语法，表示一个二元结构 `(A . B)`, 也就是一个`键值对`风格的数据结构。


```
(defvar rc/package-contents-refreshed nil)
```

`defvar` 定义变量


```
(defun rc/require-theme (theme)
	(let ((theme-package (->> theme
														(symbol-name)
														(funcall (-flip #'concat) "-theme")
														(intern))))
		(rc/require theme-package)
		(load-theme theme t)))
```

`defun` 定义函数

`let` 用来创建局部变量

`funcall` 调用一个函数对象

`#'concat` 函数对象写法(`function quoting`)，表示 `concat` 这个函数本身

`->>` 线程宏(`thread-last`) 把上一步的结果插入到下一步表达式的最后一个参数位置
 
1. `theme`输入通常是个符号
2. `symbol-name` 把符号转成字符串
3. `-flip` `dash.el` 提供的高阶函数，作用是把一个二元/多元函数的参数顺序交换（“翻转参数”
