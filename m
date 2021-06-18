Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6148C48BE8
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 03:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBDD61245
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 03:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFRDxQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jun 2021 23:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhFRDxQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jun 2021 23:53:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D1C061574
        for <selinux@vger.kernel.org>; Thu, 17 Jun 2021 20:51:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id he7so13452055ejc.13
        for <selinux@vger.kernel.org>; Thu, 17 Jun 2021 20:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvaPjsVmZvmbmaBjH9Ip+uCe3yLjn/LWTUAf4AsLuCc=;
        b=mWsXkeNJfHvkmkEcM42YausKmipW5JF36lUq5ZuYRZbUzjDxToLj00w1vJq6/j913L
         sDeVsgqU9IzFC8v+JGTOjbBRoRQSvpczYYLozARdSybAMNO9KQN6yU9BTrx+hXeDJSOE
         zMuz2gQheKdEk/q096kGNJV2lCT/RTFMo1H8OrO5++fq8mM3cyMEL/KadjCFLqJGCSJx
         YktaHrjqSDs5bPIx0yYzmKKUyEN+3lTCDnAIleZeLzKYQirpMTQ0pdt+IHxbBBJhz8me
         uU4UnF/D3ESip9DfYV90E48hRqjDJ0CE7detDusK1xZU4KCbnXjcBJI07gzq/di1ySiw
         uFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvaPjsVmZvmbmaBjH9Ip+uCe3yLjn/LWTUAf4AsLuCc=;
        b=DRMro5/b50bSt7oBVSmzYxBJQ3MQK/eNrwIeoRxe3PO2jfep1qcqA1ClNkiIKAnvW0
         jNGP1qw+MIO7Hb9Uvjy7MhfXEI/snLuNEya4X7z4hTV53vJePUTva0NrDJpf8pktgUXk
         z4h05aXOOJfE6hNoShewBc8BI+B696WG6KvWN/OfdcICXqYFQDTkhLXRke6uk51CadgU
         7qHgNtSrOB8jF+yCTBT7IXETbW21HY2f19xIzPjxrYRHd1rA2jQOGf+X3yFyk+TpnsXj
         3Qzkjm/pFxh4zFmlyemiR1Q4gUl0WllvrVKqksBceDFXZeVGmmamdq2QXt7G5buAMJGh
         ovIg==
X-Gm-Message-State: AOAM530dr/he6tgQFFZ1GT+ywkBZSBo1hco3Z7tJY85lJbVPWu94zuWq
        YHF683nLh5DKfitw11wv7/ekOpAKwMXntlBMSDP2
X-Google-Smtp-Source: ABdhPJxzm6ia3+ejrMMcICla/mBBt5Q0Nw1/BqiW3Q9bGAk/4G0iZKpQt3I2nsC5u3WqxW2S3kMoOGpHG995unio5Y8=
X-Received: by 2002:a17:906:4f14:: with SMTP id t20mr8668896eju.398.1623988265132;
 Thu, 17 Jun 2021 20:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210612081403.16732-1-toiwoton@gmail.com>
In-Reply-To: <20210612081403.16732-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jun 2021 23:50:54 -0400
Message-ID: <CAHC9VhQt=ytU11Gk8hOx1G14bQz9o8RvJHr6VJh8+Y6Tmc5xqg@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: describe nosuid and NNP transitions
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 12, 2021 at 4:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Describe cases where nosuid_transition or nnp_transition are needed.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  src/computing_security_contexts.md | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
> index bb946b5..7bd1d87 100644
> --- a/src/computing_security_contexts.md
> +++ b/src/computing_security_contexts.md
> @@ -84,7 +84,14 @@ Processes inherit their security context as follows:
>     *default_type* (policy version 28) or if a security-aware process,
>     by calling ***setexeccon**(3)* if permitted by policy prior to
>     invoking exec.
> -3. At any time, a security-aware process may invoke ***setcon**(3)* to
> +3. If the file system is mounted with *nosuid* flag, type transitions
> +   require permission *nosuid_transition*. If the thread has
> +   *no_new_privs* attribute set, the transition requires
> +   *nnp_transition*. For both transitions, policy capability
> +   *nnp_nosuid_transition* is also required. See also
> +   [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
> +   section.

Thanks for adding this text, however I might suggest the following changes:

"If the loaded SELinux policy has the nnp_nosuid_transition policy
capability enabled there are potentially two additional permissions
that are required to permit a domain transition: nosuid_transition for
nosuid mounted filesystems, and nnp_transition for for threads with
the no_new_privs flag."

... does that make sense?

> +4. At any time, a security-aware process may invoke ***setcon**(3)* to
>     switch its security context (if permitted by policy) although this
>     practice is generally discouraged - exec-based transitions are
>     preferred.
> --
> 2.30.2

-- 
paul moore
www.paul-moore.com
