Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE6C282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0698220863
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XMJ8sQgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfEWORF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 10:17:05 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:62475 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWORF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 10:17:05 -0400
X-Greylist: delayed 748 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2019 10:17:02 EDT
X-EEMSG-check-017: 216369699|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 May 2019 14:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558620255; x=1590156255;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7+V4fX918r2TNUZAC/oUOJwwWyErUaNH6IsIawevZIo=;
  b=XMJ8sQggt6ahSw+s00sNXP0YM0zAZsnlppxrU6aXhV1CbkeuzaiDCkC1
   I3NsKN2UYL9thRqho4fLAiBKt0zeY8U917wK4lmTu3Y1yaqaHhKptseSb
   U3LUDy1Wb9mw5VV+rndVda2kGtEna0NRDigOguSlitVMGX6GTsSbsFArU
   YB0GUB9fy62Pizi/AEh/LFe92BpjT6SjGgbk6F6zMG7uXUcFTwrwe3+/i
   /C1kKrNZTyxbvr2ce+BrN1ymZbILfRerxxrNOsiuM3JiFFGTtCLya11t2
   Ol1ygJ4H5h7AnyUXXS8iXpWZyKa25z4Jq8qoKx9MxY+sW+2SfEM7pGisr
   A==;
X-IronPort-AV: E=Sophos;i="5.60,503,1549929600"; 
   d="scan'208";a="24026695"
IronPort-PHdr: =?us-ascii?q?9a23=3ApgPbNBBjoSQalgc/bl5rUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX5p8bcNUDSrc9gkEXOFd2Cra4d0qyP6vyrBjZIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+roQnMucQajolvJrgswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?ohDw/G0g8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJy0kuGR/KgU+KqYz5IT+ey+MAs2qV7uV8T+2vkXInpx9qrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJcYVp6GlGQBVyJoj5wikAje60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBlIjmIUvCIP//Dfehm1isiitkx+jaPr39BZXANmLDkLb9cr?=
 =?us-ascii?q?Z98UFc0hc8wshD6J1MCrEOOvPzWknvu9zDFRI2KBC0w+fhCNVhyIweQ2SPDb?=
 =?us-ascii?q?GFMK/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gH8ih1Adeaip3Z0KaHG3BflmPU?=
 =?us-ascii?q?qZbmT2gtsbEmcFoBA+TOr0h12GSzJTYGyyX61vrg08XbinBofKXIzloLWA2i?=
 =?us-ascii?q?qgVslMZ2tGA0qAJnzfd4yFXfoXQCiOI8l9nyYCWKTnQIgkg1XmrwL+yrx6Ps?=
 =?us-ascii?q?LK9SAC85Huzt5446vUjx5h2yZzCpGfzGqEVX0u1jcKWDQ/xrwliVBswVeEl6?=
 =?us-ascii?q?5jirpXEsIFtKABaRszKZOJl78yMNv1QA+UO47SGVs=3D?=
X-IPAS-Result: =?us-ascii?q?A2DFAQBGp+Zc/wHyM5BlHQEBBQEHBQGBUwYBCwEBgWUqg?=
 =?us-ascii?q?W0ohBOIe4tuLZhXgXsJAQEBAQEBAQEBNAECAQGCEoIuAoI4IzYHDgEDAQEBB?=
 =?us-ascii?q?AEBAQEDAQFsKEIBEAGBZikBgmcBBSMPAQVBEAkCCQ8CAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/gWsDHYsEm2mBL4hygUaBDCgBi1GBVkCBOIJrPoIahTSCWASBLQGnEAYDg?=
 =?us-ascii?q?g+FXY0rBhuWOIxkl10NJIFXKwpBSoEegU6CRo4oIwMwgQYBAYceg2ArgiUBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 23 May 2019 14:04:13 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4NE4DTJ023302;
        Thu, 23 May 2019 10:04:13 -0400
Subject: Re: [Non-DoD Source] [PATCH] libsepol/cil: Allow validatetrans rules
 to be resolved
From:   jwcart2 <jwcart2@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov
References: <20190521112206.5403-1-richard_c_haines@btinternet.com>
 <82e7d8a1-d962-2a0b-fbdc-07143a8061c3@tycho.nsa.gov>
Message-ID: <439d9204-647c-9c9a-e381-ef0b2ede34c4@tycho.nsa.gov>
Date:   Thu, 23 May 2019 10:05:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <82e7d8a1-d962-2a0b-fbdc-07143a8061c3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/21/19 1:59 PM, jwcart2 wrote:
> On 5/21/19 7:22 AM, Richard Haines wrote:
>> When validatetrans rule is in CIL policy it errors with:
>> u3, r3, and t3 can only be used with mlsvalidatetrans rules
>>
>> Will now resolve these examples:
>> (validatetrans binder (and (and (eq t1 t1_t) (eq t2 t2_t)) (eq t3 t3_t)))
>> (mlsvalidatetrans file (and (and (eq t1 t1_t) (eq t2 t2_t))
>>      (and (eq t3 t3_t) (domby h1 h2))))
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
> 

Applied.
Thanks,
Jim

>> ---
>>   libsepol/cil/src/cil_verify.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
>> index 1036d73..1a21cf4 100644
>> --- a/libsepol/cil/src/cil_verify.c
>> +++ b/libsepol/cil/src/cil_verify.c
>> @@ -221,8 +221,8 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor 
>> l_flavor, enum cil_fl
>>               cil_log(CIL_ERR, "l1, l2, h1, and h2 cannot be used on the left 
>> side with a string or list on the right side\n");
>>               goto exit;
>>           } else if (l_flavor == CIL_CONS_U3 || l_flavor == CIL_CONS_R3 || 
>> l_flavor == CIL_CONS_T3) {
>> -            if (expr_flavor != CIL_MLSVALIDATETRANS) {
>> -                cil_log(CIL_ERR, "u3, r3, and t3 can only be used with 
>> mlsvalidatetrans rules\n");
>> +            if (expr_flavor != CIL_VALIDATETRANS && expr_flavor != 
>> CIL_MLSVALIDATETRANS) {
>> +                cil_log(CIL_ERR, "u3, r3, and t3 can only be used with 
>> (mls)validatetrans rules\n");
>>                   goto exit;
>>               }
>>           }
>>
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
