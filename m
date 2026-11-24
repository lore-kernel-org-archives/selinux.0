Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500517;
	b=AztE6S+dyG1v88mrCsIdCX/+V5rFkBSMgThiQGy03I2yARsgAYgNPj97uzpLx2QxiO4V
	 IefcM5Q2OQWBUDi/oRqcHGtAOgxkoTFF5Q0SvyDaNOGA6AAaxFsfugokc/zLNCbtYDhsc
	 QTsyqR1Lhcr2JhYAd/FA9oUKrv+leudx99C9DsdusVsbOLIV2chr6PLnAcOPnwZZTf4NE
	 2cqO0xtngER2L0MtBa75DGpnvnkXTix8eA1MBgcCuwhuloO2WMxSDQ6cz3Kn9PHomKJxR
	 1hxracuALLHpz8V9zBYCrG3jjuITDpmTcLlvCK5nKjiA3gJsbQrYWJXymrX/Z6sUMPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500517;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	b=woOodkNFUj8/3Ma65NngKMBmypF+n0XsPpA7gePYqPRZwXgRTtliD/t+aYVaAixN4t8+
	 qFJAomLYqhuq9Zm8fuTZVtLXluRr+TTHKFx1OL8wTLDbgFACTH/u2D+J816vfchBA8J0h
	 GQM/mxtD0OfdO1y5SObiGEyuE5igmrE5eL5TNRQVWhK1Uc8ob7SzaxfZ98ZAwV+z0qv7k
	 zhAwcvFkLje7+/pNhS86tkNRXsODjlFbwBrHzLvskGEP472CZso32tGkzm4p9UxLHnmwD
	 f3yKy2ObvVzTGAjxWvSYIMjoVmlxA4DMTY7xoVbo8HypNCt1zVwy24nLOuaaRUB1gYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZGO29w+k;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85638606A326
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 06:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85638606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZGO29w+k
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kNxQ2209250
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 06:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=Mu+lZvdLXuWGpOkRTkHFjM/i3/zxBEn62CaGxwiM
	4QAwVoT9XEi4yAVQyTS/Hdf4oK6g4Bc9UAYdPk+DRdycbrtCTJCG8mMPRAhd8Itr
	YJhqFMUPxIvAUoO28f/gr9kwh8uoUQMFVNIJ4mHntvWYoUNjLLZJkNIL9C5NO8j5
	4wzwAtnHxt9pAGjuHvdm/dL4ZGq7SYRNZIslZ6b/jAPWSWpvoexho/kIjWyCe8Go
	XEM9WzZZfx7YDi8VBJiRGkruQKiQYtAWiuR5g/M2YJX70BEeqYi1vnUAfiYQx25H
	1Q6Q3rvSf1diwPrHavfw3ko6BktLi1o93wWElVUR6hp2Ww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy1143a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 06:08:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so1039066285a.3
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795500515; x=1796105315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=ZGO29w+kZqFi0IoremOsMtN9bKkizaQT53H8YWFQDHShgC+v74I6+QopxA9VOzR3ag
         vpo8bEUIF8O5RsZIAg/OLAqOKRB/bKTx8+cSCgApxKM12o3xffG44Tb8wjTZkSkRmxCp
         wij9c01WUZzaDr5rVDD1SJT+iGxhVY2DGrilMJockekBI3nIm+ySQCHW9FAgGT1TCkED
         cBg+mmrXK3wzCDdfn6tJ9MkKWiw3B/ZXVhgrV+oDdRaYRTIjpBAkDMZ/VMsXJhU+E1Kt
         SQ9c84H9SufIQJjJDyuIlA/LWh9gOMXMRnrjdxZtJ49QfcTz5Lm9KRTSNNNdk8bu9nwV
         oZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500515; x=1796105315;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=xytKPChDPA61nbzGGxmIiNFmiF1hqV7T3skMG2V7aT4gupjiOA4p/OOmal4hFJpbe+
         EzijC4xILzXvM21+DieupYCshU3LyW463Yiix+DPiUSNVWw14qGYaYusee4w8t3cyVxq
         KnnDud6s6q1OLBtE9BE1cyJnwu+4RBNOIxcUC3fqEtlWLZGerrisNQRoqyF0O58hwcre
         MvJz23kgxTigWC2p4WspYqrftY+0jyh/AN2/05iVKdTn2tEE9ZEzOauh/chLggGd68p6
         kq0VXJSQpWfEDvFrL6JN/J+0fFSPHzizjuZCRgK03JX65Et/URC85s+eSMe+yZssaCrG
         yFFA==
X-Forwarded-Encrypted: i=1; AL+hErFRpyBxlgtWNuq6mb7ECavTWBfqioH39ec6s/zp485MVvStjl92Q589R/UnBFXAByByOpVPhFMx@vger.kernel.org
X-Gm-Message-State: APuU4Z95U2sWDqqhJjT+7NKgvQiA7gBLDyER7YOjHExHUcSfON+Th2ZC
	0ji7baSSZi3HZw4M6Kvaj8LANWP8Mp44eTAUvJZ8T0IGvEyoq2Cx8LOIL14pFLr9lkyvlTyRu1O
	aZ7s0A5P6juSOpaXF1R13Li+1/YeFvhIQTkzR5nTbqr3rsWLCUNh8bayGxRD4
X-Gm-Gg: AZFdTZdDHTa5xQqF+Jy1UrDIeESBQUIBks5KbpiTZ4XxWX+6zW4N1yzhJORVPuo6v14
	rE202H9c/f/bgeWG/QGIl1M08wAsymt23qDVIwwyYaD1f7VpOhlcVmH/ac2cu0RV3u3dQMWYAJ5
	QAR4auxcHFth3D+u98fhc78dbPoZW7zSJcZAdQM7zmLGKUA1tssykSZ3Qg33uOHKVpqty0u44nK
	A611OeFZDzChrtkJWvW+hycCZFR5Bc+y5hOaElhlUr12byiyFsf6DdjZ0BgV7WsUWzL+vRqSLeL
	tdx3SsgiPLm0VQOqgzYindxUcDxncXIGdSBq/aBMj0GKA0LAsRn422AlXyP3TsbTck5IUJUoEGe
	6FCxjfO5B+NragedOMRPf92RoPcIxxsFgxP8lHYl9DVGbbVFwaXwAetDZm/Z8F2Y=
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433056985a.0.1795500514616;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433050285a.0.1795500514001;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm23005124f8f.17.2026.11.23.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:08:33 -0800 (PST)
Date: Tue, 24 Nov 2026 08:08:29 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <7zkdydihgjnqxerwzbebrcryry37hcqc47dpzqmoxdgc7qt3i6@uanst4lmvvkn>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Proofpoint-ORIG-GUID: 9pAGDnQuISLTCAEIp54ZZfoMxCSU4XTZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX9YTMK+PsuqlS
 QxbHigdEO30xM4gM3Erkbg4Tpf0HM4ERAV0lRznDT327m9p8kzg3hrSreXIQ1k1eOcmLbZiIQLt
 Tu3lV5gvQvhirOMjXbD59hum2CaJCsU=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b0529e3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX6UYAMAv4AtfF
 ymrCYIlEzlxfBoB8MlNO/7MehRUWwhoAFP4t/dvb1k8abvwH1nxmPsPD2+M79X1G1RtcT02soLm
 DY0wFN9lKX7lj1m4gaPP5XaT9vTGdNbSohuHsER8p3TP3KIPOx6m+DyateebM/E2hCX+AHQIeJ2
 t75RjVutlnXyL3caSrOEN3UKr/qM4jPtc3LwsFsohpUFu6nfhGHfcSX4xQLk3LmhjctrW/QLGpK
 q5OlPYfJZFWjV0GHk0iCMxNPuj9GvYD23oPjvNBPlIeJKFF4IAUBbR7tz2LELtryqn4IyCv14xc
 EiY5EJCd3kc5lrtd2N1nif9xwSNOx0Hf1U7LxBCOFcbCF5gJbjGS/35+ZypI+Ep4dD6bGFtiXjA
 uf+TP5EbmxRKAPajiHRyG0TJ+zvNRSA8+7abnGtrFVdPAVb46X+b/apAHlGpe6M/v1g71lAWwJt
 T+w+Kty8oGKa5zP/k9Q==
X-Proofpoint-GUID: 9pAGDnQuISLTCAEIp54ZZfoMxCSU4XTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240024

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
