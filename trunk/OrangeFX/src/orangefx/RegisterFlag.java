/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package orangefx;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author ramakant
 */
public class RegisterFlag {
    //first integer is coordinate and second integer is value;
    static Map<Integer,Integer> flagMap = new HashMap<Integer,Integer>();
    public static void insertReg(int flagCoordinate, int flagNumber){
        flagMap.put(flagCoordinate, flagNumber);
    }
    public static Integer get(Integer flagCoordinate){
        return (Integer)flagMap.get(flagCoordinate);
    }
    public static boolean haveFlag(int flagCoordinate){
        return flagMap.containsKey(flagCoordinate);
    }
    public static void unRegister(Integer flagCoordinate){
        flagMap.remove(flagCoordinate);
    }
}
