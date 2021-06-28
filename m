Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178AEC11F64
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 20:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CD161CEC
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhF1UvH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhF1UvF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jun 2021 16:51:05 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431FC061574
        for <selinux@vger.kernel.org>; Mon, 28 Jun 2021 13:48:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o13-20020a9d404d0000b0290466630039caso5051800oti.6
        for <selinux@vger.kernel.org>; Mon, 28 Jun 2021 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8gH6s2hvcA2qfLTyA5DDMXaz3AFSQJWv0waEG9QIzM=;
        b=nv4PdtsSvsvKA9/aPkS3m5CE8Q6kha98RxefYq8paX8rS5UsKcAZVY6JWfqPEmIC8J
         tpI/D5w5kRfn/NmPaLgKiuALY++HladI0blhxISMYYxWMWRltQih5wXCvDDMl/syc4CY
         LYyN8oTy8/j02c5TILHr8p3HWCYG4B0ThFQEBCTLYUEoN1kACakPJI6zUrT5ZFj1GKPu
         siWqTQdCX/1+M3TiTzZX79puErFadyzoe0lyIMxWRBouVRS/goHQg13oKVtK16m66rpj
         r59S73n/Q3zoY+qG6sgLtH1kvio6sEnG30ns2/UokvGZmUSemOhPWHGPxc3fN4COAUWa
         QjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8gH6s2hvcA2qfLTyA5DDMXaz3AFSQJWv0waEG9QIzM=;
        b=ETCaxmofBdVKtsjCdIVGf+Q2mkBf50ekB10EQbNvgXRR/wzJH6Qz40zzy5j/GbV0M+
         6qsUk6Ur7t/Qgh+119hz5xNCM0ti4yCW2POeUUE2R6jnia9/hBsWJuGn64fa3hnzK2T/
         DRmJMhdxT3tENcNnHwheipdqHRINJV/02xomJLF8Byh3OcNiL80XwKNOiEvkfaA3ysYs
         845A99PRy4evdDs+9gSD0YdvH+5mbKddm5lac9iWuJ9dpAmeDk4MD/2NJacLI24b0BUq
         1MoEBwzfsNi4/p6lreqkEPJggGIZ/1/94T9LNEJiBztkZIzh56i1bh58X0z3fm0I/tfS
         VSEA==
X-Gm-Message-State: AOAM533WR0kFeHsGoePHajoZnjakYY2CO3DSP+jpnlEEBJQ0HQhO36kt
        K6AMQwmyD82JdRfjXg0eka+IRuqzKiXCpMn3QWs=
X-Google-Smtp-Source: ABdhPJyTjFpFHF/a1gHJ5+BJ7gVyNlSOM/KEjDhW+6NASIuNeUbMHNWX7H9gCZVNi9AmvygW0+yxqoeuviKb5p0fTsA=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr1283563otk.196.1624913318183;
 Mon, 28 Jun 2021 13:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210624195919.148828-1-jwcart2@gmail.com> <CAJfZ7==EtyPWdrC4Wz3bK=yf0PFF18b6CcVnjHfXF+4knjopPg@mail.gmail.com>
In-Reply-To: <CAJfZ7==EtyPWdrC4Wz3bK=yf0PFF18b6CcVnjHfXF+4knjopPg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Jun 2021 16:48:27 -0400
Message-ID: <CAP+JOzS+Bn4L-y9BL=5+3+GZ__TCX+9kG4RAta-JP3LoSTJCdw@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol/cil: Provide option to allow qualified names
 in declarations
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 26, 2021 at 5:46 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jun 24, 2021 at 9:59 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Qualified names have "dots" in them. They are generated when a CIL
> > policy is compiled and come from declarations in blocks. If a kernel
> > policy is decompiled into a CIL policy, the resulting policy could
> > have decarations that use qualified names. Compiling this policy would
>
> Misspelling: decarations -> declarations
>

Thanks, I'll fix that in v2.

> > result in an error because "dots" in declarations are not allowed.
> >
> > Qualified names in a policy are normally used to refer to the name of
> > identifiers, blocks, macros, or optionals that are declared in a
> > different block (that is not a parent). Name resolution is based on
> > splitting a name based on the "dots", searching the parents up to the
> > global namespace for the first block using the first part of the name,
> > using the second part of the name to lookup the next block using the
> > first block's symbol tables, looking up the third block in the second's
> > symbol tables, and so on.
> >
> > To allow the option of using qualified names in declarations:
> >
> > 1) Create a field in the struct cil_db called "qualified_names" which
> > is set to CIL_TRUE when qualified names are to be used. This field is
> > checked in cil_verify_name() and "dots" are allowed if qualified names
> > are being allowed.
> >
> > 2) Only allow the direct lookup of the whole name in the global symbol
> > table. This means that blocks, blockinherits, blockabstracts, and in-
> > statements cannot be allowed. Use the "qualified_names" field of the
> > cil_db to know when using one of these should result in an error.
> >
> > 3) Create the function cil_set_qualified_names() that is used to set
> > the "qualified_names" field. Export the function in libsepol.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/include/cil/cil.h     |  1 +
> >  libsepol/cil/src/cil.c             |  6 ++++++
> >  libsepol/cil/src/cil_build_ast.c   | 24 ++++++++++++++++++++++--
> >  libsepol/cil/src/cil_internal.h    |  1 +
> >  libsepol/cil/src/cil_resolve_ast.c |  4 ++--
> >  libsepol/cil/src/cil_verify.c      | 19 ++++++++++++++-----
> >  libsepol/cil/src/cil_verify.h      |  2 +-
> >  libsepol/src/libsepol.map.in       |  1 +
> >  8 files changed, 48 insertions(+), 10 deletions(-)
> >
> [...]
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > index 59397f70..9cb1a6f6 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -92,7 +92,7 @@ static int __cil_is_reserved_name(const char *name, enum cil_flavor flavor)
> >         return CIL_FALSE;
> >  }
> >
> > -int cil_verify_name(const char *name, enum cil_flavor flavor)
> > +int cil_verify_name(struct cil_db *db, const char *name, enum cil_flavor flavor)
> >  {
> >         int rc = SEPOL_ERR;
> >         int len;
> > @@ -116,10 +116,19 @@ int cil_verify_name(const char *name, enum cil_flavor flavor)
> >                         goto exit;
> >         }
> >
> > -       for (i = 1; i < len; i++) {
> > -               if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-') {
> > -                       cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
> > -                       goto exit;
> > +       if (db->qualified_names == CIL_FALSE) {
> > +               for (i = 1; i < len; i++) {
> > +                       if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-') {
> > +                               cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
> > +                               goto exit;
> > +                       }
> > +               }
> > +       } else {
> > +               for (i = 1; i < len; i++) {
> > +                       if (!isalnum(name[i]) && name[i] != '_' && name[i] != '-' && name[i] != '.') {
> > +                               cil_log(CIL_ERR, "Invalid character \"%c\" in %s\n", name[i], name);
> > +                               goto exit;
> > +                       }
> >                 }
> >         }
>
> As cil_verify_name does not modify db (and would be seen as a function
> which does not modify anything and only checks some rules), it would
> be better to add a const qualifier:
>
>     int cil_verify_name(const struct cil_db *db, const char *name,
> enum cil_flavor flavor)
>

Good suggestion.

> Other than that, the documentation of the new option,
> "--qualified-names  Use qualified names." make me feel like the
> wording can be improved. More precisely, a commit message contains
> "Using qualified names means that declaration names can have dots in
> them" and this definition should also be in the documentation. So I am
> suggesting to replace the documentation with:
>
>     Allow names containing dots (qualified names). Blocks,
> blockinherits, blockabstracts, and in-statements will not be allowed.
>

Sounds clearer.

> Other than that, when I tested "secil2tree -A resolve -o test.cil
> secilc/test/policy.cil && secilc -Q test.cil" I encountered other
> errors, which are not related to these patches. When modifying the
> resulting "test.cil" to make it compile (by removing blocks and
> renaming some objects), option -Q worked fine. It would be nice if
> such a command was integrated in secilc's tests, in order to prevent
> future regressions. Nevertheless such work can be done once this
> series is merged.
>

I might not have been clear. This patch doesn't allow you to compile
after using "-A resolve". I will be working on that next.
I am thinking of creating a generic block "<block>", so blocks that
are resolved can be re-written using that.

So when writing out the AST for the resolve phase,

(block b
  (type t)
  (allow t self (CLASS (PERM)))
)

would be written as

;block b
(<block>
  (type b.t)
  (allow b.t self (CLASS (PERM)))
)

or, maybe I would also create a comment statement that wouldn't be
discarded by the parser

(<comment> "block b")
(<block>
  (type b.t)
  (allow b.t self (CLASS (PERM)))
)

I need to do similar things to blockinherits, blockabstracts, and
in-statements. I also would like to be able add a comment when an
optional is disabled.

I am open to suggestions.

Thanks for the review, I will work on a v2.
Jim


> Cheers,
> Nicolas
>
