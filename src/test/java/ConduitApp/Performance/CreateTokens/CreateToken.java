package ConduitApp.Performance.CreateTokens;

import com.intuit.karate.Runner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class CreateToken {

    private static final ArrayList<String> tokens =  new ArrayList<>();
    private static final AtomicInteger counter = new AtomicInteger();
    private static String[] emails = {
            "prajwal1@test.com",
            "prajwal2@test.com",
            "prajwal3@test.com"
    };

    public static String getNextToken(){
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }

    public static void createAccessTokens(){
        for(String email: emails){
            Map<String, Object> account = new HashMap<>();
            account.put("userEmail",email);
            account.put("userPass","Welcome1");
            Map<String, Object> result = Runner.runFeature("classpath:helpers/CreateToken.feature",account,true);
            tokens.add(result.get("authtoken").toString());
        }
    }
}
