package ${basePackage}.${moduleName}.${actionPackage};
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ${basePackage}.base.BaseAction;
import ${basePackage}.common.Pagination;
import ${basePackage}.${moduleName}.${entityPackage}.${entityCamelName};
import ${basePackage}.${moduleName}.${servicePackage}.${entityCamelName}Service;

<#if subTables??>
	<#list subTables as sub>
import ${basePackage}.${moduleName}.${entityPackage}.${sub.entityCamelName};
	</#list>
</#if>

/**
 * ${remark!}
 *
 */
@Controller
@RequestMapping("/${moduleName}/${entityName}")
public class ${entityCamelName}Action extends BaseAction {
	
	@Resource(name=${entityCamelName}Service.BEAN_ID)
	private ${entityCamelName}Service ${entityName}Service;
	<#if subTables??>
		<#list subTables as sub>
	@Resource(name="${sub.entityName}Action")
	private ${sub.entityCamelName}Action ${sub.entityName}Action;
		</#list>
	</#if>
	
	/**
	 * 查询${remark!}
	 * @param params 参数列表
	 * @param page
	 */
	@RequestMapping(value = "/toList${entityCamelName}")
	public ModelAndView to${entityCamelName}List(HttpServletRequest req){
		ModelAndView mv = new ModelAndView("/${moduleName}/${entityName}/list${entityCamelName}");
		return mv;
	}
	
	/**
	 * 查询${remark!}
	 * @param params 参数列表
	 * @param page
	 */
	@RequestMapping(value = "/ajax/load${entityCamelName}List")
	@ResponseBody
	public Map<String,Object> load${entityCamelName}List(HttpServletRequest req,@RequestParam(value="page",defaultValue="1",required=false) int page){
		Map<String,Object> res = new HashMap<String,Object>();
		if (page<1){
			page=1;
		}
		Pagination<${entityCamelName}> paging = new Pagination<${entityCamelName}>(10, page);
		Map<String,Object> params = new HashMap<String, Object>();
		${entityName}Service.load${entityCamelName}List(paging,params);
		
		res.put("state",0);
		res.put("data",paging);
		return res;
	}
	
	/**
	 * 显示${remark!}详情页面
	 <#list primaryKeyList as col>
	 * @param ${col.propertyName}
	 </#list>
	 * @return
	 */
	@RequestMapping(value = "/show${entityCamelName}")
	public ModelAndView show${entityCamelName}(<#list primaryKeyList as col> <#if col_index gt 0> , </#if>${col.propertyType} ${col.propertyName}</#list>){
		ModelAndView mv = new ModelAndView("/${moduleName}/${entityName}/show${entityCamelName}");
		return mv;
	}
	
	/**
	 * 加载${remark!}详情
	 <#list primaryKeyList as col>
	 * @param ${col.propertyName}
	 </#list>
	 * @return
	 */
	@RequestMapping(value = "/ajax/load${entityCamelName}")
	@ResponseBody
	public Map<String,Object> load${entityCamelName}(<#list primaryKeyList as col> <#if col_index gt 0> , </#if>${col.propertyType} ${col.propertyName}</#list>){
		Map<String,Object> res = new HashMap<String,Object>();
		${entityCamelName} ${entityName} = ${entityName}Service.loadByKey(<#list primaryKeyList as col> <#if col_index gt 0> , </#if>${col.propertyName}</#list>);
		
		res.put("state",0);
		res.put("data",${entityName});
		return res;
	}
	
	@RequestMapping(value="/toAdd${entityCamelName}")
	public ModelAndView toAdd${entityCamelName}(){
		ModelAndView mv = new ModelAndView("/${moduleName}/${entityName}/add${entityCamelName}");
		return mv;
	}
	
	/**
	 * 保存${remark!}详情
	 * @param ${entityName}
	 * @return
	 */
	<#assign validate="">
	<#if module.persistance=="hibernate" || module.persistance=="jpa">
	<#assign validate="@Valid ">
	</#if>
	@RequestMapping(value = "/ajax/save${entityCamelName}",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> save${entityCamelName}(${validate}${entityCamelName} ${entityName}){
		Map<String,Object> res = new HashMap<String,Object>();
		${entityName}Service.save${entityCamelName}(${entityName});
		
		res.put("state",0);
		return res;
	}
	

	@RequestMapping(value="/toEdit${entityCamelName}")
	public ModelAndView toEdit${entityCamelName}(<#list primaryKeyList as col><#if col_index gt 0> , </#if>${col.propertyType} ${col.propertyName}</#list>){
		ModelAndView mv = new ModelAndView("/${moduleName}/${entityName}/edit${entityCamelName}");
		return mv;
	}
	
	/**
	 * 保存修改的${remark!}
	 * @param ${entityCamelName}
	 * @return
	 */
	 <#assign validate="">
	<#if module.persistance=="hibernate" || module.persistance=="jpa">
	<#assign validate="@Valid ">
	</#if>
	@RequestMapping(value = "/ajax/update${entityCamelName}",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> update${entityCamelName}(${validate}${entityCamelName} ${entityName}){
		Map<String,Object> res = new HashMap<String,Object>();
		${entityName}Service.update${entityCamelName}(${entityName});
		
		res.put("state",0);
		return res;
	}
	/**
	 * 修改${remark!}状态
	 * @param ${entityCamelName}
	 * @return
	 */
	@RequestMapping(value = "/ajax/updateState")
	@ResponseBody
	public Map<String,Object> updateState(HttpServletRequest req,${entityCamelName} ${entityName}){
		Map<String,Object> res = new HashMap<String,Object>();
		${entityName}Service.updateState(<#list primaryKeyList as col> <#if col_index gt 0>,</#if>${entityName}.get${col.propertyCamelName}()</#list>,${entityName}.getState());
		res.put("state",0);
		return res;
	}


}
