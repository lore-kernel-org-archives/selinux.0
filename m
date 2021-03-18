Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E4C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E9D64EF9
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCROOZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhCRON6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 10:13:58 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC6C06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:13:58 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso5298974otd.8
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xAr4EaCti/OJ7JeSMlq1+twnja/2ZrAjL/SNP8TlMew=;
        b=eRV+UpAcop/BCrGm2AYWpPPOvqYpaB6oogrQJoIwIVjmlR7ZUDFtHK4erQnNU0XakD
         m7j3u3qd8XBXe6sXaWNx/akGN3ccbzKxSAjl4mt5/jlSKZvIGWvVCqzXtCbSrlhIIsWG
         uU79AT5v8F8m8Hwl6IB3IYscaOG1ASemUKSz+FfwST6ykD3nMmeykSkv/AgYD78srx0i
         WqUFcise+uurA5d51lqGlNiUf40SLd/2F8nYJNPWi6Z14H5oIKL5wdNC5mhNXG2AlCe0
         VR13AsjZOgpqCEYAyNrMW/Ny7yn/ZsSTwOcVoB/JPqURoa9w/MW9d8SC0XHbPn529ZGG
         IV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xAr4EaCti/OJ7JeSMlq1+twnja/2ZrAjL/SNP8TlMew=;
        b=euCX9j4LZnh25AK3PpI64Z1APYqmgxwPlnvi9PMjwzJNITM5nImo4pFfJoTJnwM66i
         /WVrTCySe2ea72PTs2CvPHCmd7RozfXkQfp/4QWjHBpPMxYGZSacQcfYAQx0a2RRc3hj
         FTxaMv9nMaf9xGxKukYpI/VzpX+kSkbNdWdSZFuZm2qMaKBFUCZQHqXc+f3T7Mls5JGy
         O3EPagOX92WtJg6V5H4hh2ppWvd5j3dW/sng/Cg/X12BYH5A84Bv9MIhSKuSjEUTiYVB
         4rEzU9ZZM2754Jc8PgAhXz3kb/387F4j1B7gK7T8IntGupYGM5MfjAS7+ULPfYDP47Te
         IOSA==
X-Gm-Message-State: AOAM5329iz8C/kng8NUA2uR+k+AsxpXsJrRSoZnZZ1JYupuY+HXE9KWF
        UmsxjxxIHgGq4+AYkD48XRObfTng/ilH56eqlfI=
X-Google-Smtp-Source: ABdhPJxTtBgFHFTi30T25/7cc5QdQ0of9iUAx67znnJK6QvxCc3hqluCq1/2ZhwVCpsgofcPxn4ULA31haFreYaUUy0=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr7543553otr.59.1616076837723;
 Thu, 18 Mar 2021 07:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210316222313.19793-1-nicolas.iooss@m4x.org> <CAP+JOzTHnin3potuRfpGoRKmsd=teE=brss88XhGfeu58y+G_Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTHnin3potuRfpGoRKmsd=teE=brss88XhGfeu58y+G_Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Mar 2021 10:13:46 -0400
Message-ID: <CAP+JOzRk=rOz-9Y7kV8Dq=pAoMwEboetNF1Gd+j-cUt+vZjvvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: make num_* unsigned int in module_to_cil
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 17, 2021 at 10:10 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 6:57 PM Nicolas Iooss <nicolas.iooss@m4x.org> wro=
te:
> >
> > Using signed integer to represent counts can troube some gcc
> > optimisation passes, for example in
> > https://github.com/fishilico/selinux/runs/2125501324?check_suite_focus=
=3Dtrue#step:9:107
> >
> >       In function =E2=80=98name_list_to_string=E2=80=99,
> >           inlined from =E2=80=98constraint_expr_to_string=E2=80=99 at m=
odule_to_cil.c:1799:11:
> >       module_to_cil.c:1156:8: error: argument 1 range
> >       [18446744071562067968, 18446744073709551615] exceeds maximum
> >       object size 9223372036854775807 [-Werror=3Dalloc-size-larger-than=
=3D]
> >        1156 |  str =3D malloc(len);
> >             |        ^~~~~~~~~~~
> >       In file included from module_to_cil.c:39:
> >       module_to_cil.c: In function =E2=80=98constraint_expr_to_string=
=E2=80=99:
> >       /usr/include/stdlib.h:539:14: note: in a call to allocation
> >       function =E2=80=98malloc=E2=80=99 declared here
> >         539 | extern void *malloc (size_t __size) __THROW __attribute_m=
alloc__
> >             |              ^~~~~~
> >
> > The wide range (from 18446744071562067968 =3D 0xffffffff80000000 to
> > 18446744073709551615 =3D 0xffffffffffffffff) was caused by num_names be=
ing
> > a signed int used in "len +=3D num_names;", even though it should alway=
s
> > be non-negative.
> >
> > Prevent such issues from occurring by using "unsigned int" where
> > appropriate.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> I guess I don't need to make a patch. I thought you were just fixing
> the one function. This is exactly what I was thinking of.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

>
> > ---
> >  libsepol/src/module_to_cil.c | 62 ++++++++++++++++++------------------
> >  1 file changed, 31 insertions(+), 31 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index a87bc15e7610..cb1069caffdf 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -717,9 +717,9 @@ exit:
> >         return rc;
> >  }
> >
> > -static int num_digits(int n)
> > +static unsigned int num_digits(unsigned int n)
> >  {
> > -       int num =3D 1;
> > +       unsigned int num =3D 1;
> >         while (n >=3D 10) {
> >                 n /=3D 10;
> >                 num++;
> > @@ -945,7 +945,7 @@ static char *search_attr_list(struct list *attr_lis=
t, int is_type, void *set)
> >         return NULL;
> >  }
> >
> > -static int set_to_names(struct policydb *pdb, int is_type, void *set, =
struct list *attr_list, char ***names, int *num_names)
> > +static int set_to_names(struct policydb *pdb, int is_type, void *set, =
struct list *attr_list, char ***names, unsigned int *num_names)
> >  {
> >         char *attr_name =3D NULL;
> >         int rc =3D 0;
> > @@ -982,12 +982,12 @@ exit:
> >         return rc;
> >  }
> >
> > -static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names,=
 char ***names, int *num_names)
> > +static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names,=
 char ***names, unsigned int *num_names)
> >  {
> >         int rc =3D 0;
> >         struct ebitmap_node *node;
> >         uint32_t i;
> > -       uint32_t num;
> > +       unsigned int num;
> >         char **name_arr;
> >
> >         num =3D 0;
> > @@ -1026,7 +1026,7 @@ exit:
> >         return rc;
> >  }
> >
> > -static int process_roleset(struct policydb *pdb, struct role_set *rs, =
struct list *attr_list, char ***names, int *num_names)
> > +static int process_roleset(struct policydb *pdb, struct role_set *rs, =
struct list *attr_list, char ***names, unsigned int *num_names)
> >  {
> >         int rc =3D 0;
> >
> > @@ -1049,7 +1049,7 @@ exit:
> >         return rc;
> >  }
> >
> > -static int process_typeset(struct policydb *pdb, struct type_set *ts, =
struct list *attr_list, char ***names, int *num_names)
> > +static int process_typeset(struct policydb *pdb, struct type_set *ts, =
struct list *attr_list, char ***names, unsigned int *num_names)
> >  {
> >         int rc =3D 0;
> >
> > @@ -1072,7 +1072,7 @@ exit:
> >         return rc;
> >  }
> >
> > -static void names_destroy(char ***names, int *num_names)
> > +static void names_destroy(char ***names, unsigned int *num_names)
> >  {
> >         free(*names);
> >         *names =3D NULL;
> > @@ -1083,7 +1083,7 @@ static int roletype_role_in_ancestor_to_cil(struc=
t policydb *pdb, struct stack *
> >  {
> >         struct list_node *curr;
> >         char **tnames =3D NULL;
> > -       int num_tnames, i;
> > +       unsigned int num_tnames, i;
> >         struct role_list_node *role_node =3D NULL;
> >         int rc;
> >         struct type_set *ts;
> > @@ -1124,12 +1124,12 @@ exit:
> >  }
> >
> >
> > -static int name_list_to_string(char **names, int num_names, char **str=
ing)
> > +static int name_list_to_string(char **names, unsigned int num_names, c=
har **string)
> >  {
> >         // create a space separated string of the names
> >         int rc =3D -1;
> >         size_t len =3D 0;
> > -       int i;
> > +       unsigned int i;
> >         char *str;
> >         char *strpos;
> >
> > @@ -1184,7 +1184,7 @@ static int avrule_list_to_cil(int indent, struct =
policydb *pdb, struct avrule *a
> >         struct avrule *avrule;
> >         char **snames =3D NULL;
> >         char **tnames =3D NULL;
> > -       int s, t, num_snames, num_tnames;
> > +       unsigned int s, t, num_snames, num_tnames;
> >         struct type_set *ts;
> >
> >         for (avrule =3D avrule_list; avrule !=3D NULL; avrule =3D avrul=
e->next) {
> > @@ -1257,7 +1257,7 @@ static int cond_expr_to_cil(int indent, struct po=
licydb *pdb, struct cond_expr *
> >         char *new_val =3D NULL;
> >         char *val1 =3D NULL;
> >         char *val2 =3D NULL;
> > -       int num_params;
> > +       unsigned int num_params;
> >         const char *op;
> >         const char *fmt_str;
> >         const char *type;
> > @@ -1432,11 +1432,11 @@ static int role_trans_to_cil(int indent, struct=
 policydb *pdb, struct role_trans
> >         int rc =3D 0;
> >         struct role_trans_rule *rule;
> >         char **role_names =3D NULL;
> > -       int num_role_names =3D 0;
> > -       int role;
> > +       unsigned int num_role_names =3D 0;
> > +       unsigned int role;
> >         char **type_names =3D NULL;
> > -       int num_type_names =3D 0;
> > -       int type;
> > +       unsigned int num_type_names =3D 0;
> > +       unsigned int type;
> >         uint32_t i;
> >         struct ebitmap_node *node;
> >         struct type_set *ts;
> > @@ -1482,10 +1482,10 @@ static int role_allows_to_cil(int indent, struc=
t policydb *pdb, struct role_allo
> >         int rc =3D -1;
> >         struct role_allow_rule *rule;
> >         char **roles =3D NULL;
> > -       int num_roles =3D 0;
> > +       unsigned int num_roles =3D 0;
> >         char **new_roles =3D NULL;
> > -       int num_new_roles =3D 0;
> > -       int i,j;
> > +       unsigned int num_new_roles =3D 0;
> > +       unsigned int i, j;
> >         struct role_set *rs;
> >
> >         for (rule =3D rules; rule !=3D NULL; rule =3D rule->next) {
> > @@ -1525,11 +1525,11 @@ static int range_trans_to_cil(int indent, struc=
t policydb *pdb, struct range_tra
> >         int rc =3D -1;
> >         struct range_trans_rule *rule;
> >         char **stypes =3D NULL;
> > -       int num_stypes =3D 0;
> > -       int stype;
> > +       unsigned int num_stypes =3D 0;
> > +       unsigned int stype;
> >         char **ttypes =3D NULL;
> > -       int num_ttypes =3D 0;
> > -       int ttype;
> > +       unsigned int num_ttypes =3D 0;
> > +       unsigned int ttype;
> >         struct ebitmap_node *node;
> >         uint32_t i;
> >         struct type_set *ts;
> > @@ -1594,11 +1594,11 @@ static int filename_trans_to_cil(int indent, st=
ruct policydb *pdb, struct filena
> >  {
> >         int rc =3D -1;
> >         char **stypes =3D NULL;
> > -       int num_stypes =3D 0;
> > -       int stype;
> > +       unsigned int num_stypes =3D 0;
> > +       unsigned int stype;
> >         char **ttypes =3D NULL;
> > -       int num_ttypes =3D 0;
> > -       int ttype;
> > +       unsigned int num_ttypes =3D 0;
> > +       unsigned int ttype;
> >         struct type_set *ts;
> >         struct filename_trans_rule *rule;
> >
> > @@ -1716,7 +1716,7 @@ static int constraint_expr_to_string(struct polic=
ydb *pdb, struct constraint_exp
> >         const char *attr2;
> >         char *names =3D NULL;
> >         char **name_list =3D NULL;
> > -       int num_names =3D 0;
> > +       unsigned int num_names =3D 0;
> >         struct type_set *ts;
> >
> >         rc =3D stack_init(&stack);
> > @@ -2090,9 +2090,9 @@ static int role_to_cil(int indent, struct policyd=
b *pdb, struct avrule_block *UN
> >         int rc =3D -1;
> >         struct ebitmap_node *node;
> >         uint32_t i;
> > -       int j;
> > +       unsigned int j;
> >         char **types =3D NULL;
> > -       int num_types =3D 0;
> > +       unsigned int num_types =3D 0;
> >         struct role_datum *role =3D datum;
> >         struct type_set *ts;
> >         struct list *attr_list =3D NULL;
> > --
> > 2.31.0
> >
