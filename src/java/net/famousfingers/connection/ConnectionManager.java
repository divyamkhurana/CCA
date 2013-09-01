/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.famousfingers.connection;

import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author Ashi
 */
public class ConnectionManager {
  protected final Log logger = LogFactory.getLog(getClass());
  @Autowired
  public DataSource setDataSource(DataSource dataSource) throws SQLException {
    logger.info("The datasource object is"+dataSource);
    return dataSource;
  }
}
