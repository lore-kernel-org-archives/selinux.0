Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB0AC433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC2720714
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geFasOiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHURjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHURjE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 13:39:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C348C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 10:39:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l84so2172662oig.10
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maGvTy/NsQiJwh06DFI26B5aX/CoLcDYTTIElVllgbk=;
        b=geFasOiQrgLAnYbUhzM2g+uY0Pcr/eOtuCcnb01ipfLix64TDGFQgDe7euYPhY7qWq
         ochEbLxPjBr37ZSGxTBnM24KGWUkq//GpSifdLiLpPKmK2p5e2sa1sRV8xDtxIlnAM1+
         sPo7Q++2imdGQ42tJhe4HOLPOk5Fyrhlg5R3XJ/9uJOWLVxnwHhZA4ysdZX8e8XVHIlj
         WVB1sYxJiPaoq8LuP8FRTz46gBd+6tEgWKQeKA/ibEUPs2MGO5XrNMo6LGsxhR6IN9m2
         UJjLyq7fKEWax4IjHAx/g7AWbjZqVzajGxe9WS0aWvg78MaqWgW5qNQiLaOf6pJC6sLB
         /Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maGvTy/NsQiJwh06DFI26B5aX/CoLcDYTTIElVllgbk=;
        b=LiMKNV8nZbFfSLKgNUTUpet00hGO2Xd8jOfx0LjeOBA7eLj10Elos5V/s2wJAP1lMF
         UIE1itJEzSAlCHTyN1XqTX/VfeohBf8yxAxhNoR+j1q4pDGRC0APFRoC9ztEnr0g9+Ox
         XQ7DIlvW5tvLQpFe0XcDMI0pkCCU7y5WCrReWaC2CoaDu4ZRLHqgaPDZwJF57SvHrk1m
         6LHe08CX/wvDyIQh2FWlMOnEZar5xwhY5zOtco5qZZd+tdEkaOidpA1dbstAnduhkM3h
         Iz8nGubpLdBegfydF34IBTVE6PxIQR1q0gkvRTtTXYFXtuY7qAhLQprpbtP+C6mg/bEp
         G7Iw==
X-Gm-Message-State: AOAM5319K+nHFULJkcieqUaEfEe4E6bbLGx3FG9rH9hfGpH1T1pTZWNw
        WKaB87pPwc0rOlkiZ2Bc+i6ugKV761H0h6UnuijrVh9icSQ=
X-Google-Smtp-Source: ABdhPJwl4spzwed97eFDmPb/Ac8UndEZUTe1+bqguEKWrOOpvQmHRynnzVipIc9P/3GlVGZPGKKfvRFeZbrer9dkwK4=
X-Received: by 2002:a54:4817:: with SMTP id j23mr2488125oij.140.1598031543478;
 Fri, 21 Aug 2020 10:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200821154704.1214330-1-omosnace@redhat.com>
In-Reply-To: <20200821154704.1214330-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 13:38:52 -0400
Message-ID: <CAEjxPJ5gZhE2RB7A4LQyBOi5FQF5PLw_vs6gHeiwsiB1-j6Rog@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a race condition in security_read_policy()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 11:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In security_read_policy(), the policy length is computed using
> security_policydb_len(), which does a separate transaction, and then
> another transaction is done to write the policydb into a buffer of this
> length.
>
> The bug is that the policy might be re-loaded in between the two
> transactions and so the length can be wrong. In case the new length is
> lower than the old length, the length is corrected at the end of the
> function. In case the new length is higher than the old one, an error is
> returned.
>
> Fix it by doing everything in a single transaction and getting the
> length directly from policydb instead of calling
> security_policydb_len().
>
> Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a48fc1b337ba9..ab4de2a01634a 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3842,22 +3842,25 @@ int security_read_policy(struct selinux_state *state,
>                          void **data, size_t *len)
>  {
>         int rc;
> +       struct policydb *policydb;
>         struct policy_file fp;
>
>         if (!selinux_initialized(state))
>                 return -EINVAL;
>
> -       *len = security_policydb_len(state);
> +       read_lock(&state->ss->policy_rwlock);
> +       policydb = &state->ss->policy->policydb;
>
> +       *len = policydb->len;
>         *data = vmalloc_user(*len);

I don't believe you can hold a read_lock() across a vmalloc.  That's
why this is done the way it is now.

> -       if (!*data)
> -               return -ENOMEM;
> -
> -       fp.data = *data;
> -       fp.len = *len;
> +       if (!*data) {
> +               rc = -ENOMEM;
> +       } else {
> +               fp.data = *data;
> +               fp.len = *len;
>
> -       read_lock(&state->ss->policy_rwlock);
> -       rc = policydb_write(&state->ss->policy->policydb, &fp);
> +               rc = policydb_write(policydb, &fp);
> +       }
>         read_unlock(&state->ss->policy_rwlock);
>
>         if (rc)
> --
> 2.26.2
>
