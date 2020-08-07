Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE8C433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1F321744
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 15:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHMt9gat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGP1D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGP1C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 11:27:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D9C061756
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 08:27:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so2076421qkf.0
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=W3wAPGfjDvBPU41iH3/3DfgFZ/6wL1o7IuYaLi3lE8k=;
        b=EHMt9gatWcocDpheH7wnPsscoX2Ccau+v3k8mXFCd7F7E1ezrwYBQU9doB81uhM6id
         LJuNrHqDo8mnqUfI4Pzhhdn+t88mnsmvcv0djD5A5CVgcT9ZM9BIhbesZHmuqFThQOcq
         9901DTGjPWjHMwNIMIsVhJXZuAzE+62PEdqKsAEtytQoczxLXxOErBsHR5liqcWqs76A
         XjJQfvaHQFxEaeUQf7O0Xdc4feU1EZaLa+BY3x3PAMtTPCSl9y5MsGPFz0nlnb9f/Q2N
         eP6wIkLzyvfW5sDdAzT2rceLcw77lPrCZ6Rf7uWVvLCLU07a1wI7gLnS4NIONbypRsnO
         eGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W3wAPGfjDvBPU41iH3/3DfgFZ/6wL1o7IuYaLi3lE8k=;
        b=VqGqpPpQC3zgNruxYNnvY2BfUIJSlg98OnK3L3EB0lmQ09yvOpN/2yexXaHPv9afA8
         zFPOROyP+6QGJkxF9v0rjkim2O9y8cbJmQ8cMxwAHpcGKTaFnJmS7ecUG0rjSb6RJpE2
         3hJ4R6NIZBNC01Y5/XgvhtqXrdjHucbn6DovaEQZNU5CKcoiFIdnB1XXttWnvk+LN+bw
         zjkdKnS5cUAgy+8oHb9sdWjfwkOA+QdelaRCr86RXubKn+PVhPUF9kbmGqT/C2vVidyk
         9Ikb0zVfg1VS46NwDhSTyWaYFqIbEKT8beVpY3/p0C/YbcSJuJaFQjebsp4yHRRuqIlm
         NNrw==
X-Gm-Message-State: AOAM530oEXEYOK6TlIKn2VLFbK+6ac7cdxCaqZyLYLxQZELPOi5IS6V4
        TVTrvLlLVZIAVIUlmaHcHFXxpqDb
X-Google-Smtp-Source: ABdhPJxi1WmwQ2cyq8IDdG2S5jGtIEX2jCNf2WE155R8v/P8iLgJxzAz3UKtA4Ee3fwIWAHmVo9Qgg==
X-Received: by 2002:a05:620a:7e9:: with SMTP id k9mr14643505qkk.415.1596814021455;
        Fri, 07 Aug 2020 08:27:01 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id v28sm8876256qtk.28.2020.08.07.08.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 08:27:01 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux-notebook: mls_mcs.md convert and update text
To:     Richard Haines <richard_c_haines@btinternet.com>,
        paul@paul-moore.com, selinux@vger.kernel.org
References: <20200807144025.11668-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <80e38828-1473-5bc5-1b23-067cd242125a@gmail.com>
Date:   Fri, 7 Aug 2020 11:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807144025.11668-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/7/20 10:40 AM, Richard Haines wrote:

> This is an RFC patch to get some feedback as:
> 1) Table 1 is now a pipe table, however it still has <br> codes to
>     break up the text. Also updated styles.html.css to match the pdf version
>     to allow correct HTML rendering.
> 2) Table 2 is now a pipe table with updated text.
>
> Add a TOC to aid navigation
> Add text to clarify MCS/MLS
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>
> @@ -48,6 +56,18 @@ The sections that follow discuss the format of a security level and
>   range, and how these are managed by the constraints mechanism within
>   SELinux using dominance rules.
>   
> +### MLS or MCS Policy
> +
> +From an SELinux perspective:
> +
> +-   An MLS policy has more than one security level with zero or more categories.
> +    It is generally used in systems that require the 'Read Down' and 'Write Up'
> +    services, whether it be for files, network services etc..
> +-   An MCS policy has a single security level with zero or more categories.
> +    Example uses are virtualization (see the
> +    [**Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
> +    section) and container security.
> +

To be clear, SELinux (i.e. the code/mechanism) only knows of MLS, i.e. 
it has a MLS engine in the security server and a MLS portion of the 
policy configuration that drives that engine.  That MLS engine has been 
leveraged by two different types of policies, the original MLS 
configuration modeled after Bell-LaPadula and the later-introduced MCS 
configuration (which underwent a fundamental transformation from being 
user-facing and somewhat discretionary to being a transparent isolation 
mechanism for sandbox, container, and virtualization runtimes). The 
number of sensitivities, number of categories, and the set of MLS 
constraints used to determine whether a permission is allowed are 
entirely up to the policy author. A level in SELinux is a combination of 
a hierarchical sensitivity and a non-hierarchical (potentially empty) 
category set. In practice MCS is used for simple isolation and therefore 
doesn't employ sensitivities since there is no hierarchical relationship 
to be enforced.


