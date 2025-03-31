+++
title = "adjustbox / graphicx"
icon = "lightbulb-fill"
+++

@@log
* \link{graphicx}{https://www.ctan.org/pkg/graphicx}
* \link{adjustbox}{https://www.ctan.org/pkg/adjustbox}
@@


## adjustbox

* 是对 `graphicx` 的扩展.

* 针对 $\LaTeX$ 的 `box` 提供了非常丰富的接口, 可以灵活自定义格式.


## graphicx

`\rotatebox [⟨key-val list⟩]{⟨angle⟩}{⟨text⟩}`

* `origin` Specify the centre of rotation. `origin=⟨label ⟩`, where the labels are up to two of `lrctbB` (`B` denotes the baseline, as for PSTricks). 

* `x,y` An alternative to `origin`. `x=⟨dimen⟩,y=⟨dimen⟩` The `x, y` coordinate of the centre of rotation. As usual `\height` etc may be used. 

* `units` Specify the units used in the main argument. eg `units=-360` would mean that the argument referred to degrees *clockwise* instead of the default anticlockwise rotation.

----

`\includegraphics *[⟨key-val list⟩]{⟨file⟩}`


下述少部分参数在使用时从左向右依次生效, 包括缩放和旋转. 缩放操作包括 `scale` / `height` 等设置大小的参数. 例如: `[height=1cm, angle=90]` 先把高度设置为 `1cm` 然后旋转, 最终的宽度为 `1cm`; `[angle=90, height=1cm]` 是先旋转, 然后将高度设置为 `1cm`.


* `bb` Set the bounding box. The argument should be four dimensions, separated by spaces. 

* `bbllx,bblly,bburx,bbury` Set the bounding box. Mainly for compatibility with older packages. `bbllx=a,bblly=b,bburx=c,bbury=d` is equivalent to `bb = a b c d`.

* `natwidth,natheight` Again an alternative to `bb`. `natheight=h,natwidth=w` is equivalent to `bb = 0 0 h w`. 

* `viewport` Modify the bounding box specified in the file. The four values specify a bounding box *relative* to the `llx,lly` coordinate of the original box. 

* `trim` Modify the bounding box specified in the file. The four values specify the amounts to remove from the left, bottom, right and top of the original box. 

* `hiresbb` Boolean valued key. Defaults to true. Causes TEX to look for `%%HiResBoundingBox` comments rather than the standard `%%BoundingBox`. May be set to false to override a default setting of true specified by the `hiresbb` package option. 

* `angle` Rotation angle. 

* `origin` Rotation origin (see `\rotatebox`). 

* `width` Required width, a dimension (default units `bp`). The graphic will be scaled to make the width the specified dimension. 

* `height` Required height. a dimension (default units `bp`). 

* totalheight Required totalheight (i.e., height + depth). a dimension (default units `bp`). Most useful after a rotation (when the height might be zero).

* `keepaspectratio` Boolean valued key (like clip). If it is set to true, modify the meaning of the `width` and `height` (and `totalheight`) keys such that if both are specified then rather than distort the figure the figure is scaled such that neither dimension *exceeds* the stated dimensions. 

* `scale` Scale factor. 

* `clip` Either ‘true’ or ‘false’ (or no value, which is equivalent to ‘true’). Clip the graphic to the bounding box (or viewport if one is specified). 

* `draft` a boolean valued key, like ‘clip’. locally switches to draft mode, ie. do not include the graphic, but leave the correct space, and print the filename. 

* `type` Specify the file type. (Normally determined from the file extension.) 

* `ext` Specify the file extension. *Only* for use with `type`. 

* `read` Specify the ‘read file’ which is used for determining the size of the graphic. *Only* for use with `type`. 

* `command` Specify the file command. Only for use with type. quiet Turns off writing information about graphics to the `.log`. 

* `page` The page of a multi-page PDF graphic to be used. 

* `interpolate` Enables interpolation of bitmap images by viewers. 

* `pagebox` Specifies which PDF box should be used for the natural image size, one of mediabox, cropbox, bleedbox, trimbox, artbox. The default is driverspecific.

