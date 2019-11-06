Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F327C5DF63
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EA82067B
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="JKeFsg+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfKFQul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:50:41 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:29091 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbfKFQuk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 11:50:40 -0500
X-EEMSG-check-017: 46067013|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,275,1569283200"; 
   d="scan'208";a="46067013"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2019 16:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573059039; x=1604595039;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VtIEogTC72TZ6Rn0Zj8DvN8W2lv1xSa/wgME/L20gMo=;
  b=JKeFsg+GZpxC0VTaCMFSAzQ3gN7CmehpXPXJmnnyLEVEZesdvUTF1AIC
   aTcdExXcMLQHcgbFoIFfdWcwcQfzXvmSZ10Dw+nq9gebw40sFOww3e0aY
   42RuTxuW4v6hPOvcoEtgXV06U8U8/EN+Vo+jAGD+oB+N4Jl0Mrbk0qTt6
   t1vdGYmJGKFrG7wi9mIBbmc59zY9fN8N7DQvkDsrqcWfsGvGrbUjHWgNo
   8UkyG09KCtvISdRhFEK7Nwf83EAflqODQ86hCL6JCn7NXoGgYDPSNKXCe
   rk2GmEtR/8H00tn5uiOdVCdImXVhtChE/2oHtlRjCNoVmTIxPNwvf/bgq
   A==;
X-IronPort-AV: E=Sophos;i="5.68,275,1569283200"; 
   d="scan'208";a="35197983"
IronPort-PHdr: =?us-ascii?q?9a23=3AmPAFChDfJb9vg8ZXmHdPUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX5ocbcNUDSrc9gkEXOFd2Cra4d0KyP6v+rCDZIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQnMtMQajo9vJrgswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZDAKyZQ7xx7fbPyHdZKE4hX5VOaeJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kB3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OUHSA+eugzrHj+Ez5QLFSgv03lKnWrozaKNwGqqO2DAJZyIYu5wulAzu439?=
 =?us-ascii?q?kUg2MLIE9ddBKClYfpOlXOIP7iDfe4hlShiCxryO3dPrD6HpXMLmTMkLfmfb?=
 =?us-ascii?q?pn7U5c0xA8wcpQ55JTFLENOOjzVVPptNzEEh85NBS5w/7jCNpny4MeRXiPDb?=
 =?us-ascii?q?SDP67Jq1+H+P8gI+mWa48JojryN/8l5/v2h38jhVAdZbWp3YcQaH2gBfRpPU?=
 =?us-ascii?q?GZYXvqgtccHmYHpRQ+TOP0h12YSzJTZGi9X7g65j4lDIKqF4DDRpqigO/J4C?=
 =?us-ascii?q?DuJpBKfChiA02QC33hfIXMD+8IYT+OOMVouiYJWbioV8kq0hT48Efhxr5mKP?=
 =?us-ascii?q?fE0jMXuIil19Vv4eDX0xYo+m9aFcOYhlqRQnl0k2VAfDo/2KRysAQp0VuY+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4z8UDw=3D?=
X-IPAS-Result: =?us-ascii?q?A2AvAgDD+MJd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LGxUATIqhCmPFVEBAQEGgTaJZI9cgWcJAQEBAQEBAQEBJw0BAgEBh?=
 =?us-ascii?q?EAChA4kOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJsAQEBAQIBIxVGCwsOC?=
 =?us-ascii?q?gICJgICVwYBDAYCAQGCXz8BglIFIA+wcXWBMoVOgyyBSIEOKIwUGHiBB4E4g?=
 =?us-ascii?q?ms+hC2DKIJeBI0RiFNhRXKGXY8ngi6CNIRhjiEGG4MujTeJB45DiC+TRiKBW?=
 =?us-ascii?q?CsIAhgIIQ+DJwlHERSDERgViE9RbIQgIwMwgQUBAZEDAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Nov 2019 16:50:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA6Goa3R021639;
        Wed, 6 Nov 2019 11:50:36 -0500
Subject: Re: [PATCH] python/sepolicy: Revert "Only invoke RPM on RPM-enabled
 Linux distributions"
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191106105907.1064568-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4ccc28b3-4e2c-e287-6d3e-4738e27bbbb3@tycho.nsa.gov>
Date:   Wed, 6 Nov 2019 11:50:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106105907.1064568-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/6/19 5:59 AM, Petr Lautrbach wrote:
> Commit 8ad76337d09d4b0080275d74392a258ea4ed0273 ("Only invoke RPM on RPM-enabled
> Linux distributions") used platform.linux_distribution() function to detect

That isn't a commit hash from the upstream selinux repo at least as far 
as I can tell from my clone.  The corresponding one is 
73b7ff410c1b2958c5c1f8e26cae5347d56416d4.

Otherwise, looks good to me.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> whether the system is rpm based. This function is deprecated since Python 3.5
> and it's removed from Python 3.8 - https://bugs.python.org/issue28167
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
> ---
>   python/sepolicy/sepolicy/generate.py | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> index 973edb9d..e8d07e7d 100644
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

