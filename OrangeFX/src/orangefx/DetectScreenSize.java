/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package orangefx;

import java.awt.Dimension;
import java.awt.Toolkit;

/**
 *
 * @author ramakant
 */
public class DetectScreenSize {
    private static Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    static public int getScreenWidth(){
        return screenSize.width;
    }
    static public int getScreenHeight(){
        return screenSize.height;
    }
    static public Dimension getDimension(){
        return screenSize;
    }
}
