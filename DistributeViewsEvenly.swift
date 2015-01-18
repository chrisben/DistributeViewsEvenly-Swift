//
//  DistributeViewsEvenly.swift
//
//  Created by Christophe on 12/01/2015.
//  Copyright (c) 2015 Christophe Benoit. All rights reserved.
//
// This helper class will distribute views evenly on the horizontal or vertical plane in this manner: |-(v1)-(v2)-(v3)-| with all spaces being equal
// Views need to share the same size (either width for an horizontal distribution, or height for a vertical one)
// This is done solely using constraints and no size/position calculation
// Warning: you need to set your views height/Y or width/X constraints yourself!

import UIKit

class DistributeViewsEvenly
{
    private var views: [UIView] = [UIView]()
    private let parent: UIView
    private let margin: CGFloat
    private let viewSize: CGFloat
    private let horizontal: Bool
    private let debug: Bool = false
    
    init(parent: UIView, viewSize: Int, horizontal: Bool = true, margin: Int = 0, debug:  Bool = false) {
        self.parent = parent
        self.margin = CGFloat(margin)
        self.viewSize = CGFloat(viewSize)
        self.horizontal = horizontal
        self.debug = debug
    }
    
    func addView(view: UIView)
    {
        if self.views.isEmpty {
            // create leading spacer view
            self.addSpacer()
        }
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.views.append(view)
        
        // create trailing spacer view
        self.addSpacer()
    }
    
    func setConstraints()
    {
        // Doc: https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutbyExample/AutoLayoutbyExample.html#//apple_ref/doc/uid/TP40010853-CH5-SW8
        
        let sizeAttr: NSLayoutAttribute = (self.horizontal ? NSLayoutAttribute.Width : NSLayoutAttribute.Height)
        let leadAttr: NSLayoutAttribute = (self.horizontal ? NSLayoutAttribute.Left : NSLayoutAttribute.Top)
        let trailAttr: NSLayoutAttribute = (self.horizontal ? NSLayoutAttribute.Right : NSLayoutAttribute.Bottom)

        for (index, view) in enumerate(self.views) {
            
            if index % 2 == 0 {
                // this is a spacer
                if index == 0 {
                    // Constrain the width of spacer view 1 to be greater than or equal to the minimum desired width : 0
                    self.parent.addConstraint(NSLayoutConstraint(item: view, attribute: sizeAttr, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0))
                } else {
                    // Constrain the width of subsequent spacer views to be equal to the width of 1st spacer view
                    self.parent.addConstraint(NSLayoutConstraint(item: view, attribute: sizeAttr, relatedBy: .Equal, toItem: self.views.first, attribute: sizeAttr, multiplier: 1, constant: 0))
                }
                
                if self.debug {
                    self.parent.addConstraint(NSLayoutConstraint(item: view, attribute: (self.horizontal ? NSLayoutAttribute.Height : NSLayoutAttribute.Width), relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50))
                    self.parent.addConstraint(NSLayoutConstraint(item: view, attribute: (self.horizontal ? NSLayoutAttribute.Top : NSLayoutAttribute.Left), relatedBy: .Equal, toItem: self.parent, attribute: (self.horizontal ? NSLayoutAttribute.Top : NSLayoutAttribute.Left), multiplier: 1, constant: CGFloat(50 + 20*index)))
                }
            } else {
                // this is a user view
                
                // all views need to have the same width
                self.parent.addConstraint(NSLayoutConstraint(item: view, attribute: sizeAttr, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: self.viewSize))
            }
            
            if index + 1 < self.views.count {
                var constraint = NSLayoutConstraint(item: view, attribute: trailAttr, relatedBy: .Equal, toItem: self.views[index + 1], attribute: leadAttr, multiplier: 1, constant: 0)
                // priority is lowered to 999 for spacers that are in the middle
                if index > 0 && index + 1 < self.views.count {
                    constraint.priority = 999
                }
                self.parent.addConstraint(constraint)
            }
        }
        if let firstSpacer = self.views.first {
            // Create a Leading Space to Container constraint from spacer view 1 to the container
            self.parent.addConstraint(NSLayoutConstraint(item: firstSpacer, attribute: leadAttr, relatedBy: .Equal, toItem: self.parent, attribute: leadAttr, multiplier: 1, constant: self.margin))
        }
        if let lastSpacer = self.views.last {
            // Create a Trailing Space to Container constraint from last spacer view to the container.
            self.parent.addConstraint(NSLayoutConstraint(item: lastSpacer, attribute: trailAttr, relatedBy: .Equal, toItem: self.parent, attribute: trailAttr, multiplier: 1, constant: -self.margin))
        }
    }
    
    private func addSpacer()
    {
        let spacerView: UIView = UIView()

        if self.debug {
            // random color to differentiate items
            spacerView.backgroundColor = UIColor(hue: CGFloat(Double(arc4random_uniform(256)) / 255.0), saturation: CGFloat(Double(arc4random_uniform(128)) / 255.0 + 0.5), brightness: CGFloat(Double(arc4random_uniform(128)) / 255.0 + 0.5), alpha: 0.8)
        } else {
            // spacer views should be hidden, their size is still taken into account though
            spacerView.hidden = true;
        }
        
        spacerView.setTranslatesAutoresizingMaskIntoConstraints(false);
 
        // add the spacer
        self.parent.addSubview(spacerView);
        
        self.views.append(spacerView)
    }
}
