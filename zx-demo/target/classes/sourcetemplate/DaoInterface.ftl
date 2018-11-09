package ${basePackage}.${moduleName}.${daoPackage};

import ${basePackage}.common.Pagination;
<#if module.persistance == 'mybatis'>
import java.util.List;
</#if>

import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName};
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}Query;

/**
 * ${remark!}操作相关
 */
public interface ${entityCamelName}Dao {
	
	public final static String BEAN_ID="${entityName}Dao";
	
	public List<${entityCamelName}> get${entityCamelName}List(${entityCamelName}Query data);

	public void insert${entityCamelName}(${entityCamelName} data);

	public void update${entityCamelName}(${entityCamelName} data);

	public void delete${entityCamelName}(${entityCamelName} data);

}
