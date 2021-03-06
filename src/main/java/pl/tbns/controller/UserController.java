package pl.tbns.controller;

import java.security.Principal;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pl.tbns.service.UserService;

@Controller
public class UserController {

	 private Logger logger = LoggerFactory.getLogger(UserController.class);
	
	 @Autowired
	    private UserService userService;

	 @RequestMapping("/account")
	    public String account(Model model, Principal principal) {
	        String userName = principal.getName();
	             model.addAttribute("user", userService.findOneUserByName(userName));
	        return "account";
	    }

	    @RequestMapping(value = "/account", method = RequestMethod.POST)
	    public String doAddBlog(@Valid  Model model,  Principal principal, BindingResult result) {
	        if (result.hasErrors()) {
	            return account(model, principal);
	        }
	        logger.info("Display list users site");
	 //       String name = principal.getName();
	      
	        return "redirect:/account";
	    }

	    

}
