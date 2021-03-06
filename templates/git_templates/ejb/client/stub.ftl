<#-- 
 -- Copyright 2011 E.J.I.E., S.A.
 --
 -- Licencia con arreglo a la EUPL, Versión 1.1 exclusivamente (la «Licencia»);
 -- Solo podrá usarse esta obra si se respeta la Licencia.
 -- Puede obtenerse una copia de la Licencia en
 --
 --      http://ec.europa.eu/idabc/eupl.html
 --
 -- Salvo cuando lo exija la legislación aplicable o se acuerde por escrito, 
 -- el programa distribuido con arreglo a la Licencia se distribuye «TAL CUAL»,
 -- SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO, ni expresas ni implícitas.
 -- Véase la Licencia en el idioma concreto que rige los permisos y limitaciones
 -- que establece la Licencia.
 -->
package ${packageNameRemoting};
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.interceptor.Interceptors;
<#foreach parametro in skeletonUtils.generateParameterImports(methods,false)>	
import ${stubUtils.replaceDto(parametro)};
</#foreach>
<#if isEjb3>
import ${namePackageEjb}.${serviceName}SkeletonRemote ;
<#else>
import ${namePackageEjb}.${serviceName}Home ;
import ${namePackageEjb}.${serviceName} ;
</#if>
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ejb.interceptor.SpringBeanAutowiringInterceptor;
import com.ejie.x38.remote.RemoteEJBFactory;
<#if isEjb3>
import com.ejie.x38.remote.TransactionMetadata;
</#if>
import com.ejie.x38.remote.TransactionMetadataStubInterceptor;
import com.ejie.x38.util.StackTraceManager;

/**
 * ${serviceName} + "Stub generated by UDA".
 * @author UDA
 */

@Stateless(mappedName = "${jndiName}")
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
@Interceptors({SpringBeanAutowiringInterceptor.class, TransactionMetadataStubInterceptor.class})
@Remote(${serviceName}StubRemote.class)
@SuppressWarnings("rawtypes")
public class ${serviceName}Stub implements ${serviceName}StubRemote   {
	private static final Logger logger = LoggerFactory.getLogger(${serviceName}Stub.class);
	<#if isEjb3>
		private ${serviceName}SkeletonRemote ${serviceName?uncap_first}SkeletonRemote;
	<#else>
		private ${serviceName}Home ${serviceName?uncap_first}Home;
		private ${serviceName} ${serviceName?uncap_first};
	</#if>
	@Autowired
	private RemoteEJBFactory remoteEJBFactory;

	 <#assign param ="">
	<#assign listaMetodos = methods>
	<#list methods as metodo>
	    <#assign param = metodo[3]>
		<#assign creator=stubUtils.generateParameterConstructor(metodo[1])>
	/**
	 * Method ${metodo[0]}.
	<#foreach parametro in skeletonUtils.getParametersSkeleton(param,false,false)>
	 * @param ${ctrUtils.stringDecapitalize(stubUtils.replaceDto(parametro))} ${stubUtils.replaceDto(parametro)} 
	</#foreach>
	 * @return <#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)>${stubUtils.replaceDto(parametro)}</#foreach>
	 */
	<#if isEjb3>
	@Override
	${skeletonUtils.generateTransactionAttribute(metodo[0])}
	public <#if isJpa><#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)>${stubUtils.replaceDto(parametro)}</#foreach><#else>${metodo[2]}</#if> ${metodo[0]} (<#list skeletonUtils.getParametersSkeleton(param,false,false) as parametro>${stubUtils.replaceDto(parametro)} arg${parametro_index}<#if parametro_has_next>, </#if></#list>) <#if metodo[4]!= ""> throws ${metodo[4]}</#if> {
		<#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)><#if parametro!='void'>return</#if></#foreach> this.${serviceName?uncap_first}SkeletonRemote.${metodo[0]}(<#list skeletonUtils.getParametersSkeleton(param,false,false) as parametro>arg${parametro_index}, </#list>new TransactionMetadata(this.getClass().getName(), Thread.currentThread().getStackTrace()[1].getMethodName()));
	}
	<#else>
	@Override
	${skeletonUtils.generateTransactionAttribute(metodo[0])}
	public <#if isJpa><#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)>${parametro}</#foreach><#else>${metodo[2]}</#if> ${metodo[0]} (<#list skeletonUtils.getParametersSkeleton(param,false,false) as parametro>${parametro} arg${parametro_index}<#if parametro_has_next>, </#if></#list>) throws Exception {
		<#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)><#if parametro!='void'>return</#if></#foreach> this.${serviceName?uncap_first}.${metodo[0]}(<#list skeletonUtils.getParametersSkeleton(param,false,false) as parametro>arg${parametro_index}<#if parametro_has_next>, </#if></#list>);
	}
	</#if>	
	</#list>

	<#if isEjb3>
	@SuppressWarnings("unused")
	@PostConstruct
	private void init(){
		try{
			${serviceName?uncap_first}SkeletonRemote = (${serviceName}SkeletonRemote) remoteEJBFactory.lookup("${nameServer}", ${serviceName}SkeletonRemote.class);
			logger.info("Obtained remote Skeleton is: "+${serviceName?uncap_first}SkeletonRemote.toString());
		}catch(Exception e){
			logger.error(StackTraceManager.getStackTrace(e));
		}
	}
	<#else>
	@SuppressWarnings("unused")
	@PostConstruct
	private void init() throws Exception{
		try{
			${serviceName?uncap_first}Home = (${serviceName}Home) remoteEJBFactory.lookup("${nameServer}", ${serviceName}Home.class);
			this.${serviceName?uncap_first} = ${serviceName?uncap_first}Home.create();
			logger.info(${serviceName?uncap_first}.toString());
		}catch(Exception e){
			logger.error(StackTraceManager.getStackTrace(e));
			throw e;
		}
	}
	</#if>
	
	<#if isEjb3>
	@SuppressWarnings("unused")
	@PreDestroy
	private void destroy(){
		logger.info("Deleting cached instance of "+${serviceName}SkeletonRemote.class+" before destroying this EJB");
		remoteEJBFactory.clearInstance(${serviceName}SkeletonRemote.class);
	}
	<#else>
	   
	@SuppressWarnings("unused")
	@PreDestroy
	private void destroy(){
		logger.info("Deleting cached instance of "+${serviceName}Home.class+" before destroying this EJB");
		remoteEJBFactory.clearInstance(${serviceName}Home.class);
	}
	</#if>

	public RemoteEJBFactory getRemoteEJBFactory() {
		return remoteEJBFactory;
	}

	public void setRemoteEJBFactory(RemoteEJBFactory remoteEJBFactory) {
		this.remoteEJBFactory = remoteEJBFactory;
	}
}