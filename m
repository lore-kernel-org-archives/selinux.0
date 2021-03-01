Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E1C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC7964DAF
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhCAO4s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Mar 2021 09:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbhCAO4V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Mar 2021 09:56:21 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B4C061788
        for <selinux@vger.kernel.org>; Mon,  1 Mar 2021 06:55:41 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 21so8666199oiq.7
        for <selinux@vger.kernel.org>; Mon, 01 Mar 2021 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvYTr7O9dqOzz1B8nowLf7ifT+k+ayEzWmBFtVfasgA=;
        b=eyPhJupsAIobHCshAceGP3mfB4qKxU7CD856NFeUmsXg91MZip/tWsQQ7H0n10avzE
         1JMLq50vlNbta2m7lJxv1cHFeL5p6qewyeuJu56N9ARfijgZwWQwjmjfbptH55hLnpNr
         l1jj6kb7cNCz1ANYZDUjLtEwAkhPMdEkpNj0U6avijTsk+YeKmAl9Ahxxokl8PGIGilS
         tHwLE2hAYZ+nKAZmbNCbkqBYEwA7DIM7sujP3tN7qfNqnYyo+CxMpbcmpWQOtkwrs6j3
         8ZwETPjOxJrJjquJyO2mmXbwwUhffYsBhjjJIaXBwzG1Ysw2e7d9HGixmIiQmZKH/Udx
         FM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvYTr7O9dqOzz1B8nowLf7ifT+k+ayEzWmBFtVfasgA=;
        b=bSEeshCdoCxKbU/V3KxrZEXml2fSerxaDfPQYxX3Jm8u6/qVJAuQg0QHi2aUca1CT+
         Lk8tSrURcXyIlC4qU7IwYmdUI2s8rI4BKKzbl20HN9FpLvEH3/PjVgLE1zK9PNWGfWZL
         bWmGqboAHKSpK6TZAZgRFmwfnjDB6qEB5210oSBTNbOiE0F09wXfPK9yilrzJpH2XhwQ
         bOTB2PhnNrVGXlRxOTgIg5gIZWuJtt8/SH6izWCxJrbyj+QBqrZl+Airuq+Wk/fQok7n
         gy91wJVl+wm+tXmVyYglG7n/KUVkrvKgFkmVcOjhzK2UgLTDbzeW98DN/2G3Q9hgzhh+
         33fg==
X-Gm-Message-State: AOAM532zZizq1alNL1pOYa6dUByV97GsPt+o6wRdSV9cZff4Ew0C6liE
        ZuFcA4TotBV7NcpB4jqEM2m6PMGRYDRDQXDhEh3/x/4oczRTpQ==
X-Google-Smtp-Source: ABdhPJyfdjEA4SbFwk9n+LkBH7WyAEoP76eBpS9K74BscNKiX/0612W4ZFeb+j4qn1+3BdCAmq48AhdwXqhy/Ri7bWs=
X-Received: by 2002:a05:6808:8c3:: with SMTP id k3mr11600585oij.138.1614610540510;
 Mon, 01 Mar 2021 06:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20210228084858.8499-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210228084858.8499-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 1 Mar 2021 09:55:29 -0500
Message-ID: <CAP+JOzQbROkh0rOZ0uyrjnMtoZcDZmPix1KJU6=YrSL6La1wWw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: invalidate the pointer to the policydb if
 policydb_init fails
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 28, 2021 at 3:51 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Facebook's Infer static analyzer warns about a use-after-free issue in
> libsemanage:
>
>     int semanage_direct_mls_enabled(semanage_handle_t * sh)
>     {
>             sepol_policydb_t *p = NULL;
>             int retval;
>
>             retval = sepol_policydb_create(&p);
>             if (retval < 0)
>                     goto cleanup;
>
>             /* ... */
>     cleanup:
>             sepol_policydb_free(p);
>             return retval;
>     }
>
> When sepol_policydb_create() is called, p is allocated and
> policydb_init() is called. If this second call fails, p is freed
> andsepol_policydb_create() returns -1, but p still stores a pointer to
> freed memory. This pointer is then freed again in the cleanup part of
> semanage_direct_mls_enabled().
>
> Fix this by setting p to NULL in sepol_policydb_create() after freeing
> it.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_public.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
> index e5def7078eb0..0218c9403856 100644
> --- a/libsepol/src/policydb_public.c
> +++ b/libsepol/src/policydb_public.c
> @@ -68,6 +68,7 @@ int sepol_policydb_create(sepol_policydb_t ** sp)
>         p = &(*sp)->p;
>         if (policydb_init(p)) {
>                 free(*sp);
> +               *sp = NULL;
>                 return -1;
>         }
>         return 0;
> --
> 2.30.0
>
