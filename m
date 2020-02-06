Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C9C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADCD20838
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BbRaP2eI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBFQDb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:03:31 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:10701 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBFQDa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 11:03:30 -0500
X-EEMSG-check-017: 55691129|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55691129"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 16:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581004996; x=1612540996;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8cnBPdKCcZwMpUZeLc8Sm4KzOktm9HHzPc0nvRkaVUM=;
  b=BbRaP2eIMKTZfuojM5q7ZlnDwZX2Evd/qQtdkHoTjfQPQiMNhOhkUNwh
   zFMIhIJ7iSDG+GnC2iOcY0q8uVdDJZL+UfoixbZmQWbncIWliGjod/dss
   09B8wrPhkIEd/x9u06t9P7iuUwBX8SxxoruzoRDmNM0dBgYioqgQp4xVw
   sFOrLlmkeEvyMpQw02X7DLUu+6qnFl4ajdsMRHIBk27QT/0NhTfRHbztr
   cAjVo2wX6RIzdEf9ZlZRSrmwGiB7iuTq7BqCQyuUocc359F/jEj/qpaTB
   gddOgbsMSjpdOiGLuBvZ2v/Y3V8Ucboof3oB2IGui+XM4nzWpld6k5Wjo
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="38761459"
IronPort-PHdr: =?us-ascii?q?9a23=3AEE+CxxeyiXCo+bc9ou7zfl1IlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS5Yx7h7PlgxGXEQZ/co6odzbaP7+a9AidQuN7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90B?=
 =?us-ascii?q?vEr3VHd+lV2G9jOFafkwrh6suq85Nv7ipdt+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?dPUcZLUyxKH52yYY0BAeEcOepUtofwql8LoRa4GAKiBv7gyiVQi3Hrw6M63e?=
 =?us-ascii?q?QvHwLI0gMuEN0BsmjbotruOacOUu241rXEwSnNYv5U3zr29YjGcgomofGJRb?=
 =?us-ascii?q?9wc8TQxlU1GAPfklWct5HuMjSX1uUDr2eU9fBgVf6xh2M8twFwoiSgxscrio?=
 =?us-ascii?q?XTgIIV0UrL+T92wIYyO921UUh2asOnHptIryyWKoR7T8w4T2xopSo20KMKtJ?=
 =?us-ascii?q?GlcCQQ1ZgqwQPUZeadfIiS+B3jUf6cITJ/hH14Zr2ynw2y8U28yu3kUcm0zU?=
 =?us-ascii?q?pKojJFktbSsnAN0ATe6tSdRftn/0ehxC2P2xrS6uFCL0A0krHbJIA9zbIqip?=
 =?us-ascii?q?oSsVjMHi/xmEnsiq+Zal4k9fSy5+TiY7XmooeQN45yig7gLqQjgtGzDOs3Pw?=
 =?us-ascii?q?QUX2WX5P6w2KPs8EHnWrlGk+U6kqzDv5DbIcQbqLS5AwhQ0os76Ra+ASup38?=
 =?us-ascii?q?4CnXkbMl5IYw6Hjoj1NFHOJ/D0F/G/g0+2nztxyPDGOaPhDo3XLnffiLfhYa?=
 =?us-ascii?q?p960lExQoo099f45NUCrccIPP8QULxqtPYAQEjMwCuwOboFs991oUAVmKLGK?=
 =?us-ascii?q?OZN7nSsVDbrt4odtKQaZcVtTC1EP0s4/rjnDdtglMGVbW41psQLnajF7JpJF?=
 =?us-ascii?q?vPJTL3j9MAF3oalhQxQfasi1CYVzNXIXGoUPES/DY+XYC5Bo7ZWtrl1L6e1y?=
 =?us-ascii?q?6hAsd+enFNClfKF2zhMYqDRaFfO2qpPsZ9n2lcBvCaQIg72ETr7173?=
X-IPAS-Result: =?us-ascii?q?A2ATAwDaNzxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsIRIWFIQViQOHfyWUF4ckCQEBAQEBAQEBATcBAYRAAoJhOBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOymDAwEFIw8BBVEJAgkFCgICJgICVwYBDAYCAQGCYz8rA?=
 =?us-ascii?q?YJQkDibeIEyhUqDXYE+gQ4qjX1AgREnDAOCLy4+h1uCXgSBPwGMIooiiDGPN?=
 =?us-ascii?q?gaCPpZABhubC4s0gy6dNCKBWCsKQYFogU5QGA2OKRcVjiwjAzCOSgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 16:03:13 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016G2Msk121908;
        Thu, 6 Feb 2020 11:02:22 -0500
Subject: Re: [PATCH] libsepol/cil: Rewrite verification of map classes and
 classpermissionsets
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200131202450.25665-1-jwcart2@tycho.nsa.gov>
 <ac11d80b-c9fe-725b-8690-40abab87595f@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <fff130df-5318-62e3-2476-703b2b071248@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 11:04:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ac11d80b-c9fe-725b-8690-40abab87595f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/20 10:44 AM, Stephen Smalley wrote:
> On 1/31/20 3:24 PM, James Carter wrote:
>> The classperms associated with each map class permission and with each
>> classpermissionset are verified in __cil_verify_classperms() which had
>> multiple problems with how it did the verification.
>>
>> 1) Verification was short-circuited when the first normal class is found.
>>    The second classpermissionset statement below would not have been
>>    verified.
>>      (classpermission cp1)
>>      (classpermissionset cp1 (CLASS (PERM)))
>>      (classpermissionset cp1 cp2)
>>
>> 2) The classperms of a map class permission and classpermissionset were
>> not checked for being NULL before the function recursively called itself.
>> This would result in a segfault if the missing map or set was referred to
>> before the classmap or classpermission occured. This error was reported by
>> Dominick Grift (dominick.grift@defensec.nl).
>>    These rules would cause a segfault.
>>      (classmap cm1 (mp1))
>>      (classmapping cm1 mp1 (cm2 (mp2)))
>>      (classmap cm2 (mp2))
>>    But an error would be produced for these rules.
>>      (classmap cm1 (mp1))
>>      (classmap cm2 (mp2))
>>      (classmapping cm2 mp2 (cm1 (mp1)))
>>
>> 3) The loop detection logic was incomplete and could only detect a loop
>> with a certain statement ordering.
>>    These rules would cause a stack overflow.
>>      (classmap cm1 (mp1))
>>      (classmapping cm1 mp1 (cm2 (mp2)))
>>      (classmap cm2 (mp2))
>>      (classmapping cm2 mp2 (cm3 (mp3)))
>>      (classmap cm3 (mp3))
>>      (classmapping cm3 mp3 (cm2 (mp2)))
>>
>> Rewrote __cil_verify_classperms() to fix these errors.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
>> ---
>>   libsepol/cil/src/cil_verify.c | 83 ++++++++++++++++-------------------
>>   1 file changed, 37 insertions(+), 46 deletions(-)
> 
> [...]
> 

Applied.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
