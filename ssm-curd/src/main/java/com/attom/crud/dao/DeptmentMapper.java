package com.attom.crud.dao;

import com.attom.crud.bean.Deptment;
import com.attom.crud.bean.DeptmentExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;
public interface DeptmentMapper {
    long countByExample(DeptmentExample example);

    int deleteByExample(DeptmentExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Deptment record);

    int insertSelective(Deptment record);

    List<Deptment> selectByExample(DeptmentExample example);

    Deptment selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Deptment record, @Param("example") DeptmentExample example);

    int updateByExample(@Param("record") Deptment record, @Param("example") DeptmentExample example);

    int updateByPrimaryKeySelective(Deptment record);

    int updateByPrimaryKey(Deptment record);
}