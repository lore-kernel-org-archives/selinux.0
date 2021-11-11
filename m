Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA0BC433F5
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC461215
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhKKWGC convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:06:02 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50001 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhKKWFr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Nov 2021 17:05:47 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4FE71564781
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 23:02:56 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id q17so6783566plr.11
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 14:02:56 -0800 (PST)
X-Gm-Message-State: AOAM533YvujK9ACEKB/6Rb/rhByrUbVQssdMTycVSqwk4304ZvkuB1bE
        uniOUV2RuEQrUS0D8By+f+F0kL+m03yo3xPFJH4=
X-Google-Smtp-Source: ABdhPJz8RE/vyPIMwuYZ2zry1o0qlQFqrVauw0+Iudsb3qH19GYGPNJL+tiQ8n+NjKYiEhl7iIKfQFVir35OQYISfOY=
X-Received: by 2002:a17:902:f209:b0:141:99d1:7cef with SMTP id
 m9-20020a170902f20900b0014199d17cefmr2731984plc.70.1636668175208; Thu, 11 Nov
 2021 14:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20211021140839.7439-1-cgzones@googlemail.com> <20211105152937.36412-1-cgzones@googlemail.com>
 <CAJfZ7=n4rjs9mbqdcfMvYEMnyzUJssRR72rYT1NavCg0Ui4ggQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=n4rjs9mbqdcfMvYEMnyzUJssRR72rYT1NavCg0Ui4ggQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 11 Nov 2021 23:02:44 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nzBzMCoMs6YiiJ5OMBT-=SgYsifbV+8BnbBJAFY3R8_Q@mail.gmail.com>
Message-ID: <CAJfZ7=nzBzMCoMs6YiiJ5OMBT-=SgYsifbV+8BnbBJAFY3R8_Q@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: avoid passing NULL pointer to memcpy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 11 23:02:56 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 8, 2021 at 10:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Nov 5, 2021 at 4:29 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > memcpy(3) might be annotated with the function attribute nonnull and
> > UBSan then complains:
> >
> >     module.c:296:3: runtime error: null pointer passed as argument 2, which is declared to never be null
> >         #0 0x7f2468efa5b3 in link_netfilter_contexts ./libsepol/src/module.c:296
> >         #1 0x7f2468efa5b3 in sepol_link_packages ./libsepol/src/module.c:337
> >         #2 0x562331e9e123 in main ./semodule-utils/semodule_link/semodule_link.c:145
> >         #3 0x7f2467e247ec in __libc_start_main ../csu/libc-start.c:332
> >         #4 0x562331e9d2a9 in _start (./destdir/usr/bin/semodule_link+0x32a9)
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks!
> Nicolas

This patch is now applied.

Thanks!
Nicolas

> > ---
> > v2:
> >   include length addition into if block
> >
> > ---
> >  libsepol/src/module.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> > index 02a5de2c..b718751e 100644
> > --- a/libsepol/src/module.c
> > +++ b/libsepol/src/module.c
> > @@ -293,11 +293,14 @@ static int link_netfilter_contexts(sepol_module_package_t * base,
> >         }
> >         base->netfilter_contexts = base_context;
> >         for (i = 0; i < num_modules; i++) {
> > -               memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
> > -                      modules[i]->netfilter_contexts,
> > -                      modules[i]->netfilter_contexts_len);
> > -               base->netfilter_contexts_len +=
> > -                   modules[i]->netfilter_contexts_len;
> > +               if (modules[i]->netfilter_contexts_len > 0) {
> > +                       memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
> > +                              modules[i]->netfilter_contexts,
> > +                              modules[i]->netfilter_contexts_len);
> > +                       base->netfilter_contexts_len +=
> > +                           modules[i]->netfilter_contexts_len;
> > +               }
> > +
> >         }
> >         return 0;
> >  }
> > --
> > 2.33.1
> >

