Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A2C43619
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A55B64EC0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbhCDAYX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59524 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357080AbhCCIRb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Mar 2021 03:17:31 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B5CEB561254
        for <selinux@vger.kernel.org>; Wed,  3 Mar 2021 08:46:04 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id o10so15748564pgg.4
        for <selinux@vger.kernel.org>; Tue, 02 Mar 2021 23:46:04 -0800 (PST)
X-Gm-Message-State: AOAM531nvcm3xnz5f+VdHHdZ9ENIAbssBB5Z/JNNDaVpTyjpnP/r5r8O
        /yAKFLdYkpBfVlJWkPHvuktDEd9IjqjXtfrHMVs=
X-Google-Smtp-Source: ABdhPJwThRbpdGkFBbxhV1J6et9w3oSoAMWaGGHQF4DhZRNFvt7shVjk3Z0PlMc4K9+4YNRhAlM0NDMW3t+Qx3bFtPg=
X-Received: by 2002:aa7:9577:0:b029:1ee:ea22:5eeb with SMTP id
 x23-20020aa795770000b02901eeea225eebmr2241674pfq.33.1614757563461; Tue, 02
 Mar 2021 23:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20210228084858.8499-1-nicolas.iooss@m4x.org> <CAP+JOzQbROkh0rOZ0uyrjnMtoZcDZmPix1KJU6=YrSL6La1wWw@mail.gmail.com>
In-Reply-To: <CAP+JOzQbROkh0rOZ0uyrjnMtoZcDZmPix1KJU6=YrSL6La1wWw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 3 Mar 2021 08:45:52 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mszw=SGFZJKbBzWRNxw2wCp1iCnPN5ChRUuifMuGYR3A@mail.gmail.com>
Message-ID: <CAJfZ7=mszw=SGFZJKbBzWRNxw2wCp1iCnPN5ChRUuifMuGYR3A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: invalidate the pointer to the policydb if
 policydb_init fails
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Mar  3 08:46:05 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 1, 2021 at 3:55 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Feb 28, 2021 at 3:51 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Facebook's Infer static analyzer warns about a use-after-free issue in
> > libsemanage:
> >
> >     int semanage_direct_mls_enabled(semanage_handle_t * sh)
> >     {
> >             sepol_policydb_t *p = NULL;
> >             int retval;
> >
> >             retval = sepol_policydb_create(&p);
> >             if (retval < 0)
> >                     goto cleanup;
> >
> >             /* ... */
> >     cleanup:
> >             sepol_policydb_free(p);
> >             return retval;
> >     }
> >
> > When sepol_policydb_create() is called, p is allocated and
> > policydb_init() is called. If this second call fails, p is freed
> > andsepol_policydb_create() returns -1, but p still stores a pointer to
> > freed memory. This pointer is then freed again in the cleanup part of
> > semanage_direct_mls_enabled().
> >
> > Fix this by setting p to NULL in sepol_policydb_create() after freeing
> > it.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Nicolas

> > ---
> >  libsepol/src/policydb_public.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
> > index e5def7078eb0..0218c9403856 100644
> > --- a/libsepol/src/policydb_public.c
> > +++ b/libsepol/src/policydb_public.c
> > @@ -68,6 +68,7 @@ int sepol_policydb_create(sepol_policydb_t ** sp)
> >         p = &(*sp)->p;
> >         if (policydb_init(p)) {
> >                 free(*sp);
> > +               *sp = NULL;
> >                 return -1;
> >         }
> >         return 0;
> > --
> > 2.30.0
> >

