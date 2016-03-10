# UITableView+CornerRadius

方便地对tableView的cell的四个角进行圆角化处理

### To use with your tableView

1. import "UITableView+CornerRadius.h"
2. tableView.enableCornerRadiusCell = YES
3. tableView.cornerRadius = 5.f;
4. tableView.cornerRadiusStyle = KYTableVIewCornerRadiusStyleSectionTopAndBottom

![image](https://github.com/kirayamato1989/UITableView-CornerRadius/blob/master/Demo/UITableView.jpeg?raw=true)

### Attention

This category hooked the private method of UITableView

### License

Under MIT license