Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A7C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FEA205F4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="e4Rlb5jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfIRM2n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:28:43 -0400
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:19205 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIRM2n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 08:28:43 -0400
X-EEMSG-check-017: 14911864|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="14911864"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 12:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568809719; x=1600345719;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y4BR6f1LzTDYgMQhXwQWDHgpwyC5vGw0wbNJxAHKSnY=;
  b=e4Rlb5jZ53yF66PFCBp3yKtAiQwvvI5RK+ZK4hHsBmQsX/W/GnVcNxPz
   UVrGS1lsJWnEHV/WwYsk78mv+HupKWXdHY7YIJxMBWidDsGRQOZ1GqHcG
   SMjq9S9Em7p+pDHn5Nxlkdf9zyzQ1DE8pQkxjhw0VshrteXwune8rq5fC
   4Vd2H4oZpeIXk+sc7t+K0aDh7cbW5J7V1pLp6m0geu9UfguSpOMleK8GI
   H4W/7Pqe90jzM5Tx1jLcxWbwjXo089+xJEwpexETH1A76WctWWF4kjPed
   j1xlIhYZgc+G5WasA/Uxuq8P2TiJQEcciQT+LIQSaIpoz+ljZyD3vm1hi
   A==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="32996887"
IronPort-PHdr: =?us-ascii?q?9a23=3AYlD/yxbjjZlcx7CA1sOyA6z/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps28bR7h7PlgxGXEQZ/co6odzbaP6Oa5CSddud7B6ClELMUWEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/JKs90A?=
 =?us-ascii?q?bFr3hHd+lW2W9jOFafkwrh6suq85Nv7jpct+g9+8JcVKnxYrg1Q6FfADk6KW?=
 =?us-ascii?q?4++dfltQPETQuB53scVnsZnx9VCAXb7x/0Q4n8vDLiuuVyxCeVM8v2TaspWT?=
 =?us-ascii?q?u59KdkVAXoiCYcODEn9mzcl9F9g7haoBKloBx/3pLUbYSIP/dwYq/RYdUXTn?=
 =?us-ascii?q?dPUcZLUyxKH52yYY0BAeEcOepUtofwql8LoRa4GAKiBv7gyiVQi3Hrw6M63e?=
 =?us-ascii?q?QvHwLI0gMuEN0BsmjbotruOacOU+241rXEwSnNYv5U3zr29YjGcgomofGJRb?=
 =?us-ascii?q?9+bNbRxlc3FwPFkFqQr5HuMS6Q1usXt2ib6/RvVOKygGMgsAF+vyOvy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoh4Qts6Tm11tys3xacKtJ?=
 =?us-ascii?q?6mcCQQ1pgqyADTZ+aaf4WO/xntTvyeIS1ii3JgYL+/ghGy/lW+xeDkTcm01U?=
 =?us-ascii?q?pKrjJCktnRqnABzxzT5daDSvt65kqhxSyA1xrS6uFZOkA4j7bbKp49zb4wkZ?=
 =?us-ascii?q?ofq0LDETPtmErqlqOWc0Qk+uyw5+TmZLXpuIOcOpdphgzxPakigMyyDfkiPg?=
 =?us-ascii?q?QQUGWX5/6w2KD78U38WrpKj/k2kqfDsJDdIMQWvrW5DBJO0os49xa+Dyup0N?=
 =?us-ascii?q?QfnXUdKlJFYwiIg5LmO1HJPvD0Fe2/jEi0kDd32/DGOaXsA5TNLnfZlrfhcq?=
 =?us-ascii?q?xx60pdyAo10NxS5olZC7AdIP3tQEP+qNvYDhojPwOoxebtEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUeS6eIyJ+mBf5cVtyzgK/gh/vLuiHg5mVgHfaa3x5cYdHe4HvF+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmUuPqkEeNUSRSZ3apRK88/is0CJinDYfYXoCthKaO0z?=
 =?us-ascii?q?ulEZFMYWBGEF+MG2/yd4qYQ/cMdD6SIsh5nzwfS7ehT44h1ReztA710LdnMO?=
 =?us-ascii?q?XU9TMCtZ7519h6+ffTlRcs+jxwFcid1HuNT25slGMSWzA2xLx/oVB6ylqb3q?=
 =?us-ascii?q?l4nuJXGcZS5vNJUwc6NZncz+p1C93pWwPBYsmGREy6TdWhBDE9VM4+w9kWaU?=
 =?us-ascii?q?ZnB9qilgzD3zatA7INmb2EHpo08q3G03nxJsZwy3LL2bIgjlk6XMRDL3Gphq?=
 =?us-ascii?q?l69wTJG4HJlV2Tl7y2eqQEwC7N6GCDwHKMvEFZSgFwV6rFUWoQZ0vLs9v46U?=
 =?us-ascii?q?LCT7m1BLUmLgtO19SOJbdNat3sl1lJWPHja5ziZDejm262ChKJwPvYforjfW?=
 =?us-ascii?q?pb2CTbURYsgRweu32BME41AHHl63rXEThGDVvyZwbp9u5kpTWwSUpn4RuNah?=
 =?us-ascii?q?hay7et+hMTzceZQvcX06NM7DwtsB1oDV292JTQENPGqA1/KvYPKegh6UtKgD?=
 =?us-ascii?q?qK/zd2OYateuU511M=3D?=
X-IPAS-Result: =?us-ascii?q?A2DOAABnIYJd/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qgUAyKoQij18BAQEGgTaJdI9BgWcJAQEBAQEBAQEBNAECAQGEPwKDAyM3B?=
 =?us-ascii?q?g4CDAEBAQQBAQEBAQUDAQFshTmCOimCZwEBAQECASMVQRALGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+BdwUPsE6BMoVMgy+BSYEMKAGMCBh4gQeBOIJrPoQNEQ6DI4JYB?=
 =?us-ascii?q?JV6ln6CLIIukk8GG5kgLY1imxkigVgrCAIYCCEPgydQEBSBWheOPiQDMIEGA?=
 =?us-ascii?q?QGNGgElgi4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Sep 2019 12:28:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ICSZ6l007620;
        Wed, 18 Sep 2019 08:28:37 -0400
Subject: Re: [PATCH] selinux: improve performance of sel_write_load()
To:     zhanglin <zhang.lin16@zte.com.cn>, paul@paul-moore.com
Cc:     eparis@parisplace.org, selinux@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
References: <1568704836-14357-1-git-send-email-zhang.lin16@zte.com.cn>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8224bb2e-98e9-1ed6-3e0f-a7a75607051d@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 08:28:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1568704836-14357-1-git-send-email-zhang.lin16@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/17/19 3:20 AM, zhanglin wrote:
> remove unecessary multiplications of sel_write_load().

I'm not sure it is really a performance improvement since the compiler 
generates the same code (at least on x86_64).  I'm wondering though 
whether we still need this check at all.  It was originally patterned 
after a similar check for loading kernel modules, which was removed in 
f946eeb9313ff147075 ("module: Remove module size limit").

> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> ---
>   security/selinux/selinuxfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f3a5a138a096..4b2d87b6fcf9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -117,6 +117,7 @@ static void selinux_fs_info_free(struct super_block *sb)
>   #define SEL_CLASS_INO_OFFSET		0x04000000
>   #define SEL_POLICYCAP_INO_OFFSET	0x08000000
>   #define SEL_INO_MASK			0x00ffffff
> +#define SEL_LOAD_MAX			0x04000000
>   
>   #define TMPBUFLEN	12
>   static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
> @@ -550,7 +551,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>   		goto out;
>   
>   	length = -EFBIG;
> -	if (count > 64 * 1024 * 1024)
> +	if (count > SEL_LOAD_MAX)
>   		goto out;
>   
>   	length = -ENOMEM;
> 

