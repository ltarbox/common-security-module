/*L
 *  Copyright Ekagra Software Technologies Ltd.
 *  Copyright SAIC, SAIC-Frederick
 *
 *  Distributed under the OSI-approved BSD 3-Clause License.
 *  See http://ncip.github.com/common-security-module/LICENSE.txt for details.
 */

package gov.nih.nci.security.dialect;
import gov.nih.nci.security.constants.Constants;

import org.hibernate.dialect.MySQLInnoDBDialect;

public class CSMMySQLInnoDBDialect extends MySQLInnoDBDialect {
    
    /**
     * Create a new dialect.
     */
    public CSMMySQLInnoDBDialect() {
        super();
        registerKeyword(Constants.CSM_FILTER_ALIAS);
    }
}
