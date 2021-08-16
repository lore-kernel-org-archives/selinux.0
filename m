Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E363C432BE
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F23E6054E
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhHPOpV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhHPOpV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 10:45:21 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2EC061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 07:44:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso21159622oth.12
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+nDhgqyZxnxS4EWJpQv/GwNeZOQ45JLRcJfjtT74w4U=;
        b=vD3l8RnsVhqoCYLrQLsP4NN4lhstsD9p2ktB8XwtnFmxGJmLWw7uPFVqAo90/2EQ/M
         S4dor/X6D1K1T4SZ+AJ0OvB3/eXrewfrr4jrAvAgOOT5opVR2beA4cqfdbMNJWHU7DFF
         +AP5xr1ZDeplIub6WBlvcDnZWvxAqsJLhxELOs7MMbhw8ATlW5zEw/XoJ3oeRIZTMO6r
         6njggFUpn6tyCbRhw5D6pAaKVhJboZ89Yw+jx7+pBAAbc5HHVjhq9+9aydFryKJTs9Xz
         Dx1LdZ6izmUG85K8P6x/xbbwPx6cCkb4K7hLCiD5pT7wuTPYSwz8nzyTzaNdjkIyXuRz
         tPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+nDhgqyZxnxS4EWJpQv/GwNeZOQ45JLRcJfjtT74w4U=;
        b=Yici3VgT8sI4idCOsLxGnYZL0SJATCJiMIk8UdcyBAb/xkbBoHbYFaoTyONwP+14vy
         EAZIim0bz/piRa95+3nw0YzCjD0uaq3a6wky5MN3wWOxVVZk7idPOQvJqOXmHKNk7nBj
         ycrEz2U1yCSuMj/zOrLH42QN+G7rwFdtx7ULtemZsPPfTtpOOkcCPSDzJFXYdKs9s0Sh
         91YHbNHHu2z5a7ZAjddzke9RBX/COU+Lt5B1Ct31W9pBbR7LkNkY4AZ9EPpcVyPx31Bk
         99L69k94KQOi6Bx5J6iD2YlVNUf29b3iV90yjmE7jEcWxVhugk8T4APR2V/Eom+5Tntd
         CrbA==
X-Gm-Message-State: AOAM533TC5USSbI7l1Piy5Dy0hOPPac8nlbddocHNg36+PzOlgK2Kvem
        sdjevBaYfJaM0uChv2+igH4nF9FGfK2t5oMVFCgkC4ZNOhM=
X-Google-Smtp-Source: ABdhPJyueRxnW/Gh+y9yeC2t2nG5khLl2FK0Z0OkKMdt2VP+lbXWTyggWMuzMuicQPZcg3Kqbinmfihdvhhnl1ADuxI=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr12960786oto.295.1629125088897;
 Mon, 16 Aug 2021 07:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210810180537.669439-1-jwcart2@gmail.com> <20210810180537.669439-7-jwcart2@gmail.com>
 <CAJfZ7=nuGHfTqf2CBHcODi3R=5tc+a5ZiamiXuJTF2gJk_rk-Q@mail.gmail.com>
In-Reply-To: <CAJfZ7=nuGHfTqf2CBHcODi3R=5tc+a5ZiamiXuJTF2gJk_rk-Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 Aug 2021 10:44:38 -0400
Message-ID: <CAP+JOzQ0JN6Yezwa6LoPCM25HbPi0gcZHw4xX15onbyGNY_1nA@mail.gmail.com>
Subject: Re: [PATCH 6/8] libsepol/cil: Add line mark kind and line number to
 src info
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 5:39 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Tue, Aug 10, 2021 at 8:22 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > To be able to write line mark information when writing the AST,
> > the line mark kind and line number is needed in the src info.
> >
> > Instead of indicating whether the src info is for CIL or a hll,
> > differentiate between CIL, a normal hll line mark, and an expanded
> > hll line mark. Also include the line mark line number in the src
> > info nodes.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil.c           | 13 +++++++++----
> >  libsepol/cil/src/cil_build_ast.c | 17 +++++++++++++++--
> >  libsepol/cil/src/cil_copy_ast.c  |  3 ++-
> >  libsepol/cil/src/cil_internal.h  |  7 +++++--
> >  libsepol/cil/src/cil_parser.c    | 27 +++++++++++----------------
> >  libsepol/cil/src/cil_tree.c      |  2 +-
> >  6 files changed, 43 insertions(+), 26 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index bdd16eb8..caec5dad 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -220,7 +220,9 @@ char *CIL_KEY_IOCTL;
> >  char *CIL_KEY_UNORDERED;
> >  char *CIL_KEY_SRC_INFO;
> >  char *CIL_KEY_SRC_CIL;
> > -char *CIL_KEY_SRC_HLL;
> > +char *CIL_KEY_SRC_HLL_LMS;
> > +char *CIL_KEY_SRC_HLL_LMX;
> > +char *CIL_KEY_SRC_HLL_LME;
> >
> >  static void cil_init_keys(void)
> >  {
> > @@ -384,8 +386,10 @@ static void cil_init_keys(void)
> >         CIL_KEY_IOCTL =3D cil_strpool_add("ioctl");
> >         CIL_KEY_UNORDERED =3D cil_strpool_add("unordered");
> >         CIL_KEY_SRC_INFO =3D cil_strpool_add("<src_info>");
> > -       CIL_KEY_SRC_CIL =3D cil_strpool_add("<src_cil>");
> > -       CIL_KEY_SRC_HLL =3D cil_strpool_add("<src_hll>");
> > +       CIL_KEY_SRC_CIL =3D cil_strpool_add("cil");
> > +       CIL_KEY_SRC_HLL_LMS =3D cil_strpool_add("lms");
> > +       CIL_KEY_SRC_HLL_LMX =3D cil_strpool_add("lmx");
> > +       CIL_KEY_SRC_HLL_LME =3D cil_strpool_add("lme");
> >  }
> >
> >  void cil_db_init(struct cil_db **db)
> > @@ -2881,6 +2885,7 @@ void cil_mls_init(struct cil_mls **mls)
> >  void cil_src_info_init(struct cil_src_info **info)
> >  {
> >         *info =3D cil_malloc(sizeof(**info));
> > -       (*info)->is_cil =3D 0;
> > +       (*info)->kind =3D NULL;
> > +       (*info)->hll_line =3D 0;
> >         (*info)->path =3D NULL;
> >  }
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index ffbd3082..a0f58b1e 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -6060,6 +6060,7 @@ int cil_gen_src_info(struct cil_tree_node *parse_=
current, struct cil_tree_node *
> >                 CIL_SYN_STRING,
> >                 CIL_SYN_STRING,
> >                 CIL_SYN_STRING,
> > +               CIL_SYN_STRING,
> >                 CIL_SYN_N_LISTS | CIL_SYN_END,
> >                 CIL_SYN_END
> >         };
> > @@ -6077,8 +6078,19 @@ int cil_gen_src_info(struct cil_tree_node *parse=
_current, struct cil_tree_node *
> >
> >         cil_src_info_init(&info);
> >
> > -       info->is_cil =3D (parse_current->next->data =3D=3D CIL_KEY_SRC_=
CIL) ? CIL_TRUE : CIL_FALSE;
> > -       info->path =3D parse_current->next->next->data;
> > +       info->kind =3D parse_current->next->data;
> > +       if (info->kind !=3D CIL_KEY_SRC_CIL && info->kind !=3D CIL_KEY_=
SRC_HLL_LMS && info->kind !=3D CIL_KEY_SRC_HLL_LMX) {
> > +               cil_log(CIL_ERR, "Invalid src info kind\n");
> > +               rc =3D SEPOL_ERR;
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D cil_string_to_uint32(parse_current->next->next->data, &i=
nfo->hll_line, 10);
> > +       if (rc !=3D SEPOL_OK) {
> > +               goto exit;
> > +       }
> > +
> > +       info->path =3D parse_current->next->next->next->data;
> >
> >         ast_node->data =3D info;
> >         ast_node->flavor =3D CIL_SRC_INFO;
> > @@ -6087,6 +6099,7 @@ int cil_gen_src_info(struct cil_tree_node *parse_=
current, struct cil_tree_node *
> >
> >  exit:
> >         cil_tree_log(parse_current, CIL_ERR, "Bad src info");
> > +       cil_destroy_src_info(info);
> >         return rc;
> >  }
> >
> > diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_cop=
y_ast.c
> > index 9c0231f2..02b9828f 100644
> > --- a/libsepol/cil/src/cil_copy_ast.c
> > +++ b/libsepol/cil/src/cil_copy_ast.c
> > @@ -1692,7 +1692,8 @@ int cil_copy_src_info(__attribute__((unused)) str=
uct cil_db *db, void *data, voi
> >
> >         cil_src_info_init(&new);
> >
> > -       new->is_cil =3D orig->is_cil;
> > +       new->kind =3D orig->kind;
> > +       new->hll_line =3D orig->hll_line;
> >         new->path =3D orig->path;
> >
> >         *copy =3D new;
> > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_int=
ernal.h
> > index b9a03a37..385677d4 100644
> > --- a/libsepol/cil/src/cil_internal.h
> > +++ b/libsepol/cil/src/cil_internal.h
> > @@ -236,7 +236,9 @@ extern char *CIL_KEY_IOCTL;
> >  extern char *CIL_KEY_UNORDERED;
> >  extern char *CIL_KEY_SRC_INFO;
> >  extern char *CIL_KEY_SRC_CIL;
> > -extern char *CIL_KEY_SRC_HLL;
> > +extern char *CIL_KEY_SRC_HLL_LMS;
> > +extern char *CIL_KEY_SRC_HLL_LMX;
> > +extern char *CIL_KEY_SRC_HLL_LME;
> >
> >  /*
> >         Symbol Table Array Indices
> > @@ -963,7 +965,8 @@ struct cil_mls {
> >  };
> >
> >  struct cil_src_info {
> > -       int is_cil;
> > +       char *kind;
> > +       uint32_t hll_line;
> >         char *path;
> >  };
> >
> > diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parse=
r.c
> > index 9ca1432e..842c327c 100644
> > --- a/libsepol/cil/src/cil_parser.c
> > +++ b/libsepol/cil/src/cil_parser.c
> > @@ -44,10 +44,6 @@
> >
> >  #define CIL_PARSER_MAX_EXPR_DEPTH (0x1 << 12)
> >
> > -char *CIL_KEY_HLL_LMS;
> > -char *CIL_KEY_HLL_LMX;
> > -char *CIL_KEY_HLL_LME;
> > -
> >  struct hll_info {
> >         uint32_t hll_lineno;
> >         uint32_t hll_expand;
> > @@ -102,7 +98,6 @@ static int add_hll_linemark(struct cil_tree_node **c=
urrent, uint32_t *hll_lineno
> >         char *hll_type;
> >         struct cil_tree_node *node;
> >         struct token tok;
> > -       char *hll_file;
> >         int rc;
> >
> >         cil_lexer_next(&tok);
> > @@ -111,11 +106,11 @@ static int add_hll_linemark(struct cil_tree_node =
**current, uint32_t *hll_lineno
> >                 goto exit;
> >         }
> >         hll_type =3D cil_strpool_add(tok.value);
> > -       if (hll_type !=3D CIL_KEY_HLL_LME && hll_type !=3D CIL_KEY_HLL_=
LMS && hll_type !=3D CIL_KEY_HLL_LMX) {
> > +       if (hll_type !=3D CIL_KEY_SRC_HLL_LME && hll_type !=3D CIL_KEY_=
SRC_HLL_LMS && hll_type !=3D CIL_KEY_SRC_HLL_LMX) {
> >                 cil_log(CIL_ERR, "Invalid line mark syntax\n");
> >                 goto exit;
> >         }
> > -       if (hll_type =3D=3D CIL_KEY_HLL_LME) {
> > +       if (hll_type =3D=3D CIL_KEY_SRC_HLL_LME) {
> >                 if (cil_stack_is_empty(stack)) {
> >                         cil_log(CIL_ERR, "Line mark end without start\n=
");
> >                         goto exit;
> > @@ -132,7 +127,7 @@ static int add_hll_linemark(struct cil_tree_node **=
current, uint32_t *hll_lineno
> >                 create_node(&node, *current, tok.line, *hll_lineno, CIL=
_KEY_SRC_INFO);
> >                 insert_node(node, *current);
> >
> > -               create_node(&node, *current, tok.line, *hll_lineno, CIL=
_KEY_SRC_HLL);
> > +               create_node(&node, *current, tok.line, *hll_lineno, hll=
_type);
> >                 insert_node(node, *current);
> >
> >                 cil_lexer_next(&tok);
> > @@ -141,12 +136,15 @@ static int add_hll_linemark(struct cil_tree_node =
**current, uint32_t *hll_lineno
> >                         goto exit;
> >                 }
> >
> > +               create_node(&node, *current, tok.line, *hll_lineno, cil=
_strpool_add(tok.value));
> > +               insert_node(node, *current);
> > +
> >                 rc =3D cil_string_to_uint32(tok.value, hll_lineno, 10);
> >                 if (rc !=3D SEPOL_OK) {
> >                         goto exit;
> >                 }
> >
> > -               *hll_expand =3D (hll_type =3D=3D CIL_KEY_HLL_LMX) ? 1 :=
 0;
> > +               *hll_expand =3D (hll_type =3D=3D CIL_KEY_SRC_HLL_LMX) ?=
 1 : 0;
> >
> >                 cil_lexer_next(&tok);
> >                 if (tok.type !=3D SYMBOL && tok.type !=3D QSTRING) {
> > @@ -159,9 +157,7 @@ static int add_hll_linemark(struct cil_tree_node **=
current, uint32_t *hll_lineno
> >                         tok.value =3D tok.value+1;
> >                 }
> >
> > -               hll_file =3D cil_strpool_add(tok.value);
> > -
> > -               create_node(&node, *current, tok.line, *hll_lineno, hll=
_file);
> > +               create_node(&node, *current, tok.line, *hll_lineno, cil=
_strpool_add(tok.value));
> >                 insert_node(node, *current);
> >         }
> >
> > @@ -192,6 +188,9 @@ static void add_cil_path(struct cil_tree_node **cur=
rent, char *path)
> >         create_node(&node, *current, 0, 0, CIL_KEY_SRC_CIL);
> >         insert_node(node, *current);
> >
> > +       create_node(&node, *current, 0, 0, "1");
> > +       insert_node(node, *current);
> > +
>
> Using this raw "1" here looks strange, while every other case uses
> cil_strpool_add indirections. gcc complains about this:
>
> ../cil/src/cil_parser.c: In function =E2=80=98add_cil_path=E2=80=99:
> ../cil/src/cil_parser.c:205:44: error: passing argument 5 of
> =E2=80=98create_node=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier =
from pointer target type
> [-Werror=3Ddiscarded-qualifiers]
>   205 |         create_node(&node, *current, 0, 0, "1");
>       |                                            ^~~
> ../cil/src/cil_parser.c:76:127: note: expected =E2=80=98void *=E2=80=99 b=
ut argument
> is of type =E2=80=98const char *=E2=80=99
>    76 | tree_node **node, struct cil_tree_node *current, uint32_t
> line, uint32_t hll_offset, void *value)
>       |
>
> I understand that cil_strpool_add is used in order to be able to
> quickly compare some strings using raw pointer comparisons. So I do
> not know whether a proper fix would consist in using create_note(...,
> (void *)"1") or in introducing a char *CIL_KEY_ONE =3D
> cil_strpool_add("1"), or in making (struct cil_tree_node).data const.
>

I think that I would prefer to go with (void*)"1", since the "1" is
not a keyword of any sort.

Thanks for the review.
Jim


> >         create_node(&node, *current, 0, 0, path);
> >         insert_node(node, *current);
> >  }
> > @@ -211,10 +210,6 @@ int cil_parser(const char *_path, char *buffer, ui=
nt32_t size, struct cil_tree *
> >         struct token tok;
> >         int rc =3D SEPOL_OK;
> >
> > -       CIL_KEY_HLL_LMS =3D cil_strpool_add("lms");
> > -       CIL_KEY_HLL_LMX =3D cil_strpool_add("lmx");
> > -       CIL_KEY_HLL_LME =3D cil_strpool_add("lme");
> > -
> >         cil_stack_init(&stack);
> >
> >         cil_lexer_setup(buffer, size);
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 4cf8dcc8..52b28999 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -71,7 +71,7 @@ struct cil_tree_node *cil_tree_get_next_path(struct c=
il_tree_node *node, char **
> >                                 /* AST */
> >                                 struct cil_src_info *info =3D node->dat=
a;
> >                                 *path =3D info->path;
> > -                               *is_cil =3D info->is_cil;
> > +                               *is_cil =3D (info->kind =3D=3D CIL_KEY_=
SRC_CIL);
> >                                 return node;
> >                 } else {
> >                         if (node->flavor =3D=3D CIL_CALL) {
> > --
> > 2.31.1
> >
>
