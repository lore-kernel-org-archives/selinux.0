Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81403C0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F90420738
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb8G4R3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgCKS1i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:27:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35685 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKS1i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:27:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id k26so3136583otr.2
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnlpfTLhDIXgz6+SgWDW3Tx9RTHd0TISFqzG17NFMvg=;
        b=mb8G4R3wXGWx61uB/c9FEMhX+UpuYf84Mz9Khrd94VtgUZfsH4EBGiDVJQ+gZyfS3V
         5rPTLhs2MxIJoKRtEYM3WQK4cYA+85l/xl4TDUs7ko9j6k2V0sIeyRTnUrSTChummlha
         4LIq5BYREKrI/dQ5ue1cPUQv/h0+U3qIusL0ILCEB9mVgpH+t0NzHg19YWYi/pLHM77E
         RRBze9kuP3QbAsJceeExXcLo+olFroBAiN1X6bqQrTBjfDrstic/rXaMMYjYu7pzEJ3l
         KHjWkJn33he3fDRXV7aD8NOyrrYucLars42PkUhzP9S1+B8h9JkhpScsvqcB2zySSVwT
         CcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnlpfTLhDIXgz6+SgWDW3Tx9RTHd0TISFqzG17NFMvg=;
        b=KUEWU3KduEhOBoMgMtuxGP7EY/TPVFUsxC66IQmx7PKi5qgcDUkWwxLwdAydm5LExR
         cLnU/nb25OlvO9xztLjN5A0TMJ+kmeGIwMpkJOfzLR2Rqt8AoGxlltN1UkmqihT9gpTv
         DHPw9MedJXaCacV8DMQubFmc8w/XzxtxHgeqV/gXRVCQ7jE79K+4zcjYXC1ch6zX+OeF
         ibBU+bGW+POqpI9BAIJ8sgBtYis7vB+G74KryB9YxsJBSKIlKzJn26UDf609JewooBt0
         9pYOAxH+ItxL30tn39JFFuPynV1/DEKZe8mqhV4x48jTmWS598z4SGPFzhUC50JKeNPq
         oCgA==
X-Gm-Message-State: ANhLgQ3VE7bqK7N2r5i1HrtaL4/rc5ZG8Vd+RfoeIe27iZ7CEU/raC6J
        988fIxXvraSpYZstveAA3NYoNRnmnePSLpODdOs=
X-Google-Smtp-Source: ADFU+vsSd8MEml+zsqmMd2Kt8EF77MruytfdLiVNWnI1cwdmoL6FxnTA+IS5S5VltFPmvoK/eY9I/6cM0lo1Tab65ZY=
X-Received: by 2002:a9d:5607:: with SMTP id e7mr3469183oti.196.1583951257758;
 Wed, 11 Mar 2020 11:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <CAP+JOzT1_b+b_xMPag99239CZ5xF6wPvdt8VrNRyfsuMJYHuug@mail.gmail.com>
In-Reply-To: <CAP+JOzT1_b+b_xMPag99239CZ5xF6wPvdt8VrNRyfsuMJYHuug@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Mar 2020 14:29:01 -0400
Message-ID: <CAP+JOzQBOW=rdy8Wtdv6A-+13VkUcL=uNvT_Zu=puqZSy8ENqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 9, 2020 at 9:17 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 8:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The value attrs_expand_size == 1 removes all empty attributes, but it
> > also makes sense to expand all attributes that have only one type. This
> > removes some redundant rules (there is sometimes the same rule for the
> > type and the attribute) and reduces the number of attributes that the
> > kernel has to go through when looking up rules.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Thanks, applied.
Jim

> > ---
> >
> > v2: fix typos (Tne -> The; cointains -> contains)
> >
> >  libsepol/cil/src/cil.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index d222ad3a..c010ca2a 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> >         (*db)->disable_dontaudit = CIL_FALSE;
> >         (*db)->disable_neverallow = CIL_FALSE;
> >         (*db)->attrs_expand_generated = CIL_FALSE;
> > -       (*db)->attrs_expand_size = 1;
> > +       /* 2 == remove attributes that contain none or just 1 type */
> > +       (*db)->attrs_expand_size = 2;
> >         (*db)->preserve_tunables = CIL_FALSE;
> >         (*db)->handle_unknown = -1;
> >         (*db)->mls = -1;
> > --
> > 2.24.1
> >
