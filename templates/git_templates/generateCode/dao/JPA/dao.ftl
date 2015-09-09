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
package ${pojo.getPackageName()}.dao;  
<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName()) >
import ${pojo.importType(pojo.getPackageName()+'.model.'+pojo.getDeclarationName())};
<#-- Obtenemos el tipo de la primaria -->
<#if pojo.hasIdentifierProperty() && !c2j.isComponent(pojo.getIdentifierProperty())>
<#assign tipo=pojo.getIdentifierProperty().getType() >
<#assign Typejo = tipo.getReturnedClass().getName() >
	<#if Typejo?lower_case = 'int'><#assign TypeSimp='java.Lang.Integer'>
	<#else>
		<#assign TypeSimp = warSupressor.typeConverter(Typejo,true)>

	</#if>
<#else> <#-- clave compuesta --> 
	<#assign TypeSimp = pojo.getPackageName()+'.model.'+pojo.getDeclarationName()+'Id'>
</#if>

/**
 * ${pojo.getClassJavaDoc(pojo.getDeclarationName() + "Dao generated by UDA", 0)}, ${date}.
 * @author UDA
 */
 
public interface ${pojo.getDeclarationName()}Dao extends ${pojo.importType("com.ejie.x38.dao.GenericDao")}<${pojo.getDeclarationName()}, ${pojo.importType(TypeSimp)}> {

	/**
	 *  Method  'setEntityManager'.
	 *  @param entityManager ${pojo.importType("javax.persistence.EntityManager")}
	 */
	void setEntityManager(${pojo.importType("javax.persistence.EntityManager")} entityManager);
	
	/**
	 * Finds a List of rows in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
	 * @param pagination ${pojo.importType("com.ejie.x38.dto.Pagination")}
	 * @return ${pojo.importType("java.util.List")} ${pojo.getDeclarationName()}
	 */
	${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAll(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}, ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination);

	/**
	 * Counts the rows in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
	 * @return Long
	 */
	Long findAllCount(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case});
	
	/**
	 * Finds a List of rows in the ${pojo.getDeclarationName()} table using like.
	 *
	 * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
	 * @param pagination ${pojo.importType("com.ejie.x38.dto.Pagination")}
	 * @return ${pojo.importType("java.util.List")} ${pojo.getDeclarationName()}
	 */
	${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAllLike(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}, ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination, Boolean startsWith) ;

	<#foreach property in pojo.getAllPropertiesIterator()>
      <#if c2h.isManyToMany(property)>
        <#if c2h.isCollection(property)>
           <#include "daoRelations.ftl"/>					
        </#if>
      </#if>
    </#foreach>	
}	

</#assign>

${pojo.generateImports()}
${classbody}
	