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
 * ${pojo.getClassJavaDoc(pojo.getDeclarationName() + "DaoImpl generated by UDA", 0)}, ${date}.
 * @author UDA
 */
 
<#if annot!=0>@${pojo.importType("org.springframework.stereotype.Repository")}</#if>
public class ${pojo.getDeclarationName()}DaoImpl extends ${pojo.importType("com.ejie.x38.dao.GenericDaoImpl")}<${pojo.getDeclarationName()}, ${pojo.importType(TypeSimp)}> implements ${pojo.getDeclarationName()}Dao {
    /**
	 * Method  'setEntityManager'.
	 * 	 
	 * @param entityManager ${pojo.importType("javax.persistence.EntityManager")}
	 * @return 
	 */
	@Override
	@${pojo.importType("javax.persistence.PersistenceContext")}(unitName = "${app?upper_case}_JTA")
	public void setEntityManager(${pojo.importType("javax.persistence.EntityManager")} entityManager) {
		super.setEntityManager(entityManager);
	}

	/**
	 * Finds a List of rows in the${pojo.getDeclarationName()} table.
	 *
	 * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
	 * @param pagination ${pojo.importType("com.ejie.x38.dto.Pagination")}
	 * @return ${pojo.importType("java.util.List")} ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.transaction.annotation.Transactional")}(readOnly = true)
	public ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAll(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}, ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination) {
	    ${pojo.importType("javax.persistence.EntityManager")} em = this.getEntityManager();
		${pojo.importType("javax.persistence.criteria.CriteriaBuilder")} cb =  em.getCriteriaBuilder();
		${pojo.importType("javax.persistence.criteria.CriteriaQuery")}<${pojo.getDeclarationName()}> query = cb.createQuery(${pojo.getDeclarationName()}.class);
		${pojo.importType("javax.persistence.criteria.Root")}<${pojo.getDeclarationName()}> ${pojo.getDeclarationName()?lower_case}Aux = query.from(${pojo.getDeclarationName()}.class);
		 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(pojo.getDeclarationName())+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(pojo.getDeclarationName()))>
		<#foreach temp in daoUtilities.getFromParams(pojo,cfg) >
		    <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[1])+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[1]))>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[0])+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[0]))>
			 ${pojo.importType("javax.persistence.criteria.Join")}< ${pojo.beanCapitalize(temp[0])}, ${pojo.beanCapitalize(temp[1])}> ${temp[2]} = ${temp[3]}.join(
			${pojo.beanCapitalize(temp[0])}_.${temp[4]}, ${pojo.importType("javax.persistence.criteria.JoinType")}.LEFT);
		</#foreach>
		<#if pojo.hasIdentifierProperty() && c2j.isComponent(pojo.getIdentifierProperty())>
		     <#assign importarOtro=pojo.importType(pojo.getPackageName()+'.model.'+pojo.getDeclarationName()+'Id_')>
		</#if>

		${pojo.importType("java.util.List")}<${pojo.importType("javax.persistence.criteria.Predicate")}> predicates = new ${pojo.importType("java.util.ArrayList")}<${pojo.importType("javax.persistence.criteria.Predicate")}>();
	<#foreach temp2 in daoUtilities.getFirsLevelFields(pojo,true) >
       if (${pojo.getDeclarationName()?lower_case} != null && ${pojo.getDeclarationName()?lower_case}.${temp2[2]} != null <#if temp2[5]!=''> ${temp2[5]} </#if>) {
			predicates.add(cb.equal(${temp2[0]}.get(${pojo.getDeclarationName()}_.${temp2[1]}), ${pojo.getDeclarationName()?lower_case}.${temp2[2]}));
       }                                         
	</#foreach>
	<#foreach temp3 in daoUtilities.getSecondLevelFields(pojo,cfg,true) >
       if (${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}() != null && ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]} != null <#if temp3[8]!=''> ${temp3[8]} </#if>) {
			predicates.add(cb.equal(${temp3[4]}.get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}), ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]}));
       }                                   
	</#foreach>
	<#foreach temp4 in daoUtilities.getThirdLevelFields(pojo,cfg,true) >
       if (${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}() != null && ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]} != null <#if temp4[8]!=''> ${temp4[8]} </#if>) {
			predicates.add(cb.equal(${temp4[5]}.get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}), ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]}));
		}                      
	</#foreach>
	   query.where(predicates.toArray(new Predicate[]{}));
	   		return (${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}>)  queryPagination(pagination, query,${pojo.getDeclarationName()?lower_case}Aux
				,cb).getResultList();
	}

	/**
	 * Counts the rows in the${pojo.getDeclarationName()} table.
	 *
	 * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
	 * @return Long
	 */
	@${pojo.importType("org.springframework.transaction.annotation.Transactional")}(readOnly = true)
	public Long findAllCount(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}) {
		${pojo.importType("javax.persistence.EntityManager")} em = this.getEntityManager();
		${pojo.importType("javax.persistence.criteria.CriteriaBuilder")} cb = em.getCriteriaBuilder();
		${pojo.importType("javax.persistence.criteria.CriteriaQuery")}<Long> query = cb.createQuery(Long.class);

		${pojo.importType("javax.persistence.criteria.Root")}<${pojo.getDeclarationName()}> ${pojo.getDeclarationName()?lower_case}Aux = query.from(${pojo.getDeclarationName()}.class);

		<#foreach temp in daoUtilities.getFromParams(pojo,cfg) >
		     <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[1])+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[1]))>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[0])+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[0]))>
			 ${pojo.importType("javax.persistence.criteria.Join")}< ${pojo.beanCapitalize(temp[0])}, ${pojo.beanCapitalize(temp[1])}> ${temp[2]} = ${temp[3]}.join(
			${pojo.beanCapitalize(temp[0])}_.${temp[4]}, ${pojo.importType("javax.persistence.criteria.JoinType")}.LEFT);
		</#foreach>

		${pojo.importType("java.util.List")}<${pojo.importType("javax.persistence.criteria.Predicate")}> predicates = new ${pojo.importType("java.util.ArrayList")}<${pojo.importType("javax.persistence.criteria.Predicate")}>();

	<#foreach temp2 in daoUtilities.getFirsLevelFields(pojo,true) >
       if (${pojo.getDeclarationName()?lower_case} != null && ${pojo.getDeclarationName()?lower_case}.${temp2[2]} != null <#if temp2[5]!=''> ${temp2[5]} </#if>) {
			predicates.add(cb.equal(${temp2[0]}.get(${pojo.getDeclarationName()}_.${temp2[1]}), ${pojo.getDeclarationName()?lower_case}.${temp2[2]}));
       }                                                    
	</#foreach>
	<#foreach temp3 in daoUtilities.getSecondLevelFields(pojo,cfg,true) >
       if (${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}() != null && ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]} != null <#if temp3[8]!=''> ${temp3[8]} </#if>) {
			predicates.add(cb.equal(${temp3[4]}.get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}), ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]}));
       }                                                    
	</#foreach>
	<#foreach temp4 in daoUtilities.getThirdLevelFields(pojo,cfg,true) >
       if (${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}() != null && ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]} != null <#if temp4[8]!=''> ${temp4[8]} </#if>) {
			predicates.add(cb.equal(${temp4[5]}.get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}), ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]}));
		}                                                
	</#foreach>

	    query.select(cb.count(${pojo.getDeclarationName()?lower_case}Aux)); 
		query.where(predicates.toArray(new Predicate[]{}));
		return (Long) em.createQuery(query).getSingleResult();
	}
	<#foreach property in pojo.getAllPropertiesIterator()>
      <#if c2h.isManyToMany(property)>
        <#if c2h.isCollection(property)>
           <#include "daoRelationsImpl.ftl"/>					
        </#if>
      </#if>
    </#foreach>	
 	
 	/**
	 * Finds a List of rows in the${pojo.getDeclarationName()} table using like.
	 *
	 * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
	 * @param pagination ${pojo.importType("com.ejie.x38.dto.Pagination")}
	 * @return ${pojo.importType("java.util.List")} ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.transaction.annotation.Transactional")}(readOnly = true)
	public ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAllLike(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}, ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination, Boolean startsWith) {
	    ${pojo.importType("javax.persistence.EntityManager")} em = this.getEntityManager();
		${pojo.importType("javax.persistence.criteria.CriteriaBuilder")} cb =  em.getCriteriaBuilder();
		${pojo.importType("javax.persistence.criteria.CriteriaQuery")}<${pojo.getDeclarationName()}> query = cb.createQuery(${pojo.getDeclarationName()}.class);
		${pojo.importType("javax.persistence.criteria.Root")}<${pojo.getDeclarationName()}> ${pojo.getDeclarationName()?lower_case}Aux = query.from(${pojo.getDeclarationName()}.class);
		 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(pojo.getDeclarationName())+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(pojo.getDeclarationName()))>
		<#foreach temp in daoUtilities.getFromParams(pojo,cfg) >
		    <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[1])+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[1]))>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[0])+'_')>
			 <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp[0]))>
			 ${pojo.importType("javax.persistence.criteria.Join")}< ${pojo.beanCapitalize(temp[0])}, ${pojo.beanCapitalize(temp[1])}> ${temp[2]} = ${temp[3]}.join(
			${pojo.beanCapitalize(temp[0])}_.${temp[4]}, ${pojo.importType("javax.persistence.criteria.JoinType")}.LEFT);
		</#foreach>

		${pojo.importType("java.util.List")}<${pojo.importType("javax.persistence.criteria.Predicate")}> predicates = new ${pojo.importType("java.util.ArrayList")}<${pojo.importType("javax.persistence.criteria.Predicate")}>();
	<#foreach temp2 in daoUtilities.getFirsLevelFields(pojo,true) >
       if (${pojo.getDeclarationName()?lower_case} != null && ${pojo.getDeclarationName()?lower_case}.${temp2[2]} != null <#if temp2[5]!=''> ${temp2[5]} </#if>) {
	   <#if temp2[3]='1'>
	        if(startsWith){
				predicates.add(cb.like(${temp2[0]}.get(${pojo.getDeclarationName()}_.${temp2[1]}), ${pojo.getDeclarationName()?lower_case}.${temp2[2]}+"%"));
			}else{
				predicates.add(cb.like(${temp2[0]}.get(${pojo.getDeclarationName()}_.${temp2[1]}), "%"+${pojo.getDeclarationName()?lower_case}.${temp2[2]}+"%"));
			}	
		<#else>
				predicates.add(cb.equal(${temp2[0]}.get(${pojo.getDeclarationName()}_.${temp2[1]}), ${pojo.getDeclarationName()?lower_case}.${temp2[2]}));
		</#if>
       }                                         
	</#foreach>
	<#foreach temp3 in daoUtilities.getSecondLevelFields(pojo,cfg,true) >
       if (${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}() != null && ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]} != null <#if temp3[8]!=''> ${temp3[8]} </#if>) {
	    <#if temp3[6]='1'>
	       if(startsWith){
				predicates.add(cb.like(${temp3[4]}.get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}), ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]}+"%"));
			}else{
				predicates.add(cb.like(${temp3[4]}.get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}), "%"+${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]}+"%"));
			}	
		<#else>
				predicates.add(cb.equal(${temp3[4]}.get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}), ${temp3[0]?lower_case}.get${pojo.beanCapitalize(temp3[5])}().${temp3[3]}));
		</#if>			
       }                                   
	</#foreach>
	<#foreach temp4 in daoUtilities.getThirdLevelFields(pojo,cfg,true) >
       if (${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}() != null && ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]} != null <#if temp4[8]!=''> ${temp4[8]} </#if>) {
		<#if temp4[5]='1'>
	       if(startsWith){
				predicates.add(cb.like(${temp4[5]}.get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}), ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]}+"%"));
			}else{
				predicates.add(cb.like(${temp4[5]}.get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}), "%" + ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]}+"%"));
			}	
		<#else>
				predicates.add(cb.equal(${temp4[5]}.get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}), ${temp4[0]?lower_case}.get${pojo.beanCapitalize(temp4[1])}().get${pojo.beanCapitalize(temp4[2])}().${temp4[4]}+"%"));
		</#if>
		}                      
	</#foreach>
	   query.where(predicates.toArray(new Predicate[]{}));
	   	   		return (${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}>)  queryPagination(pagination, query,${pojo.getDeclarationName()?lower_case}Aux
				,cb).getResultList();

	}
    
    private  ${pojo.importType("javax.persistence.TypedQuery")}<${pojo.getDeclarationName()}> queryPagination(${pojo.importType("com.ejie.x38.dto.Pagination")} pagination,
                  ${pojo.importType("javax.persistence.criteria.CriteriaQuery")}<${pojo.getDeclarationName()}> query, ${pojo.importType("javax.persistence.criteria.Root")}<${pojo.getDeclarationName()}> ${pojo.getDeclarationName()?lower_case}Aux,
                  ${pojo.importType("javax.persistence.criteria.CriteriaBuilder")} cb) {
		    
			if (pagination != null && pagination.getSort() != null ) {
			<#foreach temp2 in daoUtilities.getFirsLevelFields(pojo,false) >
			<#if temp2[4]!=''>
				if (pagination.getSort().equals("${temp2[4]}")) {
				    if (pagination.getAscDsc().equals("desc")) {
						query.orderBy(cb.desc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${temp2[1]}).get(${pojo.getDeclarationName()}Id_.${temp2[4]})));
					}else{
					    query.orderBy(cb.asc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${temp2[1]}).get(${pojo.getDeclarationName()}Id_.${temp2[4]})));
					}	
				}    
			<#else>
				if (pagination.getSort().equals("${temp2[1]}")) {
				    if (pagination.getAscDsc().equals("desc")) {
						query.orderBy(cb.desc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${temp2[1]})));
					}else{
					    query.orderBy(cb.asc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${temp2[1]})));
					}	
				}    
             </#if>	   
	</#foreach>

	<#foreach temp3 in daoUtilities.getSecondLevelFieldsPK(pojo,cfg,false) >
		<#if temp3[7]!=''>
		if (pagination.getSort().equals("${temp3[7]}")) {
		  if (pagination.getAscDsc().equals("desc")) {
		  <#assign importar=pojo.importType(pojo.getPackageName()+'.model.'+pojo.beanCapitalize(temp3[1])+'Id_')>
                query.orderBy(cb.desc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp3[1])})
                                         .get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}).get(${pojo.beanCapitalize(temp3[1])}Id_.${temp3[7]})));
										 										 
        } else {
                query.orderBy(cb.asc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp3[1])})
                                         .get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]}).get(${pojo.beanCapitalize(temp3[1])}Id_.${temp3[7]})));
		<#else>
			if (pagination.getSort().equals("${temp3[2]}")) {
		       if (pagination.getAscDsc().equals("desc")) {
                query.orderBy(cb.desc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp3[1])})
                                         .get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]})));
            } else {
                query.orderBy(cb.asc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp3[1])})
                                         .get(${pojo.beanCapitalize(temp3[1])}_.${temp3[2]})));
		</#if>
        }
	 }				
	</#foreach>
	<#--
		<#foreach temp4 in daoUtilities.getThirdLevelFields(pojo,cfg,false) >
		<#if temp4[7]!=''>
		if (pagination.getSort().equals("${temp4[7]}")) {
		if (pagination.getAscDsc().equals("desc")) {
                query.orderBy(cb.desc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp4[1])})
                                         .get(${pojo.beanCapitalize(temp4[1])}_.${ctrTl.stringDecapitalize(temp4[2])}).get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}).get(${pojo.beanCapitalize(temp4[2])}Id_.${temp4[7]})));
        } else {
                query.orderBy(cb.asc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp4[1])})
                                         .get(${pojo.beanCapitalize(temp4[1])}_.${ctrTl.stringDecapitalize(temp4[2])}).get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]}).get(${pojo.beanCapitalize(temp4[2])}Id_.${temp4[7]})));
        }
		}	
		<#else>
		if (pagination.getSort().equals("${temp4[3]}")) {
		if (pagination.getAscDsc().equals("desc")) {
                query.orderBy(cb.desc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp4[1])})
                                         .get(${pojo.beanCapitalize(temp4[1])}_.${ctrTl.stringDecapitalize(temp4[2])}).get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]})));
        } else {
                query.orderBy(cb.asc(${pojo.getDeclarationName()?lower_case}Aux.get(${pojo.getDeclarationName()}_.${ctrTl.stringDecapitalize(temp4[1])})
                                         .get(${pojo.beanCapitalize(temp4[1])}_.${ctrTl.stringDecapitalize(temp4[2])}).get(${pojo.beanCapitalize(temp4[2])}_.${temp4[3]})));
        }
		}	
		</#if>	
	</#foreach>-->

			}
			TypedQuery<${pojo.getDeclarationName()}> queryPag = this.getEntityManager().createQuery(
                        query);
            if (pagination != null && pagination.getRows() != null
                        && pagination.getPage() != null) {
                  queryPag.setFirstResult((int) ((pagination.getPage() - 1) * pagination
                             .getRows()));
                  queryPag.setMaxResults(pagination.getRows().intValue() - 1);
            } else if (pagination != null && pagination.getRows() != null
                        && pagination.getPage() == null) {
                  queryPag.setFirstResult(1);
                  queryPag.setMaxResults(pagination.getRows().intValue() - 1);
            }
            return queryPag;

		}		
	
}
</#assign>
${pojo.generateImports()}
${classbody}
	