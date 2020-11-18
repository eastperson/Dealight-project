package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlDtlsVO {
	
    private long htdlId;

    private long htdlSeq;

    private String menuName;

    private int menuPrice;

}
