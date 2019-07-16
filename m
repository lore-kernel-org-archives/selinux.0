Return-Path: <SRS0=e+Ck=VN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BCC7618F
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 16:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A796206C2
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 16:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+RPO/SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfGPQ2i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:28:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43754 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfGPQ2i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jul 2019 12:28:38 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so40889732ios.10
        for <selinux@vger.kernel.org>; Tue, 16 Jul 2019 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ja5Kh7ATw5JoZcLTpGLbKyjhSq7u8o/reojXvxp8LLA=;
        b=u+RPO/SORVt2AkQkurLX9wrBZzozpHA3wVDjRDiVs57DF2/8zQrnOfgtErh3HHxpRf
         u/XLuGKE6OwlUv6N4tgNzm82SbX+ld6Cu5AZGiNGIATuRq89Xbpyn8dOoO0tNiSlHkn+
         JOQdmYHvh/Cr8Ukb5LByEnqCaAehFUIN2GUq/LSVudiLgfPoFkQ5YNZxsEFVsUx5Dz1d
         Xt+EzKwn1l9Emh0IGmVJsR1L/D0h/EfJ0K64x6FQqOhUC41SlKxyiv8TcukTLNETHku1
         NbwzWBZURrWgP0GiBlyBKGY4vUf3Yxt5juo+Y5hCD8TVJIfvtYwKK575UF8mLR46YXtq
         Lhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ja5Kh7ATw5JoZcLTpGLbKyjhSq7u8o/reojXvxp8LLA=;
        b=I2qlPgUqMBQ4uhGNQF/jJ3OvPsWLqjiUi+GfztS0BrCE4rgWnt3s7Y9cF0QsCN4eVl
         WGKJDt68P3BOIpxtSor5xd7AXF3K+obXyuFH4KwHuOaPidXmVObIfmKzBm6qnb6WfUHM
         /kxS1LRwzqZhk7uUZy7a4OJWkE+bwtVebFR+ZCHGyZ5JRYYKnyfjfWZp9xO53hOobp6C
         r/zs9kdVUyQlSYz4H6XM08aYsGfsmOJBhl0QKv2VXqRjUxHKTY6Q2QuIGfzWm+0ytC0j
         bSNERI5mpsa3v9swZhCevCv0nDyeeCynIth+XFeNQXwzYx1zski5YlmE42Urb4dT6mr3
         t+JA==
X-Gm-Message-State: APjAAAVI/yx9l85L5eVzVaQvSGYRFJIF9jUIpvdtVtLSpg377JZgfRrz
        NZj/LLS1g11My/kVMiCT/oJfxHAttMGxrVvuv28YDIVU
X-Google-Smtp-Source: APXvYqwdsBWQVAhEbJY6PKATWpwlaSu/OfNbzkJOIeza43D0BZ7C7VIF0ORXMgu/1wKqh//wxrOXTs6/AfH0XeTCQOM=
X-Received: by 2002:a5e:8618:: with SMTP id z24mr32346323ioj.174.1563294516855;
 Tue, 16 Jul 2019 09:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190715144502.30547-1-bigon@debian.org> <20190715144502.30547-3-bigon@debian.org>
 <CAFftDdpaEeCQiw6KNDQq+_RO48GNuDmLbxMAb1wxQp9ES8sEWQ@mail.gmail.com>
In-Reply-To: <CAFftDdpaEeCQiw6KNDQq+_RO48GNuDmLbxMAb1wxQp9ES8sEWQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 16 Jul 2019 11:28:24 -0500
Message-ID: <CAFftDdoVHYH-SGEaPa+CU8hJSEZFQ7-3hPiOnu1h2xnWG5HZzQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mcstrans: Add reference to setools.conf man page in
 the daemon one
To:     Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Staged:
https://github.com/SELinuxProject/selinux/pull/171

On Tue, Jul 16, 2019 at 10:20 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> The three in the series LGTM. Ack.
>
> On Mon, Jul 15, 2019 at 9:55 AM Laurent Bigonville <bigon@debian.org> wro=
te:
> >
> > From: Laurent Bigonville <bigon@bigon.be>
> >
> > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> > ---
> >  mcstrans/man/man8/mcstransd.8    | 2 +-
> >  mcstrans/man/ru/man8/mcstransd.8 | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mcstrans/man/man8/mcstransd.8 b/mcstrans/man/man8/mcstrans=
d.8
> > index 64774a52..9a5922ba 100644
> > --- a/mcstrans/man/man8/mcstransd.8
> > +++ b/mcstrans/man/man8/mcstransd.8
> > @@ -29,4 +29,4 @@ The program was enhanced/rewritten by Joe Nall <joe@n=
all.com>.
> >  /etc/selinux/{SELINUXTYPE}/setrans.conf
> >
> >  .SH "SEE ALSO"
> > -.BR mcs (8),
> > +.BR setrans.conf (5), mcs (8)
> > diff --git a/mcstrans/man/ru/man8/mcstransd.8 b/mcstrans/man/ru/man8/mc=
stransd.8
> > index 90247c32..4cd68c17 100644
> > --- a/mcstrans/man/ru/man8/mcstransd.8
> > +++ b/mcstrans/man/ru/man8/mcstransd.8
> > @@ -23,7 +23,7 @@ mcstransd \- =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=
=BD=D0=BD=D1=8F=D1=8F =D1=81=D0=BB=D1=83=D0=B6=D0=B1=D0=B0 MCS (=D0=BC=D1=
=83=D0=BB=D1=8C=D1=82=D0=B8=D0=BA=D0=B0=D1=82=D0=B5=D0=B3=D0=BE=D1=80=D0=B8
> >  /etc/selinux/{SELINUXTYPE}/setrans.conf
> >
> >  .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=
=9A=D0=96=D0=95"
> > -.BR mcs (8)
> > +.BR setrans.conf (5), mcs (8)
> >
> >  .SH "=D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB"
> >  =D0=AD=D1=82=D0=B0 man-=D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=
=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh <dwalsh@redh=
at.com>.
> > --
> > 2.22.0
> >
