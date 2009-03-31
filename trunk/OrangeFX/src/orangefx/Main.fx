/*
* Main.fx
 *
 * Created on 29 Mar, 2009, 3:56:47 AM
 */

package orangefx;

import java.lang.Object;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import orangefx.ConstantsV;
import orangefx.MinePlace;
import javafx.scene.effect.*;
import javafx.scene.effect.light.*;
/**
 * @author ramakant
 */
 //points of origin of rectangles
var progress:Integer;
var progressPercent:Integer =bind  (progress*100/480);
package var scenex:Scene=Scene{
    fill:Color.TRANSPARENT
    content:[
            ImageView {
                fitWidth:520
                fitHeight:300
        image: Image {
            url: "{__DIR__}resources/instructions.png"
        }

    }
    Rectangle {
        x: 20, y: 300
        width: bind progress, height: 30
        fill: Color.GREEN
        arcWidth:10
        arcHeight:10
        effect: Lighting {
        light: DistantLight { azimuth: -225 }
        surfaceScale: 3
    }

    }
//        Rectangle {
//        x: bind progress+20, y: 300
//        width: bind 500 - (20 + progress), height: 20
//        fill: Color.TRANSPARENT
//    }
        Text {
        font : Font {
            size: 15
        }
        x: 240, y: 318
        content:bind '{progressPercent}%'
        stroke:Color.BLACK
    }




    ]
}


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
    scene:bind scenex;
    //fullScreen:true
    
};
var timer = Timeline{
    keyFrames:[
    KeyFrame{
            time:0s
            values:[progress  => 0 ]
        }
        KeyFrame{
            time:3s
            values:[scenex => scene,progress =>480 ]
        }
    ]
}


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
    timer.play();
    //scaleTransition.play();
    if(ConstantsV.greens >=225-30){
        println('congratulations you won');
        MinePlace.winCelebration();
    }    
}
