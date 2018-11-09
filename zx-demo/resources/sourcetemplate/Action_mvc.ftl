package ${basePackage}.${moduleName}.${actionPackage};
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
<#if module.persistance=="hibernate" || module.persistance=="jpa">
import javax.validation.Valid;
</#if>
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import ${basePackage}.base.BaseAction;
import ${basePackage}.common.Pagination;
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName};
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName}Query;
import ${basePackage}.${moduleName}.${servicePackage}.I${entityCamelName}Service;
import com.zztl.fcs.page.model.Page;

<#if subTables??>
	<#list subTables as sub>
import ${basePackage}.${moduleName}.${entityPackage}.${sub.entityCamelName};
	</#list>
</#if>

/**
 * ${remark!}
 *
 */
@RestController
@RequestMapping("/${entityName}")
@Api(value = "${remark!}接口",description="${remark!}接口")
public class ${entityCamelName}Controller {
	
	@Resource(name=I${entityCamelName}Service.BEAN_ID)
	private I${entityCamelName}Service ${entityName}Service;
	<#if subTables??>
		<#list subTables as sub>
	@Resource(name="${sub.entityName}Action")
	private ${sub.entityCamelName}Action ${sub.entityName}Action;
		</#list>
	</#if>
	
	
	/**
	 * 分页查询${remark!}
	 * @return
	 */
	@RequestMapping(value = "/query/page", method = RequestMethod.POST,produces="application/json")
	@ApiOperation(value = "${remark!}分页查询", notes = "${remark!}分页查询", httpMethod = "POST", response = ApiResult.class)
	public ApiResult<PageInfo<${entityCamelName}>> query${entityCamelName}Page(@RequestBody ApiParam<Page<${entityCamelName}Query>> apiParam){
		ApiResult<PageInfo<${entityCamelName}>> result=new ApiResult<PageInfo<${entityCamelName}>>();
		if(apiParam!=null){		
			Page<${entityCamelName}Query> page=apiParam.getData();
			PageHelper.startPage(page.getPageNum(),page.getPageSize());
	        List<${entityCamelName}> ${entityName}List = ${entityName}Service.get${entityCamelName}List(page.getData());  
	        PageInfo<${entityCamelName}> pagehelper = new PageInfo<${entityCamelName}>(${entityName}List);  
			result.setSuccess(true);
			result.setMessage("查询成功");
			result.setData(pagehelper);
			result.setCode("200");
		}else{
			result.setSuccess(false);
			result.setMessage("查询失败");
			result.setCode("100");
		}
        return result;
	}
	
	/**
	 * 查询${remark!}
	 <#list primaryKeyList as col>
	 * @param ${col.propertyName}
	 </#list>
	 * @return
	 */
	@RequestMapping(value = "/query", method = RequestMethod.POST,produces="application/json")
	@ApiOperation(value = "${remark!}查询", notes = "${remark!}查询", httpMethod = "POST", response = ApiResult.class)
	public ApiResult<List<${entityCamelName}>> query${entityCamelName}(@RequestBody ApiParam<${entityCamelName}Query> apiParam){
		ApiResult<List<${entityCamelName}>> result=new ApiResult<List<${entityCamelName}>>();
		List<${entityCamelName}> list=${entityName}Service.get${entityCamelName}List(apiParam.getData());
		result.setSuccess(true);
		result.setMessage("查询成功");
		result.setData(list);
		result.setCode("200");
        return result;
	}
	
	/**
	 * 新增${remark!}
	 <#list primaryKeyList as col>
	 * @param ${col.propertyName}
	 </#list>
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST,produces="application/json")
	@ApiOperation(value = "${remark!}新增", notes = "${remark!}新增", httpMethod = "POST", response = ApiResult.class)
	public ApiResult<String> add${entityCamelName}(@RequestBody ApiParam<${entityCamelName}> apiParam){
		ApiResult<String> result=new ApiResult<String>();
		if(apiParam!=null&&apiParam.getData()!=null){
			${entityName}Service.insert${entityCamelName}(apiParam.getData());
			result.setSuccess(true);
			result.setMessage("新增成功");
			result.setData("新增成功");
			result.setCode("200");
		}else{
			result.setSuccess(true);
			result.setMessage("新增失败");
			result.setData("新增失败");
			result.setCode("100");
		}
        return result;
	}
	
	/**
	 * 修改${remark!}
	 <#list primaryKeyList as col>
	 * @param ${col.propertyName}
	 </#list>
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST,produces="application/json")
	@ApiOperation(value = "${remark!}修改", notes = "${remark!}修改", httpMethod = "POST", response = ApiResult.class)
	public ApiResult<String> update${entityCamelName}(@RequestBody ApiParam<${entityCamelName}> apiParam){
		ApiResult<String> result=new ApiResult<String>();
		if(apiParam!=null&&apiParam.getData()!=null){
			${entityName}Service.update${entityCamelName}(apiParam.getData());
			result.setSuccess(true);
			result.setMessage("修改成功");
			result.setData("修改成功");
			result.setCode("200");
		}else{
			result.setSuccess(true);
			result.setMessage("修改失败");
			result.setData("修改失败");
			result.setCode("100");
		}
        return result;
	}

	/**
	 * 删除${remark!}
	 <#list primaryKeyList as col>
	 * @param ${col.propertyName}
	 </#list>
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST,produces="application/json")
	@ApiOperation(value = "${remark!}删除", notes = "${remark!}删除", httpMethod = "POST", response = ApiResult.class)
	public ApiResult<String> delete${entityCamelName}(@RequestBody ApiParam<${entityCamelName}> apiParam){
		ApiResult<String> result=new ApiResult<String>();
		if(apiParam!=null&&apiParam.getData()!=null){
			${entityName}Service.delete${entityCamelName}(apiParam.getData());
			result.setSuccess(true);
			result.setMessage("删除成功");
			result.setData("删除成功");
			result.setCode("200");
		}else{
			result.setSuccess(true);
			result.setMessage("删除失败");
			result.setData("删除失败");
			result.setCode("100");
		}
        return result;
	}
}
