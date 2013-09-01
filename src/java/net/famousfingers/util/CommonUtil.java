package net.famousfingers.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import net.famousfingers.constants.ReusableConstants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CommonUtil
{
  protected static final Log logger = LogFactory.getLog(CommonUtil.class);

  

  public static Properties readProperties(String filename) throws IOException { Properties props = new Properties();
    ClassLoader loader = Thread.currentThread().getContextClassLoader();
    InputStream stream = loader.getResourceAsStream(filename);
    props.load(stream);
    return props;
  }

  public static Boolean isAnalayst(String email , Connection con)
    throws SQLException
  {
    String methodName = "isAnalayst";
    logger.info("Inside method" + methodName);
    CallableStatement callIsAnalyst = con.prepareCall("{call isAnalyst(?)}");
    callIsAnalyst.setString(1, email);
    logger.info("Calling procedureisAnalyst with" + email + "as parameter");
    callIsAnalyst.registerOutParameter(2, 16);
    callIsAnalyst.executeQuery();
    logger.info("Procedure call successful" + callIsAnalyst.toString());
    Boolean isAnalyst = Boolean.valueOf(callIsAnalyst.getBoolean(2));
    return isAnalyst;
  }

  public static Boolean isConsultant(String email,Connection con) throws SQLException {
    String methodName = "isConsultant";
    logger.info("Inside method" + methodName);
    CallableStatement callIsConsultant = con.prepareCall("{call "+ ReusableConstants.CONSULTANT+"(?)}");
    callIsConsultant.setString(1, email);
    logger.info("Calling procedureisConsultant with" + email + "as parameter");
    callIsConsultant.registerOutParameter(2, java.sql.Types.BOOLEAN);
    callIsConsultant.executeQuery();
    logger.info("Procedure call successful" + callIsConsultant.toString());
    Boolean isConsultant = Boolean.valueOf(callIsConsultant.getBoolean(2));
    return isConsultant;
  }

  public static Boolean doesEmailExists(String email,Connection con)
    throws SQLException
  {
    String methodName = "doesEmailExists";
    logger.info("Inside method" + methodName);
    CallableStatement callDoesEmailExist = con.prepareCall("{call "+ReusableConstants.PROCEDURE_EMAIL_EXISTS+"(?,?)}");
    callDoesEmailExist.setString(1, email);
    logger.info("Calling proceduredoesEmailExists with" + email + "as parameter");
    callDoesEmailExist.registerOutParameter(2, java.sql.Types.BOOLEAN);
    callDoesEmailExist.execute();
    logger.info("Procedure call successful" + callDoesEmailExist.toString());
    Boolean doesEmailExists = Boolean.valueOf(callDoesEmailExist.getBoolean(2));
    return doesEmailExists;
  }

  public static String getPassword(String object, String id,Connection con)
    throws SQLException
  {
    String methodName = "getPassword";
    logger.info("Inside method" + methodName);
    CallableStatement callGetPassword = con.prepareCall("{call "+ReusableConstants.PROCEDURE_GET_PASSWORD+"(?)}");
    callGetPassword.setString(1, object);
    callGetPassword.setString(2, id);
    callGetPassword.registerOutParameter(3, java.sql.Types.CHAR);
    logger.info("Calling proceduregetPassword with" + object + "and" + id + "as parameters");
    callGetPassword.executeQuery();
    logger.info("Procedure call successful" + callGetPassword.toString());
    String getPassword = callGetPassword.getString(3);
    return getPassword;
  }

  public static String getRole(String object, String id,Connection con)
    throws SQLException
  {
    String methodName = "getRole";
    logger.info("Inside method" + methodName);
    CallableStatement callGetRole = con.prepareCall("{call "+ReusableConstants.PROCEDURE_GET_ROLE+"(?)}");
    callGetRole.setString(1, object);
    callGetRole.setString(2, id);
    callGetRole.registerOutParameter(3, java.sql.Types.CHAR);
    logger.info("Calling proceduregetRole with" + object + "and" + id + "as parameters");
    callGetRole.executeQuery();
    logger.info("Procedure call successful" + callGetRole.toString());
    String getRole = callGetRole.getString(3);
    return getRole;
  }

  public static String getStatus(String object, String id,Connection con)
    throws SQLException
  {
    String methodName = "getStatus";
    logger.info("Inside method" + methodName);
    CallableStatement callGetStatus = con.prepareCall("{call "+ReusableConstants.PROCEDURE_GET_STATUS+"(?)}");
    callGetStatus.setString(1, object);
    callGetStatus.setString(2, id);
    callGetStatus.registerOutParameter(3, java.sql.Types.CHAR);
    logger.info("Calling proceduregetStatus with" + object + "and" + id + "as parameters");
    callGetStatus.executeQuery();
    logger.info("Procedure call successful" + callGetStatus.toString());
    String getStatus = callGetStatus.getString(3);
    return getStatus;
  }

  public static String getEntity(Boolean isAnalyst, Boolean isConsultant,Connection con) {
    String methodName = "getEntity";
    String entity = null;
    logger.info("Inside method" + methodName);
    if ((isAnalyst.booleanValue()) && (!isConsultant.booleanValue())) {
      entity = "analyst";
      logger.info("The resultant object isanalyst");
    } else if ((isConsultant.booleanValue()) && (!isAnalyst.booleanValue())) {
      entity = "consultant";
      logger.info("The resultant object isconsultant");
    } else {
      logger.fatal("Procedure not returing correct values");
    }
    return entity;
  }

  public static Boolean consultantIsDisabled(Connection con)
    throws SQLException
  {
    String methodName = "consultantIsDisabled";
    logger.info("Inside method" + methodName);
    CallableStatement callConsultantIsDisabled = con.prepareCall("{call "+ReusableConstants.PROCEDURE_CONSULTANT_IS_DISABLED+"(?)}");
    logger.info("Calling procedureisConsultantDisabled");
    callConsultantIsDisabled.registerOutParameter(1, java.sql.Types.BOOLEAN);
    callConsultantIsDisabled.executeQuery();
    logger.info("Procedure call successful" + callConsultantIsDisabled.toString());
    Boolean consultantIsDisabled = Boolean.valueOf(callConsultantIsDisabled.getBoolean(2));
    return consultantIsDisabled;
  }
}