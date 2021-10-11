# IOS开发计算器

## 一、效果展示

横屏竖屏功能展示如下：

![竖屏](https://raw.githubusercontent.com/iwork-2021/iw01-bbzunyi/main/pics/vertical.png)
![横屏](https://raw.githubusercontent.com/iwork-2021/iw01-bbzunyi/main/pics/horizontal.png)


结果展示：https://www.bilibili.com/video/BV1s44y1x7fi/



## 二、实验中遇到的问题：

1、布局问题

​	这一问题遭到了很多困难，一开始用install好好地，结果第二天突然就不行了，再询问过曹春老师过后，最后使用了hidden属性来控制横竖屏变量的出现与消失，最后一切正常。

2、符号的显示问题

​	把会变化的符号连接到了Viewcontroller里的UIbutton，View层面控制按钮文字的变换，体会到了MVC模式的优越。

3、括号的实现

   因为只考虑简单的计算，所以创建了一个变量来保存之前操作符的值，在括号运算结束后将之前的值重新赋予pendingOp变量。

4、一些显示问题

​	MVC模式的体现，在controller模块根据提供的信息对label内容的显示，按钮颜色的显示等等进行了变换。



## 三、感想与体会

​	这是第一次接触ios开发，显而易见会遇到很多困难。但cc老师给了我很多的帮助，我在自己阅读了很多文档后，也慢慢了解了swift语言与IOS开发（xcode）。在这次实验中体会到MVC模式的实现，将数据方法封装到了model里面，也巧妙地用了老师提供的框架，采用字典的结构实现了操作符与函数的对应。虽然这次计算器的部分没有实现（指圆按钮，按下双目操作符会变色等等，只实现了按下2nd会变色），但是实验做到最后对很多东西都产生了很多理解，总的来说受益匪浅，也会为了下一部更多视图的切换做好了准备，到此结束，over！
