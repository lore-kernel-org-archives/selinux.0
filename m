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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03CC432BE
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD661078
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhHPOno (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhHPOlU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 10:41:20 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19800C061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 07:40:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o20so26969898oiw.12
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iqc+5vfvmzI22b4zGBgC55IW4Zjw7lY4e9VOLMo5yOg=;
        b=DeRKfNbjDtN9870mHV1x0bcpV3SIqdBvn483FvMwepbd2Wn7q7MPEMqDUZNLBUyB+N
         CdA43/94UQbgURT6COZ2oECI0yx3fFnOScKjnyA6Qx7dqU7qemNFWh5jSgzcgCYdh3dl
         XPe8K5PQjTTWteai0WmSstdKvdlPIDLYYUkVKNdxVswQ9kTNhzpA8Z7QUtEY+ScY8Fx7
         GKLusmGYoWWOm6koL8wpa2bEcb0dWQsOGSC0JHyFhD5767g2Bz6tedq2kVuSr40aUWLf
         QSbSvqZ69KGHb7680emSZVb7zqwED4g8hSgKdWbYnjgFm9ObS0k4Sti1DDgKv/PFzXAv
         MeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iqc+5vfvmzI22b4zGBgC55IW4Zjw7lY4e9VOLMo5yOg=;
        b=r5WUoTdbVdLE3XCNOpCFPvYxxDkxj15ZA1qBVUUxEaejX7wFD97bVXa07qMJJH8QkX
         /SMFPJG02RdtkR7lSXZrHTueloStPzBH795JX5GVACEz+GArLXjjarLfhxqH+D/Xneej
         Tuxs8p5IdmQ7hQHgxc1L9M8XOQmWOPlstTpdsrCAqwsc/qWfNJtY948BEqb4DbrrEd3k
         86GxBkufa5UqlLrHouVvYnjQofvLfyhGSa7Wja3v/VeuLRYGXOyt515/khpJcg0i1kWO
         NoDgK5xjVDtwQ7YPnmUDbS2bFZCI5Ne9B9OLF1r0E9Um6TeDWUS7DFWu66khwThJz6FS
         WA4Q==
X-Gm-Message-State: AOAM5321XIjK3NmBovrD7VqKjnhnDPRImms2WYeXg4OFjZ4ExqLO5QM5
        K88yWgycjW687UP4DcWFpvuyuPwpiwL82VpoaCQ=
X-Google-Smtp-Source: ABdhPJya8N0/9N5lHlmDRrYAn+NOPQf1Zm7EwTqmFMhWLUYjnFGxc1qStTvwit8cSkuyncjuhl6buwkCwbNUrZ4CNOk=
X-Received: by 2002:aca:1815:: with SMTP id h21mr12003851oih.128.1629124816311;
 Mon, 16 Aug 2021 07:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210810180537.669439-1-jwcart2@gmail.com> <20210810180537.669439-8-jwcart2@gmail.com>
 <CAJfZ7=nsPMgBFrfHiAdAhOVY9XNJxDuR7=sSbE8=fP1EAFuNPw@mail.gmail.com>
In-Reply-To: <CAJfZ7=nsPMgBFrfHiAdAhOVY9XNJxDuR7=sSbE8=fP1EAFuNPw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 Aug 2021 10:40:05 -0400
Message-ID: <CAP+JOzQfmRSN8UWY5bWNaGHte9+SeH0KK7W1K2u+0Kt5dMwccw@mail.gmail.com>
Subject: Re: [PATCH 7/8] libsepol/cil: Report correct high-level language line numbers
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 5:23 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Tue, Aug 10, 2021 at 8:22 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL supports specifiying the original high-level language file and
> > line numbers when reporting errors. This is done through line marks
> > and is mostly used to report the original Refpolicy file and line
> > number for neverallow rules that have been converted to CIL.
> >
> > As long as the line mark remain simple, everything works fine, but
> > the wrong line numbers will be reported with more complex nextings
> > of line marks.
> >
> > Example:
> > ;;* lms 100 file01.hll
> > (type t1a)
> > (allow t1a self (CLASS (PERM)))
> > ;;* lmx 200 file02.hll
> > (type t2a)
> > (allow t2a self (CLASS (PERM)))
> > ;;* lme
> > (type t1b)
> > (allow t1b self (CLASS (PERM)))
> > (allow bad1b self (CLASS (PERM))) ; file01.hll:101 (Should be 106)
> > ;;* lme
> >
> > The primary problem is that the tree nodes can only store one hll
> > line number. Instead a number is needed that can be used by any
> > number of stacked line mark sections. This number would increment
> > line a normal line number except when in lmx sections (that have
> > the same line number throughout the section because they represent
> > an expansion of a line -- like the expansion of a macro call. This
> > number can go backwards when exiting a lms section within a lmx
> > section, because line number will increase in the lms section, but
> > outside the lmx section, the line number did not advance.
> >
> > This number is called the hll_offset and this is the value that is
> > now stored in tree nodes instead of the hll line number. To calculate
> > the hll line number for a rule, a search is made for an ancestor of
> > the node that is a line mark and the line number for a lms section
> > is the hll line number stored in the line mark, plus the hll offset
> > of the rule, minus the hll offset of the line mark node, minus one.
> > (hll_lineno + hll_offset_rule - hll_offset_lm - 1)
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_binary.c    |  9 ++--
> >  libsepol/cil/src/cil_build_ast.c |  4 +-
> >  libsepol/cil/src/cil_copy_ast.c  |  2 +-
> >  libsepol/cil/src/cil_parser.c    | 74 +++++++++++++++++++-------------
> >  libsepol/cil/src/cil_tree.c      | 53 +++++++++++++++--------
> >  libsepol/cil/src/cil_tree.h      |  4 +-
> >  6 files changed, 90 insertions(+), 56 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 2b65c622..43c37fc2 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -4480,7 +4480,8 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t=
 kind, struct cil_tree_node *no
> >         avrule_t *avrule;
> >         struct cil_tree_node *source_node;
> >         char *source_path;
> > -       int is_cil;
> > +       char *lm_kind;
> > +       uint32_t hll_line;
> >
> >         avrule =3D cil_malloc(sizeof(avrule_t));
> >         avrule->specified =3D kind;
> > @@ -4492,11 +4493,11 @@ static avrule_t *__cil_init_sepol_avrule(uint32=
_t kind, struct cil_tree_node *no
> >
> >         avrule->source_filename =3D NULL;
> >         avrule->source_line =3D node->line;
> > -       source_node =3D cil_tree_get_next_path(node, &source_path, &is_=
cil);
> > +       source_node =3D cil_tree_get_next_path(node, &lm_kind, &hll_lin=
e, &source_path);
> >         if (source_node) {
> >                 avrule->source_filename =3D source_path;
> > -               if (!is_cil) {
> > -                       avrule->source_line =3D node->hll_line;
> > +               if (lm_kind !=3D CIL_KEY_SRC_CIL) {
> > +                       avrule->source_line =3D hll_line + node->hll_of=
fset - source_node->hll_offset - 1;
> >                 }
> >         }
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index a0f58b1e..a5afc267 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -619,7 +619,7 @@ int cil_gen_perm_nodes(struct cil_db *db, struct ci=
l_tree_node *current_perm, st
> >                 cil_tree_node_init(&new_ast);
> >                 new_ast->parent =3D ast_node;
> >                 new_ast->line =3D current_perm->line;
> > -               new_ast->hll_line =3D current_perm->hll_line;
> > +               new_ast->hll_offset =3D current_perm->hll_offset;
> >
> >                 rc =3D cil_gen_perm(db, current_perm, new_ast, flavor, =
num_perms);
> >                 if (rc !=3D SEPOL_OK) {
> > @@ -6203,7 +6203,7 @@ int __cil_build_ast_node_helper(struct cil_tree_n=
ode *parse_current, uint32_t *f
> >
> >         ast_node->parent =3D ast_current;
> >         ast_node->line =3D parse_current->line;
> > -       ast_node->hll_line =3D parse_current->hll_line;
> > +       ast_node->hll_offset =3D parse_current->hll_offset;
> >
> >         if (parse_current->data =3D=3D CIL_KEY_BLOCK) {
> >                 rc =3D cil_gen_block(db, parse_current, ast_node, 0);
> > diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_cop=
y_ast.c
> > index 02b9828f..34282a92 100644
> > --- a/libsepol/cil/src/cil_copy_ast.c
> > +++ b/libsepol/cil/src/cil_copy_ast.c
> > @@ -2010,7 +2010,7 @@ int __cil_copy_node_helper(struct cil_tree_node *=
orig, __attribute__((unused)) u
> >
> >                 new->parent =3D parent;
> >                 new->line =3D orig->line;
> > -               new->hll_line =3D orig->hll_line;
> > +               new->hll_offset =3D orig->hll_offset;
> >                 new->flavor =3D orig->flavor;
> >                 new->data =3D data;
> >
> > diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parse=
r.c
> > index 842c327c..3ccef5d7 100644
> > --- a/libsepol/cil/src/cil_parser.c
> > +++ b/libsepol/cil/src/cil_parser.c
> > @@ -45,21 +45,21 @@
> >  #define CIL_PARSER_MAX_EXPR_DEPTH (0x1 << 12)
> >
> >  struct hll_info {
> > -       uint32_t hll_lineno;
> > +       uint32_t hll_offset;
> >         uint32_t hll_expand;
> >  };
> >
> > -static void push_hll_info(struct cil_stack *stack, uint32_t hll_lineno=
, uint32_t hll_expand)
> > +static void push_hll_info(struct cil_stack *stack, uint32_t hll_offset=
, uint32_t hll_expand)
> >  {
> >         struct hll_info *new =3D cil_malloc(sizeof(*new));
> >
> > -       new->hll_lineno =3D hll_lineno;
> > +       new->hll_offset =3D hll_offset;
> >         new->hll_expand =3D hll_expand;
> >
> >         cil_stack_push(stack, CIL_NONE, new);
> >  }
> >
> > -static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno=
, uint32_t *hll_expand)
> > +static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_offset=
, uint32_t *hll_expand)
> >  {
> >         struct cil_stack_item *curr =3D cil_stack_pop(stack);
> >         struct hll_info *info;
> > @@ -69,17 +69,17 @@ static void pop_hll_info(struct cil_stack *stack, u=
int32_t *hll_lineno, uint32_t
> >         }
> >         info =3D curr->data;
> >         *hll_expand =3D info->hll_expand;
> > -       *hll_lineno =3D info->hll_lineno;
> > +       *hll_offset =3D info->hll_offset;
> >         free(curr->data);
> >  }
> >
> > -static void create_node(struct cil_tree_node **node, struct cil_tree_n=
ode *current, uint32_t line, uint32_t hll_line, void *value)
> > +static void create_node(struct cil_tree_node **node, struct cil_tree_n=
ode *current, uint32_t line, uint32_t hll_offset, void *value)
> >  {
> >         cil_tree_node_init(node);
> >         (*node)->parent =3D current;
> >         (*node)->flavor =3D CIL_NODE;
> >         (*node)->line =3D line;
> > -       (*node)->hll_line =3D hll_line;
> > +       (*node)->hll_offset =3D hll_offset;
> >         (*node)->data =3D value;
> >  }
> >
> > @@ -93,12 +93,12 @@ static void insert_node(struct cil_tree_node *node,=
 struct cil_tree_node *curren
> >         current->cl_tail =3D node;
> >  }
> >
> > -static int add_hll_linemark(struct cil_tree_node **current, uint32_t *=
hll_lineno, uint32_t *hll_expand, struct cil_stack *stack, char *path)
> > +static int add_hll_linemark(struct cil_tree_node **current, uint32_t *=
hll_offset, uint32_t *hll_expand, struct cil_stack *stack, char *path)
> >  {
> >         char *hll_type;
> >         struct cil_tree_node *node;
> >         struct token tok;
> > -       int rc;
> > +       uint32_t prev_hll_expand, prev_hll_offset;
>
> In this function, gcc (in GitHub Actions CI) reports:
>
>   ../cil/src/cil_parser.c: In function =E2=80=98cil_parser=E2=80=99:
>   ../cil/src/cil_parser.c:181:16: error: =E2=80=98hll_offset=E2=80=99 may=
 be used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>     181 |   (*hll_offset)++;
>         |   ~~~~~~~~~~~~~^~
>   ../cil/src/cil_parser.c:222:11: note: =E2=80=98hll_offset=E2=80=99 was =
declared here
>     222 |  uint32_t hll_offset =3D 1;
>         |           ^~~~~~~~~~
>
> In fact the warning is misleading because it comes from
> prev_hll_offset not being initialized and gcc having trouble figuring
> out it is initialized in calls to pop_hll_info.
>
> To silence this warning, could you initialize prev_hll_offset to some val=
ue?
>

Yes, I will do that.
Thanks,
Jim

> >
> >         cil_lexer_next(&tok);
> >         if (tok.type !=3D SYMBOL) {
> > @@ -115,19 +115,33 @@ static int add_hll_linemark(struct cil_tree_node =
**current, uint32_t *hll_lineno
> >                         cil_log(CIL_ERR, "Line mark end without start\n=
");
> >                         goto exit;
> >                 }
> > -               pop_hll_info(stack, hll_lineno, hll_expand);
> > +               prev_hll_expand =3D *hll_expand;
> > +               pop_hll_info(stack, &prev_hll_offset, hll_expand);
> > +               if (*hll_expand) {
> > +                       /* This is needed when exiting an lms section w=
ithin an lmx section.
> > +                        * In the lms section, hll_offset will incremen=
t and then revert
> > +                        * back to its previous value when going back i=
nto the lmx section.
> > +                        */
> > +                       *hll_offset =3D prev_hll_offset;
> > +               }
> > +               if (prev_hll_expand && !*hll_expand) {
> > +                       /* This is needed to count the lme at the end o=
f an lmx section
> > +                        * within an lms section (or within no hll sect=
ion).
> > +                        */
> > +                       (*hll_offset)++;
> > +               }
> >                 *current =3D (*current)->parent;
> >         } else {
> > -               push_hll_info(stack, *hll_lineno, *hll_expand);
> > +               push_hll_info(stack, *hll_offset, *hll_expand);
> >
> > -               create_node(&node, *current, tok.line, *hll_lineno, NUL=
L);
> > +               create_node(&node, *current, tok.line, *hll_offset, NUL=
L);
> >                 insert_node(node, *current);
> >                 *current =3D node;
> >
> > -               create_node(&node, *current, tok.line, *hll_lineno, CIL=
_KEY_SRC_INFO);
> > +               create_node(&node, *current, tok.line, *hll_offset, CIL=
_KEY_SRC_INFO);
> >                 insert_node(node, *current);
> >
> > -               create_node(&node, *current, tok.line, *hll_lineno, hll=
_type);
> > +               create_node(&node, *current, tok.line, *hll_offset, hll=
_type);
> >                 insert_node(node, *current);
> >
> >                 cil_lexer_next(&tok);
> > @@ -136,16 +150,9 @@ static int add_hll_linemark(struct cil_tree_node *=
*current, uint32_t *hll_lineno
> >                         goto exit;
> >                 }
> >
> > -               create_node(&node, *current, tok.line, *hll_lineno, cil=
_strpool_add(tok.value));
> > +               create_node(&node, *current, tok.line, *hll_offset, cil=
_strpool_add(tok.value));
> >                 insert_node(node, *current);
> >
> > -               rc =3D cil_string_to_uint32(tok.value, hll_lineno, 10);
> > -               if (rc !=3D SEPOL_OK) {
> > -                       goto exit;
> > -               }
> > -
> > -               *hll_expand =3D (hll_type =3D=3D CIL_KEY_SRC_HLL_LMX) ?=
 1 : 0;
> > -
> >                 cil_lexer_next(&tok);
> >                 if (tok.type !=3D SYMBOL && tok.type !=3D QSTRING) {
> >                         cil_log(CIL_ERR, "Invalid line mark syntax\n");
> > @@ -157,8 +164,10 @@ static int add_hll_linemark(struct cil_tree_node *=
*current, uint32_t *hll_lineno
> >                         tok.value =3D tok.value+1;
> >                 }
> >
> > -               create_node(&node, *current, tok.line, *hll_lineno, cil=
_strpool_add(tok.value));
> > +               create_node(&node, *current, tok.line, *hll_offset, cil=
_strpool_add(tok.value));
> >                 insert_node(node, *current);
> > +
> > +               *hll_expand =3D (hll_type =3D=3D CIL_KEY_SRC_HLL_LMX) ?=
 1 : 0;
> >         }
> >
> >         cil_lexer_next(&tok);
> > @@ -167,6 +176,11 @@ static int add_hll_linemark(struct cil_tree_node *=
*current, uint32_t *hll_lineno
> >                 goto exit;
> >         }
> >
> > +       if (!*hll_expand) {
> > +               /* Need to increment because of the NEWLINE */
> > +               (*hll_offset)++;
> > +       }
> > +
> >         return SEPOL_OK;
> >
> >  exit:
> > @@ -205,7 +219,7 @@ int cil_parser(const char *_path, char *buffer, uin=
t32_t size, struct cil_tree *
> >         struct cil_tree_node *current =3D NULL;
> >         char *path =3D cil_strpool_add(_path);
> >         struct cil_stack *stack;
> > -       uint32_t hll_lineno =3D 0;
> > +       uint32_t hll_offset =3D 1;
> >         uint32_t hll_expand =3D 0;
> >         struct token tok;
> >         int rc =3D SEPOL_OK;
> > @@ -223,7 +237,7 @@ int cil_parser(const char *_path, char *buffer, uin=
t32_t size, struct cil_tree *
> >                 cil_lexer_next(&tok);
> >                 switch (tok.type) {
> >                 case HLL_LINEMARK:
> > -                       rc =3D add_hll_linemark(&current, &hll_lineno, =
&hll_expand, stack, path);
> > +                       rc =3D add_hll_linemark(&current, &hll_offset, =
&hll_expand, stack, path);
> >                         if (rc !=3D SEPOL_OK) {
> >                                 goto exit;
> >                         }
> > @@ -234,7 +248,7 @@ int cil_parser(const char *_path, char *buffer, uin=
t32_t size, struct cil_tree *
> >                                 cil_log(CIL_ERR, "Number of open parent=
hesis exceeds limit of %d at line %d of %s\n", CIL_PARSER_MAX_EXPR_DEPTH, t=
ok.line, path);
> >                                 goto exit;
> >                         }
> > -                       create_node(&node, current, tok.line, hll_linen=
o, NULL);
> > +                       create_node(&node, current, tok.line, hll_offse=
t, NULL);
> >                         insert_node(node, current);
> >                         current =3D node;
> >                         break;
> > @@ -256,12 +270,12 @@ int cil_parser(const char *_path, char *buffer, u=
int32_t size, struct cil_tree *
> >                                 goto exit;
> >                         }
> >
> > -                       create_node(&node, current, tok.line, hll_linen=
o, cil_strpool_add(tok.value));
> > +                       create_node(&node, current, tok.line, hll_offse=
t, cil_strpool_add(tok.value));
> >                         insert_node(node, current);
> >                         break;
> >                 case NEWLINE :
> >                         if (!hll_expand) {
> > -                               hll_lineno++;
> > +                               hll_offset++;
> >                         }
> >                         break;
> >                 case COMMENT:
> > @@ -269,7 +283,7 @@ int cil_parser(const char *_path, char *buffer, uin=
t32_t size, struct cil_tree *
> >                                 cil_lexer_next(&tok);
> >                         }
> >                         if (!hll_expand) {
> > -                               hll_lineno++;
> > +                               hll_offset++;
> >                         }
> >                         if (tok.type !=3D END_OF_FILE) {
> >                                 break;
> > @@ -306,7 +320,7 @@ int cil_parser(const char *_path, char *buffer, uin=
t32_t size, struct cil_tree *
> >
> >  exit:
> >         while (!cil_stack_is_empty(stack)) {
> > -               pop_hll_info(stack, &hll_lineno, &hll_expand);
> > +               pop_hll_info(stack, &hll_offset, &hll_expand);
> >         }
> >         cil_lexer_destroy();
> >         cil_stack_destroy(&stack);
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 52b28999..4fdf339d 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -50,10 +50,12 @@ __attribute__((noreturn)) __attribute__((format (pr=
intf, 1, 2))) void cil_tree_e
> >         exit(1);
> >  }
> >
> > -struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *nod=
e, char **path, int* is_cil)
> > +struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *nod=
e, char **info_kind, uint32_t *hll_line, char **path)
> >  {
> > +       int rc;
> > +
> >         if (!node) {
> > -               return NULL;
> > +               goto exit;
> >         }
> >
> >         node =3D node->parent;
> > @@ -62,16 +64,21 @@ struct cil_tree_node *cil_tree_get_next_path(struct=
 cil_tree_node *node, char **
> >                 if (node->flavor =3D=3D CIL_NODE && node->data =3D=3D N=
ULL) {
> >                         if (node->cl_head->data =3D=3D CIL_KEY_SRC_INFO=
 && node->cl_head->next !=3D NULL && node->cl_head->next->next !=3D NULL) {
> >                                 /* Parse Tree */
> > -                               *path =3D node->cl_head->next->next->da=
ta;
> > -                               *is_cil =3D (node->cl_head->next->data =
=3D=3D CIL_KEY_SRC_CIL);
> > +                               *info_kind =3D node->cl_head->next->dat=
a;
> > +                               rc =3D cil_string_to_uint32(node->cl_he=
ad->next->next->data, hll_line, 10);
> > +                               if (rc !=3D SEPOL_OK) {
> > +                                       goto exit;
> > +                               }
> > +                               *path =3D node->cl_head->next->next->ne=
xt->data;
> >                                 return node;
> >                         }
> >                         node =3D node->parent;
> >                 } else if (node->flavor =3D=3D CIL_SRC_INFO) {
> >                                 /* AST */
> >                                 struct cil_src_info *info =3D node->dat=
a;
> > +                               *info_kind =3D info->kind;
> > +                               *hll_line =3D info->hll_line;
> >                                 *path =3D info->path;
> > -                               *is_cil =3D (info->kind =3D=3D CIL_KEY_=
SRC_CIL);
> >                                 return node;
> >                 } else {
> >                         if (node->flavor =3D=3D CIL_CALL) {
> > @@ -86,17 +93,22 @@ struct cil_tree_node *cil_tree_get_next_path(struct=
 cil_tree_node *node, char **
> >                 }
> >         }
> >
> > +exit:
> > +       *info_kind =3D NULL;
> > +       *hll_line =3D 0;
> > +       *path =3D NULL;
> >         return NULL;
> >  }
> >
> >  char *cil_tree_get_cil_path(struct cil_tree_node *node)
> >  {
> > -       char *path =3D NULL;
> > -       int is_cil;
> > +       char *info_kind;
> > +       uint32_t hll_line;
> > +       char *path;
> >
> >         while (node) {
> > -               node =3D cil_tree_get_next_path(node, &path, &is_cil);
> > -               if (node && is_cil) {
> > +               node =3D cil_tree_get_next_path(node, &info_kind, &hll_=
line, &path);
> > +               if (node && info_kind =3D=3D CIL_KEY_SRC_CIL) {
> >                         return path;
> >                 }
> >         }
> > @@ -114,8 +126,7 @@ __attribute__((format (printf, 3, 4))) void cil_tre=
e_log(struct cil_tree_node *n
> >
> >         if (node) {
> >                 char *path =3D NULL;
> > -               int is_cil;
> > -               unsigned hll_line =3D node->hll_line;
> > +               uint32_t hll_offset =3D node->hll_offset;
> >
> >                 path =3D cil_tree_get_cil_path(node);
> >
> > @@ -124,12 +135,20 @@ __attribute__((format (printf, 3, 4))) void cil_t=
ree_log(struct cil_tree_node *n
> >                 }
> >
> >                 while (node) {
> > -                       node =3D cil_tree_get_next_path(node, &path, &i=
s_cil);
> > -                       if (node && !is_cil) {
> > +                       do {
> > +                               char *info_kind;
> > +                               uint32_t hll_line;
> > +
> > +                               node =3D cil_tree_get_next_path(node, &=
info_kind, &hll_line, &path);
> > +                               if (!node || info_kind =3D=3D CIL_KEY_S=
RC_CIL) {
> > +                                       break;
> > +                               }
> > +                               if (info_kind =3D=3D CIL_KEY_SRC_HLL_LM=
S) {
> > +                                       hll_line +=3D hll_offset - node=
->hll_offset - 1;
> > +                               }
> > +
> >                                 cil_log(lvl," from %s:%d", path, hll_li=
ne);
>
> While modifying this code, it would be nice if this "%d" was modified
> to "%u", as hll_line should never be negative.
>
> > -                               path =3D NULL;
> > -                               hll_line =3D node->hll_line;
> > -                       }
> > +                       } while (1);
> >                 }
> >         }
> >
> > @@ -222,7 +241,7 @@ void cil_tree_node_init(struct cil_tree_node **node=
)
> >         new_node->next =3D NULL;
> >         new_node->flavor =3D CIL_ROOT;
> >         new_node->line =3D 0;
> > -       new_node->hll_line =3D 0;
> > +       new_node->hll_offset =3D 0;
> >
> >         *node =3D new_node;
> >  }
> > diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> > index f4d22071..5a98da55 100644
> > --- a/libsepol/cil/src/cil_tree.h
> > +++ b/libsepol/cil/src/cil_tree.h
> > @@ -46,11 +46,11 @@ struct cil_tree_node {
> >         struct cil_tree_node *next;             //Each element in the l=
ist points to the next element
> >         enum cil_flavor flavor;
> >         uint32_t line;
> > -       uint32_t hll_line;
> > +       uint32_t hll_offset;
> >         void *data;
> >  };
> >
> > -struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *nod=
e, char **path, int* is_cil);
> > +struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *nod=
e, char **info_kind, uint32_t *hll_line, char **path);
> >  char *cil_tree_get_cil_path(struct cil_tree_node *node);
> >  __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tr=
ee_node *node, enum cil_log_level lvl, const char* msg, ...);
> >
> > --
> > 2.31.1
> >
>
