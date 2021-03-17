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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6DC433E6
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C80864F69
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCQOK5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCQOK3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 10:10:29 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2BCC06174A
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 07:10:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso1864260ott.13
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7KcpmKmwgaqooff84uWNoSqDeOMyCEffrhPrBV6THWo=;
        b=bSqibWXwFl2fwgbrPx82+p666ibFpJL80GMVh20jRnkfwcCR692PNxibz6WUBwnDMz
         MCIeYKo0uSoPkuaxr/2OvHnk/4UJDFNIiR0CGwN43GMRjLkeGKiQ3YygnSrQrzpV47f5
         nbYjNxrIZ0lZiaNrSBWyhgSRNo0sfNsfCU3AlISy2vSLZk7q1ALa5X/F54wm2O3oaV94
         dwL0frpG26hzOC1s1BQqsk/DG/svqqNCH8mITQGeRnD1DLyqr/AYBZ78xn7dlSElqTgW
         fHGf1M5tAHSL80dhwUx7B3W9+kg7ihMgzcGvMBfcJjIhp2S/yd5rsESVvuXfiyLTdmI2
         Z2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KcpmKmwgaqooff84uWNoSqDeOMyCEffrhPrBV6THWo=;
        b=EzgtsOd5+a1gJXW5etq43GwnZWsHPv9ZEVDPcxH9DmKoUC7yGAqIMJRTsst+GTXRmW
         T7Hk8bqh4dXX8KrwaEujOPIHrgkRLiY9DwgVB9CHhIl08JmduiRa9XTjgkAR7BRwMw4l
         l+XwcVLsHTdUKGNrnlBkT+r1Z7vstWBpEFZu8nbf/NQRk7oTFG9ugVEWT3eaEep9JR75
         nQ0kwaqVvkS0NdH+Bil2xZidy4X9YjOYiQg1h8H2qegp2+kJcxuo2Q3jAbleB3dqktGU
         b/bXyXBiGD4GwnBsz1Ad2W5dvK4YltouzTNt7tt8050NEU+dwtnCwIVh7B0+usW/VLwa
         V9vw==
X-Gm-Message-State: AOAM533khUDtaw6YzvtmgoP67abW5PEttZT37pIDoalgjLeNSYPtIRzS
        fRklAkpgX6GF0TBwBq/BYeT/dCab6DmmGzKkEnMLfFSdvto=
X-Google-Smtp-Source: ABdhPJzGH3cisWi1mUOJfO4tsUHlIJvkH8N51ALJNoEEoMwd2PhqMM7K33wKgZYmVKyRD2k8kK8L/fuXwhB78YwWMh4=
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr3500185otp.295.1615990228725;
 Wed, 17 Mar 2021 07:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210316222313.19793-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210316222313.19793-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 17 Mar 2021 10:10:17 -0400
Message-ID: <CAP+JOzTHnin3potuRfpGoRKmsd=teE=brss88XhGfeu58y+G_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: make num_* unsigned int in module_to_cil
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 6:57 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> Using signed integer to represent counts can troube some gcc
> optimisation passes, for example in
> https://github.com/fishilico/selinux/runs/2125501324?check_suite_focus=3D=
true#step:9:107
>
>       In function =E2=80=98name_list_to_string=E2=80=99,
>           inlined from =E2=80=98constraint_expr_to_string=E2=80=99 at mod=
ule_to_cil.c:1799:11:
>       module_to_cil.c:1156:8: error: argument 1 range
>       [18446744071562067968, 18446744073709551615] exceeds maximum
>       object size 9223372036854775807 [-Werror=3Dalloc-size-larger-than=
=3D]
>        1156 |  str =3D malloc(len);
>             |        ^~~~~~~~~~~
>       In file included from module_to_cil.c:39:
>       module_to_cil.c: In function =E2=80=98constraint_expr_to_string=E2=
=80=99:
>       /usr/include/stdlib.h:539:14: note: in a call to allocation
>       function =E2=80=98malloc=E2=80=99 declared here
>         539 | extern void *malloc (size_t __size) __THROW __attribute_mal=
loc__
>             |              ^~~~~~
>
> The wide range (from 18446744071562067968 =3D 0xffffffff80000000 to
> 18446744073709551615 =3D 0xffffffffffffffff) was caused by num_names bein=
g
> a signed int used in "len +=3D num_names;", even though it should always
> be non-negative.
>
> Prevent such issues from occurring by using "unsigned int" where
> appropriate.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I guess I don't need to make a patch. I thought you were just fixing
the one function. This is exactly what I was thinking of.

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  libsepol/src/module_to_cil.c | 62 ++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index a87bc15e7610..cb1069caffdf 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -717,9 +717,9 @@ exit:
>         return rc;
>  }
>
> -static int num_digits(int n)
> +static unsigned int num_digits(unsigned int n)
>  {
> -       int num =3D 1;
> +       unsigned int num =3D 1;
>         while (n >=3D 10) {
>                 n /=3D 10;
>                 num++;
> @@ -945,7 +945,7 @@ static char *search_attr_list(struct list *attr_list,=
 int is_type, void *set)
>         return NULL;
>  }
>
> -static int set_to_names(struct policydb *pdb, int is_type, void *set, st=
ruct list *attr_list, char ***names, int *num_names)
> +static int set_to_names(struct policydb *pdb, int is_type, void *set, st=
ruct list *attr_list, char ***names, unsigned int *num_names)
>  {
>         char *attr_name =3D NULL;
>         int rc =3D 0;
> @@ -982,12 +982,12 @@ exit:
>         return rc;
>  }
>
> -static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, c=
har ***names, int *num_names)
> +static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, c=
har ***names, unsigned int *num_names)
>  {
>         int rc =3D 0;
>         struct ebitmap_node *node;
>         uint32_t i;
> -       uint32_t num;
> +       unsigned int num;
>         char **name_arr;
>
>         num =3D 0;
> @@ -1026,7 +1026,7 @@ exit:
>         return rc;
>  }
>
> -static int process_roleset(struct policydb *pdb, struct role_set *rs, st=
ruct list *attr_list, char ***names, int *num_names)
> +static int process_roleset(struct policydb *pdb, struct role_set *rs, st=
ruct list *attr_list, char ***names, unsigned int *num_names)
>  {
>         int rc =3D 0;
>
> @@ -1049,7 +1049,7 @@ exit:
>         return rc;
>  }
>
> -static int process_typeset(struct policydb *pdb, struct type_set *ts, st=
ruct list *attr_list, char ***names, int *num_names)
> +static int process_typeset(struct policydb *pdb, struct type_set *ts, st=
ruct list *attr_list, char ***names, unsigned int *num_names)
>  {
>         int rc =3D 0;
>
> @@ -1072,7 +1072,7 @@ exit:
>         return rc;
>  }
>
> -static void names_destroy(char ***names, int *num_names)
> +static void names_destroy(char ***names, unsigned int *num_names)
>  {
>         free(*names);
>         *names =3D NULL;
> @@ -1083,7 +1083,7 @@ static int roletype_role_in_ancestor_to_cil(struct =
policydb *pdb, struct stack *
>  {
>         struct list_node *curr;
>         char **tnames =3D NULL;
> -       int num_tnames, i;
> +       unsigned int num_tnames, i;
>         struct role_list_node *role_node =3D NULL;
>         int rc;
>         struct type_set *ts;
> @@ -1124,12 +1124,12 @@ exit:
>  }
>
>
> -static int name_list_to_string(char **names, int num_names, char **strin=
g)
> +static int name_list_to_string(char **names, unsigned int num_names, cha=
r **string)
>  {
>         // create a space separated string of the names
>         int rc =3D -1;
>         size_t len =3D 0;
> -       int i;
> +       unsigned int i;
>         char *str;
>         char *strpos;
>
> @@ -1184,7 +1184,7 @@ static int avrule_list_to_cil(int indent, struct po=
licydb *pdb, struct avrule *a
>         struct avrule *avrule;
>         char **snames =3D NULL;
>         char **tnames =3D NULL;
> -       int s, t, num_snames, num_tnames;
> +       unsigned int s, t, num_snames, num_tnames;
>         struct type_set *ts;
>
>         for (avrule =3D avrule_list; avrule !=3D NULL; avrule =3D avrule-=
>next) {
> @@ -1257,7 +1257,7 @@ static int cond_expr_to_cil(int indent, struct poli=
cydb *pdb, struct cond_expr *
>         char *new_val =3D NULL;
>         char *val1 =3D NULL;
>         char *val2 =3D NULL;
> -       int num_params;
> +       unsigned int num_params;
>         const char *op;
>         const char *fmt_str;
>         const char *type;
> @@ -1432,11 +1432,11 @@ static int role_trans_to_cil(int indent, struct p=
olicydb *pdb, struct role_trans
>         int rc =3D 0;
>         struct role_trans_rule *rule;
>         char **role_names =3D NULL;
> -       int num_role_names =3D 0;
> -       int role;
> +       unsigned int num_role_names =3D 0;
> +       unsigned int role;
>         char **type_names =3D NULL;
> -       int num_type_names =3D 0;
> -       int type;
> +       unsigned int num_type_names =3D 0;
> +       unsigned int type;
>         uint32_t i;
>         struct ebitmap_node *node;
>         struct type_set *ts;
> @@ -1482,10 +1482,10 @@ static int role_allows_to_cil(int indent, struct =
policydb *pdb, struct role_allo
>         int rc =3D -1;
>         struct role_allow_rule *rule;
>         char **roles =3D NULL;
> -       int num_roles =3D 0;
> +       unsigned int num_roles =3D 0;
>         char **new_roles =3D NULL;
> -       int num_new_roles =3D 0;
> -       int i,j;
> +       unsigned int num_new_roles =3D 0;
> +       unsigned int i, j;
>         struct role_set *rs;
>
>         for (rule =3D rules; rule !=3D NULL; rule =3D rule->next) {
> @@ -1525,11 +1525,11 @@ static int range_trans_to_cil(int indent, struct =
policydb *pdb, struct range_tra
>         int rc =3D -1;
>         struct range_trans_rule *rule;
>         char **stypes =3D NULL;
> -       int num_stypes =3D 0;
> -       int stype;
> +       unsigned int num_stypes =3D 0;
> +       unsigned int stype;
>         char **ttypes =3D NULL;
> -       int num_ttypes =3D 0;
> -       int ttype;
> +       unsigned int num_ttypes =3D 0;
> +       unsigned int ttype;
>         struct ebitmap_node *node;
>         uint32_t i;
>         struct type_set *ts;
> @@ -1594,11 +1594,11 @@ static int filename_trans_to_cil(int indent, stru=
ct policydb *pdb, struct filena
>  {
>         int rc =3D -1;
>         char **stypes =3D NULL;
> -       int num_stypes =3D 0;
> -       int stype;
> +       unsigned int num_stypes =3D 0;
> +       unsigned int stype;
>         char **ttypes =3D NULL;
> -       int num_ttypes =3D 0;
> -       int ttype;
> +       unsigned int num_ttypes =3D 0;
> +       unsigned int ttype;
>         struct type_set *ts;
>         struct filename_trans_rule *rule;
>
> @@ -1716,7 +1716,7 @@ static int constraint_expr_to_string(struct policyd=
b *pdb, struct constraint_exp
>         const char *attr2;
>         char *names =3D NULL;
>         char **name_list =3D NULL;
> -       int num_names =3D 0;
> +       unsigned int num_names =3D 0;
>         struct type_set *ts;
>
>         rc =3D stack_init(&stack);
> @@ -2090,9 +2090,9 @@ static int role_to_cil(int indent, struct policydb =
*pdb, struct avrule_block *UN
>         int rc =3D -1;
>         struct ebitmap_node *node;
>         uint32_t i;
> -       int j;
> +       unsigned int j;
>         char **types =3D NULL;
> -       int num_types =3D 0;
> +       unsigned int num_types =3D 0;
>         struct role_datum *role =3D datum;
>         struct type_set *ts;
>         struct list *attr_list =3D NULL;
> --
> 2.31.0
>
