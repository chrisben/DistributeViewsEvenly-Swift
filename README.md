DistributeViewsEvenly-Swift
===========================

**NOTICE: The functionality provided by this library is superseded by the native [UIStackView](https://developer.apple.com/documentation/uikit/uistackview) class added from iOS 9**

Swift4 helper class to distribute views evenly on the horizontal or vertical axis using autolayout constraints. The views you want to set need to share the same width (horizontal) or height (vertical).

This is not a trivial thing to achieve with UIKit, as there needs to be extra invisible "spacer views" to be added between your views, as recommended in [this Apple doc](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutbyExample/AutoLayoutbyExample.html#//apple_ref/doc/uid/TP40010853-CH5-SW8).

This helper class makes it much quicker to achieve this result.

There are other libraries doing similar stuff, this one is written in Swift and doesn't use any calculation which means it's not prone to rounding errors or divisions by zero!

There are no limits to the number of views you can space this way.


Installation
------------
You can add this repository to your project as a submodule using:

```shell
git submodule add https://github.com/chrisben/DistributeViewsEvenly-Swift.git
```

Drag the .swift file into your project, make it sure it's part of your target and you'll be ready to go. 


Usage
-----

In your view controller:

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let buttonWidth = 50
    let buttonHeight = 100

    // Create 3 buttons and add them to the view
    let button1 = MyButton(height: buttonHeight)
    self.view.addSubview(button1)

    let button2 = MyButton(height: buttonHeight)
    self.view.addSubview(button2)

    let button3 = MyButton(height: buttonHeight)
    self.view.addSubview(button3)

    /* Now distribute those buttons evenly across the width: | []-[]-[] | */
    let distrib = DistributeViewsEvenly(parent: self.view, viewSize: buttonWidth, horizontal: true, margin: 0)

    // add all views at once
    distrib.addViews([button1, button2, button3])
    // or add them one by one using distrib.addView(button1)

    // assign layout constraints at the end
    distrib.setConstraints()
}
```

Options
-------

* parent: the parent view where subviews will be added using addView
* viewSize: the width (horizontal distribution) or height (vertical) of the views you want to add to the parent - all those views need to share the same value
* horizontal: set to false for a vertical distribution, true otherwise
* margin: margins can be added to the left and right side of your distribution

By setting the ```debug``` property to ```true``` to visualise the spacer views and see what's going on.
