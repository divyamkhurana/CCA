/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.famousfingers.builder;

import java.sql.ResultSet;
import java.sql.SQLException;
import net.famousfingers.constants.ReusableConstants;
import net.famousfingers.domain.FFAnalayst;

/**
 *
 * @author Ashi
 */
public class AnalystBuilder {
  private String analyst_id=null;
  private String first_name=null;;
  private String last_name=null;;
  private String email=null;;
  private String mobile_no=null;
  private String phone_no=null;
  private String city=null;
  private String pin_code=null;
  private String address=null;
  private String country=null;
  private String role=null;
  private String entity=null;
  FFAnalayst analystInfo=null;
  
  public FFAnalayst getAnalystDetails(ResultSet entityDetails) throws SQLException{
    
  if(entityDetails!=null){
    if(entityDetails.next()){
      analystInfo=new FFAnalayst();
      analyst_id=entityDetails.getString("analyst_id");
      analystInfo.setAnalyst_id(analyst_id);
      
      first_name=entityDetails.getString("first_name");
      analystInfo.setFirst_name(first_name);
      
      last_name= entityDetails.getString("last_name");
      analystInfo.setLast_name(last_name);
      
      email=entityDetails.getString("email");
      analystInfo.setEmail(email);
      
      mobile_no=entityDetails.getString("mobile_no");
      analystInfo.setMobile_no(mobile_no);
      
      phone_no=entityDetails.getString("phone_no");
      analystInfo.setPhone_no(phone_no);
      
      city=entityDetails.getString("city");
      analystInfo.setCity(city);
      
      pin_code=entityDetails.getString("pincode");
      analystInfo.setPin_code(pin_code);
      
      address=entityDetails.getString("address");
      analystInfo.setAddress(address);
      
      country=entityDetails.getString("country");
      analystInfo.setCountry(country);
      
      role=entityDetails.getString("role");
      analystInfo.setRole(role);
      
      analystInfo.setEntity(ReusableConstants.ANALYST);
    }
  }    
    return analystInfo;
  }
  
}
