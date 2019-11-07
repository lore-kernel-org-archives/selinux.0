Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BBC5DF61
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C384B218AE
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 13:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n5wA1RiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbfKGNRp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:17:45 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:9018 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGNRp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 08:17:45 -0500
X-EEMSG-check-017: 25059575|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="25059575"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Nov 2019 13:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573132659; x=1604668659;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8s+5F66/BSEIzltvuhOiOp9iWoDBbsQAqUnZ0Dk+3Co=;
  b=n5wA1RiMwSPVESignChk8c5m4JdErInBQvGuqfNiI4uX5RIgKJdooCmb
   kyjb5ef4GUn4Zxrfjr5Jf39dwMICSn6BskFfjUHMOj5Hg+b0UXrPYSMTu
   sd5qN86IJJblBMIRVb277AH6whmk+qyjngmVwWa/7Ic+Yv9jutPTQ/+hd
   Cog4LT6/gF8PRvf7Xh7kqNQSH2zq3MGO/5LRx3bSkT0pd4aVHN/wpsSWB
   KgowcDDQ0NiR5j+2RtLELyoDroyK41lKJ5u+4kB5Dhd9fDHu5yFpw3TUp
   wDsR7kD2vGrgm7dPUIjOthkrar5zwLWzEbwXH2JzBynA3GKCXlhbjz+op
   g==;
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="29859459"
IronPort-PHdr: =?us-ascii?q?9a23=3A0so1bh1/l04mRkPSsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMULPad9pjvdHbS+e9qxAeQG9mCsLQd0rud7/GocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBmrqQjducYbjI9/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXxuV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4TMQiQ2RytyY7zL0LoY?=
 =?us-ascii?q?a7fSgWyJQnwB7fbeaLc4+S4hLsUuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0MxSww+n9FdV9ypkeVnmVDa?=
 =?us-ascii?q?KCKqPdr0KH5uI1LOmQfoMapDH9K/097f70kXA5gUMdfbWu3ZYPc3C3APBmI0?=
 =?us-ascii?q?SfYXrxjdYMCnkKvgUgQ+zwklGCUiBcZ2y0X60i4jE3EoWmDZ3MRtPlvLvU5C?=
 =?us-ascii?q?qnBNVyb31aEFqFGnegI52AUuoQciibCtVsnjwNSf6qTIp3kVm1uQv7zad3Bv?=
 =?us-ascii?q?Tb9zdetp/50tVxoerJmkIc7ztxWv+B3nmNQmc8pWYBQzs7zegrukBm4kuS2q?=
 =?us-ascii?q?h/xfpDHJpc4O0fAVRyDoLV0+EvU4O6YQnGZNrcDQ/8E9g=3D?=
X-IPAS-Result: =?us-ascii?q?A2BcAgBAGMRd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LGxUATIqhCmPF1QGgTaJZI9cgWcJAQEBAQEBAQEBJw0BAgEBhEACh?=
 =?us-ascii?q?A4kOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFVELDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYJSJQ+zFYEyhU6DLoFIgQ4ojBQYeIEHgTiCaz6ELYMogl4Ej?=
 =?us-ascii?q?RKIVGFFcoZejyiCLoI2hGGOJAYbgy6NPIkIjkaIMZNKIoFYKwgCGAghD4MnC?=
 =?us-ascii?q?UcRFJBBGBWIT1FshCAjAzCBBQEBkCIBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Nov 2019 13:17:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA7DHZMK028771;
        Thu, 7 Nov 2019 08:17:36 -0500
Subject: Re: [PATCH v2] python/sepolicy: Revert "Only invoke RPM on
 RPM-enabled Linux distributions"
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <4ccc28b3-4e2c-e287-6d3e-4738e27bbbb3@tycho.nsa.gov>
 <20191107102337.1087390-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <694bb4e1-b0f4-ef3b-e311-f40552499c9e@tycho.nsa.gov>
Date:   Thu, 7 Nov 2019 08:17:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107102337.1087390-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/19 5:23 AM, Petr Lautrbach wrote:
> Commit 73b7ff410c1b ("Only invoke RPM on RPM-enabled Linux distributions") used
> platform.linux_distribution() function to detect whether the system is rpm
> based. This function is deprecated since Python 3.5 and it's removed from Python
> 3.8 - https://bugs.python.org/issue28167
> 
> The original problem is already fixed by another commit
> 671f83b42ba2 ("policycoreutils/sepolicy: Check get_rpm_nvr_list() return
> value"):
> 
>      $ sepolicy generate --customize -p mypolicy -n testpolicy -d httpd_sys_script_t -w /home
>      Failed to retrieve rpm info for selinux-policy
>      Created the following files:
>      mypolicy/testpolicy.te # Type Enforcement file
>      mypolicy/testpolicy.if # Interface file
>      mypolicy/testpolicy.fc # File Contexts file
>      mypolicy/testpolicy_selinux.spec # Spec file
>      mypolicy/testpolicy.sh # Setup Script
> 
> Fixes:
>       File "/usr/lib/python3.8/site-packages/sepolicy/generate.py", line 1384, in generate
>         if (platform.linux_distribution(full_distribution_name=0)[0] in ("redhat", "centos", "SuSE", "fedora", "mandrake", "mandriva")):
>       AttributeError: module 'platform' has no attribute 'linux_distribution'
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> The commit hash in the commit message is fixed now.
> 
>   python/sepolicy/sepolicy/generate.py | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> index 973edb9d6b91..e8d07e7d65a9 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -26,7 +26,6 @@ import re
>   import sepolicy
>   from sepolicy import get_all_types, get_all_attributes, get_all_roles
>   import time
> -import platform
>   
>   from .templates import executable
>   from .templates import boolean
> @@ -1178,8 +1177,7 @@ allow %s_t %s_t:%s_socket name_%s;
>                   newsh += re.sub("TEMPLATETYPE", self.name, t1)
>   
>           newsh += self.generate_user_sh()
> -        if (platform.linux_distribution(full_distribution_name=0)[0] in ("redhat", "centos", "SuSE", "fedora", "mandrake", "mandriva")):
> -            newsh += re.sub("TEMPLATEFILE", self.file_name, script.rpm)
> +        newsh += re.sub("TEMPLATEFILE", self.file_name, script.rpm)
>   
>           return newsh
>   
> @@ -1379,7 +1377,6 @@ Warning %s does not exist
>           out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
>           out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))
>           if self.type != NEWTYPE:
> -            if (platform.linux_distribution(full_distribution_name=0)[0] in ("redhat", "centos", "SuSE", "fedora", "mandrake", "mandriva")):
> -                out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
> +            out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
>               out += "%s # %s\n" % (self.write_sh(out_dir), _("Setup Script"))
>           return out
> 

