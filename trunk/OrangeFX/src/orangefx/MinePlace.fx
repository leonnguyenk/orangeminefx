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

/**
 * @author ramakant
 */
// mineplace returns group not an instance of mineplace so it must
public class MinePlace extends CustomNode{
    package var isBomb = false;
    package var bombInVicinity = 0;
    package var x=0;
    package var y = 0;
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
                    x: x+3  y: y+3
                    width: width height: height
                    arcWidth: 20  arcHeight: 20
                    fill: color
                    stroke:stroke
                }
                Text {
                    font : Font {
                        size:fontSize
                    }
                    x: 10, y: 10
                    content: text
                }
            ]
            onMousePressed: function(e):Void{
                var rect: MinePlace = e.node as MinePlace;
                //var rect = re.parent;
                if(rect.isBomb) {   //rect.fill = Color.GREEN;
                    rect.color = Color.RED
                }
                else{
                    rect.color = Color.GREEN;
                    rect.fontSize = 30;
                    rect.text = (rect.bombInVicinity.toString()) ;
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
    for( index in [1..256]){
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



