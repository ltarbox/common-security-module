package gov.nih.nci.security.authorization.attributeLevel;

import gov.nih.nci.logging.api.logger.util.ThreadVariable;
import gov.nih.nci.logging.api.user.UserInfo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.acegisecurity.context.SecurityContextHolder;
import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;


public class AttributeSecuritySessionInterceptor extends EmptyInterceptor
{
	
	boolean securityBehaviourStrict = true;
	
	
	public AttributeSecuritySessionInterceptor(){
		this.securityBehaviourStrict = true;
	}
	public AttributeSecuritySessionInterceptor(boolean strict){
		this.securityBehaviourStrict = strict;
	}

	
	
	
	/* (non-Javadoc)
	 * @see org.hibernate.EmptyInterceptor#onLoad(java.lang.Object, java.io.Serializable, java.lang.Object[], java.lang.String[], org.hibernate.type.Type[])
	 */
	@Override
	public boolean onLoad(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types)
	{
		

		Object objectUserInfo = ThreadVariable.get();
		String[] groupNames = null;
		if (objectUserInfo instanceof UserInfo)
		{
			groupNames = ((UserInfo)objectUserInfo).getGroupNames();
			
		}
		if(groupNames!=null && groupNames.length>0 )
		{
			List attributeList = UserClassAttributeMapCache.getAttributeMapForGroup(groupNames, entity.getClass().getName());
			if (attributeList == null)
				attributeList = new ArrayList();
			for (int i=0; i < propertyNames.length; i++)
			{
				if (!(attributeList.contains(propertyNames[i])))
				{
					if(this.securityBehaviourStrict){
						state[i]=null;
					}else{
						if(!types[i].isAssociationType())
							state[i]=null;
					}
				}
			}
			return super.onLoad(entity, id, state, propertyNames, types);
		}
		else
		{
		
			String userName = null;
			if(null != SecurityContextHolder.getContext().getAuthentication()){
				userName = SecurityContextHolder.getContext().getAuthentication().getName();
			}
			if (null == userName)
			{
				//Object objectUserInfo = ThreadVariable.get();
				if (objectUserInfo instanceof UserInfo)
				{
					userName = ((UserInfo)objectUserInfo).getUsername();
				}
				else
				{
					userName = (String)objectUserInfo;
				}
			}
			List attributeList = UserClassAttributeMapCache.getAttributeMap(userName, entity.getClass().getName());
			if (attributeList == null)
				attributeList = new ArrayList();
			for (int i=0; i < propertyNames.length; i++)
			{
				if (!(attributeList.contains(propertyNames[i])))
				{
					if(this.securityBehaviourStrict){
						state[i]=null;
					}else{
						if(!types[i].isAssociationType())
							state[i]=null;
					}
				}
			}
			return super.onLoad(entity, id, state, propertyNames, types);		
		}
	}

}
