/*
 * MinePlace.fx
 *
 * Created on 29 Mar, 2009, 4:25:49 AM
 */

package orangefx;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.util.Sequences;
import orangefx.MinePlace;


//var zoom = 1
var points = [0..600 step 40];

package var rectangles = {
    for(i in [0..255]){
        MinePlace {
            xvalue: points[i / 16],
            yvalue: points[i mod 16],
            width: 40,
            height: 40,
            fontSize : 30

            color: Color.ORANGE
            stroke: Color.WHITE
            opacity: 1.0

        }
    }
};
/**
 * @author ramakant
 */
// mineplace returns group not an instance of mineplace so it must
public class MinePlace extends CustomNode{
    package var isBomb = false;
    package var bombInVicinity = 0;
    package var xvalue=0;
    package var yvalue = 0;
    package var width = 10 ;
    package var height = 10 ;
    package var color = Color.WHITE;
    package var stroke = Color.WHITE;
    package var text = '';
    package var fontSize = 10;
    package var gr = Group {
                //var m : MinePlace = super;
             content:[
                 Rectangle {
                    var bombInVicinity = 0;
                    x: xvalue  y: yvalue
                    width: width height: height
                    arcWidth: 10  arcHeight: 10
                    fill: bind color
                    stroke:stroke
                }
                Text {
                    font : Font {
                        size:fontSize
                    }
                    x:xvalue+10, y: yvalue+32
                    content: bind text
                }
            ]
            onMousePressed: function(e):Void{
                //detecting click points
                println("clicked at {e.sceneX},{e.sceneY}");
                var clickX:Integer  = e.sceneX as Integer;
                var clickY:Integer = e.sceneY as Integer;
                // mapping clicks to x,y rectangle coordinates
                var rectX:Integer = clickX/40;
                var rectY:Integer = clickY/40;
                //mapping rectangle coordinates to actual rectangle coordinates
                var rectN:Integer = rectX*16+rectY;
                var rect = rectangles[rectN];
                //var rect = re.parent;
                if(rect.isBomb) {   //rect.fill = Color.GREEN;
                    rect.color = Color.RED
                }
                else{
                    rect.color = Color.GREEN;
                    rect.fontSize = 30;
                    if(rect.bombInVicinity>0){
                        rect.text = '{rect.bombInVicinity}' ;
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
            var x: Integer= index / 16;
            var y: Integer = index mod 16;
            for(i in [x-1..x+1]){
                for(j in [y-1..y+1]){
                    if(i>=0 and j>=0 and i<16 and j<16){
                        rect[i*16+j].bombInVicinity++;
                    }
                }
            }
        }
    }
}



