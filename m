Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CF9C433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 19:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiDTTFi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381607AbiDTTFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 15:05:37 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FC3C498
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:02:50 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d39f741ba0so2939303fac.13
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jIkYi1s7YS8fSg5YC9+pAY9b+Tz0QfYvpHfSwFjq1UM=;
        b=mWrGwi3QDIJUecaIWJcAqZHtlLclogz1TD2U+ZuRMbiKmG8IaQRzRJ62Yp1m3jl4gi
         iUC8qFLxR/AyOzWDnhbsUVNPzh/71RelG278oHPViAIxcUVJid9xqRw+85NVAlE1Q1f/
         LuaUIjOjcwYP5R1diRaYumHBFVtPLA9w0u3jryRZSDKgZSAnHb6PnaDLFo2OfgaEff0+
         FOeJx7qvzys8adVEcGfff3LaB8IaP7Rcq5yC/UQ7p8HOJs9uZabhfItR5GXWQKCG1OY5
         7R7/W/NumuPiCZ6x8IWjctbE3XRXE6T56f1uYidLZ+/1h/WHyYJR3vNZo16g4eh7Xqco
         ndnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jIkYi1s7YS8fSg5YC9+pAY9b+Tz0QfYvpHfSwFjq1UM=;
        b=nhVWCnSF2BvnIFAHHnK0z1F29xON9W+rCyY1/CJO3O8kzb3DXQ5j5lErpDXuFXm0QI
         O4gOEfVgC0XJabW//8qRHe80VWFDK71FniN/BPpUgC0NpwTcIvWpiKysxQt0Y5ngfiGk
         5nTlKopNjty4kn4EINWzVHVuPxt7e6lLUqTsXJRgpl2a/EavZ8Nug6MDKjT+E2NmgTi4
         4ibrvLw769Cyp7Kw9lPI0qvQM5Tv0IMvUvukV9w4gzoSCy2nnP6uFJqt8+UTJ9hu5HrP
         lPum+0NX1SC5+JN799NlMh1SYYQa8M0BQBjp9WMGqyzx1GD/tHaMUa3kpjeXW4wu+1yJ
         kbKw==
X-Gm-Message-State: AOAM533sO+90nxPzeoxK6YVswR+kAfr9Heda5VsvvAIY0uNqpN8N/Yym
        0iDKVm9maR9FdOs79+LR6yQ4Trimv2ut0ctFAKGzbPfW
X-Google-Smtp-Source: ABdhPJzwQVst7ctRZrcmj4juKkC9yJIqrImc9rsrgxM25H1ekGTgD16+j+SzReGSMHphobJXRv0kI+ZuZJTgz1OJhHI=
X-Received: by 2002:a05:6870:f624:b0:e1:c071:121c with SMTP id
 ek36-20020a056870f62400b000e1c071121cmr2272187oab.182.1650481370192; Wed, 20
 Apr 2022 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220413155633.62677-1-cgzones@googlemail.com>
 <CAP+JOzQrx0OLTdACuMOucJcTAm0pnDFGYeFkV=XibGqHHfSxXQ@mail.gmail.com> <CAP+JOzR696tsM4UjU5fvK0y-TyQcgks_ctiP3miEoDoBRNji5g@mail.gmail.com>
In-Reply-To: <CAP+JOzR696tsM4UjU5fvK0y-TyQcgks_ctiP3miEoDoBRNji5g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Apr 2022 15:02:39 -0400
Message-ID: <CAP+JOzRUfuuvPntA0+YR9jdA9-QLe9QRUq9uMG72pSvB08RVhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: correct parameter type in selabel_open(3)
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 2:53 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Apr 14, 2022 at 2:52 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, Apr 13, 2022 at 1:22 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > selabel_open(3) takes an `unsigned int` as backend parameter.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Acked-by: James Carter <jwcart2@gmail.com>
> For all three patches, of course.
>

These three patches have been merged.
Thanks,
Jim

> >
> > > ---
> > >  libselinux/man/man3/selabel_open.3 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3=
/selabel_open.3
> > > index 971ebc1a..c8348ca4 100644
> > > --- a/libselinux/man/man3/selabel_open.3
> > > +++ b/libselinux/man/man3/selabel_open.3
> > > @@ -10,7 +10,7 @@ selabel_open, selabel_close \- userspace SELinux la=
beling interface
> > >  .br
> > >  .B #include <selinux/label.h>
> > >  .sp
> > > -.BI "struct selabel_handle *selabel_open(int " backend ,
> > > +.BI "struct selabel_handle *selabel_open(unsigned int " backend ,
> > >  .in +\w'struct selabel_handle *selabel_open('u
> > >  .BI "const struct selinux_opt *" options ,
> > >  .br
> > > --
> > > 2.35.2
> > >
