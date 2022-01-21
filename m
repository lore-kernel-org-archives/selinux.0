Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF72C433F5
	for <selinux@archiver.kernel.org>; Fri, 21 Jan 2022 13:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380726AbiAUNbQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350533AbiAUNbA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jan 2022 08:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642771859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTny4+OzgrtbvIS2AEoo8jfaJrnFzUd2jbVNvvCU2ho=;
        b=ItErOSiHEG0PascWWylVlwcpj9EmTPx6986fXYlr1GSdmga5BDgIL2715JN9XcIJB8lXkc
        K1KlqwyBTXeTS7qE7arHZCwKtx4xBFCfCr12LQqUpRLRw3d1uDCtFKaEq04NBMEmihrwoD
        HjnwZIntfsnxBAN2K3GBJiqlIEcG3ks=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-lTD7PdDwOqm1lNWzQIZphA-1; Fri, 21 Jan 2022 08:30:58 -0500
X-MC-Unique: lTD7PdDwOqm1lNWzQIZphA-1
Received: by mail-yb1-f199.google.com with SMTP id c76-20020a25c04f000000b00613e2c514e2so15130130ybf.21
        for <selinux@vger.kernel.org>; Fri, 21 Jan 2022 05:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTny4+OzgrtbvIS2AEoo8jfaJrnFzUd2jbVNvvCU2ho=;
        b=wTaWuHYGGsVpQU1BX2Lw/MSz9ooJlbJOmppWmiAmEtV41yAPOCfUS5fGEjVS1pT91g
         YcB3fHuq8oyXAMJ6ctiXaZ7fbcwCT5nN2YUJOauM5l/uJPKqs327bbMzzxNoRbf+Tjx+
         0uE2oqYTte4Hhm/i1MSZXHq4etuAQocJkuygjxEAislPxwBvqvMjl3fwKNaSRl75hGxI
         nryE/u3S3eL1JlSqFFh0fSdoZC3+hXUFx1YFbvZIzeaqO6FrLRLX7Es935uTLWJXiGT1
         K+u5EbpxfgvUcPMa9crkglDlv3YvvIjRDnNIsoEtItzPcfLg/sXnvEvFDJKPa7xvAS5L
         yp4Q==
X-Gm-Message-State: AOAM532PTuA5ZUZ1cGGsPwLU7CLg2ypE6oeFHcBgwYdf6ZLVgXOecW/c
        /WFA63mI6yyAoAwoiM5gP3CQH1kWyZPPQVI0/Y7Pq4fwGTF/YymQ3Wyh2bbbl306fn/0N/zFdqM
        jsqbZfexVeSmYeD0H6BqyCj8Cne7XEFXB2Q==
X-Received: by 2002:a25:414:: with SMTP id 20mr5954194ybe.1.1642771857453;
        Fri, 21 Jan 2022 05:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhAbW5vA+Pd0qE5Df5hZGPQLELxoB+V5ORaj9JxuWFCMR/3KJ89OWNGHpqL5JedLpRHn/iMnGCWh8RZQbgdTY=
X-Received: by 2002:a25:414:: with SMTP id 20mr5954129ybe.1.1642771856874;
 Fri, 21 Jan 2022 05:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20220113143935.195125-1-omosnace@redhat.com> <20220113143935.195125-5-omosnace@redhat.com>
 <CAP+JOzQZGwupcKQCMYc4DWE-MyNKo31Tio83RkcLJVepScFQgQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQZGwupcKQCMYc4DWE-MyNKo31Tio83RkcLJVepScFQgQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 21 Jan 2022 14:30:45 +0100
Message-ID: <CAFqZXNsgtdct+DWGdvLpJW8xH9H7HuX0+MOAB9zbw_N266k5NQ@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 4/5] libsemanage: optionally rebuild policy
 when modules are changed externally
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 20, 2022 at 11:08 PM James Carter <jwcart2@gmail.com> wrote:
> On Thu, Jan 13, 2022 at 6:37 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:\
[...]
> > @@ -1119,13 +1248,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
> >                 }
> >         }
> >
> > -       /* Before we do anything else, flush the join to its component parts.
> > -        * This *does not* flush to disk automatically */
> > -       if (users->dtable->is_modified(users->dbase)) {
> > -               retval = users->dtable->flush(sh, users->dbase);
> > -               if (retval < 0)
> > -                       goto cleanup;
> > -       }
> > +       if (force_rebuild)
> > +               goto rebuild;
> >
> >         /*
> >          * This is for systems that have already migrated with an older version
> > @@ -1135,70 +1259,66 @@ static int semanage_direct_commit(semanage_handle_t * sh)
> >          * in order to skip re-linking are present; otherwise, we force
> >          * a rebuild.
> >          */
> > -       if (!do_rebuild) {
> > -               int files[] = {SEMANAGE_STORE_KERNEL,
> > -                                          SEMANAGE_STORE_FC,
> > -                                          SEMANAGE_STORE_SEUSERS,
> > -                                          SEMANAGE_LINKED,
> > -                                          SEMANAGE_SEUSERS_LINKED,
> > -                                          SEMANAGE_USERS_EXTRA_LINKED};
> > -
> > -               for (i = 0; i < (int) ARRAY_SIZE(files); i++) {
> > -                       path = semanage_path(SEMANAGE_TMP, files[i]);
> > -                       if (stat(path, &sb) != 0) {
> > -                               if (errno != ENOENT) {
> > -                                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > -                                       retval = -1;
> > -                                       goto cleanup;
> > -                               }
> > -
> > -                               do_rebuild = 1;
> > -                               goto rebuild;
> > +       for (i = 0; i < (int) ARRAY_SIZE(semanage_computed_files); i++) {
> > +               path = semanage_path(SEMANAGE_TMP, semanage_computed_files[i]);
> > +               if (stat(path, &sb) != 0) {
> > +                       if (errno != ENOENT) {
> > +                               ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
> > +                               retval = -1;
> > +                               goto cleanup;
> >                         }
> > +
> > +                       force_rebuild = 1;
> > +                       goto rebuild;
> >                 }
> >         }
> >
> >  rebuild:
>
> I know that the rebuild label and goto rebuild was there originally,
> but I would prefer to have it eliminated.
>
> instead of:
> if (force_rebuild)
>     goto rebuild;
> ...
> for (...
>     path = ...
>     if (...
>         ...
>         force_rebuild = 1;
>         goto rebuild;
>     }
> }
>
> rebuild:
>
> why not:
> if (!force_rebuild)
>     for (...
>         path = ...
>         if (...
>             force_rebuild = 1;
>             break;
>         }
>     }
> }

Good point, it really doesn't need to be there. I'll remove it in the
next revision.

Thanks for the review!

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

