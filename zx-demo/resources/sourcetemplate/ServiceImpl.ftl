package ${basePackage}.${moduleName}.${servicePackage}.${serviceImplPackage};

import java.util.Map;
<#if module.persistance=="mybatis">
import java.util.List;
</#if>

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;

import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName};
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}Query;
import ${basePackage}.${moduleName}.${servicePackage}.I${entityCamelName}Service;
import ${basePackage}.${moduleName}.${daoPackage}.${entityCamelName}Dao;

/**
 * ${remark!}操作相关
 */
@Service(I${entityCamelName}Service.BEAN_ID)
public class ${entityCamelName}ServiceImpl implements I${entityCamelName}Service {

	Logger logger = LoggerFactory.getLogger(${entityCamelName}ServiceImpl.class);

	@Resource(name=${entityCamelName}Dao.BEAN_ID)
	private ${entityCamelName}Dao ${entityName}Dao;

	@Override
	public List<${entityCamelName}> get${entityCamelName}List(${entityCamelName}Query data) {
		// TODO Auto-generated method stub
		List<${entityCamelName}> list=new ArrayList<>();
		list=${entityName}Dao.get${entityCamelName}List(data);
		return list;
	}

	@Override
	public void insert${entityCamelName}(${entityCamelName} data) {
		// TODO Auto-generated method stub
		${entityName}Dao.insert${entityCamelName}(data);
	}

	@Override
	public void update${entityCamelName}(${entityCamelName} data) {
		// TODO Auto-generated method stub
		${entityName}Dao.update${entityCamelName}(data);
	}

	@Override
	public void delete${entityCamelName}(${entityCamelName} data) {
		// TODO Auto-generated method stub
		${entityName}Dao.delete${entityCamelName}(data);
	}

	@Override
	public void insert${entityCamelName}Branch(List<${entityCamelName}> data) {
		// TODO Auto-generated method stub
		for(${entityCamelName} ${entityName}:data) {
			${entityName}Dao.insert${entityCamelName}(${entityName});
		}
	}

	@Override
	public void update${entityCamelName}Branch(List<${entityCamelName}> data) {
		// TODO Auto-generated method stub
		for(${entityCamelName} ${entityName}:data) {
			${entityName}Dao.update${entityCamelName}(${entityName});
		}
	}

	@Override
	public void delete${entityCamelName}Branch(List<${entityCamelName}> data) {
		// TODO Auto-generated method stub
		for(${entityCamelName} ${entityName}:data) {
			${entityName}Dao.delete${entityCamelName}(${entityName});
		}
	}

}
