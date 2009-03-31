/*
 * MinePlace.fx
 *
 * Created on 29 Mar, 2009, 4:25:49 AM
 */

package orangefx;

import javafx.animation.transition.FadeTransition;
import javafx.scene.CustomNode;
import javafx.scene.effect.light.DistantLight;
import javafx.scene.effect.Lighting;
import javafx.scene.Group;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.Scene;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import javafx.util.Sequences;
import orangefx.ConstantsV;
import orangefx.Main;
import orangefx.MinePlace;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;


function fadeIt(rect:MinePlace):Void{
    var fadeTransition = FadeTransition {
        duration: 0.3s node: rect
        fromValue: 1.0 toValue: 0.3
        repeatCount:2 autoReverse: true
    }
    fadeTransition.play();
}


//var zoom = 1
package var points = [0..640 step 40];
package var noOfRectangles:Integer = 0;
package var rectangles = {
    for(i in [0..255]){
        MinePlace {
            xvalue: points[i mod 16],
            yvalue: points[i / 16],
            width: 40,
            height: 40,
            fontSize : 30

            color: Color{red:1.0,green:0.7}
            stroke: Color.WHITE            
        }
    }
};
/**
 * @author ramakant
 */
// mineplace returns group not an instance of mineplace so it must
public class MinePlace extends CustomNode{
    package var isBomb = false;
    package var bombInVicinity:Integer = 0;
    package var xvalue:Integer=0;
    package var yvalue:Integer = 0;
    package var width:Integer = 10 ;
    package var height:Integer = 10 ;
    package var color = Color.WHITE;
    package var stroke = Color.WHITE;
    package var text = '';
    package var fontSize:Integer = 10;
    package var index:Integer = noOfRectangles++;
    package var azimuth:Integer = -10;
    package var gr = Group {
                //var m : MinePlace = super;
             content:[
                 Rectangle {
                    var bombInVicinity = 0;
                    x: xvalue  y: yvalue
                    width: width height: height
                    arcWidth: 10  arcHeight: 10
                    fill: bind color
                    //stroke:stroke
                }
                Text {
                    font : Font {
                        size:fontSize
                        embolden:true
                    }
                    x:xvalue+10, y: yvalue+32
                    content: bind text
                }
            ]
//            effect:InnerShadow {
//
//                offsetX: 5
//                offsetY: 5
//                radius: 10
//                //color: Color.WHEAT
//            }
            effect:Lighting {
                light:DistantLight{
                    azimuth : bind azimuth
                    elevation:50
                }
                surfaceScale: 3.0
                specularConstant:1.0
            }

            onMouseEntered:function(e):Void{
               var clickX:Integer  = e.sceneX as Integer;
                var clickY:Integer = e.sceneY as Integer;
                // mapping clicks to x,y rectangle coordinates
                var rectX:Integer = clickX/40;
                var rectY:Integer = clickY/40;
                //mapping rectangle coordinates to actual rectangle coordinates
                var rectN:Integer = rectY*16+rectX;
                var rect = rectangles[rectN];
                fadeIt(rect);
            }

            onMousePressed: function(e):Void{
                //detecting click points
                println("clicked at {e.sceneX},{e.sceneY}");
                var clickX:Integer  = e.sceneX as Integer;
                var clickY:Integer = e.sceneY as Integer;
                // mapping clicks to x,y rectangle coordinates
                var rectX:Integer = clickX/40;
                var rectY:Integer = clickY/40;
                //mapping rectangle coordinates to actual rectangle coordinates
                var rectN:Integer = rectY*16+rectX;
                var rect = rectangles[rectN];
                //var rect = re.parent;
                if(e.secondaryButtonDown)
                    insertFlag(rectX*40,rectY*40);
                if(e.primaryButtonDown){
                if(rect.isBomb) {  
                //rect.fill = Color.GREEN;
                println('we have a bomb here');
                    rect.color = Color.RED;
                    insert loseText into Main.stage.scene.content;
                    delete rect from Main.stage.scene.content;
                    disposeAfterDelay(3s);
                    println('game over');
                    ConstantsV.reds++;
                    //newOutScene();
                }
                else{                   
                    if(rect.color!=Color.GREEN){
                        rect.color = Color.GREEN;
                        ConstantsV.greens++;
                        if(ConstantsV.greens>=235){
                            insert winText into Main.stage.scene.content;
                            
                        }

                    }
                    rect.fontSize = 30;
                    if(rect.bombInVicinity>0){
                        rect.text = '{rect.bombInVicinity}' ;
                    }
                    else{
                        greenify(rectN);
                    }
                }
            }
        }
    }
    override function create():Node{
      return gr;//group returned
    }
}

package function PlantBombs(rect:MinePlace[]):Void{
    var bombPlaces = Sequences.shuffle([0..255]);//this sequence's first 30 elements represent the random bombplaces
    for(i in [1..30]){
        rect[bombPlaces[i] as Integer].isBomb = true;//setting the bomb
    }
}

// this function can be merged to plantbombs for optimization and less coding, but for now it is more convenient here
package function BombCalculator(rect:MinePlace[]):Void{
    for( index in [0..255]){
        if(rect[index].isBomb){
            var x: Integer= index mod 16;
            var y: Integer = index / 16;
            for(i in [x-1..x+1]){
                for(j in [y-1..y+1]){
                    if(i>=0 and j>=0 and i<16 and j<16){
                        rect[j*16+i].bombInVicinity++;
                    }
                }
            }
        }
    }
}

//greenifying the boxes-- no mines
function greenify(index:Integer):Void{
    //first color them green as they are available for coloring and show number if greater then 0
    if(not rectangles[index].isBomb){
        if(rectangles[index].color!=Color.GREEN){
        rectangles[index].color = Color.GREEN;
                        rectangles[index].color= Color.GREEN;
                        ConstantsV.greens++;
                        if(ConstantsV.greens>=235){
                            insert winText into Main.stage.scene.content;
                            //Main.stage.close;
                            //newScene();
                    }}
           if(rectangles[index].bombInVicinity!=0){
            rectangles[index].fontSize = 30;
            rectangles[index].text = '{rectangles[index].bombInVicinity}' ;
           }

    }
    //if it is a zero value area then recursive call to greenify all neighbours which are not green
    if(rectangles[index].color== Color.GREEN and not rectangles[index].isBomb and rectangles[index].bombInVicinity == 0){
        //now recursive call to open neighbours
        var  x:Integer= index mod 16;
            var y: Integer = index / 16;
            for(i in [x-1..x+1 step 1]){
                for(j in [y-1..y+1 step 1]){
                    if(i>=0 and j>=0 and i<16 and j<16  and i!=j){
                        if((rectangles[j*16 + i].color != Color.GREEN) and not rectangles[j*16 + i].isBomb){
                            println('greenifying square{i},{j}');
                            greenify(j*16 + i);

                        }
                    }
                }
            }
      }
}


function insertFlag(x:Integer,y:Integer):Void{
    var flag = ImageView {
        x:x
        y:y
        image: Image {
            url: "{__DIR__}resources/flag.gif"
        }
    }
    insert flag into Main.scene.content;
    ConstantsV.flags++;
}

function removeFlag(x:Integer,y:Integer):Void{
   
}


function newScene():Void{
    Stage {
    title : "Congrats"
    scene: Scene {
        width: 200
        height: 100
        content: [ Text {
            font : Font {
                size: 80
            }
            x: 10, y: 30
            content: "Congratulations You Won!"
        }
        ]
    }
}
}

var winText = Text {
            font : Font {
                size: 80
            }
            x: 10, y: 30
            content: "Congratulations You Won!"
        }




 var loseText = Text {
            font : Font {
                size: 50
            }
            x: 200, y: 300
            content: "You Lose"
        }
 function disposeAfterDelay(timedelay:Duration):Void{
     Timeline{
         keyFrames:[
            KeyFrame{
                time:0s
                action:function(){
                    insert rectOverlay into Main.stage.scene.content
                }
            }
            KeyFrame{
                time:timedelay                
                action:dispose
                }          
         ]
     }.play()
 }

function dispose():Void{
    Main.stage.close();
}

package var rectOverlay = Rectangle {
    x:0, y: 0
    width: 650, height: 650
    fill: Color.WHITE
    opacity:0.4
}





