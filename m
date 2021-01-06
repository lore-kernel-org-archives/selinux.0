Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12425C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0B423106
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFIcI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbhAFIcI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609921841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jEcCPM6Tk1VU/yPd3hFpER/iY3U07dO0i1qTpgwoVBw=;
        b=D5DQUuX0xV1Yn+rSGN+q1N49Ehm1LlS5HQHCsGWHzuB1JRzDrUmgZhwxXKXJSS5LgkwHpr
        Pzp2xi6+Tf688CR1wvA6npr95UMr8S/NBma4c98qtOUjtbqmCpSA8Y2bwg1NLfjX+HGiIY
        rEJYgxS1eYcdYFANRLYOI2L/0be4gKA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-7x0NiPJyO42KdJ90EBo3Sg-1; Wed, 06 Jan 2021 03:30:38 -0500
X-MC-Unique: 7x0NiPJyO42KdJ90EBo3Sg-1
Received: by mail-lf1-f71.google.com with SMTP id y5so3525090lfc.2
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 00:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEcCPM6Tk1VU/yPd3hFpER/iY3U07dO0i1qTpgwoVBw=;
        b=hOlgC4onFPV/scM7rpQ3KCG52bvynYNrihIeGQO9C8S3+hF6B/dM+aQX9FTsVRMCqO
         VrqFLwL9xUPtdofIYThB3hCaUIHI0Xu/vQpm9y1Tfed8o8X6j+tJ36BGNUBY7/Lhva7Q
         PVU8vsK00BYxs5QNA3AGYl6d4rG9HuaAtEvb56+ft8wol2lbbckrtYfkbpG6HJwJZeXD
         Eg7HJibbe+sYql7gM5E9pJ42gOGFMXzwaVy0GsDDTWem+p/vRbea6YEmgsVt+5PIGSyU
         XKYQaHhZ588e0r0eUzWAUs8309MZOjrn1lyNLoJ6Z8a2m7OS/sAxjjBSI3iLPsVQ+6Pc
         sLtw==
X-Gm-Message-State: AOAM533VghXhdJD1shVOhT3DmBnrHUBG8OQYPR8DsbMlMGvVTAs62Wgb
        pjfZPYcd8TnjBAVs6Qctfq9ApLlpX6xVkAD4wSmviV7mJ7bgkX5MfUe2rOqUm/5lZLt6pKekh+I
        2N035HvIXD9fsk7Xa/guTl5QiiqblCzsWMg==
X-Received: by 2002:a19:4941:: with SMTP id l1mr1473206lfj.80.1609921836695;
        Wed, 06 Jan 2021 00:30:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAUbRVjzOjtLd93xUHgLYXd0s6jKPb9LtGgxN4y7WtljpelRnef+nqc4Ff6A5+fA/VVUPKur8UHY+UK00CzBo=
X-Received: by 2002:a19:4941:: with SMTP id l1mr1473202lfj.80.1609921836461;
 Wed, 06 Jan 2021 00:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20210106081922.450743-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210106081922.450743-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 6 Jan 2021 09:30:20 +0100
Message-ID: <CAFqZXNs6n8Ta=z+MUG6XgwJVpbeoSdfuZ9r8fm0toDwRP+ukhg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: destroy filename_trans list properly
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 9:22 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> OSS-Fuzz found a direct memory leak in policydb_filetrans_insert()
> because filenametr_destroy() does not fully destroy the list associated
> with a typetransition.
>
> More precisely, let's consider this (minimized) CIL policy:
>
>     (class CLASS (PERM))
>     (classorder (CLASS))
>     (sid SID)
>     (sidorder (SID))
>     (user USER)
>     (role ROLE)
>     (type TYPE) ; "type 1" in libsepol internal structures
>     (type TYPE2) ; "type 2" in libsepol internal structures
>     (type TYPE3) ; "type 3" in libsepol internal structures
>     (category CAT)
>     (categoryorder (CAT))
>     (sensitivity SENS)
>     (sensitivityorder (SENS))
>     (sensitivitycategory SENS (CAT))
>     (allow TYPE self (CLASS (PERM)))
>     (roletype ROLE TYPE)
>     (userrole USER ROLE)
>     (userlevel USER (SENS))
>     (userrange USER ((SENS)(SENS (CAT))))
>     (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>
>     (typetransition TYPE2 TYPE CLASS "some_file" TYPE2)
>     (typetransition TYPE3 TYPE CLASS "some_file" TYPE3)
>
> The two typetransition statements make policydb_filetrans_insert()
> insert an item with key {ttype=1, tclass=1, name="some_file"} in the
> hashmap p->filename_trans. This item contains a linked list of two
> filename_trans_datum_t elements:
>
> * The first one uses {otype=2, stypes=bitmap containing 2}
> * The second one uses {otype=3, stypes=bitmap containing 3}
>
> Nevertheless filenametr_destroy() (called by
> hashtab_map(p->filename_trans, filenametr_destroy, NULL);) only frees
> the first element. Fix this memory leak by freeing all elements.
>
> This issue was introduced by commit 42ae834a7428 ("libsepol,checkpolicy:
> optimize storage of filename transitions") and was never present in the
> kernel, as filenametr_destroy() was modified appropriately in commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b

Ouch, good catch!

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29138

I get "Permission denied" when opening this link. Any chance it could
be made public?

> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/policydb.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f43d5c67463e..71ada42ca609 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1462,12 +1462,16 @@ static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
>                               void *p __attribute__ ((unused)))
>  {
>         filename_trans_key_t *ft = (filename_trans_key_t *)key;
> -       filename_trans_datum_t *fd = datum;
> +       filename_trans_datum_t *fd = datum, *next;
>
>         free(ft->name);
>         free(key);
> -       ebitmap_destroy(&fd->stypes);
> -       free(datum);
> +       do {
> +               next = fd->next;
> +               ebitmap_destroy(&fd->stypes);
> +               free(fd);
> +               fd = next;
> +       } while (fd);
>         return 0;
>  }
>
> --
> 2.30.0
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

