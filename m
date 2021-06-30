Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43781C11F68
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 19:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2377B61427
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 19:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhF3TFg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:05:36 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46502 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhF3TFf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jun 2021 15:05:35 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 15:05:35 EDT
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DEF445646D0
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 20:55:12 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id h1so2031582plt.1
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 11:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM531QsGinAFXBWWsjdRtldrhiIngAGoB8SZX0K1iOSihx9qswPizD
        e3AbD3Et7Gal0oUhIB4TbrWgQTXwoRYsy1xkhz0=
X-Google-Smtp-Source: ABdhPJyXAnnsHXea80LMmXK8ogkn4elSuLqUBXMBCff9dT9fyyXmZZ6d5lzkiIr/iMYuDioF7WCD2fZWFkYTJV4EpRQ=
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id
 d23-20020a170902b717b029011afae3ba7cmr32646242pls.28.1625079311599; Wed, 30
 Jun 2021 11:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210624195919.148828-1-jwcart2@gmail.com> <CAJfZ7==EtyPWdrC4Wz3bK=yf0PFF18b6CcVnjHfXF+4knjopPg@mail.gmail.com>
 <CAP+JOzS+Bn4L-y9BL=5+3+GZ__TCX+9kG4RAta-JP3LoSTJCdw@mail.gmail.com>
In-Reply-To: <CAP+JOzS+Bn4L-y9BL=5+3+GZ__TCX+9kG4RAta-JP3LoSTJCdw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Jun 2021 20:55:00 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mX0G1bQcpuSB_rtcKSFzjGwvtYjuS7JAwgNxxKUDaa2g@mail.gmail.com>
Message-ID: <CAJfZ7=mX0G1bQcpuSB_rtcKSFzjGwvtYjuS7JAwgNxxKUDaa2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol/cil: Provide option to allow qualified names
 in declarations
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 30 20:55:13 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 28, 2021 at 10:48 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Jun 26, 2021 at 5:46 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Thu, Jun 24, 2021 at 9:59 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > Qualified names have "dots" in them. They are generated when a CIL
> > > policy is compiled and come from declarations in blocks. If a kernel
> > > policy is decompiled into a CIL policy, the resulting policy could
> > > have decarations that use qualified names. Compiling this policy would
> >
> > Misspelling: decarations -> declarations
> >
>
> Thanks, I'll fix that in v2.
>
> > > result in an error because "dots" in declarations are not allowed.
> > >
> > > Qualified names in a policy are normally used to refer to the name of
> > > identifiers, blocks, macros, or optionals that are declared in a
> > > different block (that is not a parent). Name resolution is based on
> > > splitting a name based on the "dots", searching the parents up to the
> > > global namespace for the first block using the first part of the name,
> > > using the second part of the name to lookup the next block using the
> > > first block's symbol tables, looking up the third block in the second's
> > > symbol tables, and so on.
> > >
> > > To allow the option of using qualified names in declarations:
> > >
> > > 1) Create a field in the struct cil_db called "qualified_names" which
> > > is set to CIL_TRUE when qualified names are to be used. This field is
> > > checked in cil_verify_name() and "dots" are allowed if qualified names
> > > are being allowed.
> > >
> > > 2) Only allow the direct lookup of the whole name in the global symbol
> > > table. This means that blocks, blockinherits, blockabstracts, and in-
> > > statements cannot be allowed. Use the "qualified_names" field of the
> > > cil_db to know when using one of these should result in an error.
> > >
> > > 3) Create the function cil_set_qualified_names() that is used to set
> > > the "qualified_names" field. Export the function in libsepol.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > ---
> > >  libsepol/cil/include/cil/cil.h     |  1 +
> > >  libsepol/cil/src/cil.c             |  6 ++++++
> > >  libsepol/cil/src/cil_build_ast.c   | 24 ++++++++++++++++++++++--
> > >  libsepol/cil/src/cil_internal.h    |  1 +
> > >  libsepol/cil/src/cil_resolve_ast.c |  4 ++--
> > >  libsepol/cil/src/cil_verify.c      | 19 ++++++++++++++-----
> > >  libsepol/cil/src/cil_verify.h      |  2 +-
> > >  libsepol/src/libsepol.map.in       |  1 +
> > >  8 files changed, 48 insertions(+), 10 deletions(-)
> > >
> > [...]
> > > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > > index 59397f70..9cb1a6f6 100644
> > > --- a/libsepol/cil/src/cil_verify.c
> > > +++ b/libsepol/cil/src/cil_verify.c
> > > @@ -92,7 +92,7 @@ static int __cil_is_reserved_name(const char *name, enum cil_flavor flavor)
> > >         return CIL_FALSE;
> > >  }
> > >
> > > -int cil_verify_name(const char *name, enum cil_flavor flavor)
> > > +int cil_verify_name(struct cil_db *db, const char *name, enum cil_flavor flavor)
> > >  {
> > >         int rc = SEPOL_ERR;
> > >         int len;
> > > @@ -116,10 +116,19 @@ int cil_verify_name(const char *name, enum cil_flavor flavor)
> > >                         goto exit;
> > >         }
> > >
> > > -       for (i = 1; i < len; i++) {
> > > -               if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-') {
> > > -                       cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
> > > -                       goto exit;
> > > +       if (db->qualified_names == CIL_FALSE) {
> > > +               for (i = 1; i < len; i++) {
> > > +                       if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-') {
> > > +                               cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
> > > +                               goto exit;
> > > +                       }
> > > +               }
> > > +       } else {
> > > +               for (i = 1; i < len; i++) {
> > > +                       if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-' && name[i] != '.') {
> > > +                               cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
> > > +                               goto exit;
> > > +                       }
> > >                 }
> > >         }
> >
> > As cil_verify_name does not modify db (and would be seen as a function
> > which does not modify anything and only checks some rules), it would
> > be better to add a const qualifier:
> >
> >     int cil_verify_name(const struct cil_db *db, const char *name,
> > enum cil_flavor flavor)
> >
>
> Good suggestion.
>
> > Other than that, the documentation of the new option,
> > "--qualified-names  Use qualified names." make me feel like the
> > wording can be improved. More precisely, a commit message contains
> > "Using qualified names means that declaration names can have dots in
> > them" and this definition should also be in the documentation. So I am
> > suggesting to replace the documentation with:
> >
> >     Allow names containing dots (qualified names). Blocks,
> > blockinherits, blockabstracts, and in-statements will not be allowed.
> >
>
> Sounds clearer.
>
> > Other than that, when I tested "secil2tree -A resolve -o test.cil
> > secilc/test/policy.cil && secilc -Q test.cil" I encountered other
> > errors, which are not related to these patches. When modifying the
> > resulting "test.cil" to make it compile (by removing blocks and
> > renaming some objects), option -Q worked fine. It would be nice if
> > such a command was integrated in secilc's tests, in order to prevent
> > future regressions. Nevertheless such work can be done once this
> > series is merged.
> >
>
> I might not have been clear. This patch doesn't allow you to compile
> after using "-A resolve". I will be working on that next.
> I am thinking of creating a generic block "<block>", so blocks that
> are resolved can be re-written using that.
>
> So when writing out the AST for the resolve phase,
>
> (block b
>   (type t)
>   (allow t self (CLASS (PERM)))
> )
>
> would be written as
>
> ;block b
> (<block>
>   (type b.t)
>   (allow b.t self (CLASS (PERM)))
> )
>
> or, maybe I would also create a comment statement that wouldn't be
> discarded by the parser
>
> (<comment> "block b")
> (<block>
>   (type b.t)
>   (allow b.t self (CLASS (PERM)))
> )
>
> I need to do similar things to blockinherits, blockabstracts, and
> in-statements. I also would like to be able add a comment when an
> optional is disabled.
>
> I am open to suggestions.

These suggestions look good to me. Actually I even began writing a
small patch to show resolved blockinherit statements as "( ;
blockinherit b", because otherwise the parentheses are wrong in the
output of "secil2tree -A resolve secilc/test/policy.cil".

About introducing a new comment statement, it sounds like a whole new
feature just designed to make a niche tool work in a simple way. In my
humble opinion I prefer seeing regular comments in secil2tree dumps,
which has the advantage of being an existing syntax, being easy to
read, etc. But this is what I feel and of course if you prefer the way
you suggest or if someone else has a different preference, it would be
all right. And I might have missed the whole point of introducing
comments which are not discarded by CIL parsers and what advantage
this approach gives.

Cheers,
Nicolas

