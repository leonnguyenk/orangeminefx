/*
* Main.fx
 *
 * Created on 29 Mar, 2009, 3:56:47 AM
 */

package orangefx;

import java.lang.Object;
import java.lang.System;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import orangefx.MinePlace;
import orangefx.ConstantsV;
/**
 * @author ramakant
 */
 //points of origin of rectangles

var glowlevel: Integer=0;

package var scene:Scene =  Scene {
        fill:Color.TRANSPARENT;
        content: [
            MinePlace.rectangles,
            ImageView {
                fitWidth:20
                fitHeight:20
                x: 640 y: 0 image: Image {
                    url:"{__DIR__}resources/close.png"
                }
                onMouseClicked:function(e){
                    stage.close();
                }
            }
        ]
    };

package var stage:Stage = Stage {
    title: "Orange Mines"
    width: 660
    height: 650
    style: StageStyle.TRANSPARENT;
    scene:scene;
    //fullScreen:true
    
};

//var scaleTransition = ScaleTransition {
//        duration: 2s node: MinePlace.rectangles[40]
//        byX: 4.6 byY: 1.5
//        repeatCount:4 autoReverse: true
//    }

override function run():Void{
    println('first {MinePlace.points[0]} second last {MinePlace.points[15]} last {MinePlace.points[16]}');
    MinePlace.PlantBombs(MinePlace.rectangles);
    MinePlace.BombCalculator(MinePlace.rectangles);
    stage;
    //scaleTransition.play();
    if(ConstantsV.greens >=256-30){
        println('congratulations you won');
        stage.close;
    }

}
