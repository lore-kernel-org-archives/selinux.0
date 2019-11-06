Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3766C5DF63
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925412067B
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="V2srSnPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfKFRfK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:35:10 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:49220 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfKFRfJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 12:35:09 -0500
X-EEMSG-check-017: 46342730|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,275,1569283200"; 
   d="scan'208";a="46342730"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2019 17:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573061706; x=1604597706;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ION5+qz2/6PnFyZJGCSOuXq51+5pUeFpP0Q6buCDMs8=;
  b=V2srSnPbR/HlapedzkXbv3oh34cr0yA/LQKdVOYPovUXx7I3DXdxrXvU
   /VSabUWFCGOtaaj1fdeSl0K5nNDXEiM4Kyu+NNdeHXlW91aOxWOYmeQ8+
   djJgR5eB4HlMl74iP1UxQ7ySfEkemEBOt2MqoNluTdG7xV9AtHbDxi1cu
   P8s8sgv72PEDzP+oLkZl7lvEgF74AEVQtE0XEKpp+aiNMC6kpCqJCo6Sf
   xVf1F6Imp3inAciyRSGYuXJl2czIOngmRWxRB9Ga872QLH5EXRJunoDGX
   SW3595+K2dABPVIdymrqPxOl3rbDgonx0TnlOSJLx1rojP+nE53Jo8Ff3
   g==;
X-IronPort-AV: E=Sophos;i="5.68,275,1569283200"; 
   d="scan'208";a="29827529"
IronPort-PHdr: =?us-ascii?q?9a23=3AtwhlcxKS4Ktv/RdBMdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeLPvxwZ3uMQTl6Ol3ixeRBMOHsqkC0rOJ+Pm4AiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oRjTu8UZnIduNqg8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEktGQLKkk+fqZb5Pz+Ly+8AtGqb7uR8Wu21kW4ntx99ryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqiKUN5NuT88/TGxltzw2x70btZ?=
 =?us-ascii?q?KhYiQHx4orywTCZ/GBboOG+AjsVPyLLjd9nH9lfbW/iAus/kW40e38U9W00E?=
 =?us-ascii?q?5NripYjtnArnAN2ALX6siAUvZ94l2u2SyO1wDO8eFIO1w0lKrHJJ4hxb48jJ?=
 =?us-ascii?q?wTvljYHiDqgkn2ia6WdkE89uip7eTofKnmq4eBO4J7hQzyKKQjltGlDegmPQ?=
 =?us-ascii?q?UCQXKX9fmk2L3m50L5QbFKjvMskqnetZDXPcYbp6ClDABPyIYj9wizAiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDlrbhcq?=
 =?us-ascii?q?p6605Y0gUz1spT55NTCrEGO/LzQVT8tNnXAx42KQC0xPznCNpl3IMERW2PGr?=
 =?us-ascii?q?OZML/VsVKQ/eIgPe2MZI4TuDbgJPko/ODujXAnll8HZ6Wp3oUYaGq+Hvt4J0?=
 =?us-ascii?q?WVe33sgs0OETRCgg1rau3hj1mLSnZyYHGpROpo4DAwD4avFsHCQYe2m5SEgD?=
 =?us-ascii?q?f9GYdZMDNoEFeJRHX3fIyeR61EPCCNKcZ7jmYsSamqS4hn0wqn8gD91ew0fa?=
 =?us-ascii?q?Lv5iQEuMe7h5BO7OrJmER3rGclAg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ASAADmA8Nd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFtAgEBAQELAYFzLIFAATIqhCmRJ5snCQEBAQEBAQEBATQBAgEBg?=
 =?us-ascii?q?hOCLQKEDiQ3Bg4CDgEBAQQBAQEBAQUDAQFshUOCOykBgm0BBSMEEUEQCwkPA?=
 =?us-ascii?q?gIfBwICVwYNBgIBAYJfP4J4sSZ1fzOFToMsgUiBDigBjBOBV0CBESeCaz5ph?=
 =?us-ascii?q?myCXgSBOwGLVYhTYUVylgQGgiiVNgYbmWyqNyOBWCsKQYFogU5QERSDPo4sI?=
 =?us-ascii?q?wMwgQUBAZEDAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Nov 2019 17:34:55 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA6HYsU4031850;
        Wed, 6 Nov 2019 12:34:54 -0500
Subject: Re: [Non-DoD Source] Re: [PATCH] libsepol/cil: Report disabling an
 optional block only at high verbose levels
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20191101151903.15554-1-jwcart2@tycho.nsa.gov>
 <CAJfZ7=nLxMZz_Y_m59gzn1fo=wXeDtn2fFMbHpv_9erZKOedZQ@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <d2f1ca31-b273-e196-2c2f-8d0933974984@tycho.nsa.gov>
Date:   Wed, 6 Nov 2019 12:35:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nLxMZz_Y_m59gzn1fo=wXeDtn2fFMbHpv_9erZKOedZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/2/19 1:16 PM, Nicolas Iooss wrote:
> On Fri, Nov 1, 2019 at 4:25 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
>>
>> Since failing to resolve a statement in an optional block is normal,
>> only display messages about the statement failing to resolve and the
>> optional block being disabled at the highest verbosity level.
>>
>> These messages are now only at log level CIL_INFO instead of CIL_WARN.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> I confirm that this fixes the issue I experienced with "semodule
> --verbose -B" being much noisier in 3.0-rc1 than in 2.9.
> 
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> 
> Thanks
> Nicolas
> 

I merged this.
Jim

>> ---
>>   libsepol/cil/src/cil_resolve_ast.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index 70a60bdf..87575860 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -3761,14 +3761,16 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
>>                  enum cil_log_level lvl = CIL_ERR;
>>
>>                  if (optstack != NULL) {
>> -                       lvl = CIL_WARN;
>> +                       lvl = CIL_INFO;
>>
>>                          struct cil_optional *opt = (struct cil_optional *)optstack->data;
>>                          struct cil_tree_node *opt_node = opt->datum.nodes->head->data;
>> -                       cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
>>                          /* disable an optional if something failed to resolve */
>>                          opt->enabled = CIL_FALSE;
>> +                       cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
>> +                       cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
>>                          rc = SEPOL_OK;
>> +                       goto exit;
>>                  }
>>
>>                  cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
>> --
>> 2.21.0
>>
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
