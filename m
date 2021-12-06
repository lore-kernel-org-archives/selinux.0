Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB8C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 09:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhLFJTX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239396AbhLFJTW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Dec 2021 04:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638782154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9q7LeQhf5AWVhUvL8JVu2PpakFvFX7rnL+ohMu0p0I=;
        b=PTJpAXMuo/6VhgA3WUJjHt8ShG2gsN0H3JwjoxVeM1PE7Cl6t4VsmqmB+gssjfqvVQY/JJ
        xrY+xQCyLD6+yRXV7ITlsxhGoWOKRA77+g629EENIfZoKo0PaSqVXGdnwMRQ6G90y+tHZ7
        JW8pwKD9Q8ianw66T9WTnZ/zbBbsSDM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-xCVjrU6aPnepIW-vRcpclA-1; Mon, 06 Dec 2021 04:15:52 -0500
X-MC-Unique: xCVjrU6aPnepIW-vRcpclA-1
Received: by mail-yb1-f199.google.com with SMTP id y17-20020a2586d1000000b005f6596e8760so18671590ybm.17
        for <selinux@vger.kernel.org>; Mon, 06 Dec 2021 01:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9q7LeQhf5AWVhUvL8JVu2PpakFvFX7rnL+ohMu0p0I=;
        b=BD2gShoTvn2SkVHRbjRhelQPF2bKuSU1fcHzfm7hNS1CvY4pL9KHKB7JkqclJ0MPpF
         JFMX745QwLBkDNFlF50nZdnUyljp3eVEgJMGpSRYzjXC+zKmWGQtjUJF4XCQFQtLvGPL
         Rc494pBTcmxGvUB5Yxl1eDu1o2q+9PsU+V+dGnA1BvEQMGC/iOgdwATvhjxxtG+vIaHg
         X1qW3/3L2S9mr+eIALZMgo+40vKpHt3kuA5wP3lsnIynZ8mQlbGLQVDNEURWtQ/Pv6qT
         gKtdlnJ9tbW+sJ97PO42xIhmu9eNTbTFQ/eiJWe3spdjOP35IxVjnqt4mdHfK9IKgkz5
         oIpA==
X-Gm-Message-State: AOAM533CJXbS6ILyc0x5W08GNcosRVx0hocOT2z6uFHvqMsjuc9Ef8Oo
        kys9i7MRmijx00KXQ2nwclls15JIczFtvZNR3cxrr+/CZ6H3EgmBHo7tqlvYzV7Bm43cYA6BWDb
        9dD84/brC6jJ/IE5C/RwwjoN/cWXHQcf6Hw==
X-Received: by 2002:a25:3b04:: with SMTP id i4mr39004985yba.767.1638782151904;
        Mon, 06 Dec 2021 01:15:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygOXN5DwxETcg+8zbuZINwEZOW6aA//EFeTffc5Z0ZA70SNru1sXcy/iQRJW6bMBWX+q1r447ibczC/XIWykY=
X-Received: by 2002:a25:3b04:: with SMTP id i4mr39004938yba.767.1638782151340;
 Mon, 06 Dec 2021 01:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20211202033447.253596-1-bernard@vivo.com> <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
In-Reply-To: <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Dec 2021 10:15:41 +0100
Message-ID: <CAFqZXNvScVVconffdqAue-m5Ub119Pw+rdSZ2TXHt-BFeVa-GQ@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: fix potential memleak
To:     Paul Moore <paul@paul-moore.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 6, 2021 at 4:12 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Dec 1, 2021 at 10:35 PM Bernard Zhao <bernard@vivo.com> wrote:
> >
> > This patch try to fix potential memleak in function
> > selinux_fs_context_dup`s error branch.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > ---
> >  security/selinux/hooks.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 62d30c0a30c2..36d7fc373839 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2856,24 +2856,38 @@ static int selinux_fs_context_dup(struct fs_context *fc,
> >         if (src->fscontext) {
> >                 opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
> >                 if (!opts->fscontext)
> > -                       return -ENOMEM;
> > +                       goto err_fscontext;
> >         }
> >         if (src->context) {
> >                 opts->context = kstrdup(src->context, GFP_KERNEL);
> >                 if (!opts->context)
> > -                       return -ENOMEM;
> > +                       goto err_context;
> >         }
> >         if (src->rootcontext) {
> >                 opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
> >                 if (!opts->rootcontext)
> > -                       return -ENOMEM;
> > +                       goto err_rootcontext;
> >         }
> >         if (src->defcontext) {
> >                 opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
> >                 if (!opts->defcontext)
> > -                       return -ENOMEM;
> > +                       goto err_defcontext;
> >         }
> >         return 0;
> > +
> > +err_defcontext:
> > +       if (src->rootcontext)
> > +               kfree(opts->rootcontext);
> > +err_rootcontext:
> > +       if (src->context)
> > +               kfree(opts->context);
> > +err_context:
> > +       if (src->fscontext)
> > +               kfree(opts->fscontext);
> > +err_fscontext:
> > +       kfree(fc->security);

Also here you need to be careful to not double-free fc->security.
(Paul's pseudocode below already correctly resets it to NULL after
freeing.)

> > +
> > +       return -ENOMEM;
> >  }
>
> Thanks for catching this a providing a patch, however I think the
> memory cleanup can be made simpler, see the pseudo code below:
>
> static int selinux_fs_context_dup(...)
> {
>
>   fc->security = kzalloc(...);
>   if (!fc->security)
>     return -ENOMEM;
>
>   opts = fc->security;
>
>   if (src->fscontext) {
>     opts->fscontext = kstrdup(...);
>     if (!opts->fscontext)
>       goto err;
>   }
>
>   /* ... */
>
>   return 0;
>
>   err:
>     kfree(opts->fscontext);
>     kfree(opts->context);
>     kfree(opts->rootcontext);
>     kfree(opts->defcontext);
>     kfree(opts);
>     fc->security = NULL;
>     return -ENOMEM;
> }
>
> --
> paul moore
> www.paul-moore.com
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

