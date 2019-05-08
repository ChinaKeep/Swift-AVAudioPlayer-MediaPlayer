//
//  ViewController.swift
//  Swift-AVPlayer
//
//  Created by 品德信息 on 2016/12/29.
//  Copyright © 2016年 品德信息. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import AudioToolbox  //导入音频工具箱框架，使用系统声音服务

class ViewController: UIViewController {
//初始化音频播放对象，将音频播放对象，作为试图控制器的类的属性
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    //创建一个视频播放控制器属性，用于视频播放
    var mediaPlayer:MPMoviePlayerController = MPMoviePlayerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //本地的音乐的播放：
        self.localMusic()
        
        //背景音乐的播放需要现在info.plist进行社会 Required background。。。
        self.backgroundMusic()
  
      //视频播放
//        self.mediaPlayerViedo()
        
        //ios 8 的新类用于视频播放
//        AVPlayerViewController
        
        //声明一个系统声音标志类型的声音变量
        var soundID:SystemSoundID = 0
        let path = Bundle.main.path(forResource: "callRing", ofType: "mp3")
        //路径找不到就会报内存错误的
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundID)
        
        
        
    }
    func mediaPlayerViedo() {
        //视频播放前首先创建一个异常捕捉语句
        do{
            let path = Bundle.main.path(forResource: "loginmovie", ofType: "mp4")
            let movieUrl = URL(fileURLWithPath:path!)
            mediaPlayer = MPMoviePlayerController(contentURL:movieUrl)
            //设置音频播放为全屏
            mediaPlayer.controlStyle = MPMovieControlStyle.fullscreen
            mediaPlayer.view.frame = self.view.bounds
            //设置开始时间
            mediaPlayer.initialPlaybackTime = -1
            self.view.addSubview(mediaPlayer.view)
            
            mediaPlayer.play()
            //添加一个通知用来监听视频播放是否结束
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.movieFinished(notify:)), name: .MPMoviePlayerPlaybackDidFinish, object: mediaPlayer)
            
        }catch
        {
            print(error)
        }
    }
    //创建一个方法用来响应视频播放
    func movieFinished(notify:NSNotification) {
        print("movie ends")
        //获取视频播放控制器
        let player = notify.object
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: player)
        
    }
    func backgroundMusic()  {
        //获取音频会话对象，改对象属于单利模式，也就是说不用开发者写，自行实例化，这个类在各种音频环境中起着非常重要的作用
        let session = AVAudioSession.sharedInstance()
        //在音频播放前，首先创建一个异常捕捉语句
        do{
            //启动音频会话管理，此时会阻断后台音乐播放
            try session.setActive(true)
            //设置音频播放类别，表示该应用仅支持音频播放
            try session.setCategory(AVAudioSessionCategoryPlayback)
            
            //定义一个字符串变量，描述声音文件的路径
            let path = Bundle.main.path(forResource: "callRing", ofType: "mp3")
            //将字符串路径转化为网址路径
            let soundUrl = URL(fileURLWithPath: path!)
            
            try audioPlayer = AVAudioPlayer(contentsOf:soundUrl)
            //为音频播放做好准备
            audioPlayer.prepareToPlay()
            //设置音量
            audioPlayer.volume = 1.1
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
        }catch{
            print(error)
        }

    }
    
    func localMusic()  {
        let path = Bundle.main.path(forResource: "callRing", ofType: "mp3")
        //        public init(fileURLWithPath path: String)
        let soundUrl = URL(fileURLWithPath: path!)
        
        //在音频播放前首先创建一个异常捕捉语句
        do{
            //对音频播放对象进行初始化，并加载指定的音频播放对象
            //            public init(contentsOf url: URL) throws
            
            try audioPlayer = AVAudioPlayer(contentsOf:soundUrl)
            //设置音频对象播放的音量的大小
            audioPlayer.volume = 1.0
            //设置音频播放的次数，-1为无限循环播放
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch{
            print(error)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

