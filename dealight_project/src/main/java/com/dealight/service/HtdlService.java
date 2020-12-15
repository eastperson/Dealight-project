package com.dealight.service;

import java.util.List;

import com.dealight.domain.AttachFileDTO;
import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlPageDTO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.StoreMenuVO;

//jongwoo

public interface HtdlService {
	
	//식당 메뉴 조회
	List<StoreMenuVO> findById(Long storeId); 

	//메뉴에 해당하는 가격 조회
//	MenuDTO findPriceByName(Long storeId, String name);
	
	//핫딜 등록
	void register(HtdlVO vo, List<HtdlDtlsVO> dtlsList);

	//핫딜 read
	HtdlVO readHtdl(Long htdlId);
	
	//전체 핫딜(핫딜+상세+매장평가) 조회
	
	List<HtdlVO> getList();
	
	//핫딜(진행중,예정) 조회
	List<HtdlVO> findAll();
	
	//전체 핫딜(핫딜+상세+매장평가)+페이징 
	List<HtdlVO> getList(String stusCd, HtdlCriteria hCri);
	
	//HtdlPageDTO getPageDto(HtdlCriteria hCri, int total, List<HtdlVO> lists);
	
	HtdlPageDTO getListPage(String stusCd, HtdlCriteria hCri);
	
	//해당 핫딜(핫딜+상세+매장평가)
	HtdlVO read(Long htdlId);
	
	//(핫딜+상세 핫딜번호,메뉴이름, 할인가격)
	HtdlVO readHtdlDtls(Long htdlId);
	
	//핫딜 수정
	boolean modify(HtdlVO vo);
	//핫딜 현재인원 수정
	boolean curPnumModify(HtdlVO vo);
	
	int getTotal(String stusCd, HtdlCriteria hCri);
	
	//핫딜 취소
	boolean remove(Long htdlId);
	//전체 핫딜의 시작시간,마감시간 format하고 리스트에 담는다
	
	//void asyncMethodTest();
	
	// select
	List<HtdlDtlsVO> readDtls(long htdlId);
	// select
	HtdlRsltVO readRslt(long htdlId);
	
	int calHtdlEndTm(HtdlVO htdl);
	
	// mapper method �ʿ�
	List<HtdlVO> readAllStoreHtdlList(long storeId);
	
	// mapper method �ʿ�
	// htdl_stus_cd = 'A'
	List<HtdlVO> readActStoreHtdlList(long storeId);

}
