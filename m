Return-Path: <SRS0=SKFz=ZL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DCBC43215
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5057C2240C
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Lbswht9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKSS7q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:59:46 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:54360 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfKSS7n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Nov 2019 13:59:43 -0500
X-EEMSG-check-017: 51451598|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,219,1571702400"; 
   d="scan'208";a="51451598"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Nov 2019 18:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574189982; x=1605725982;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Otwbz/MfqeHzCKb0LGfOQsxR4iVvzAIFYiCKCK//gOU=;
  b=Lbswht9F/JyV+0vNx+z+9w14M/11psdC7yAUTUzJ2zL1DqoiBI7gzblC
   91BL0e0fTOHDgF74SSpa2ZpYNIXSPlWz/APtmXphx0YboQ6T6++eFG8Ry
   KESotGz5FbmW4zZEopD6iyvyu3Za9L2eCE94psV5IjgevTQaYLKKqxeck
   A/xE6gvJwIK4vMEjeF46+kF9btP5JgquVOFKDOjl74Ot+xNfgSRaDjiqS
   t69io0fsUi2Lu2PFQoUTQ8/2tT5NJAOegSjooj3dVzvR3PNV0dPoCHExE
   ICP2gOFNcMlGxhtxv6Fq9rN6VXAnRwPmswFIBb3Ew6W2ymWXhQ8MKPp+Q
   A==;
X-IronPort-AV: E=Sophos;i="5.69,219,1571702400"; 
   d="scan'208";a="35732484"
IronPort-PHdr: =?us-ascii?q?9a23=3AtMOERxyON7fNv4rXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u4eIJqq85mqBkHD//Il1AaPAdyArasY26GP6vCocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi5rgjdudQajZZhJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMYIhw74smZ?=
 =?us-ascii?q?oTtkTPBCn2l1ntjKCKbEkk/+mo6+D/brXnoJ+TKZN0hxnjPqkhlcGzG+Q1Ph?=
 =?us-ascii?q?UUU2SF9umwyqfv8VDhTLVPlPI2k63ZsJ7AJcQco660GxRV3Zs46xukEzen0M?=
 =?us-ascii?q?gXnXkALF5ffhKHlJLmN0vBIPD/E/ezm06snytzx/DaIr3hBY3AL3bCkLfleb?=
 =?us-ascii?q?Zw8E1cxxQpzdBZ+Z1UDqsNIPXpWk/+rNbYFAM2MxSow+b7D9VwzpgeVnyLAq?=
 =?us-ascii?q?+YNqPSrFCJ6/kxI+mDeoAVoizxK/s76P70i382h1sdcbOu3ZsNZ3CyBu5mLF?=
 =?us-ascii?q?mBYXrwntcBFn8Hvg4/TOzslV2DXidfZ3WsUKIm4DE0FoamAJzdRoCinrOBxj?=
 =?us-ascii?q?23Hp5IaWBcDFCDD3Poe5+DW/cWZyLBavNmxwMFUbzpZ4Io3hao/Fvlyr5jBu?=
 =?us-ascii?q?nZ4CsVsdTkztcjo6XImBUz8yFkJ9qS3nvLTGxumG4MATgs0/NRu0t4n2yf3L?=
 =?us-ascii?q?B4jvoQLtla4/dEQ09uLpLH5/BrAND1HATad5GGT0jwEYbuOi04Ut9km4xGWE?=
 =?us-ascii?q?16Adj3y0mYjic=3D?=
X-IPAS-Result: =?us-ascii?q?A2ASAAATO9Rd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFtAgEBAQELAYFzLIFAMyqEKo9aAQEBAQEBBoE2iWaRQwkBAQEBA?=
 =?us-ascii?q?QEBAQE0AQIBAYRAAoIlJDcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbQEFI?=
 =?us-ascii?q?wQRQRALGAICJgICVwYBDAYCAQGCXz+CUyWxSH8zhU6DLoFIgQ4oAYwUGHiBB?=
 =?us-ascii?q?4E4gms+h1WCXgSND4lMRnSWFII1gjeTEgYbgj6MIosxLY4bnBgjgVgrCAIYC?=
 =?us-ascii?q?CEPgydQERSRJheOQSMDMIEFAQGOMgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Nov 2019 18:59:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAJIxedE005094;
        Tue, 19 Nov 2019 13:59:41 -0500
Subject: Re: [RFC PATCH 1/2] selinux: Don't call avc_compute_av() from RCU
 path walk
To:     Will Deacon <will@kernel.org>, selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-2-will@kernel.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5e51f9a5-ba76-a42d-fc2b-9255f8544859@tycho.nsa.gov>
Date:   Tue, 19 Nov 2019 13:59:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119184057.14961-2-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/19/19 1:40 PM, Will Deacon wrote:
> 'avc_compute_av()' can block, so we carefully exit the RCU read-side
> critical section before calling it in 'avc_has_perm_noaudit()'.
> Unfortunately, if we're calling from the VFS layer on the RCU path walk
> via 'selinux_inode_permission()' then we're still actually in an RCU
> read-side critical section and must not block.

avc_compute_av() should never block AFAIK. The blocking concern was with 
slow_avc_audit(), and even that appears dubious to me. That seems to be 
more about misuse of d_find_alias in dump_common_audit_data() than anything.

> 
> 'avc_denied()' already handles this by simply returning success and
> postponing the auditing until we're called again on the slowpath, so
> follow the same approach here and return early if the node lookup fails
> on the RCU walk path.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   security/selinux/avc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index ecd3829996aa..9c183c899e92 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1159,16 +1159,19 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>   	rcu_read_lock();
>   
>   	node = avc_lookup(state->avc, ssid, tsid, tclass);
> -	if (unlikely(!node))
> +	if (unlikely(!node)) {
> +		if (flags & AVC_NONBLOCKING)
> +			goto out;
>   		node = avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
> -	else
> +	} else {
>   		memcpy(avd, &node->ae.avd, sizeof(*avd));
> +	}
>   
>   	denied = requested & ~(avd->allowed);
>   	if (unlikely(denied))
>   		rc = avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
>   				flags, avd);
> -
> +out:
>   	rcu_read_unlock();
>   	return rc;
>   }
> 

