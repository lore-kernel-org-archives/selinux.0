Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9277C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6304D230FB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAFINI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:13:08 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:45351 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFINH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:13:07 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 79408561205
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 09:12:25 +0100 (CET)
Received: by mail-oi1-f178.google.com with SMTP id w124so2646105oia.6
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 00:12:25 -0800 (PST)
X-Gm-Message-State: AOAM531AlcaB6HiVALNMfZlM9En11g50lMtG6neZbYlqBYumnIAxFjDY
        hJl9z5YI1c5192s2d1SOzX2oKZLujcjPgpI9g4Q=
X-Google-Smtp-Source: ABdhPJylONDBVFYC5h4q91aFA60uryBZIdeR8+eUY9qfFsLyz+Ph5MuZd4nCZQyHwpT5K/qVurde73I3+o8x3vvTEqI=
X-Received: by 2002:a05:6808:99a:: with SMTP id a26mr2491470oic.40.1609920744316;
 Wed, 06 Jan 2021 00:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <20201230100746.2549568-2-nicolas.iooss@m4x.org> <CAP+JOzQcM03WUJ-Fg2LuLxzCGiagJnuyJozv7ed6f34vnKEKXA@mail.gmail.com>
In-Reply-To: <CAP+JOzQcM03WUJ-Fg2LuLxzCGiagJnuyJozv7ed6f34vnKEKXA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Jan 2021 09:12:13 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k-XcmOow5SeYABHKELxX+4GkFpPsL-q41cyDmR3mC_RQ@mail.gmail.com>
Message-ID: <CAJfZ7=k-XcmOow5SeYABHKELxX+4GkFpPsL-q41cyDmR3mC_RQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] libsepol: ensure that hashtab_search is not called
 with a NULL key
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 09:12:26 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 4, 2021 at 5:31 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 5:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > While fuzzing /usr/libexec/hll/pp, a policy module was generated which
> > triggered a NULL result when doing:
> >
> >     key = pdb->sym_val_to_name[sym][i];
> >
> > Detect such unexpected behavior to exit with an error instead of
> > crashing.
> >
> > This issue has been found while fuzzing hll/pp with the American Fuzzy
> > Lop.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/src/module_to_cil.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > index c99790eb76e7..99360a9afdd0 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -3459,6 +3459,10 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
> >                 map = decl->required.scope[sym];
> >                 ebitmap_for_each_positive_bit(&map, node, i) {
> >                         key = pdb->sym_val_to_name[sym][i];
> > +                       if (key == NULL) {
> > +                               rc = -1;
> > +                               goto exit;
> > +                       }
> >
> >                         scope_datum = hashtab_search(pdb->scope[sym].table, key);
> >                         if (scope_datum == NULL) {
> > --
> > 2.29.2
> >
>
> This is a similar case as the previous patch. There are other places
> where a check could go, but the check really should happen when
> reading the binary policy.

I agree, thanks for your review! I have sent a new patch which
introduces a check in policydb_read
(https://lore.kernel.org/selinux/20210106080836.344857-1-nicolas.iooss@m4x.org/T/).

Nicolas

