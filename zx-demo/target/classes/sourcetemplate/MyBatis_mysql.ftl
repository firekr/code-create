<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${basePackage}.${moduleName}.${daoPackage}.${entityCamelName}Dao" >
 <#-- <resultMap id="BaseResultMap" type="${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}" >
    <#list primaryKeyList as col>
    <id column="${col.columnName}" property="${col.propertyName}" jdbcType="${col.columnType}" />
    </#list>
    <#list columns as col>
    <#if !col.primaryKey>
    <result column="${col.columnName}" property="${col.propertyName}" jdbcType="${col.columnType}" <#if col.columnType == 'DATE' || col.columnType=='TIMESTAMP'>javaType="java.util.Date"</#if> />
    </#if>
    </#list>
  </resultMap>-->
  
  <sql id="Base_Column_List" >
    <#list columns as col>${col.columnName} AS ${col.propertyName} <#if col_index lt columns?size-1>,</#if></#list>
  </sql>
  
  <insert id="insert${entityCamelName}" parameterType="${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}">
  	insert into ${tableFullName} (
  	<trim suffixOverrides=",">
  	<#list columns as col>
  		<if test="${col.propertyName}!=null">
  			${col.columnName},
  		</if>
  	</#list>
  	</trim>
  	)values (
  	<trim suffixOverrides=",">
  	<#list columns as col>
  		<if test="${col.propertyName}!=null">
  			${'#'}{${col.propertyName},jdbcType=${col.columnType}},
  		</if>
  	</#list></trim>)
  	<#if primaryKeyList?size==1>
  		<#list primaryKeyList as col>
  		<#if col.identity>
	    <selectKey resultType="${col.propertyType}" keyProperty="${col.propertyName}" >
	      select last_insert_id()
	    </selectKey>
	    </#if>
	    </#list>
    </#if>
  </insert>

  <insert id="insert${entityCamelName}1" parameterType="${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}">
  	insert into ${tableFullName} (
  	<trim suffixOverrides=",">
  	<#list columns as col>
		${col.columnName},
  	</#list>
  	</trim>
  	)values (
  	<trim suffixOverrides=",">
  	<#list columns as col>
	  	${'#'}{${col.propertyName},jdbcType=${col.columnType}},
  	</#list>
  	</trim>
  	)
  	<#if primaryKeyList?size==1>
  		<#list primaryKeyList as col>
  		<#if col.identity>
	    <selectKey resultType="${col.propertyType}" keyProperty="${col.propertyName}" >
	      select last_insert_id()
	    </selectKey>
	    </#if>
	    </#list>
    </#if>
  </insert>
  
  <update id="update${entityCamelName}" parameterType="${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}">
  	update ${tableFullName} <set>
  	<#list columns as col>
  	<if test="${col.propertyName}!=null">
  	<#assign jdbcType=col.columnType?replace(" UNSIGNED","")><#if jdbcType=="INT"><#assign jdbcType="INTEGER"><#elseif jdbcType=="DATETIME"><#assign jdbcType="DATE"></#if>${col.columnName}=${'#'}{${col.propertyName},jdbcType=${jdbcType}}<#if col_index lt columns?size-1>,</#if>
  	</if>
  	</#list>
  	</set> 
  	where <#list primaryKeyList as col><#if col_index gt 0> and </#if>${col.columnName!}=${'#'}{${col.propertyName!},jdbcType=${col.columnType!}}</#list>
  </update>
  
  <update id="update${entityCamelName}1" parameterType="${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}">
  	update ${tableFullName} <set>
  	<#list columns as col>
  	<#assign jdbcType=col.columnType?replace(" UNSIGNED","")><#if jdbcType=="INT"><#assign jdbcType="INTEGER"><#elseif jdbcType=="DATETIME"><#assign jdbcType="DATE"></#if>${col.columnName}=${'#'}{${col.propertyName},jdbcType=${jdbcType}}<#if col_index lt columns?size-1>,</#if>
  	</#list>
  	</set> 
  	where <#list primaryKeyList as col><#if col_index gt 0> and </#if>${col.columnName!}=${'#'}{${col.propertyName!},jdbcType=${col.columnType!}}</#list>
  </update>
  
  <select id="get${entityCamelName}List" parameterType="${entityCamelName}Query" resultMap="BaseResultMap">
  	select <include refid="Base_Column_List"/> from ${tableFullName} where 1=1
  	<#list columns as col>
  	<if test="${col.propertyName}!=null">
  	and ${col.columnName}=${'#'}{${col.propertyName},jdbcType=${col.columnType}}
  	</if>
    </#list>
  	order by <#list primaryKeyList as col><#if col_index gt 0> , </#if>${col.columnName!} desc</#list>
  </select>
  <select id="count${entityCamelName}" parameterType="${entityCamelName}Query" resultType="int">
  	select count(*) from ${tableFullName} where 1=1
  	<#list columns as col>
  	<if test="${col.propertyName}!=null">
  	and ${col.columnName}=${'#'}{${col.propertyName},jdbcType=${col.columnType}}
  	</if>
    </#list>
  </select>
  <delete id="delete${entityCamelName}" parameterType="${entityCamelName}Query">
  		delete from ${tableFullName} where 1=1
  		<#list columns as col>
		  	<if test="${col.propertyName}!=null">
		  	and ${col.columnName}=${'#'}{${col.propertyName},jdbcType=${col.columnType}}
		  	</if>
	    </#list>
  </delete>
</mapper>