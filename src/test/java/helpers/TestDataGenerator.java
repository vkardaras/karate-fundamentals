package helpers;

import com.github.javafaker.Faker;

public class TestDataGenerator {

    public static String getRandomProductName() {
        Faker faker = new Faker();
        String productName = faker.commerse().productName() + faker.random().nextInt(100);
        return productName;
    }
}
