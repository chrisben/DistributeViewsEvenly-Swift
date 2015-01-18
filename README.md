DistributeViewsEvenly-Swift
===========================

Swift helper class to distribute views evenly on the horizontal or vertical axis using autolayout constraints. The views you want to set need to share the same width (horizontal) or height (vertical).

This is not a trivial thing to achieve with UIKit, as there needs to be extra invisible "spacer views" to be added between your views. [Here's the Apple doc](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutbyExample/AutoLayoutbyExample.html#//apple_ref/doc/uid/TP40010853-CH5-SW8) explaining how to do it.

This helper class makes it much quicker to achieve this result.

There are other libraries doing similar stuff, this one is written in Swift and doesn't use any calculation which means it's not prone to rounding errors or divisions by zero!


Installation
------------
You can add this repository to your project as a submodule using:

```shell
git submodule add (+ this git repository)
```

Drag the .swift file into your project, make it sure it's part of your target and you'll be ready to go. 


Usage
-----

In your view controller:

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let buttonWidth = 50

    let distrib = DistributeViewsEvenly(parent: self.view, viewWidth: buttonWidth, horizonal: true, margin: 0)

    let button1 = MyButton(width: buttonWidth)
    distrib.addView(button1)

    let button2 = MyButton(width: buttonWidth)
    distrib.addView(button2)

    let button3 = MyButton(width: buttonWidth)
    distrib.addView(button3)

    distrib.setConstraints()
}
```

Options
-------

* parent: the parent view where subviews will be added using addView
* viewWidth: the width of the views you want to add to the parent, if you want a vertical distribution, this is actually the height!
* horizontal: set to false for a vertical distribution, true otherwise
* margin: margins can be added to the left and right side of your distribution

By setting the ```debug``` property to ```true``` to visualise the spacer views and see what's going on.