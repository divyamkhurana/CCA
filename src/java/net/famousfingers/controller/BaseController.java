/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.famousfingers.controller;

import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Ashi
 */
@org.springframework.stereotype.Controller
public class BaseController {
  
  /****
   * This method will redirect the consultant to a disabled page based on it's role
   */
  public ModelAndView redirectToDisabledPage(){
    
    return new ModelAndView("ff.disabled");
    // Throws to disabled page after doing tiles lookup
  }
  
  public ModelAndView redirectToIncompletePage(){
    
    return new ModelAndView("ff.incomplete");
    // Throws to incomplete page after doing tiles lookup
  }
  
}
