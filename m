Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B1DC48BD1
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3F8613E7
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 22:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJWnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJWnS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 18:43:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830C2C061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 15:41:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ce15so1548695ejb.4
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZJjJ5wdXFEXNjhM6EHcu5V9FB4RRow8gmw59isyI0Y=;
        b=XlNKKCs9ZUEt9qXRPr7uZJ8t/PhTChCNLV8NlZe+YOmSq3ZffQZstxTYJs47T2DrlZ
         m7p7oGq5eKdPNpVuoZZWisZvikWMYKKq5amFJAg+ELUFy6K7FenQRcIpPbRvH+EYH+lS
         rHh2UpXeuIUkGEDYiu+oJZX86UAtZYa3H/2g2So99PAcATqXfkEIPf2YMrhbf46X96xF
         8q54MWCti+t9t/yDBaMX9suD/+UIvYaocRhGreWNS0j8Gi3EpPX1w5AooHOvaKfEVrty
         C5nDf07i88mK38+2nEuJXYFDDlgXlK4SyONyhh5PdzB40tlM0kUiJbGuG+Jg4H9L08Nl
         tJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZJjJ5wdXFEXNjhM6EHcu5V9FB4RRow8gmw59isyI0Y=;
        b=dzU3C/QSoopIs5c+SDBs3QRoz6/4s8RzKN3hVWmKr3z9N4/iO4e7zmXGe9nmyrP0/m
         UN7OPJDhu4JVvjZMoqigFRXlATzSo6UcFS4KUeTzEwqYhhKScXEY7cyOkHGTVE+lFVmw
         tomcloLd/w3836XhP4XksBhxQABobmzrtbi2d3XkBMa8C9IWApjif4KVJnPbHs93+xa+
         O3iJtlMltNyUi5dVYaDvSlqisPxxXZB3YHVjc5kp+DOhyyJo+JXPwDcen6Ln+250bjZF
         van9vcrzzxrozC5udPwnq5VpUTbwNA6YkymrzphAR/Akww9oS2F5dCpu/Syl7+x6WLUd
         al0A==
X-Gm-Message-State: AOAM533DMEj3XDFs+XWyGgw0dcYK9072h8VkbFUYuL/h/5V1qGZvJm1N
        1OiZuJp3DjmK3T3osTW90bcBgfRMnge+n10VIsyk
X-Google-Smtp-Source: ABdhPJyPYehvSJldCE6QFB3ayonvvwuXDqKXExeloyf0FAQdMqGKMr/7WINHa5LvGxYpCcIGUn8n6xmtkupPTLUGldU=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr667490ejk.488.1623364870931;
 Thu, 10 Jun 2021 15:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk> <YMI1IpLMGuFvw4kd@zeniv-ca.linux.org.uk>
In-Reply-To: <YMI1IpLMGuFvw4kd@zeniv-ca.linux.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 18:41:00 -0400
Message-ID: <CAHC9VhTQeeL4rfL02RHax1zgpiJNRr1s_xP8Skrr476esrsfXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kill unused 'flags' argument in avc_has_perm_flags()
 and avc_audit()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 11:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From 565799de3ee0a295842a07a5f9a459db5e793beb Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Sat, 16 Jan 2021 15:57:49 -0500
> Subject: [PATCH 2/2] kill unused 'flags' argument in avc_has_perm_flags() and
>  avc_audit()
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/avc.c         | 7 +++----
>  security/selinux/hooks.c       | 5 ++---
>  security/selinux/include/avc.h | 7 ++-----
>  3 files changed, 7 insertions(+), 12 deletions(-)

I'm looking at patch 1/2 now, but if we can safely get rid of the
flags arg then we might as well do away with avc_has_perm_flags()
altogether and just convert the callers to avc_has_perm().

> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index c3bbfc8e8b46..098f31c415e2 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -154,8 +152,7 @@ int avc_has_perm(struct selinux_state *state,
>  int avc_has_perm_flags(struct selinux_state *state,
>                        u32 ssid, u32 tsid,
>                        u16 tclass, u32 requested,
> -                      struct common_audit_data *auditdata,
> -                      int flags);
> +                      struct common_audit_data *auditdata);
>
>  int avc_has_extended_perms(struct selinux_state *state,
>                            u32 ssid, u32 tsid, u16 tclass, u32 requested,
> --
> 2.11.0

-- 
paul moore
www.paul-moore.com
