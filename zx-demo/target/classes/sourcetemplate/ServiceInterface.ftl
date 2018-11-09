package ${basePackage}.${moduleName}.${servicePackage};

import java.util.Map;
import java.util.List;
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName};
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}Query;

/**
 * ${remark!}操作相关
 */
public interface I${entityCamelName}Service {
	
	public final static String BEAN_ID="${entityName}Service";
	
	List<${entityCamelName}> get${entityCamelName}List(${entityCamelName}Query data);

	void insert${entityCamelName}(${entityCamelName} data);

	void update${entityCamelName}(${entityCamelName} data);

	void delete${entityCamelName}(${entityCamelName} data);
	
	void insert${entityCamelName}Branch(List<${entityCamelName}> data);

	void update${entityCamelName}Branch(List<${entityCamelName}> data);

	void delete${entityCamelName}Branch(List<${entityCamelName}> data);

}
