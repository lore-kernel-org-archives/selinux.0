Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA39C43461
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929A420731
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PozqVaG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgIKQLe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgIKPhk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:37:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA803C061345
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:07:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so10071083edl.9
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbDVAZ8479QxTTU+9CPaAwRC24vjJ3NY/VD1gldY8EI=;
        b=PozqVaG2sAbE2N7JCp0aWhqRoUF2RyvWiga82BjZxX+Ypjgjt20Fl4YJ3kVPB/5sMo
         NjA68jBomxt24tdFnqJYbw/MVckRkNZFCcsl79Eg2umXPB5lQKbIEDo+A92qJfN+IhQI
         FjDIccdwzI/r7nFIhkez8y2S2YYnNow/Y2SwNmePhku4UfG6xApsbikxiePefztpVFGe
         DsHc/GbN2Xf4UxLi4yU2eOMVUN1U0OAqLijRMhQ7JJLamrO3V/iZNaoJqP4mRxbGYxly
         o5oxwNSg46bjtvOCbAgp70ruzUtCu2FVA2F8pFeWLmk6XxfLSyeABEzyEuGhtiHzU4h2
         jVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbDVAZ8479QxTTU+9CPaAwRC24vjJ3NY/VD1gldY8EI=;
        b=ghNBQ9oWWTL3W1okKtRjhI2qIPKeaHhIwPNYejuuQCpSkrB/KcJuyFUNI1juDO9w5c
         D+sX0QyGWDzJtQ+aeRy4pXGw1bUybMgi2gKJEXrwRsgKah86cl0/hyTLjxD60lEXN8pG
         HKMy6rLl0cAu8B71xp82kVGwdk8T9fPgOVyDEPac7/HzN0CUgVqOYprczWt45kvmoArX
         8CcfQ6BUtwD/v0ycTOts438Hmlr+Q3A0CpOJoiKleFguogipgRqnxm7DIlfL3szui7JW
         RrduRnkToB/ylMh60ByMFD2iSH6pkcsdj0r+hMb3gWzZ2C1k0MYMlVWONmeHHv0uimc5
         UdlA==
X-Gm-Message-State: AOAM533XGdkMRbukAeM8xvn67JxZOxyXtj57qy3X9uVVI8bqKoqwqCNU
        66JkhLHc2qSzlD0tiZJnol1Ar0Kf/T4uXJ1lxSvfqAPjWg==
X-Google-Smtp-Source: ABdhPJz/fm5IUs2gu7IVHvoJ8wcDloGLa0gX3BvN+vX/BaFrJCpq++mO1EgtknTW/xLFdrZDnipnyre5/QQCqFgNMRg=
X-Received: by 2002:aa7:cd06:: with SMTP id b6mr2092326edw.196.1599833241451;
 Fri, 11 Sep 2020 07:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200909222822.23198-1-nramas@linux.microsoft.com>
In-Reply-To: <20200909222822.23198-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 10:07:10 -0400
Message-ID: <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Add helper functions to get and set checkreqprot
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 6:28 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> checkreqprot data member in selinux_state struct is accessed directly by
> SELinux functions to get and set. This could cause unexpected read or
> write access to this data member due to compiler optimizations and/or
> compiler's reordering of access to this field.
>
> Add helper functions to get and set checkreqprot data member in
> selinux_state struct. These helper functions use READ_ONCE and
> WRITE_ONCE macros to ensure atomic read or write of memory for
> this data member.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c            |  6 +++---
>  security/selinux/include/security.h | 10 ++++++++++
>  security/selinux/selinuxfs.c        |  5 +++--
>  3 files changed, 16 insertions(+), 5 deletions(-)

...

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index cbdd3c7aff8b..cc29177c8858 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -143,6 +143,16 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
>  }
>  #endif
>
> +static inline bool checkreqprot_enabled(const struct selinux_state *state)
> +{
> +       return READ_ONCE(state->checkreqprot);
> +}
> +
> +static inline void checkreqprot_set(struct selinux_state *state, bool value)
> +{
> +       WRITE_ONCE(state->checkreqprot, value);
> +}

This is a nitpick, and I recognize that Stephen already suggested the
use of "*_set()" and "*_enabled()" for names, but if we are going to
name the setter "*_set()" let's also name the getter "*_get()".

Other than that, it looks fine to me.

-- 
paul moore
www.paul-moore.com
