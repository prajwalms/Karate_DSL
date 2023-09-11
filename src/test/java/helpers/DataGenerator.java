package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String generateRandomEmail() {
        Faker fake = new Faker();
        String randomEmail = fake.name().firstName().toLowerCase() + fake.random().nextInt(0, 100) + "@test.com";
        return randomEmail;
    }



    public static String generateRandomUserName() {
        Faker fake = new Faker();
        String randomEmail = fake.name().username().toLowerCase();
        return randomEmail;
    }


    public static JSONObject generateRandomBody(){
        Faker f= new Faker();
        String randomTitle= f.gameOfThrones().character();
        String randomDesc= f.gameOfThrones().city();
        String ramdomBody = f.gameOfThrones().quote();
        JSONObject js= new JSONObject();
        js.put("title", randomTitle);
        js.put("description", randomDesc);
        js.put("body", ramdomBody);

        return js;
    }

}