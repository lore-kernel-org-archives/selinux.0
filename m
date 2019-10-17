Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B62ECE58E
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 12:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7105214E0
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 12:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iCZF+G4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406327AbfJQMlo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:41:44 -0400
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:52515 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406326AbfJQMlo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Oct 2019 08:41:44 -0400
X-EEMSG-check-017: 18389276|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,307,1566864000"; 
   d="scan'208";a="18389276"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2019 12:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571316103; x=1602852103;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ix/sy0RHe0BbOCO8fDeZmjIXyPWFy1CVKrh5Y+YVyY8=;
  b=iCZF+G4vXipflXunLfp/CjfwMwCrBjQczAlKhNRcgf1qRmyDQgVyVxHu
   X9vYdyYumUrQPjLQkNSERnCpQnuouTlwwXqIO9p5pUEZTbY+locZdek4B
   CSL58iWkDPtnB0xZR9NEwuoUkCNkEZfy2n4ci0hncmXewxQrCAv0Ffilc
   ritrBDvw8vV+0/TZ6AHrjwN/3QUhqn2zPbpRy0GpnW2UGq/TYlXybVN4z
   9wcpG8SYsYXcViqDdR3/0TbeTILVkEeqmIo3LAtFeYmbHFlkpzFwwfsVn
   dNtpd7u1c03zIlRi2W6HoOqZ/Yezg6bV4kJSRA+BDGmKC0/HQ8hFyKJdr
   g==;
X-IronPort-AV: E=Sophos;i="5.67,307,1566864000"; 
   d="scan'208";a="29080506"
IronPort-PHdr: =?us-ascii?q?9a23=3AzQdpBBeJBWK5+UfYeJ5OmIBmlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSyYR7h7PlgxGXEQZ/co6odzbaP6Oa/Biddut6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twfcu8sZjYZiJKs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zu?=
 =?us-ascii?q?QvHx/I3AIjEdwBvnvbo9fpO6kdSu210KrFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jblLfuZ6?=
 =?us-ascii?q?t961JGyAUo199S/IhUBa8cL/LzQEDxqMbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLjSvkGM5uIuJemMeYAUtS3jK/gq+fHul2U1mVwDcqmz25sYdnS4Eu5hI0?=
 =?us-ascii?q?WDbnq/yusGRF8HohB2aOX3lEeIWDVTLyKqW6sh+isxAaq8AIvDT5zri7uEim?=
 =?us-ascii?q?PzBZBSZ2ZbGniSHnryMYaJQfEBbGSVOMAyvCYDUO2aV4I51Ryo/DT/wr5jI/?=
 =?us-ascii?q?ucrjYUrrr/xdN14KvVjhh0+jtqWZfOm1qRRn15yztbDwQ927py9AkkkQaO?=
X-IPAS-Result: =?us-ascii?q?A2CTAQDmYKhd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYFzLGxUMiqEJY5nUwaBESWJeYoMhSiBewkBAQEBAQEBAQEjEQECAQGEQ?=
 =?us-ascii?q?AKDAyQ2Bw4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJoAQUjDwEFUQkCDgoCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/AYJSJZNbm3KBMoh4gUiBDCgBjA0YeIEHgTgMgio1P?=
 =?us-ascii?q?odSgl4ErVGCLIIyhFqODwYbgyyWGi2OA5s/CCqBWCsIAhgIIQ+DJwlHEBSCC?=
 =?us-ascii?q?IYRiBklAzCBBgEBkDYBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Oct 2019 12:41:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9HCfesD015524;
        Thu, 17 Oct 2019 08:41:40 -0400
Subject: Re: [PATCH] libsepol: Use LIBSEPOL_3.0 and fix
 sepol_policydb_optimize symbol mapping
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191011070716.198563-1-plautrba@redhat.com>
 <8cecd4d2-7b46-6d41-62fe-fd33eda2376d@tycho.nsa.gov>
Message-ID: <5404baae-90bc-1dde-6994-8665a50297e5@tycho.nsa.gov>
Date:   Thu, 17 Oct 2019 08:41:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8cecd4d2-7b46-6d41-62fe-fd33eda2376d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/15/19 10:22 AM, Stephen Smalley wrote:
> On 10/11/19 3:07 AM, Petr Lautrbach wrote:
>> There's a typo in commit b8213acff837101 ("libsepol: add a function to 
>> optimize
>> kernel policy") which added new function sepol_policydb_optimize(), 
>> but there's
>> sepol_optimize_policy in libsepol.map.
>>
>> LIBSEPOL_3.0 is used to follow the next release version libsepol-3.0
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.

> 
>> ---
>>   libsepol/src/libsepol.map.in | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
>> index 6358e51f..f4946a79 100644
>> --- a/libsepol/src/libsepol.map.in
>> +++ b/libsepol/src/libsepol.map.in
>> @@ -60,7 +60,7 @@ LIBSEPOL_1.1 {
>>       sepol_polcap_getname;
>>   } LIBSEPOL_1.0;
>> -LIBSEPOL_1.2 {
>> +LIBSEPOL_3.0 {
>>     global:
>> -    sepol_optimize_policy;
>> +    sepol_policydb_optimize;
>>   } LIBSEPOL_1.1;
>>
> 

