Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02CC43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BAC20674
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O5koy3iD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfKLOf4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:35:56 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:42553 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfKLOf4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 09:35:56 -0500
X-EEMSG-check-017: 47633912|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="47633912"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 14:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573569355; x=1605105355;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9liI6RLCogZBFokU1DZSVU4g8mBobQdnoH2r1miNYcM=;
  b=O5koy3iDN7NyPnjyAFFGjuY5OOtcduAEwICVrGDvjVXZGMnDBTS8taqC
   cjMVJ3UVR+QCu4gg6juqKlGBLw5enGVfQEL/1YYWzUK6ictAgHu9ZRkcl
   icpRfN5Up9SAnVle9Cioyq3FYp6T+67S1I6WvkvMKGmRbEaDtAzcfpbli
   VCug1vwrL92ZPm9gXR55hIsqa1xSEyqtJPSBuWBWKZmEEfbe7tfOwEbS1
   l9CUSgnUoTJW+ZYn2+4kvjOWJQ2/A1e3kHgoROB8wTLykHcl2GGjq6IrX
   9/NNUDa63jSy7i0ACAp05C26KcsseMluTtzNUihF00FLVlWmvI800hIsg
   g==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="35388001"
IronPort-PHdr: =?us-ascii?q?9a23=3A5reVgR+OkojtDP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20ewcTK2v8tzYMVDF4r011RmVBN6dsqgVwLSL+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanfL9+MhG7oQrQu8QWnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uo5f5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRa?=
 =?us-ascii?q?9+cdbPxkk3FwPKkFOQopH4MTOQzOsNt2yb4PRgVOmyjGMnsBx+oiO0y8cwio?=
 =?us-ascii?q?jGmoIVylfe+SV/24Y6P8e0SEF8Yd66CZZdsTyROYVxQsMnWW5ouSA6x6UeuZ?=
 =?us-ascii?q?+7YCgKyJMnxxjFZ/yAaYiI7RTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWAN450lg7+MqMulta5AeskKQ?=
 =?us-ascii?q?gBQ3KX+eG91L3n5UH5QbNKgeMqkqTBrZzXKssWqrS5DgNIyIov9RmyAym83N?=
 =?us-ascii?q?gFhXUHKUhKeBODj4jnIVHOJ/X4AO+kg1uxizdm3OzGP739DZXNKXjPirHhfa?=
 =?us-ascii?q?1n5EJGxwozys5f64pOCr4dOPLzRlPxtNvAAx8hNwy72fvnCMln1owFQ22CGb?=
 =?us-ascii?q?WZP73Pvl+I/O0vP/OAa5MSuDb4M/Il/eLhjWclmV8BeqmkxYAXZ268HvRnJU?=
 =?us-ascii?q?WZfHXtj8wfEWcFoAU+VvbmiF6cXj5JYXa9QaY86is8CIK8AoeQDryq1YSMwD?=
 =?us-ascii?q?3zOpRLenpMA1uMWSPwc4yZR+0GYQqIL8NhmyBCXr+kHctpzhyqtQnn25J5Ie?=
 =?us-ascii?q?fOvC4Vr5Tu0J5y/eKAuws18GlPE8mF02yLB1pxl2cMSi5+iLtzumRh21yD1u?=
 =?us-ascii?q?5+mPUeGttNsaAaGjwmPILRmrQpQ+v5XRjMK5LQEger?=
X-IPAS-Result: =?us-ascii?q?A2AUAgCtwcpd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LGxVMiqEKY8FVAaBESWJZo9cgWcJAQEBAQEBAQEBJw0BAgEBhEACg?=
 =?us-ascii?q?h0kOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFVELDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYJSJQ+vMYEyhU6DMoFIgQ4ojBQYeIEHgTgMgl8+hC2DKIJeB?=
 =?us-ascii?q?I0XiFhhRXOGX48pgi+CNoRhjicGG4MvjT6JDI5HiDaTUSKBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?wlHERSQQRgViE9RbIQgIwMwgQUBAZBXAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Nov 2019 14:35:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACEZrsH022782;
        Tue, 12 Nov 2019 09:35:53 -0500
Subject: Re: [PATCH v2] python/sepolicy: Revert "Only invoke RPM on
 RPM-enabled Linux distributions"
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <4ccc28b3-4e2c-e287-6d3e-4738e27bbbb3@tycho.nsa.gov>
 <20191107102337.1087390-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <27f9d7f7-5481-a229-906b-4c34d42e115c@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 09:35:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
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

Thanks, applied.

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

