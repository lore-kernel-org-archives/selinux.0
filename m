Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9900EC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1902146E
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Cga9Uawo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfLRRnR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:43:17 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:32425 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRnR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 12:43:17 -0500
X-EEMSG-check-017: 61895198|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="61895198"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 17:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576690995; x=1608226995;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GS8HsaeLKhlOx1GDE+aJwqe147RI1w6UlplS4nwA+4k=;
  b=Cga9Uawo8q4/wVDNMW6nzc17GeSkrnw7eNcf1YImg/IZoAf83szlwBG8
   8ySzs4VjMnt/as9jQJCLVzJC9y7g9cQ0ZSK8nJZ3OlyIZIVkInaUJ24NT
   Nx+K6n4b0vtjalAmtyHWK+HcvLs1cvGIW1SA1uxAMpS3Nqvw9EIQ3VEKa
   zUbQH/MWhz1RaoW0ncYOJa8c3I2yATE5BW2bN7FahBPVRHHrr8cR8sGlC
   Or5ZUBlpiwOoXQqVmvgUnLqlt+MYWCNn0iF9Bl8b/0Yg/oIg66Ys74ePx
   N/4smSPZNKOuFCBoSCsJnv3csS5pzMo6hju6a3LqyNo+qjiQqzXuT4pRH
   g==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36919399"
IronPort-PHdr: =?us-ascii?q?9a23=3AXFuSkBwuFZBm31DXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4RK/ad9pjvdHbS+e9qxAeQG9mCsLQe07ud4vGocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBmqqQjduc0bjI9/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
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
 =?us-ascii?q?CQ0y1/kzZvqLGWmiPJ3bKxJ1I8JmdXSTw63h/XKo+ugoVfBRP5Yg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BgAgB/ZPpd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXyBd?=
 =?us-ascii?q?oFtIBIqhASJA4ZZBoE3iWqRRQkBAQEBAQEBAQE3AQGEQAKCPTgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjFUEQCxgCAiYCAlcGAQwGAgEBgl8/glMlr?=
 =?us-ascii?q?guBMoVPgziBQYEOKIwyeYEHgTgPgigHLj6EM4Mmgl4Elw5GlzWCP4JDk0oGG?=
 =?us-ascii?q?5pOjk6cXyKBWCsIAhgIIQ+DJ1AYDZt2IwMwjy0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 17:43:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIHgqnR056762;
        Wed, 18 Dec 2019 12:42:53 -0500
Subject: Re: [PATCH v12 20/25] LSM: Verify LSM display sanity in binder
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-21-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <37a82a11-2e1e-0d01-93c8-6a45763c6bb3@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 12:43:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-21-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Verify that the tasks on the ends of a binder transaction
> use the same "display" security module. This prevents confusion
> of security "contexts".
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/security.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 963641acf9dc..bca092dd4f00 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -738,9 +738,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
>   	return call_int_hook(binder_set_context_mgr, 0, mgr);
>   }
>   
> +/**
> + * security_binder_transaction - Binder driver transaction check
> + * @from: source of the transaction
> + * @to: destination of the transaction
> + *
> + * Verify that the tasks have the same LSM "display", then
> + * call the security module hooks.
> + *
> + * Returns -EINVAL if the displays don't match, or the
> + * result of the security module checks.
> + */
>   int security_binder_transaction(struct task_struct *from,
>   				struct task_struct *to)
>   {
> +	int from_display = lsm_task_display(from);
> +	int to_display = lsm_task_display(to);
> +
> +	/*
> +	 * If the display is LSMBLOB_INVALID the first module that has
> +	 * an entry is used. This will be in the 0 slot.
> +	 *
> +	 * This is currently only required if the server has requested
> +	 * peer contexts, but it would be unwieldly to have too much of
> +	 * the binder driver detail here.
> +	 */
> +	if (from_display == LSMBLOB_INVALID)
> +		from_display = 0;
> +	if (to_display == LSMBLOB_INVALID)
> +		to_display = 0;
> +	if (from_display != to_display)
> +		return -EINVAL;
> +
>   	return call_int_hook(binder_transaction, 0, from, to);
>   }
>   
> 

