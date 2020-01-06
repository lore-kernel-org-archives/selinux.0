Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F5C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E53420731
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mej2kPeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgAFVZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:25:55 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:9937 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgAFVZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 16:25:54 -0500
X-EEMSG-check-017: 63304281|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="63304281"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 21:25:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578345952; x=1609881952;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DvKwP+zm9yWcM/KI0EUJvVJldh/ba0CFm6Nx9gWe4uM=;
  b=mej2kPePXTLRqyaMlVE4vLV4xeqFZ/SCTAl+MFJkM3iSq4SZiKGPko8F
   7hBxtXP03AhDvxjCNF2AHJTmcoeBD0h3RyfDRGs6yf9oD4XkvTktoWpvk
   06UeLGrRNZSxmwswBYd+e/EtODRnhJmFrfKk3uaSde6VtqHkWURINcSPX
   oc1UZp3eq/cQo5Lz/aeZG6zzICFKuzMMaYF6MubaW3UUvceYKn/l5nAZr
   0cP2EiphsZ/k4Qahi8OgO/SLsIK3fAIznmAuG0hFIm1gMM1DgRQZN+GxM
   8qh/16r7LPjcBkxpzxrw0tjXEc/CA8zXp+noa/lV83sXrDMrhcOxRJTJ0
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="37406374"
IronPort-PHdr: =?us-ascii?q?9a23=3AxkKjwhdruxGl6lhTa6hIF0mmlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcWzZx7h7PlgxGXEQZ/co6odzbaP6Oa6BDRLuMrR+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgZduJqksxh?=
 =?us-ascii?q?bGoXZDZvhby35vKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXG?=
 =?us-ascii?q?ZNQ9pdWzBEDo66YYQPFe4BNvtGoYf7qVUFsB+yCRCiCe7rzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzIwRIuH9wOvnrXotv6OqgdXuKpw6fH1jjDc/Fb1C3h5ITUfB0so/eBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgEiMqYP7JzOV1voCs26G5OR9UOKgkWonqwVvrTmv28whjZ?=
 =?us-ascii?q?LJiZ8Oyl3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?ASsUTFEC/2n172g7GKeUk+5uip6/joYrXhppOGMY97lhr+Pbg0lsy6AOQ4Nh?=
 =?us-ascii?q?ACX2md+euiyL3u5VD1TbpFg/EskqTVrYrWKdoUq6KnGQNZz54v6xOlADen1N?=
 =?us-ascii?q?QYk2MHLFVAeB+flIjmJkrOLevkDfa/n1uskDBry+rAPr36GJrBNHfDkLD/fb?=
 =?us-ascii?q?pl8U5T1BIzzcxD55JTErwBOOj8WlL1tNHDFh82KRG0w+L+BNV40YMeXniPDb?=
 =?us-ascii?q?GDPKzOtl+I4/olI/OQa48NpDb9N/8l6ub1jXAnnV8dfK+p3YYYaX2jAPRmLF?=
 =?us-ascii?q?uWYWD2jtcCD2gKpAw+Q/LuiFGYVj5TfXmyVbom5j4nEIKmEZvDRoe1jbyF3S?=
 =?us-ascii?q?e7GIBWZ29fBlCXD3jna5iEW+0NaCKOIs5tizkEVb+8RI880RGhqhT3y6RoLu?=
 =?us-ascii?q?XK4C0Ur5Hj28Zv5+3Vix4y8SZ4D8OH02GCHClImTYwTiIylIV4plZwggOb2L?=
 =?us-ascii?q?V8q+RRCNgW4vROSAp8PpnZmagyEN32WwTcbv+XR1u8BNarGzc8SpQ22dBdTV?=
 =?us-ascii?q?x6HoCZkh3b3yesS4QQnriPCY18prnQxFDtNs19zDDAz6BngF44FJgcfVa6j7?=
 =?us-ascii?q?JyolCAT7XClF+UwuPzLvUR?=
X-IPAS-Result: =?us-ascii?q?A2DaAgAVpRNe/wHyM5BcChwBAQEBAQcBAREBBAQBAYF8g?=
 =?us-ascii?q?X2BbAEgEiqECYkDhmUBAQQGgTeBAYhtj2GBZwkBAQEBAQEBAQE3AQGEQAKCD?=
 =?us-ascii?q?TgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/glMlrWWBMoVPgyiBPYEOKIwzeYEHgREnD4IoNT6EHhODKIJeBI0li?=
 =?us-ascii?q?RBhRpc9gkCCRY5UhHsGG4JGMIdNkBiOU5xqIoFYKwgCGAghD4MnUBgNm3YjA?=
 =?us-ascii?q?zCOZwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Jan 2020 21:25:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006LPGfw119434;
        Mon, 6 Jan 2020 16:25:16 -0500
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
References: <157678334821.158235.2125894638773393579.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a5794ae2-d1e3-4ad3-6a16-2d479f33da16@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 16:26:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157678334821.158235.2125894638773393579.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/19 2:22 PM, Paul Moore wrote:
> Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> code was originally developed to make it easier for Linux
> distributions to support architectures where adding parameters to the
> kernel command line was difficult.  Unfortunately, supporting runtime
> disable meant we had to make some security trade-offs when it came to
> the LSM hooks, as documented in the Kconfig help text:
> 
>    NOTE: selecting this option will disable the '__ro_after_init'
>    kernel hardening feature for security hooks.   Please consider
>    using the selinux=0 boot parameter instead of enabling this
>    option.
> 
> Fortunately it looks as if that the original motivation for the
> runtime disable functionality is gone, and Fedora/RHEL appears to be
> the only major distribution enabling this capability at build time
> so we are now taking steps to remove it entirely from the kernel.
> The first step is to mark the functionality as deprecated and print
> an error when it is used (what this patch is doing).  As Fedora/RHEL
> makes progress in transitioning the distribution away from runtime
> disable, we will introduce follow-up patches over several kernel
> releases which will block for increasing periods of time when the
> runtime disable is used.  Finally we will remove the option entirely
> once we believe all users have moved to the kernel cmdline approach.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   security/selinux/Kconfig     |    3 +++
>   security/selinux/selinuxfs.c |    6 ++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 996d35d950f7..580ac24c7aa1 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
>   	  using the selinux=0 boot parameter instead of enabling this
>   	  option.
>   
> +	  WARNING: this option is deprecated and will be removed in a future
> +	  kernel release.
> +
>   	  If you are unsure how to answer this question, answer N.
>   
>   config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 278417e67b4c..adbe2dd35202 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>   	int new_value;
>   	int enforcing;
>   
> +	/* NOTE: we are now officially considering runtime disable as
> +	 *       deprecated, and using it will become increasingly painful
> +	 *       (e.g. sleeping/blocking) as we progress through future
> +	 *       kernel releases until eventually it is removed */
> +	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");

Looking for examples of similar deprecations in the kernel, I notice 
that they often use pr_warn_once() or WARN_ONCE() to avoid spamming the 
kernel logs excessively.  They also often include the current process 
name to identify the offending process.  In this case, it probably 
matters little since this is only done (legitimately) by the init 
process and only once, so up to you whether you bother amending it. 
Also for some interfaces, they appear to document the intent to remove 
it in a file under Documentation/ABI/obsolete/ and then later move that 
to removed/ when fully removed. Regardless,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> +
>   	if (count >= PAGE_SIZE)
>   		return -ENOMEM;
>   
> 

