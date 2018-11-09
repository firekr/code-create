package ${basePackage}.${moduleName}.${entityPackage};

<#if subTables?size gt 0>
import java.util.List;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
<#if module.persistance=="hibernate" || module.persistance=="jpa">
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.validator.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
<#if subTables?size gt 0>
import javax.persistence.Transient;
</#if>
</#if>
<#if importClassList??>
<#list importClassList as imp>
import ${imp!};
</#list>
</#if>

/**
* ${remark!}查询类
*/
<#if module.persistance=="hibernate" || module.persistance=="jpa">
@Entity
@Table(name="${tableFullName!}")
</#if>
@ApiModel(value = "${remark!}实体查询类")
public class ${entityCamelName!}Query extends ${entityCamelName!}{

	private static final long serialVersionUID = 1L;
	
}
