Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D78BC43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C932E20657
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n3BdO+J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCKPv5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:51:57 -0400
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:33407 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbfCKPv5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 11:51:57 -0400
X-EEMSG-check-017: 190646484|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Mar 2019 15:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552319514; x=1583855514;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5No7V0/DWrr7E1NnboRgYcPP0M06ad4t8nXMPxNFwCI=;
  b=n3BdO+J2RbD75VIbCG3W0ZERDYfAIyBQcG4vOcCRARGWRnc7mPF3QUov
   Q6r/oeq0xiEG54YaX+7S8DxovQmgC49GbM7wn69lExqu3U4LYrQn3zje0
   kD7MT1Rv62otCZrFpDzBbwsXq8ssD/rjzLTjQpiCfKm/cgBaK4ovGknkw
   EZnU49KbFd8U1/lGM0aOKgiFZ23fyEzx2pPSUcGBF2otWlItv1TcAr3jE
   o7YsNuOv8BO5nq1ll6l7lTKAZdq7pI34DqaibMI3cycjeXoI/O2nGtPFk
   +S4tDjTIwXH7/L4QMXbDTSoL45idDakstT0BGYa9vHNAjfA77K6NVbiMj
   w==;
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="21343414"
IronPort-PHdr: =?us-ascii?q?9a23=3Abr4seR0pyYP/cL1gsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIRLPad9pjvdHbS+e9qxAeQG9mCs7Qc0qL/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHOfwlEniaxba5vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcY8CA+8HMO1FrYfyukEOoAOjCwesGu3vxDxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98NqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym0yskDNxyPDbIr3hGI7CIWLYnbf7Y7?=
 =?us-ascii?q?ly9k5cxxAvzdxF+51UDbQBKurpWkDtrNzYEgM5Mwuszub8Ftp90oIeWWSSAq?=
 =?us-ascii?q?6WK67Sr1CI6fw1I+WWZ48apiz9K/476P7ql3M5nkUdfab6lacQPUi1Au4uB0?=
 =?us-ascii?q?yEfWDmi9wBWTMSugMjUPbggXWYXDJTbmr0VKU5sHVzE4+iDIHeVqizj7Gbmi?=
 =?us-ascii?q?S2BJtbYiZBEF/fP23vctC/R/oUaC+UavRkmzgAWKnpH5QtzjmypQT6zPxhNe?=
 =?us-ascii?q?OS9SoG48GwnONp7vHewElhvQd/CN6QhiTUFTB5?=
X-IPAS-Result: =?us-ascii?q?A2BsAADngoZc/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?WUqgWsnhAmTTEwBAQEBAQEGgQgtfIhDiVWFEoF7OAGEQAKEOiI2Bw0BAQMBA?=
 =?us-ascii?q?QEGAQMCAWwogjopAYJnAQUjDwEFUQkCDgoCAiYCAlcGAQwGAgEBgl8/gWkNl?=
 =?us-ascii?q?B6bZoEviimBCyQBiywXeIEHgREngjY1hEqDQYJXA4oFEYZagWORTgmTBgYZk?=
 =?us-ascii?q?zotikuUPQgpgVYrCAIYCCEPgyeCFheOOiMDMIEFAQGMbIJNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Mar 2019 15:51:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2BFpp4U012354;
        Mon, 11 Mar 2019 11:51:52 -0400
Subject: Re: [PATCH v3] libselinux: Add security_reject_unknown(3) man page
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <pjdy35sma9h.fsf@redhat.com>
 <20190306125814.22023-1-plautrba@redhat.com>
 <d303cc9d-e439-994f-1f98-48c98a6c8866@tycho.nsa.gov>
Message-ID: <ce371a86-a8ae-bcf9-2ac3-9fe881abda0e@tycho.nsa.gov>
Date:   Mon, 11 Mar 2019 11:48:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d303cc9d-e439-994f-1f98-48c98a6c8866@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/19 8:26 AM, Stephen Smalley wrote:
> On 3/6/19 7:58 AM, Petr Lautrbach wrote:
>> Commit c19395d72295 ("libselinux: selinux_set_mapping: fix handling of 
>> unknown
>> classes/perms") added a new interface security_reject_unknown() which 
>> needs to
>> be documented.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.

> 
>> ---
>>   libselinux/man/man3/security_getenforce.3     | 20 ++++++++++++++++++-
>>   libselinux/man/man3/security_reject_unknown.3 |  1 +
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>   create mode 100644 libselinux/man/man3/security_reject_unknown.3
>>
>> diff --git a/libselinux/man/man3/security_getenforce.3 
>> b/libselinux/man/man3/security_getenforce.3
>> index 29cf3de7..f339b8b0 100644
>> --- a/libselinux/man/man3/security_getenforce.3
>> +++ b/libselinux/man/man3/security_getenforce.3
>> @@ -1,6 +1,7 @@
>>   .TH "security_getenforce" "3" "1 January 2004" 
>> "russell@coker.com.au" "SELinux API documentation"
>>   .SH "NAME"
>> -security_getenforce, security_setenforce, security_deny_unknown, 
>> security_get_checkreqprot\- get or set the enforcing state of SELinux
>> +security_getenforce, security_setenforce, security_deny_unknown, 
>> security_reject_unknown,
>> +security_get_checkreqprot \- get or set the enforcing state of SELinux
>>   .
>>   .SH "SYNOPSIS"
>>   .B #include <selinux/selinux.h>
>> @@ -11,6 +12,8 @@ security_getenforce, security_setenforce, 
>> security_deny_unknown, security_get_ch
>>   .sp
>>   .B int security_deny_unknown(void);
>>   .sp
>> +.B int security_reject_unknown(void);
>> +.sp
>>   .B int security_get_checkreqprot(void);
>>   .
>>   .SH "DESCRIPTION"
>> @@ -27,6 +30,21 @@ returned.
>>   returns 0 if SELinux treats policy queries on undefined object 
>> classes or
>>   permissions as being allowed, 1 if such queries are denied, and \-1 
>> on error.
>> +.BR security_reject_unknown ()
>> +returns 1 if the current policy was built with handle-unknown=reject 
>> and SELinux
>> +would reject loading it, if it did not define all kernel object 
>> classes and
>> +permissions. In this state, when
>> +.BR selinux_set_mapping()
>> +and
>> +.BR selinux_check_access()
>> +are used with an undefined userspace class or permission, an error is 
>> returned
>> +and errno is set to EINVAL.
>> +
>> +It returns 0 if the current policy was built with 
>> handle-unknown=allow or
>> +handle-unknown=deny. In this state, policy queries are treated 
>> according to
>> +.BR security_deny_unknown().
>> +\-1 is returned on error.
>> +
>>   .BR security_get_checkreqprot ()
>>   can be used to determine whether SELinux is configured to check the
>>   protection requested by the application or the actual protection 
>> that will
>> diff --git a/libselinux/man/man3/security_reject_unknown.3 
>> b/libselinux/man/man3/security_reject_unknown.3
>> new file mode 100644
>> index 00000000..d59e5c2c
>> --- /dev/null
>> +++ b/libselinux/man/man3/security_reject_unknown.3
>> @@ -0,0 +1 @@
>> +.so man3/security_getenforce.3
>>
> 

