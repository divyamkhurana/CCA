package net.famousfingers.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import net.famousfingers.constants.ReusableConstants;
import net.famousfingers.util.CommonUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Ashi
 */
@org.springframework.stereotype.Controller
public class LoginController extends BaseController {
  
  // Autowire the connection bean here , no need to instantitate an object.
 @Autowired
  private DataSource ds;
  
  protected final Log logger = LogFactory.getLog(getClass());
  String email = null;
  String passwordEntered = null;
  String entity = null; //Will be consultant/analyst
  String passwordActual = null;
  private Connection con;

  @RequestMapping(value = "/authenticateUser" , method= RequestMethod.POST)
  //This request mapping will be valid only for loginUser.php requests.
  //TODO:Change the mappiing if required and make it more general.
  public ModelAndView handleRequest(@RequestParam("email") String emailForm,@RequestParam("password")String passwordForm,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    con=ds.getConnection();
    logger.info("The connection object is"+con);
    logger.info("Inside method handleRequest-> authenticateUser()");
    email = emailForm; //Get email from form bean
    passwordEntered = passwordForm;//Get password from form bean
    logger.info("the password is"+passwordEntered);
    Boolean isEmailExists = false;
    if (StringUtils.isNotBlank(email) && StringUtils.isNotEmpty(email)) {
      isEmailExists = CommonUtil.doesEmailExists(email,con);
    }
    if (isEmailExists) {
      entity = CommonUtil.getEntity(CommonUtil.isAnalayst(email,con), CommonUtil.isConsultant(email,con),con);
      passwordActual = CommonUtil.getPassword(entity, email,con);
      if (StringUtils.equals(passwordActual, passwordEntered)) {
        if (StringUtils.equals(entity, ReusableConstants.ANALYST)) {
          //Just get the rest of the data in a domain object for the analyst to avoid further calls to DB
        } else if (StringUtils.equals(entity, ReusableConstants.CONSULTANT)) {
            if (!CommonUtil.consultantIsDisabled(con)) {
              //Just get the rest of the data in a domain object for the consultant to avoid further calls to DB
            } else {
              // Consultant is disabled in this case , just reuse the  method from the BaseController which throws 
              //  to the disabled page
              redirectToDisabledPage();
              return null;
              //Don't Execute rest of the code
            }
          } else {
          }
        
      } else {
        //Password does not match
        logger.warn("The password is not matching , Throw back to login page");
      }
    } else {
      //email does not exist in the database
      logger.warn("The email does not exist , Throw back to login page");
    }

    return new ModelAndView("hello");
  }
  


@RequestMapping(value = "/login", method = RequestMethod.GET)
public ModelAndView loginUser() {
  return new ModelAndView("login");
  }

}
