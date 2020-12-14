package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.HtdlWithStoreDTO;

/*
 * 
 *****[김동인] 
 * 
 */
//jongwoo

public interface HtdlMapper {

	HtdlVO findById(Long htdlId);
	List<HtdlVO> getList();
	List<HtdlVO> getListWithPaging(@Param("stusCd") String stusCd, @Param("hCri") HtdlCriteria hCri);
	int delete(Long htdlId);
	int getTotalCount(@Param("stusCd") String stusCd, @Param("hCri") HtdlCriteria hCri);
	
	Long getSeqHtdl();
	
	//핫딜 상세 mapper
	void insertDtls(HtdlDtlsVO vo);
	void insertDtlsList(List<HtdlDtlsVO> dtlsList);
	List<HtdlDtlsVO> findDtlsById(Long htdlId);
	int updateDtls(HtdlDtlsVO vo);
	int deleteDtls(Long htdlId);
	
	//핫딜 결과 mapper
	void insertRslt(HtdlRsltVO vo);
	HtdlRsltVO findRsltById(@Param("storeId") Long storeId, @Param("htdlId") Long htdlId);
	List<HtdlRsltVO> getRsltList(Long storeId);
	
	//핫딜+상세+결과
	HtdlVO getHtdlDtlsRslt(Long htdlId);
	//핫딜+매장
	List<HtdlWithStoreDTO> getHtdlWithStoreList(String stusCd);
	
	//핫딜+상세
	HtdlVO findHtdlDtlsById(Long htdlId);
	
	//핫딜+상세+매장평가
	HtdlVO findHtdlById(Long htdlId);
	List<HtdlVO> getHtdlList();
	
	// create
	public void insert(HtdlVO htdl);
	
	public void insertSelectKey(HtdlVO htdl);
	
	// read
	// by store id
	public List<HtdlVO> findByStoreId(Long storeId);
	
	// read
	// by store id
	public List<HtdlVO> findByStoreIdStusCd(@Param("storeId")long storeId,@Param("stusCd") String stusCd);
	
	// read list
	public List<HtdlVO> findAll();
	
	// update
	public int update(HtdlVO htdl);
	

}
