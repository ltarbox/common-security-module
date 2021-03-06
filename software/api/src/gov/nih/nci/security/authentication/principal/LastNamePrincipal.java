/*L
 *  Copyright Ekagra Software Technologies Ltd.
 *  Copyright SAIC, SAIC-Frederick
 *
 *  Distributed under the OSI-approved BSD 3-Clause License.
 *  See http://ncip.github.com/common-security-module/LICENSE.txt for details.
 */

package gov.nih.nci.security.authentication.principal;

import java.security.Principal;

import javax.security.auth.Subject;


/**
 * This class holds the Last Name of the user retrieved. It would be returned as part of the <code>JAAS</code>
 * {@link Subject} to the calling application
 * 
 * @author Kunal Modi (Ekagra Software Technologies Ltd.)
 */
public class LastNamePrincipal extends BasePrincipal
{

	/**
	 * This Constructor accepts the last name value which would be stored in this {@link Principal}
	 * @param name the last name value to be stored
	 */
	public LastNamePrincipal(String name)
	{
		super(name);
		// TODO Auto-generated constructor stub
	}

}
