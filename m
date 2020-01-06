Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5BC33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DECE207FF
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jDSEVkNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFQTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:19:41 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:64233 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQTk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 11:19:40 -0500
X-EEMSG-check-017: 66175892|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="66175892"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 16:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578327577; x=1609863577;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+HBmSC8iDwk24yA1GMUKJVGXzvlel1xCVDaaM3OTux4=;
  b=jDSEVkNLJ/ueuWU1/R+V5+rq6XhL8fiKn/uCqgtLEONsMrpwcBFOTgSV
   6CGR9+bvJMqBTj0eqS/IqcrNdlVW6TsowZ/1QX3sFrcU/VC78YBlbtx5L
   ouOGtaWF8MWZfFoz0sz38IG+eGmELTSKnNZ2v7PWvyZRpCDbhvl7j+97A
   vc2atXNcIxIsn5S+iw9XcsYc03hxxvdlmFKrszYZhi3MxhzMpr8rFPMoQ
   tUEW0xjCeahK2fFpEIEQ8dmZlRIUu6er1p3OitBtin9+Rf8Hr98hZmYqA
   tbUscFi/9TPQ9VtD1w2EoMk2cHPEd7ULj8McDAgDG8OsCOC95b7o6MliP
   g==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="31627678"
IronPort-PHdr: =?us-ascii?q?9a23=3AGwuu8xwlbTrX4uzXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4RK/ad9pjvdHbS+e9qxAeQG9mCsLQe1rKd4/6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBi2sQnducobjIp/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXxuV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIvwt9F/JJbFLEALenoWkDttNzXFAI5MwKww+n5EtVxz58RVniVDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuA56PH0ln82h18ccbOy3ZQLaHC3BOlmI0?=
 =?us-ascii?q?udYXXymNcMCmYKvgwiTOP0jF2OSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGB3i?=
 =?us-ascii?q?K7HppMZmBcC1CMCmzld4OeVPcJdi2SI9VtkjseVbiuU4Uhzw2htBfmy7p7Ke?=
 =?us-ascii?q?rZ4ikYtZPl1Nho6OzfjAoy+iJoAMSAyWGNTn10n2MRSz8z26BwvFF9ylOd3q?=
 =?us-ascii?q?VjnfxYGsJc5+lTXgc5K5Hc1ep6BM72Wg7bedeJUlmmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtW5kB/D2yuqA7kIl72EH5E07K3c0GbrJ8pnyHbJyrMhj184TctLL2Gmgb?=
 =?us-ascii?q?R/9wfLDY7Tj0qZj7qqdbgb3CPV92eM03SBvFpEXw53VqXFXmsSaVfWrdTj4U?=
 =?us-ascii?q?PCSr6uCakiMgdbzs6CMKRKYMXzjVpaXPfjJMjeY2WplmeyAhaIxrWMYJDoe2?=
 =?us-ascii?q?Ua3CXSEk4EkxsN8naALgUxGj2uo2TZDDxoFFLgf1nj8e1kpHynSU80yhmAb1?=
 =?us-ascii?q?d92Lqt5h4VmfucRusL3r0avichpCh0HFe7397PCNqPuRBhfKNCbtM5+1pH1H?=
 =?us-ascii?q?vVtwh6Ppy+Ma9unEUefB50v0PzzRV4EJ9Mkc40o38wzgpyMbqS0EldeDOAwZ?=
 =?us-ascii?q?DwJrrXJ3Hq/B+1dq7W3krT0M6M9acS7PQ0slDjvAauFko47XprycVa03yZ5s?=
 =?us-ascii?q?aCMA1HepvqX1d/zBN6rqzUZiQnr9ff3GZhIIGvuT/LxtwtCfFgwR/mdNBaZu?=
 =?us-ascii?q?fMHwbpHtxcHMOuIfEkn1WzRhMCIO1WsqUzOofudf6BwrSqJ85mlTerjCJA+o?=
 =?us-ascii?q?85mkaN8TdsD/XF1Isfwu2Jmw6AWyr4gX+/vc3t34NJfzcfGiy40yegTJVcYq?=
 =?us-ascii?q?x0YJYjF2ijOYu0y894ipqrXGRXp3C5AFZT49OkYRqfaRTG2ARU0UkG6Si8lT?=
 =?us-ascii?q?CQ0y1/kzZvqLGWmiPJ3bKxJ1I8JmdXSTw63h/XKo+ugoVfBRL5Yg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CxAADeXBNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWsEA?=
 =?us-ascii?q?QELAYF8gWwBIBIqhAmJA4ZiAQEEBoESJYlukUgJAQEBAQEBAQEBNwEBhEACg?=
 =?us-ascii?q?g03Bg4CEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjBBFBEAsYAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfP4JTBSCsX3V/M4VPgyiBPYEOKAGMMnmBB4ERJwwDgl0+h?=
 =?us-ascii?q?1mCXgSWNWFGlz2CQIJFk08GG5pbjlOcaSOBWCsIAhgIIQ87gmxQGA2NHheOQ?=
 =?us-ascii?q?SMDMI5nAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jan 2020 16:19:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006GIsBc229396;
        Mon, 6 Jan 2020 11:18:56 -0500
Subject: Re: [PATCH 24/25] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-25-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <663ff9d1-f666-2962-2a59-abca5f90ab1a@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 11:22:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-25-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:'
>          lsm1\0value\0lsm2\0value\0...
> This entry is not writable.

My takeaway from the earlier exchange with Simon on v12 was that we 
should either define a new LSM hook for /proc/pid/attr/context that is 
guaranteed to return a value in a consistent format with SO_PEERCONTEXT 
or fix AppArmor to return consistent results from its existing 
getprocattr hook (particularly with respect to the newline character).

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-api@vger.kernel.org
> ---
>   fs/proc/base.c      |  1 +
>   security/security.c | 27 +++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 950c200cb9ad..d13c2cf50e4b 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "keycreate",		0666),
>   	ATTR(NULL, "sockcreate",	0666),
>   	ATTR(NULL, "display",		0666),
> +	ATTR(NULL, "context",		0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/security/security.c b/security/security.c
> index 80539dfd0245..e94de64e114c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2099,6 +2099,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   				char **value)
>   {
>   	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	int rc = 0;
> +	int finallen = 0;
>   	int display = lsm_task_display(current);
>   	int slot = 0;
>   
> @@ -2126,6 +2130,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   		return -ENOMEM;
>   	}
>   
> +	if (!strcmp(name, "context")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +				     list) {
> +			rc = hp->hook.getprocattr(p, "current", &cp);
> +			if (rc == -EINVAL || rc == -ENOPROTOOPT)
> +				continue;
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
> +					cp, rc);
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +		}
> +		if (final == NULL)
> +			return -EINVAL;
> +		*value = final;
> +		return finallen;
> +	}
> +
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> 

