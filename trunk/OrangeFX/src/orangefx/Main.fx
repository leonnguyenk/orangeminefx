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


var glowlevel: Integer=0;

//the sequence of rectangles




//var colorsx =
var stage = Stage {
    title: "Orange Mines"
    width: 700
    height: 700
    //style: StageStyle.UNDECORATED;
    
    scene: Scene {
            //fill:Color.TRANSPARENT;
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
            MinePlace.rectangles
        ]

    }
}

var glowTimeLine = Timeline{

}

override function run():Void{
    MinePlace.PlantBombs(MinePlace.rectangles);
    MinePlace.BombCalculator(MinePlace.rectangles);
    stage;
}
