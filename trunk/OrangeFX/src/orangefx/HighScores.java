/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package orangefx;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

/**
 *
 * @author ramakant
 */
public class HighScores implements Serializable{

    
    //time t = new time
    public String name;
    public String score;
    public void writeScore(String name,String score){
        try{
            FileOutputStream fs = new FileOutputStream("resources/.highScores");
            ObjectOutputStream os = new ObjectOutputStream(fs);
            os.writeObject(name);
            os.writeObject(score);
            os.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public void readScore(){
        try{
            FileInputStream fis = new FileInputStream("resources/.highScores");
            ObjectInputStream ois = new ObjectInputStream(fis);
            name = (String)ois.readObject();
            score = (String)ois.readObject();
            ois.close();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
    

    