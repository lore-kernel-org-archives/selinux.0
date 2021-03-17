Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB73C433E6
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFAB64F6C
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhCQOFD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhCQOEz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 10:04:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D7C06174A
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 07:04:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w65so41863239oie.7
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ICAG10Hx8TNHJ3USB3AwURB9QlJ612tUbPpZKbgIasU=;
        b=Ra6Ta69tOGkpWfufItT2dQnFfCbjsDF+ZNnvdI3Rotpom2KZ3OG7mcDzPUO4CblKIB
         ExvOP/TCrvnlrHMRe976TZf3UZbOxWd6MCKxvqOcfgc0W3VALXVhoz7/20hHvWgPtIhc
         RAsCitKiZrZGKMvS6wFef3oYxOTfMqxMtlcqrcq9/mddtjmGBI73xTKFWbKadXECEvBY
         bsBJH2ZtAVpTYwXBvHDL7rB0L+onooKMG2YtXkgcERFzg79vCwohQEv0rkii73MvgmDT
         pzJKc83kA3eWbJPrg7wfieeNxQf9nUXAjdtRSq6cwepJlPx69NfBYyEEVD16+/WeGIwC
         f3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ICAG10Hx8TNHJ3USB3AwURB9QlJ612tUbPpZKbgIasU=;
        b=Yb8yPQRdkb6w8WmFPUDZ+I+J0EFmVz3X9c7u5gqz4B+asadPQN7lLSCMgraNsKgylD
         3fY2qwDfk43VcXin6KFJFsXNhR9t+AmN4Z+im35b/NUEBjkGTG8TGAHLHvv65NL7Aa18
         7tyaF0cQBZgNYlG84iFjJnxB+3znVzvea/xVBSUVEw7PIoKPaVqQcXdiJZkud9Lwtq0g
         uMhM5OZ+0GvBkndC3Y5MHxSAQ3Rrz6vURmVbM9Ctwy6EM2Hl7TSZ+mxBGQMJNHkYhufG
         Pxdmqw8dnILf6V0kSYeTguum/kkrIU5sZYeLNsVbwBqv3fpe42KJMh97XuMcshgD5fi2
         7D7Q==
X-Gm-Message-State: AOAM530M/+85tXQTEbbrbnDcjQxGon2X8mkVmN9mvJ3//NHcCRVMrjzc
        XLSqz9RdQLU3u2Glb/AdFAtDPf2iA73k3MAL4iQ=
X-Google-Smtp-Source: ABdhPJzV2JIfQH/nngvkAy/EAtbCl93pDzfeq3756y8TnaX90USGj+489y+DPJAQBX0vjo+XUKj+BS6itNwjuvkIpQo=
X-Received: by 2002:aca:53cc:: with SMTP id h195mr2525259oib.16.1615989894720;
 Wed, 17 Mar 2021 07:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204646.52060-1-jwcart2@gmail.com> <20210316204646.52060-4-jwcart2@gmail.com>
 <CAJfZ7=nnUVB+AwEd=s9rtMApc36w75atoC=ZZC+B=zp0ONtu2Q@mail.gmail.com>
In-Reply-To: <CAJfZ7=nnUVB+AwEd=s9rtMApc36w75atoC=ZZC+B=zp0ONtu2Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 17 Mar 2021 10:04:43 -0400
Message-ID: <CAP+JOzRV3QgUkOqfpq=BdmWBRbq-o0aOuK3VgQrh_4O9FK8ffA@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol: Write "NO_IDENTIFIER" for empty CIL
 constraint expression
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 5:45 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Tue, Mar 16, 2021 at 9:49 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > If a role or user attribute with nothing associated with it is used
> > in a constraint expression, then the bitmap will be empty. This is
> > not a problem for the kernel, but does cause problems when converting
> > a kernel policy or module to CIL.
> >
> > When creating a CIL policy from a kernel policy or module, if an
> > empty bitmap is encountered, use the string "NO_IDENTIFIER". An
> > error will occur if an attempt is made to compile the resulting
> > policy, but a valid policy was not being produced before anyway.
> > Treat types the same way even though empty bitmaps are not expected.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/kernel_to_cil.c |  2 +-
> >  libsepol/src/module_to_cil.c | 10 +++++++---
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index 96e0f5d3..c6dd2e12 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -189,7 +189,7 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
> >                                         names =3D ebitmap_to_str(&curr-=
>names, pdb->p_role_val_to_name, 1);
> >                                 }
> >                                 if (!names) {
> > -                                       goto exit;
> > +                                       names =3D strdup("NO_IDENTIFIER=
");
> >                                 }
> >                                 if (strchr(names, ' ')) {
> >                                         new_val =3D create_str("(%s %s =
(%s))", 3, op, attr1, names);
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 3cc75b42..2a794f57 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1793,9 +1793,13 @@ static int constraint_expr_to_string(struct poli=
cydb *pdb, struct constraint_exp
> >                                                 goto exit;
> >                                         }
> >                                 }
> > -                               rc =3D name_list_to_string(name_list, n=
um_names, &names);
> > -                               if (rc !=3D 0) {
> > -                                       goto exit;
> > +                               if (num_names =3D=3D 0) {
> > +                                       names =3D strdup("NO_IDENTIFIER=
");
> > +                               } else {
> > +                                       rc =3D name_list_to_string(name=
_list, num_names, &names);
> > +                                       if (rc !=3D 0) {
> > +                                               goto exit;
> > +                                       }
> >                                 }
> >
> >                                 // length of values/oper + 2 spaces + 2=
 parens + null terminator
>
> Hello,
> This change somehow made gcc unhappy:
>
> $ gcc -O2 -c module_to_cil.c
> In function =E2=80=98name_list_to_string=E2=80=99,
>     inlined from =E2=80=98constraint_expr_to_string=E2=80=99 at module_to=
_cil.c:1799:11:
> module_to_cil.c:1156:8: warning: argument 1 range
> [18446744071562067968, 18446744073709551615] exceeds maximum object
> size 9223372036854775807 [-Walloc-size-larger-than=3D]
>  1156 |  str =3D malloc(len);
>       |        ^~~~~~~~~~~
> In file included from module_to_cil.c:39:
> module_to_cil.c: In function =E2=80=98constraint_expr_to_string=E2=80=99:
> /usr/include/stdlib.h:539:14: note: in a call to allocation function
> =E2=80=98malloc=E2=80=99 declared here
>   539 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
>       |              ^~~~~~
>
> (With gcc 10.2.0 on Arch Linux and gcc 9.3.0-17ubuntu1 on Ubuntu 20.04
> which is used by GitHub Actions,
> https://github.com/fishilico/selinux/runs/2125501324?check_suite_focus=3D=
true#step:9:107
> ; building for x86_64)
>
> The main cause of this error is the fact that num_names is considered
> as a signed integer in name_list_to_string(). This patch fixes the
> issue:
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 2a794f577841..6185c7e4ccb7 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1124,7 +1124,7 @@ exit:
>  }
>
>
> -static int name_list_to_string(char **names, int num_names, char **strin=
g)
> +static int name_list_to_string(char **names, unsigned int num_names,
> char **string)
>  {
>         // create a space separated string of the names
>         int rc =3D -1;
>

This looks good to me.

> ... but it would be even better if the type of num_names was
> consistent. Right now, ebitmap_to_names() initializes a local variable
> "uint32_t num;" and then does "*num_names =3D num;" with "int
> *num_names". I believe the code would be more correct if the parameter
> of ebitmap_to_names() was "uint32_t *num_names" or "unsigned int
> *num_names" (why is uint32_t used?), and if all its callers used an
> unsigned type to store this value. What do you think?
>

uint32_t is probably used because both startbit in an ebitmap_node_t
and highbit in an ebitmap_t are uint32_t. Although the ebitmap
functions take unsigned int for bit position and return unsigned int
for bit position as well.

I do agree that it would be better to make the type consistent, but,
since num_names has type int in many places, I would rather change it
everywhere to unsigned int. I'll send out a patch.

> Moreover, I stumbled upon this code pattern in function name_list_to_stri=
ng:
>
> len +=3D strlen(names[i]);
> if (len < strlen(names[i])) {
>     log_err("Overflow");
>     return -1;
> }
>
> Nowadays, both gcc and clang provide checked arithmetic builtins and I
> think the intent of this code would be clearer if it used them:
>
> if (__builtin_add_overflow(len, strlen(names[i]), &len)) {
>     log_err("Overflow");
>     return -1;
> }
>
> Does anyone have an opinion about using checked arithmetic builtins?
> (I have not used them much, and if someone knows of some compatibility
> issues, this would be important to know)
>

I don't know about compatibility issues, but I would prefer to use the
builtins as long as they won't cause problems.

Jim


> Cheers,
> Nicolas
>
