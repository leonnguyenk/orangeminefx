/*
* Main.fx
 *
 * Created on 29 Mar, 2009, 3:56:47 AM
 */

package orangefx;

import java.lang.Object;
import javafx.animation.Timeline;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import orangefx.MinePlace;
/**
 * @author ramakant
 */
 //points of origin of rectangles
var points = [0..600 step 40];

var glowlevel: Integer=0;

//the sequence of rectangles
var rect = {
    for(i in [1..256]){        
        MinePlace {
            x: points[i / 16],
            y: points[i mod 16],
            width: 40,
            height: 40,
                
            color: Color.ORANGE
            stroke: Color.WHITE
            opacity: 1.0
            
        }       
    }
};



//var colorsx =
var stage = Stage {
    title: "Application title"
    width: 640
    height: 640
    style: StageStyle.UNDECORATED;
    
    scene: Scene {
            fill:Color.TRANSPARENT;
//        fill: RadialGradient {
//            centerX: 320
//            centerY: 320
//            focusX: 320
//            focusY: 320
//            radius: 320
//            stops: [
//                Stop {
//                    color: Color.BLUE
//                    offset: 0.0
//                },
//                Stop {
//                    color: Color.ORANGERED
//                    offset: 0.5
//                },
//                Stop {
//                    color: Color.RED
//                    offset: 1.0
//                },
//
//            ]
//        }
        content: [
            rect
        ]

    }
}

var glowTimeLine = Timeline{

}

override function run():Void{
    MinePlace.PlantBombs(rect);
    MinePlace.BombCalculator(rect);
    stage;
}
