Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED90BC433EF
	for <selinux@archiver.kernel.org>; Fri, 14 Jan 2022 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiANTo0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiANToZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jan 2022 14:44:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74999C06173E
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 11:44:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso7578344wmd.5
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=NC94UKEH4E6rP1nDiXrKKk/+Ee1IAybdbP5bOp0+J+o=;
        b=QTS0F5YUXkNhnD/dhnDk4IrgPadGu2hGDaa6pcpZRHI6+67yBuaR9j3FvgCRgUPaXM
         neMZqtPdz9yFXfq9FV82Zv3OE0/bzlyD8RlSHbLSmkOH4eNkIWogfElJurDtI6ddDxX8
         5wATMXbZzC+yQTgNYcDGXDUU10+FSBwiSBUpsliHdw/VEGwLKbaT1A60JM+a4jEecTaZ
         /Wyow6cZ0XF6KgF/FQQKFLN1XA7NfjMZnCaZz0iBgcUnxvQGd9nKppHftG3bJrLbMOfg
         Qn8e0/293ZemRI/CIv2/KcLk61ooCP+Il1MKcnH9HbGJJFran3c5DPl20mBnpq4ui3OZ
         gXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=NC94UKEH4E6rP1nDiXrKKk/+Ee1IAybdbP5bOp0+J+o=;
        b=aB0xpyP0gp8BHwIXH1arPm0rHuPC09+ZMLIVcV8EN3ZaGi5Lbp3uBbhYSq0KsHc1a1
         nA2Js82yxPCKV64R6pOFH8m/N76YDeF1PhEeeOxqP++k6E7wBiCXtlyUM34enImv3iAH
         eZkWp6fN2yWr9mhl+NT211YkZ3n6U1Xr8YYF/eZlSMYeEOyfOHWm2qyYFiWTWdkNc3Lt
         v0P6rBNx6vwL68mqHZovf8SJnoALLRG47VjMqKWm8Pryav1hK1AvKx117PwBky8Xs+RE
         75Ht3/ITH/JZLT/+jQbasZsElKp+YHDPrKFpnRr7Qo+iCh4Ay6EM7pFGdAUQm/O0cNtd
         Me6w==
X-Gm-Message-State: AOAM532bonxatGwvUogBzTcE9GtXYZcW1A41GZbXr2p76KeyB5Ict3O6
        B5cazNbuYZARTVeckx7rTSM=
X-Google-Smtp-Source: ABdhPJyTKpVVP3tAEoFxua4i33R2w+chaVMP1PTgLnZqnQuhe6u5VUS+7LTvAjtcEvTcNzYShAK8ag==
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr4566169wrp.712.1642189463978;
        Fri, 14 Jan 2022 11:44:23 -0800 (PST)
Received: from ?IPV6:2001:a61:35cd:c301:2e0:4cff:febf:22de? ([2001:a61:35cd:c301:2e0:4cff:febf:22de])
        by smtp.gmail.com with ESMTPSA id b13sm6203488wrh.32.2022.01.14.11.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 11:44:23 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <dd96ca20-2f8f-ea6c-48b8-6649915fac1c@gmail.com>
Date:   Fri, 14 Jan 2022 20:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] libsepol/cil: Limit the amount of reporting for
 neverallow violations
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20220114192002.730773-1-jwcart2@gmail.com>
In-Reply-To: <20220114192002.730773-1-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

as a heavy user of neverallow / neverallowx, please don't limit this.

When adding a new neverallow rule there might quite a few types violating them, and having to rebuild the policy every 2 types would make fixing them incredibly annoying.

If you want to limit this, then please make it opt-in or add it as a command line option.

On 1/14/22 20:20, James Carter wrote:
> When there is a neverallow violation, a search is made for all of
> the rules that violate the neverallow. The violating rules as well
> as their parents are written out to make it easier to find these
> rules.
> 
> If there is a lot of rules that violate a neverallow, then this
> amount of reporting is too much. Instead, only print out the first
> two rules (with their parents) that match the violated neverallow
> rule along with the total number of rules that violate the
> neverallow.
> 
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>   libsepol/cil/src/cil_binary.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 4ac8ce8d..04a5d053 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4640,6 +4640,8 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
>   	char *neverallow_str;
>   	char *allow_str;
>   	enum cil_flavor avrule_flavor;
> +	int num_matching = 0;
> +	int count_matching = 0;
>   
>   	target.rule_kind = CIL_AVRULE_ALLOWED;
>   	target.is_extended = cil_rule->is_extended;
> @@ -4666,11 +4668,19 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
>   		goto exit;
>   	}
>   
> +	cil_list_for_each(i2, matching) {
> +		num_matching++;
> +	}
>   	cil_list_for_each(i2, matching) {
>   		n2 = i2->data;
>   		r2 = n2->data;
>   		__cil_print_parents("    ", n2);
>   		__cil_print_rule("      ", allow_str, r2);
> +		count_matching++;
> +		if (count_matching >= 2) {
> +			cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
> +			break;
> +		}
>   	}
>   	cil_log(CIL_ERR,"\n");
>   	cil_list_destroy(&matching, CIL_FALSE);

-- 
bauen1
https://dn42.bauen1.xyz/
