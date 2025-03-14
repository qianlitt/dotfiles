# kitty

- [kitty 的官方文档](https://sw.kovidgoyal.net/kitty/)
- [kitty - Arch Linux 中文维基](https://wiki.archlinuxcn.org/wiki/Kitty)

## 主题

使用 `kitty +kitten themes` 打开 kitty 自带的配色选择界面。用方向键选择配色；(A)ll, (D)ark, (L)ight, (R)ecent, (U)ser 选择菜单。

> [!NOTE]
>
> - 该功能无法在 ssh、Zellij 中正常使用。
>   - Zellij 若与 terminal 同开同关，则需用 `kitty` 命打开一个干净的 kitty 窗口。
>   - kitty 主题的选择也会影响到 Zellij 的配色。
> - [和我一起配置kitty_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1WJ4m1w7ms/)，这位 up 主选择了 **Catppuccin-Mocha**。

## 字体

使用 `kitty list-fonts --psnames` 列出可用的字体。

> [!WARNING]
> 终端里显示字符图标需要 Nerd 字体，但如果选用了带 **Mono** 样式的字体，图标就会显得很小。这是因为 Mono 样式会将 Unicode 字符严格限制在终端所能显示的字符格内。
>
> - [终端里的字符图标其实很好配置_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1nmwieeEiD) 提供了一个解决方法：使用 `symbol_map` 进行字符集映射。

- 已进行的映射：
  - icon -> Symbols Nerd Font Mono
  - 中文字符 -> Maple Mono NF CN
