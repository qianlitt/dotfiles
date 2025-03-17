# fish

## 插件

我使用 [jorgebucaran/fisher: A plugin manager for Fish](https://github.com/jorgebucaran/fisher) 作为 fish 的插件管理器。

### 安装

#### 包管理器

在 Arch Linux 下，fisher 可以用 `pacman` 包管理器安装：

```shell
# pacman -S fisher
```

#### 手动安装

可以用脚本安装：

```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

### 使用 `fish_plugins` 文件同步插件

每当在命令行中安装或删除 fish 插件时，fisher 都会更新 `$__fish_config_dir/fish_plugins`（通常是 `~/.config/fish/fish_plugins`）。因此可以用 Git 跟踪该文件，以在不同机器上同步插件配置。

例如，`$__fish_config_dir/fish_plugins` 中有以下内容：

```
patrickf1/fzf.fish
jhillyerd/plugin-git
```

```shell
fisher update
```

运行以上命令即可安装 `patrickf1/fzf.fish` 和 `jhillyerd/plugin-git` 插件，同时删除不在该文件中的插件。
