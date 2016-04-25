//
//  TimerScrollView.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/20.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

protocol TimerScrollViewDelegate {
    func scrollToIndexOfPage(index:Int)
}

class TimerScrollView: UIView,UIScrollViewDelegate {
    var count : Int = 0
    var timer : NSTimer!
    var timerDelegate:TimerScrollViewDelegate?
    var scrollView : UIScrollView?
    var pageCT : UIPageControl?
    
    /*
    params: 
        array : 图片URL集合
        contentOffSetIndex : 偏移位置
    */
    func configScrollView(array:NSArray,contentOffsetIndex:Int){
        count = array.count
        self.clipsToBounds = false
        self.backgroundColor = UIColor.whiteColor()
        scrollView = UIScrollView(frame: self.bounds)
        scrollView!.delegate = self
        scrollView!.contentSize = CGSizeMake(CGFloat(array.count+2) * self.frame.size.width, self.frame.size.height)
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.showsVerticalScrollIndicator = false
        self.addSubview(scrollView!)
        createImageViews(array,contentOffsetIndex:contentOffsetIndex)
        
        configPageControll(contentOffsetIndex)
        
        timerBegin()
    }
    
    func createImageViews(array:NSArray,contentOffsetIndex:Int){
        for i in 0 ..< array.count+2{
            var url : String!
            if i == 0 {
                url = array[array.count-1] as! String
            }else if i == array.count + 1 {
                url = array[0] as! String
            }else {
                url = array[i-1] as! String
            }
            
            
            let URL : NSURL = NSURL(string: url)!
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i)*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
            //图片的加载需要依赖于框架，
            
            scrollView!.addSubview(imageView)
        }
        
        scrollView!.contentOffset = CGPointMake(CGFloat(contentOffsetIndex+1)*self.frame.size.width, 0)
    }
    
    func configPageControll(currentPage:Int) {
        pageCT = UIPageControl(frame: CGRectMake(0,self.frame.size.height-30.0,self.frame.size.width,15))
        pageCT!.pageIndicatorTintColor = UIColor.grayColor()
        pageCT!.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageCT!.numberOfPages = count
        pageCT!.currentPage = currentPage
        self.addSubview(pageCT!)
    }
    
    //开启
    func timerBegin() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("timerRun:"), userInfo: nil, repeats: true)
    }
    
    //暂停
    func timerSuspend() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    func timerRun(runTimer:NSTimer) {
        let offsetX = scrollView!.contentOffset.x
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.scrollView!.contentOffset = CGPointMake(offsetX+self.frame.size.width, 0)
            }) { (boolValue:Bool) -> Void in
                self.resetContentOffset()
        }
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timerSuspend()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timerBegin()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        resetContentOffset()
    }
    
    func resetContentOffset(){
        if scrollView!.contentOffset.x < self.frame.size.width {
            scrollView!.contentOffset = CGPointMake(self.frame.size.width*CGFloat(count), 0)
        }
        
        if scrollView!.contentOffset.x > self.frame.size.width * CGFloat(count) {
            scrollView!.contentOffset = CGPointMake(self.frame.size.width, 0)
        }
        
//        if timerDelegate?(respondsToSelector(Selector("scrollToIndexOfPage:"))) {
        let index = Int((scrollView!.contentOffset.x - self.frame.size.width) / self.frame.size.width)
        pageCT?.currentPage = index
        timerDelegate?.scrollToIndexOfPage(index)
//        }
        
        
    }
    
    
    

}
