Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E180C4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44DC61AFC
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 09:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhHPJYY convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:24:24 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56915 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhHPJYY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 05:24:24 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C7C4D564792
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 11:23:50 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so10890823pjz.0
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 02:23:50 -0700 (PDT)
X-Gm-Message-State: AOAM5310FURhjO8dX1bkSXR8KBHigMVF3E+Vl67pEBPjN3FU9libnbqj
        BTcu7529FZQ+0JClCWgMo8nRl/FvxVGpc07CoeU=
X-Google-Smtp-Source: ABdhPJznvzclzhS25TZkTBlHPwCs5Lebe254YFs2xZqYsQDP5Fuy4sFYS4VVSs4A5mBZI3tuO3i2Y4joGyKKjSySM04=
X-Received: by 2002:a17:90a:a96:: with SMTP id 22mr16391263pjw.156.1629105829107;
 Mon, 16 Aug 2021 02:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210810180537.669439-1-jwcart2@gmail.com> <20210810180537.669439-8-jwcart2@gmail.com>
In-Reply-To: <20210810180537.669439-8-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 16 Aug 2021 11:23:38 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nsPMgBFrfHiAdAhOVY9XNJxDuR7=sSbE8=fP1EAFuNPw@mail.gmail.com>
Message-ID: <CAJfZ7=nsPMgBFrfHiAdAhOVY9XNJxDuR7=sSbE8=fP1EAFuNPw@mail.gmail.com>
Subject: Re: [PATCH 7/8] libsepol/cil: Report correct high-level language line numbers
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Aug 16 11:23:51 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 10, 2021 at 8:22 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL supports specifiying the original high-level language file and
> line numbers when reporting errors. This is done through line marks
> and is mostly used to report the original Refpolicy file and line
> number for neverallow rules that have been converted to CIL.
>
> As long as the line mark remain simple, everything works fine, but
> the wrong line numbers will be reported with more complex nextings
> of line marks.
>
> Example:
> ;;* lms 100 file01.hll
> (type t1a)
> (allow t1a self (CLASS (PERM)))
> ;;* lmx 200 file02.hll
> (type t2a)
> (allow t2a self (CLASS (PERM)))
> ;;* lme
> (type t1b)
> (allow t1b self (CLASS (PERM)))
> (allow bad1b self (CLASS (PERM))) ; file01.hll:101 (Should be 106)
> ;;* lme
>
> The primary problem is that the tree nodes can only store one hll
> line number. Instead a number is needed that can be used by any
> number of stacked line mark sections. This number would increment
> line a normal line number except when in lmx sections (that have
> the same line number throughout the section because they represent
> an expansion of a line -- like the expansion of a macro call. This
> number can go backwards when exiting a lms section within a lmx
> section, because line number will increase in the lms section, but
> outside the lmx section, the line number did not advance.
>
> This number is called the hll_offset and this is the value that is
> now stored in tree nodes instead of the hll line number. To calculate
> the hll line number for a rule, a search is made for an ancestor of
> the node that is a line mark and the line number for a lms section
> is the hll line number stored in the line mark, plus the hll offset
> of the rule, minus the hll offset of the line mark node, minus one.
> (hll_lineno + hll_offset_rule - hll_offset_lm - 1)
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_binary.c    |  9 ++--
>  libsepol/cil/src/cil_build_ast.c |  4 +-
>  libsepol/cil/src/cil_copy_ast.c  |  2 +-
>  libsepol/cil/src/cil_parser.c    | 74 +++++++++++++++++++-------------
>  libsepol/cil/src/cil_tree.c      | 53 +++++++++++++++--------
>  libsepol/cil/src/cil_tree.h      |  4 +-
>  6 files changed, 90 insertions(+), 56 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 2b65c622..43c37fc2 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4480,7 +4480,8 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *no
>         avrule_t *avrule;
>         struct cil_tree_node *source_node;
>         char *source_path;
> -       int is_cil;
> +       char *lm_kind;
> +       uint32_t hll_line;
>
>         avrule = cil_malloc(sizeof(avrule_t));
>         avrule->specified = kind;
> @@ -4492,11 +4493,11 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *no
>
>         avrule->source_filename = NULL;
>         avrule->source_line = node->line;
> -       source_node = cil_tree_get_next_path(node, &source_path, &is_cil);
> +       source_node = cil_tree_get_next_path(node, &lm_kind, &hll_line, &source_path);
>         if (source_node) {
>                 avrule->source_filename = source_path;
> -               if (!is_cil) {
> -                       avrule->source_line = node->hll_line;
> +               if (lm_kind != CIL_KEY_SRC_CIL) {
> +                       avrule->source_line = hll_line + node->hll_offset - source_node->hll_offset - 1;
>                 }
>         }
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index a0f58b1e..a5afc267 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -619,7 +619,7 @@ int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, st
>                 cil_tree_node_init(&new_ast);
>                 new_ast->parent = ast_node;
>                 new_ast->line = current_perm->line;
> -               new_ast->hll_line = current_perm->hll_line;
> +               new_ast->hll_offset = current_perm->hll_offset;
>
>                 rc = cil_gen_perm(db, current_perm, new_ast, flavor, num_perms);
>                 if (rc != SEPOL_OK) {
> @@ -6203,7 +6203,7 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
>
>         ast_node->parent = ast_current;
>         ast_node->line = parse_current->line;
> -       ast_node->hll_line = parse_current->hll_line;
> +       ast_node->hll_offset = parse_current->hll_offset;
>
>         if (parse_current->data == CIL_KEY_BLOCK) {
>                 rc = cil_gen_block(db, parse_current, ast_node, 0);
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index 02b9828f..34282a92 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -2010,7 +2010,7 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
>
>                 new->parent = parent;
>                 new->line = orig->line;
> -               new->hll_line = orig->hll_line;
> +               new->hll_offset = orig->hll_offset;
>                 new->flavor = orig->flavor;
>                 new->data = data;
>
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> index 842c327c..3ccef5d7 100644
> --- a/libsepol/cil/src/cil_parser.c
> +++ b/libsepol/cil/src/cil_parser.c
> @@ -45,21 +45,21 @@
>  #define CIL_PARSER_MAX_EXPR_DEPTH (0x1 << 12)
>
>  struct hll_info {
> -       uint32_t hll_lineno;
> +       uint32_t hll_offset;
>         uint32_t hll_expand;
>  };
>
> -static void push_hll_info(struct cil_stack *stack, uint32_t hll_lineno, uint32_t hll_expand)
> +static void push_hll_info(struct cil_stack *stack, uint32_t hll_offset, uint32_t hll_expand)
>  {
>         struct hll_info *new = cil_malloc(sizeof(*new));
>
> -       new->hll_lineno = hll_lineno;
> +       new->hll_offset = hll_offset;
>         new->hll_expand = hll_expand;
>
>         cil_stack_push(stack, CIL_NONE, new);
>  }
>
> -static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno, uint32_t *hll_expand)
> +static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_offset, uint32_t *hll_expand)
>  {
>         struct cil_stack_item *curr = cil_stack_pop(stack);
>         struct hll_info *info;
> @@ -69,17 +69,17 @@ static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno, uint32_t
>         }
>         info = curr->data;
>         *hll_expand = info->hll_expand;
> -       *hll_lineno = info->hll_lineno;
> +       *hll_offset = info->hll_offset;
>         free(curr->data);
>  }
>
> -static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, uint32_t line, uint32_t hll_line, void *value)
> +static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, uint32_t line, uint32_t hll_offset, void *value)
>  {
>         cil_tree_node_init(node);
>         (*node)->parent = current;
>         (*node)->flavor = CIL_NODE;
>         (*node)->line = line;
> -       (*node)->hll_line = hll_line;
> +       (*node)->hll_offset = hll_offset;
>         (*node)->data = value;
>  }
>
> @@ -93,12 +93,12 @@ static void insert_node(struct cil_tree_node *node, struct cil_tree_node *curren
>         current->cl_tail = node;
>  }
>
> -static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno, uint32_t *hll_expand, struct cil_stack *stack, char *path)
> +static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_offset, uint32_t *hll_expand, struct cil_stack *stack, char *path)
>  {
>         char *hll_type;
>         struct cil_tree_node *node;
>         struct token tok;
> -       int rc;
> +       uint32_t prev_hll_expand, prev_hll_offset;

In this function, gcc (in GitHub Actions CI) reports:

  ../cil/src/cil_parser.c: In function ‘cil_parser’:
  ../cil/src/cil_parser.c:181:16: error: ‘hll_offset’ may be used
uninitialized in this function [-Werror=maybe-uninitialized]
    181 |   (*hll_offset)++;
        |   ~~~~~~~~~~~~~^~
  ../cil/src/cil_parser.c:222:11: note: ‘hll_offset’ was declared here
    222 |  uint32_t hll_offset = 1;
        |           ^~~~~~~~~~

In fact the warning is misleading because it comes from
prev_hll_offset not being initialized and gcc having trouble figuring
out it is initialized in calls to pop_hll_info.

To silence this warning, could you initialize prev_hll_offset to some value?

>
>         cil_lexer_next(&tok);
>         if (tok.type != SYMBOL) {
> @@ -115,19 +115,33 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
>                         cil_log(CIL_ERR, "Line mark end without start\n");
>                         goto exit;
>                 }
> -               pop_hll_info(stack, hll_lineno, hll_expand);
> +               prev_hll_expand = *hll_expand;
> +               pop_hll_info(stack, &prev_hll_offset, hll_expand);
> +               if (*hll_expand) {
> +                       /* This is needed when exiting an lms section within an lmx section.
> +                        * In the lms section, hll_offset will increment and then revert
> +                        * back to its previous value when going back into the lmx section.
> +                        */
> +                       *hll_offset = prev_hll_offset;
> +               }
> +               if (prev_hll_expand && !*hll_expand) {
> +                       /* This is needed to count the lme at the end of an lmx section
> +                        * within an lms section (or within no hll section).
> +                        */
> +                       (*hll_offset)++;
> +               }
>                 *current = (*current)->parent;
>         } else {
> -               push_hll_info(stack, *hll_lineno, *hll_expand);
> +               push_hll_info(stack, *hll_offset, *hll_expand);
>
> -               create_node(&node, *current, tok.line, *hll_lineno, NULL);
> +               create_node(&node, *current, tok.line, *hll_offset, NULL);
>                 insert_node(node, *current);
>                 *current = node;
>
> -               create_node(&node, *current, tok.line, *hll_lineno, CIL_KEY_SRC_INFO);
> +               create_node(&node, *current, tok.line, *hll_offset, CIL_KEY_SRC_INFO);
>                 insert_node(node, *current);
>
> -               create_node(&node, *current, tok.line, *hll_lineno, hll_type);
> +               create_node(&node, *current, tok.line, *hll_offset, hll_type);
>                 insert_node(node, *current);
>
>                 cil_lexer_next(&tok);
> @@ -136,16 +150,9 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
>                         goto exit;
>                 }
>
> -               create_node(&node, *current, tok.line, *hll_lineno, cil_strpool_add(tok.value));
> +               create_node(&node, *current, tok.line, *hll_offset, cil_strpool_add(tok.value));
>                 insert_node(node, *current);
>
> -               rc = cil_string_to_uint32(tok.value, hll_lineno, 10);
> -               if (rc != SEPOL_OK) {
> -                       goto exit;
> -               }
> -
> -               *hll_expand = (hll_type == CIL_KEY_SRC_HLL_LMX) ? 1 : 0;
> -
>                 cil_lexer_next(&tok);
>                 if (tok.type != SYMBOL && tok.type != QSTRING) {
>                         cil_log(CIL_ERR, "Invalid line mark syntax\n");
> @@ -157,8 +164,10 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
>                         tok.value = tok.value+1;
>                 }
>
> -               create_node(&node, *current, tok.line, *hll_lineno, cil_strpool_add(tok.value));
> +               create_node(&node, *current, tok.line, *hll_offset, cil_strpool_add(tok.value));
>                 insert_node(node, *current);
> +
> +               *hll_expand = (hll_type == CIL_KEY_SRC_HLL_LMX) ? 1 : 0;
>         }
>
>         cil_lexer_next(&tok);
> @@ -167,6 +176,11 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno
>                 goto exit;
>         }
>
> +       if (!*hll_expand) {
> +               /* Need to increment because of the NEWLINE */
> +               (*hll_offset)++;
> +       }
> +
>         return SEPOL_OK;
>
>  exit:
> @@ -205,7 +219,7 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>         struct cil_tree_node *current = NULL;
>         char *path = cil_strpool_add(_path);
>         struct cil_stack *stack;
> -       uint32_t hll_lineno = 0;
> +       uint32_t hll_offset = 1;
>         uint32_t hll_expand = 0;
>         struct token tok;
>         int rc = SEPOL_OK;
> @@ -223,7 +237,7 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>                 cil_lexer_next(&tok);
>                 switch (tok.type) {
>                 case HLL_LINEMARK:
> -                       rc = add_hll_linemark(&current, &hll_lineno, &hll_expand, stack, path);
> +                       rc = add_hll_linemark(&current, &hll_offset, &hll_expand, stack, path);
>                         if (rc != SEPOL_OK) {
>                                 goto exit;
>                         }
> @@ -234,7 +248,7 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>                                 cil_log(CIL_ERR, "Number of open parenthesis exceeds limit of %d at line %d of %s\n", CIL_PARSER_MAX_EXPR_DEPTH, tok.line, path);
>                                 goto exit;
>                         }
> -                       create_node(&node, current, tok.line, hll_lineno, NULL);
> +                       create_node(&node, current, tok.line, hll_offset, NULL);
>                         insert_node(node, current);
>                         current = node;
>                         break;
> @@ -256,12 +270,12 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>                                 goto exit;
>                         }
>
> -                       create_node(&node, current, tok.line, hll_lineno, cil_strpool_add(tok.value));
> +                       create_node(&node, current, tok.line, hll_offset, cil_strpool_add(tok.value));
>                         insert_node(node, current);
>                         break;
>                 case NEWLINE :
>                         if (!hll_expand) {
> -                               hll_lineno++;
> +                               hll_offset++;
>                         }
>                         break;
>                 case COMMENT:
> @@ -269,7 +283,7 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>                                 cil_lexer_next(&tok);
>                         }
>                         if (!hll_expand) {
> -                               hll_lineno++;
> +                               hll_offset++;
>                         }
>                         if (tok.type != END_OF_FILE) {
>                                 break;
> @@ -306,7 +320,7 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>
>  exit:
>         while (!cil_stack_is_empty(stack)) {
> -               pop_hll_info(stack, &hll_lineno, &hll_expand);
> +               pop_hll_info(stack, &hll_offset, &hll_expand);
>         }
>         cil_lexer_destroy();
>         cil_stack_destroy(&stack);
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 52b28999..4fdf339d 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -50,10 +50,12 @@ __attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_tree_e
>         exit(1);
>  }
>
> -struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **path, int* is_cil)
> +struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **info_kind, uint32_t *hll_line, char **path)
>  {
> +       int rc;
> +
>         if (!node) {
> -               return NULL;
> +               goto exit;
>         }
>
>         node = node->parent;
> @@ -62,16 +64,21 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
>                 if (node->flavor == CIL_NODE && node->data == NULL) {
>                         if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
>                                 /* Parse Tree */
> -                               *path = node->cl_head->next->next->data;
> -                               *is_cil = (node->cl_head->next->data == CIL_KEY_SRC_CIL);
> +                               *info_kind = node->cl_head->next->data;
> +                               rc = cil_string_to_uint32(node->cl_head->next->next->data, hll_line, 10);
> +                               if (rc != SEPOL_OK) {
> +                                       goto exit;
> +                               }
> +                               *path = node->cl_head->next->next->next->data;
>                                 return node;
>                         }
>                         node = node->parent;
>                 } else if (node->flavor == CIL_SRC_INFO) {
>                                 /* AST */
>                                 struct cil_src_info *info = node->data;
> +                               *info_kind = info->kind;
> +                               *hll_line = info->hll_line;
>                                 *path = info->path;
> -                               *is_cil = (info->kind == CIL_KEY_SRC_CIL);
>                                 return node;
>                 } else {
>                         if (node->flavor == CIL_CALL) {
> @@ -86,17 +93,22 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
>                 }
>         }
>
> +exit:
> +       *info_kind = NULL;
> +       *hll_line = 0;
> +       *path = NULL;
>         return NULL;
>  }
>
>  char *cil_tree_get_cil_path(struct cil_tree_node *node)
>  {
> -       char *path = NULL;
> -       int is_cil;
> +       char *info_kind;
> +       uint32_t hll_line;
> +       char *path;
>
>         while (node) {
> -               node = cil_tree_get_next_path(node, &path, &is_cil);
> -               if (node && is_cil) {
> +               node = cil_tree_get_next_path(node, &info_kind, &hll_line, &path);
> +               if (node && info_kind == CIL_KEY_SRC_CIL) {
>                         return path;
>                 }
>         }
> @@ -114,8 +126,7 @@ __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *n
>
>         if (node) {
>                 char *path = NULL;
> -               int is_cil;
> -               unsigned hll_line = node->hll_line;
> +               uint32_t hll_offset = node->hll_offset;
>
>                 path = cil_tree_get_cil_path(node);
>
> @@ -124,12 +135,20 @@ __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *n
>                 }
>
>                 while (node) {
> -                       node = cil_tree_get_next_path(node, &path, &is_cil);
> -                       if (node && !is_cil) {
> +                       do {
> +                               char *info_kind;
> +                               uint32_t hll_line;
> +
> +                               node = cil_tree_get_next_path(node, &info_kind, &hll_line, &path);
> +                               if (!node || info_kind == CIL_KEY_SRC_CIL) {
> +                                       break;
> +                               }
> +                               if (info_kind == CIL_KEY_SRC_HLL_LMS) {
> +                                       hll_line += hll_offset - node->hll_offset - 1;
> +                               }
> +
>                                 cil_log(lvl," from %s:%d", path, hll_line);

While modifying this code, it would be nice if this "%d" was modified
to "%u", as hll_line should never be negative.

> -                               path = NULL;
> -                               hll_line = node->hll_line;
> -                       }
> +                       } while (1);
>                 }
>         }
>
> @@ -222,7 +241,7 @@ void cil_tree_node_init(struct cil_tree_node **node)
>         new_node->next = NULL;
>         new_node->flavor = CIL_ROOT;
>         new_node->line = 0;
> -       new_node->hll_line = 0;
> +       new_node->hll_offset = 0;
>
>         *node = new_node;
>  }
> diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> index f4d22071..5a98da55 100644
> --- a/libsepol/cil/src/cil_tree.h
> +++ b/libsepol/cil/src/cil_tree.h
> @@ -46,11 +46,11 @@ struct cil_tree_node {
>         struct cil_tree_node *next;             //Each element in the list points to the next element
>         enum cil_flavor flavor;
>         uint32_t line;
> -       uint32_t hll_line;
> +       uint32_t hll_offset;
>         void *data;
>  };
>
> -struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **path, int* is_cil);
> +struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **info_kind, uint32_t *hll_line, char **path);
>  char *cil_tree_get_cil_path(struct cil_tree_node *node);
>  __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...);
>
> --
> 2.31.1
>

