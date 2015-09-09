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
import javax.ejb.Remote;
<#if isEjb3>
import ${namePackageService}.${serviceName};
<#else>
<#foreach parametro in skeletonUtils.generateParameterImports(methods,false)>
import ${parametro};
</#foreach>
</#if>

/**
 * ${serviceName} + "StubRemote generated by UDA".
 * @author UDA
 */

@Remote
<#if isEjb3>
public interface ${serviceName}StubRemote extends ${serviceName}{
<#else>
@SuppressWarnings("rawtypes")
public interface ${serviceName}StubRemote{ 
	<#assign listaMetodos = methods>
	<#list methods as metodo>
	<#assign param = metodo[3]>
	/**
	 * Method ${metodo[0]}
	 *
	 * @return <#if isJpa><#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)>${parametro}</#foreach><#else>${metodo[2]}</#if>
	 */	
	public <#if isJpa><#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)>${parametro}</#foreach><#else>${metodo[2]}</#if> ${metodo[0]} (<#list skeletonUtils.getParametersSkeleton(param,false,false) as parametro>${parametro} arg${parametro_index}<#if parametro_has_next>,</#if></#list>) throws Exception;
	</#list>	
</#if>

}