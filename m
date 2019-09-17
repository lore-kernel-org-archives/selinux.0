Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC98C4CECD
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E40221852
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PUDnjSAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfIQO7U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:59:20 -0400
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:1581 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfIQO7U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 10:59:20 -0400
X-EEMSG-check-017: 14648359|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,516,1559520000"; 
   d="scan'208";a="14648359"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Sep 2019 14:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568732357; x=1600268357;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=RCwT9d0OHGH4M52uA4FOGsZzTb0YqV6O+j8lek6ogPM=;
  b=PUDnjSAml1Y7DP8d4LgbKs71zcV8d7AUhdj8wC/TVTWr3Wh+fdAircgr
   b7J2cvtBpvr24KuCBK1Zs5Sqj772kk3VqK0Y73lloZ9GnhZznkSsOuRVc
   /i4nWx/EH5MmG4tF5d/BqEaIlYYJo5Vj/KAPzVj8TNrGghohXjrfQv77y
   0NP/P5Wp9cgrwUe3BnHYx7wA2MhpUc/1imVZe3jEQ9NH2twgCR8xCaB56
   OCidMfHy0X1tOpD2Xy3rGZ1u09F//CgPUBGK1BjsVK/p3K7GsZCDguaVP
   JbkkySdGjaCIyHBjPipxZiFqfc4YsMif3XKjx5/JkIUNLRRz2gDIOKEoe
   w==;
X-IronPort-AV: E=Sophos;i="5.64,516,1559520000"; 
   d="scan'208";a="32947460"
IronPort-PHdr: =?us-ascii?q?9a23=3Al4JtkREQFzXoa8UdF3VrM51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yr8ywAkXT6L1XgUPTWs2DsrQY0rGQ6v6rBDFIoc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bIrXdFe+Rbzn5sKV6Pghrw/Mi98IN9/yhKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHH53bc+0+?=
 =?us-ascii?q?88Dw/I2gIuFM8KvHjNotj4MKIeXOaox6fK0DrDdetb1yrj5ojGch4vov+CUr?=
 =?us-ascii?q?x/fsXT1UYhGBjIjkmTpIH/Iz+ZyuoAvmqd4uF9VeyvkWknqwRprzityMYjlp?=
 =?us-ascii?q?PGhpgJylza6C50x4Q1JNOkR0Fhe96kDIVcujqGN4p2XswiQ2ZotDw8yr0do5?=
 =?us-ascii?q?G3ZicKyJM5xxPGbfGMboaG4hXmVOmLIDd4gmpoeLawhxau9Eis0PHzVs6x0F?=
 =?us-ascii?q?pSoCpKidjMtnYD1xPN8MiLUOdy/kCk2TuJygvd6flELFgpmafUJJMt2L49mo?=
 =?us-ascii?q?cJvUjdESL6hl/6gLKQe0454Oan8f7nba/jppKEMo90jRzxPbo2l8ykBOQ4Lh?=
 =?us-ascii?q?AOX2+G+eSgzLHj/VP2QLFNjvAujqnWqoraJcUGpq6iGQNVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2UILElZdx6diojpOlXOLOj5Dfe5nVusjC9my+3JM7DuGJnALmXPnK3/cb?=
 =?us-ascii?q?ty9UJQ0hc/wcha551OC7EBJPzzWlX2tNzdFhI5MQK1zPr9B9VnyoMSR3mCAr?=
 =?us-ascii?q?OZMazOsV+I4fgjI++XZIAPojr9JP8l5+D2gX8jhVAdZbWp3YcQaH2gGPRmIl?=
 =?us-ascii?q?mWYX3ogtgbCmcGpAs+TOvtiF2ZSj5efHOyUq0z5z0hD4KmF4jDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1CXD3joc4SEW/ERaCOdOcJhjDMEWqa7S4M71hGhqhX6y7x5Ie?=
 =?us-ascii?q?rQ4CEYsojj1Ncmr9HUwDcz/jtwBt/V8maKVHo8ymUJTDgy1bs5oEt60Uyr1P?=
 =?us-ascii?q?RoxftCGooXr+hEVgY8KI700eN3EZbxVxjHc9PPT0ypEfu8BjRkTM06ysUSOQ?=
 =?us-ascii?q?4pGcqphwrfhQK2ErQVkPqNH5Vy/aXCiSuib/1hwmrLgfFyx2ItRdFCYCj/3f?=
 =?us-ascii?q?9y?=
X-IPAS-Result: =?us-ascii?q?A2AjEgBq9IBd/wHyM5BmHQEBBQEHBQGBZ4FuKm1TMiqEI?=
 =?us-ascii?q?Y8OgWolmTSBZwkBAQEBAQEBAQErCQECAQGCEoItAoJ8IzgTAgwBAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIUuDII6KQGCZgEBAQECASMPAQVGCwkCCQ8CAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYF7Dw+SOJtvgTKETg9vgzqBQwaBDCiLeIFXQIERJwyCMS4+hC2DIoJYB?=
 =?us-ascii?q?IEvAYkaghaKRpVJBoImhXWBEIUQiGYGG5kajgqFToI+kwkhgVgrCkGBaIEaA?=
 =?us-ascii?q?QEyH4YVim8kAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Sep 2019 14:59:15 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8HExEQU027596;
        Tue, 17 Sep 2019 10:59:14 -0400
Subject: Re: [Non-DoD Source] [PATCH 0/9] Fix issues found by static analyzers
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
 <393f7b30-35e5-5c43-7d26-070dd43adbb3@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <fd3da02e-1968-a18b-c25f-29573ec9220f@tycho.nsa.gov>
Date:   Tue, 17 Sep 2019 11:01:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <393f7b30-35e5-5c43-7d26-070dd43adbb3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 12:46 PM, jwcart2 wrote:
> On 9/1/19 2:06 PM, Nicolas Iooss wrote:
>> Hi,
>>
>> In August I ran several free static analyzers in order to find new
>> issues in the userspace code. I used:
>>
>> * clang's static analyzer (with scripts/run-scan-build)
>> * https://lgtm.com/ (I wrote a simple configuration file to analyze the
>>    C code, the results are available on
>>    https://lgtm.com/projects/g/fishilico/selinux-for-lgtm/ )
>> * Facebook's Infer (https://fbinfer.com/, I wrote a script to invoke it
>>    like clang's static analyzer)
>>
>> Each analyzer gave many results, with several true bugs in them. Here
>> are patches that fix some of them. I will post the configuration files
>> and scripts I used separately.
>>
>> Thanks,
>> Nicolas
>>
>> Nicolas Iooss (9):
>>    semodule-utils: fix comparison with argc
>>    libsepol/cil: help static analyzers by aborting when an allocation
>>      fails
>>    libsepol: do not dereference a failed allocated pointer
>>    libsepol: do not dereference scope if it can be NULL
>>    libsepol: reset *p to NULL if sepol_module_package_create fails
>>    libsepol/cil: do not dereference perm_value_to_cil when it has not
>>      been allocated
>>    python/chcat: remove unnecessary assignment
>>    python/sepolicy: remove unnecessary pass statement
>>    libsepol/tests: do not dereference a NULL pointer
>>
>>   libsepol/cil/src/cil_binary.c                        | 10 ++++++----
>>   libsepol/cil/src/cil_mem.c                           |  5 +++++
>>   libsepol/src/avrule_block.c                          |  3 ++-
>>   libsepol/src/kernel_to_cil.c                         |  8 +++++---
>>   libsepol/src/kernel_to_conf.c                        |  8 +++++---
>>   libsepol/src/module.c                                |  4 +++-
>>   libsepol/tests/test-common.c                         | 11 +++++++----
>>   python/chcat/chcat                                   |  1 -
>>   python/sepolicy/sepolicy/__init__.py                 |  1 -
>>   semodule-utils/semodule_package/semodule_unpackage.c |  2 +-
>>   10 files changed, 34 insertions(+), 19 deletions(-)
>>
> 
> I forgot to mention this when I commented on patches 2 and 3, but patches 1 and 
> 4-9 all look good to me.
> 
> I plan on merging these, my take on your patch 2, and your updated patch 3 
> tomorrow, unless there are any objections.
> 

I have indeed merged your patches 1 and 4-9 along with my take on your patch 2 
and your updated patch 3.

Thanks,
Jim

> Jim
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
