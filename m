Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CDC433EF
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD1661269
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhKKWE1 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:04:27 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:52917 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKKWE1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Nov 2021 17:04:27 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4D32D564777
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 23:01:34 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso5647987pji.0
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 14:01:34 -0800 (PST)
X-Gm-Message-State: AOAM532g1cRR2wjtHdu7ifc4J3Ajdxdfj2OPBY9BYeadnWaIdC5dgoGw
        e/pNr4wszytbXOYmdNt7qF9PMTFnL1URZB2jzRg=
X-Google-Smtp-Source: ABdhPJxyMxa9HEPUWIjWBiLHEmT2PQ0vfmhH7bMKqTLNuQWfzT3bpR4+yWwflNn1JzA7mWx2L+v0XqMuHSSFaxC3h1c=
X-Received: by 2002:a17:903:30cd:b0:141:c6dd:4d03 with SMTP id
 s13-20020a17090330cd00b00141c6dd4d03mr2705482plc.16.1636668092956; Thu, 11
 Nov 2021 14:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20211013125358.15534-1-cgzones@googlemail.com>
 <20211019151123.10335-1-cgzones@googlemail.com> <CAJfZ7=mtO=1qyQPWGnpgOYU5K_3EFN4UVP09aF=SYpE3Sy5AUA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mtO=1qyQPWGnpgOYU5K_3EFN4UVP09aF=SYpE3Sy5AUA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 11 Nov 2021 23:01:21 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kqz75s7+F0=gdpefmFgq7UOA6a6ofLxSjB=Z6yzMLCTw@mail.gmail.com>
Message-ID: <CAJfZ7=kqz75s7+F0=gdpefmFgq7UOA6a6ofLxSjB=Z6yzMLCTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: do not pass NULL to memcpy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 11 23:01:34 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 8, 2021 at 10:38 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Oct 19, 2021 at 5:13 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
> > use it as source of a memcpy(3), even with a size of 0.  memcpy(3) might
> > be annotated with the function attribute nonnull and UBSan then
> > complains:
> >
> >     link.c:193:3: runtime error: null pointer passed as argument 2, which is declared to never be null
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> For these 3 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Sorry for the delay, I have been busy with other topics.
>
> Thanks!
> Nicolas

I applied these 3 patches.

Thanks!
Nicolas

> > ---
> > v2:
> >    drop realloc rewrite, just check for 0 size
> > ---
> >  libsepol/src/link.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 7512a4d9..b14240d5 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -190,8 +190,9 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> >                         ERR(state->handle, "Out of memory!");
> >                         return -1;
> >                 }
> > -               memcpy(newmap, mod->perm_map[sclassi],
> > -                      mod->perm_map_len[sclassi] * sizeof(*newmap));
> > +               if (mod->perm_map_len[sclassi] > 0) {
> > +                       memcpy(newmap, mod->perm_map[sclassi], mod->perm_map_len[sclassi] * sizeof(*newmap));
> > +               }
> >                 free(mod->perm_map[sclassi]);
> >                 mod->perm_map[sclassi] = newmap;
> >                 mod->perm_map_len[sclassi] = perm->s.value;
> > --
> > 2.33.0
> >

