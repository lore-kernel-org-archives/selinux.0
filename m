Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBD7C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55BF2085A
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 13:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MHFwuui6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCRNqi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:46:38 -0400
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:3223 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbfCRNqi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 09:46:38 -0400
X-EEMSG-check-017: 130056837|USFB19PA14_EEMSG_MP10.csd.disa.mil
IronPort-Data: A9a23:Pt5C/K9mFrP0AVTp7eY3DrVtTnXEHrLSOkUsvfnCuuS56PZXvCDKkM
 wh9Bc2zj7I0IXt0JEdsy8gAZNEQgkiIxAT+oUkcZXoPqFoZGcXO2XJGV980IjrbnIejrY+p4
 beZ2jqnxHyOreBO4bpXAtec7pxgpEYcBPE/U3msypRNhBJqqbvKOBS4HhTfnMUtLl0t0BnqG
 ibQ2m/F2kZzoWpeq92IBu8iP92ugkOVXO6l7GDakTLhFuS64ZU9nwOidAH7HhFPqwT7XF+GB
 qenhmDXkrlJWhQKhqly59IE8lJWR/Q2veueuM0C/CcBGiHesSXYv5ndFilT+O3tc7ofP/3bT
 R7gBddFhmbp7l6kAyxw3CfQuuStNvCvfJnsw4VQlEQkRPX8/1MM6BQNKMlpXoy99XV03fZgD
 azi7WdJI/E5oRf0HPu7LFjACw2H6oFj+iJSymL+8qWmR2oAHliVLmbK4/gCxNk7JtLaGfi6e
 /sOWkRxd17M64/CilRlxyQ0DpaLlYpkfLXV90uCo2tf+1SJ3DcbxcSn1BE4SNwoiwwEZMoLK
 jLNDXTuAi/uww5T3ywqvIxy0KHzg4dLhi3MmRIV4JhVGPRjpMuIkETYkYDYwmXFDqZ1hzjAZ
 TG6tiG/f5Lk6mJUHhxTlHSvmaRrc76ozhvM7aqApZzH3hfLHMLWc1H92+4UG9THWvyV53LVx
 exzzYSUflnoBYkszf3ZDJiGHBcnFvDJcjIBfKVNgtJnf10kIheUOpIIyxI4w/cJtqyGvwcO1
 vixA==
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Mar 2019 13:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552916795; x=1584452795;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iegj1UZhlAirZtdftuGSWEIs30NU7OopH+fCm75EOSI=;
  b=MHFwuui6c8ybZpHVrs/RL+C3hDcj4UQQT1sNlwFZPB4TOGr3qXAcQgP+
   dLrJTg6sRE/4DYn4K5i4cv6ygsA1/7LhALIu/VpNDbFHSQQmW7nE/e8X1
   N2PXcZBaquGwDtpi8wipZfJ1TUVmxh0ddzVbv2oPsJT+5sTTXfjZYORh/
   2KgJ9y0+0e1yfVF5krXQVmaMw01MPb+KMbXXztikcaii5OqjeEq+lzuXK
   mfBKorTCW3oMIVifrnu3H0u4P4faFv/PAGejSDLonnI9GMkyODv1LWILA
   8CQgEMWp8SYgcZedvNDD4H5Iy9k9ywSw5QVL0CV8xtvkLDxsTBE0nLPyu
   A==;
X-IronPort-AV: E=Sophos;i="5.58,494,1544486400"; 
   d="scan'208";a="21579980"
IronPort-Data: A9a23:loqlPa02KUMBpoAiNvbDix16xU5lqk9dZTB8AwV8FTx1RF+xpyt6hr
 jRreeUAIHYRxDT2AevoUeziAFg009Z3p9jG0lgJV+g6iADVWt0tZkx3Obb+CemYTn2izbBxx
 Sb1mjco8Eok6QCpzkc1gD8BqRj0Ja/dQMjzZ7qWXdmGFc6d5ZhPXZiEGgZ29s0sAO7qSQllw
 9HkquXlabff9ESGm4au9jRGbFmfB0B2uihoXzSfHW2xKIeFUD4uZ1bMZHOVZlLOKj/TGXYwG
 L90YzmHuXMfHIg77WdLLw/ARS2J17ghAZkVBnmKMraJ2FFX3S5p763Qnb10GEkO9H8tBu7vF
 DnUZztuN84sh/YwSQOpwlU3FThssgo2FsQqS2Q95bFJIo89iAApHbxth8VKptS4XjH6aW5XG
 N6XZcmckDWseUaWfwSaaCaBCR46zfItDvA59r1rqciVR2Qut9XaT4wTVNnI6rjY7/c+tcCig
 slZeWrQeIQMSPm8+zHuuIO48E3CNCztg/wh+Sq+8soIfJ4itVDlQmv+CVRF2J4NAZzohKu63
 JT3zZ/k2OFiYlSqlRQBEjIDCtvJK5WcUzgn2iBn4tIOag8P7GSNTlNki+ce3ll88r4rawHzT
 meMxGPq6wvQkLPt+f21ucQ5TC7Ck6vpDLvwfoOblpBSMTVjjHATecDQKG+cigMUK7A1Mn4Dx
 +0201KZHRYPgcRytQpKK+FF8Z8Y8xUDxJcNO9vG2mR1B1o/vfEMeLY1mGwMvWQm4ipw7ZjYp
 IDBjdhDOBE1H0l5AE8BxSZtkkRZKi9cPgF4VTCkXc07oWXrZ5LsHIn5OUZfbj4CFK520puyW
 htn8S+iuVAYvma/S/pNR1ecNnB
IronPort-PHdr: 9a23:qJQZpRD3mRb8eqdP5g4eUyQJP3N1i/DPJgcQr6AfoPdwSP35rs2wAk
 XT6L1XgUPTWs2DsrQY0rKQ6/mocFdDyK7JiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wEZ
 cKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmSaxbaluIB
 mrsA7cqtQYjYx+J6gr1xDHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6
 dYDCk9PGAu+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85K
 l3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQXdKUNhXWSJPH4iwa5
 IDAuQFMOpdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03esuHgPJ0xAvEd8VrHTZrs/4OLsOXe
 27zqTFyyjIYfNM2Tf67YjFag0voe2SUrJoccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv
 +gi3U8pgFtojmg2scsio7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totS
 on0LEKp5G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzVZKsj
 JJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZoIrUvPBCr2mETyjK
 OOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0PhITU2SD/OSzzrzj/Un3QLVQif02l7
 HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS9sx/
 DDOb3hGZPNIWLfn7j/Zrt98VBTxxczzd9F+5JYEK0OIPX2WkXprtzXEgc5MxCow+bgENh9zZ
 0RWWaOAq+fLaPTvkSF5vwgI+aSfo8ZojX9JOY/5/7ok3A5nUURfa6z3ZsYcHq4BOhpI12FYX
 rwhdcMCX8KsRAjTOzuk1CCSSRcZ2u2X64l4zE7D4WmDZ3dSYy3nLOB2yK7FIVMZm9aElCMDW
 vod4KcVvcPdi2SJNNhniYDVbi/VYAhzwqutBPgy7V5MOXU5jYVtZ3m1Ndv5u3TkQs++iBzD8
 SYy2uNVX17nnsURz8q26ByuVZyylSb0ah9mPFYEd1T5/VUUgY1LJLcwet6C830Wg3cZNiJVF
 emQtKgAT0rSdIx2dAOaV5nG9q+lhDDwzaqA7gNmryPBZw09L/c3nfoK8Z+1XnGzq8hgEciQs
 ZUK22mibBw9xLJC47KjUqZjaCqeroY3CLX82eD12WOtllCUAFsSaXFQWwfZkzOoNTi5kLDTq
 ShCbM7MgdG08GPKqlHZcb3gVpcSvfjNtXTb36ylmq+GxqFx7KBYYvke2oBwinQC1MJkxsT/H
 eHNggxHCOho2bAAzx0D17geVvs8fFlqHOjSU800wSKYFdg17qx4BIamfucS/ZAlo4D7QAnpy
 95Hh6Y2MnQAtGNpEI1e6BbetU061pvz2/VtwVheJenKvYmzkUTdwVxolPGyRp6EMNDnNIsoX
 dsyxB9beqg2U5FPxaf2or9cunPI3T21AimdqqT31bZytvQ8aAKvqcWsVLm6Tq1G1Ii/nMv6N
 xc13+R992eFwYJeY7gWUYwsR5hrvfVZTdrtNCc7mFlLaTh6myK4NkuHuZwj0/7Lto=
X-IPAS-Result: =?us-ascii?q?A2AQAACioI9c/wHyM5BjGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFmKoE4MyeEC4gci3ABAQEGgQgtiUCJXoUTFIFnOAGEQAKEWCI0CQ0BA?=
 =?us-ascii?q?QMBAQEIAQEBAQIBbCiCOikBgmcBBSMEEUEQCw4KAgIRFQICVwYBDAYCAQGCX?=
 =?us-ascii?q?z+BaQ2qAXwzhUaEYIELJAGLLxd4gQeBESeCa4Q8gQSCS4JXA5FRkwQJkx8GG?=
 =?us-ascii?q?ZNXLYpalGo4gVYrCAIYCCEPgyeCFheOOiMDMIEFAQGNTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Mar 2019 13:46:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2IDkOtE031343;
        Mon, 18 Mar 2019 09:46:25 -0400
Subject: Re: [PATCH] selinux: fix NULL dereference in policydb_destroy()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
References: <20190317134653.26824-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a5c9075d-fd4d-6ff7-b848-2f78ff871c45@tycho.nsa.gov>
Date:   Mon, 18 Mar 2019 09:42:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190317134653.26824-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/17/19 9:46 AM, Ondrej Mosnacek wrote:
> The conversion to kvmalloc() forgot to account for the possibility that
> p->type_attr_map_array might be null in policydb_destroy().
> 
> Fix this by destroying its contents only if it is not NULL.
> 
> Also make sure ebitmap_init() is called on all entries before
> policydb_destroy() can be called. Right now this is a no-op, because
> both kvcalloc() and ebitmap_init() just zero out the whole struct, but
> let's rather not rely on a specific implementation.
> 
> Reported-by: syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
> Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/policydb.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> NOTE: This applies directly on top of current Linus' tree, since the
> problematic commit is not present in the selinux/stable-5.1 branch.
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 6b576e588725..daecdfb15a9c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -828,9 +828,11 @@ void policydb_destroy(struct policydb *p)
>   	hashtab_map(p->range_tr, range_tr_destroy, NULL);
>   	hashtab_destroy(p->range_tr);
>   
> -	for (i = 0; i < p->p_types.nprim; i++)
> -		ebitmap_destroy(&p->type_attr_map_array[i]);
> -	kvfree(p->type_attr_map_array);
> +	if (p->type_attr_map_array) {
> +		for (i = 0; i < p->p_types.nprim; i++)
> +			ebitmap_destroy(&p->type_attr_map_array[i]);
> +		kvfree(p->type_attr_map_array);
> +	}
>   
>   	ebitmap_destroy(&p->filename_trans_ttypes);
>   	ebitmap_destroy(&p->policycaps);
> @@ -2496,10 +2498,13 @@ int policydb_read(struct policydb *p, void *fp)
>   	if (!p->type_attr_map_array)
>   		goto bad;
>   
> +	/* just in case ebitmap_init() becomes more than just a memset(0): */
> +	for (i = 0; i < p->p_types.nprim; i++)
> +		ebitmap_init(&p->type_attr_map_array[i]);
> +
>   	for (i = 0; i < p->p_types.nprim; i++) {
>   		struct ebitmap *e = &p->type_attr_map_array[i];
>   
> -		ebitmap_init(e);
>   		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
>   			rc = ebitmap_read(e, fp);
>   			if (rc)
> 

