package com.devops.springboot_app.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    // Logger is defined at class level
    private static final Logger log =
            LoggerFactory.getLogger(HelloController.class);


    @GetMapping("/hello")
    public String hello() {
        log.info("User request received at /hello endpoint");
        return "Hello from Spring Boot on EKS";
    }
}
