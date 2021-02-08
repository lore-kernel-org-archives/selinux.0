Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD42C433DB
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FBB60230
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhBHVEx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:04:53 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39252 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhBHVEb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 16:04:31 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C61D8564EEF
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 22:03:33 +0100 (CET)
Received: by mail-oi1-f178.google.com with SMTP id d20so17101785oiw.10
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 13:03:33 -0800 (PST)
X-Gm-Message-State: AOAM533MW2mPnkB85BFzBav+U2M7jxJIFN6Sf2SV4fqQrGMnUG45VJDL
        3hLQAMPm4cnRPhgADfz/qOXT5vFPmIzrriGV5NU=
X-Google-Smtp-Source: ABdhPJy81E0EcEjgLcu5Wrp4M+i5btkbQX9u2APoAs+IZHY09XrAy7zLxkkOldpRewpbh4OXsOnJo2q3oaTntaXbA0Q=
X-Received: by 2002:a05:6808:918:: with SMTP id w24mr450007oih.20.1612818212663;
 Mon, 08 Feb 2021 13:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20210205144421.279511-1-jwcart2@gmail.com>
In-Reply-To: <20210205144421.279511-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 8 Feb 2021 22:03:21 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==zE4uYDchHDYfF6L3i+1=oqL4nDNHKKQwacn=Q9L8b4g@mail.gmail.com>
Message-ID: <CAJfZ7==zE4uYDchHDYfF6L3i+1=oqL4nDNHKKQwacn=Q9L8b4g@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix integer overflow in the handling of hll
 line marks
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  8 22:03:34 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 3:44 PM James Carter <jwcart2@gmail.com> wrote:
>
> From: James Carter <jwcart2@tycho.nsa.gov>
>
> Nicolass Iooss reports:
>   OSS-Fuzz found an integer overflow when compiling the following
>   (empty) CIL policy:
>
>   ;;*lms 2147483647 a
>   ; (empty line)
>
> Change hll_lineno to uint32_t which is the type of the field hll_line
> in struct cil_tree_node where the line number will be stored eventually.
> Read the line number into an unsigned long variable using strtoul()
> instead of strtol(). On systems where ULONG_MAX > UINT32_MAX, return
> an error if the value is larger than UINT32_MAX.
>
> Also change hll_expand to uint32_t, since its value will be either
> 0 or 1 and there is no need for it to be signed.
>
> Reported-by: Nicolass Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

By the way this week I have infrequent access to the system I use to
work on SELinux stuff, so I will not be able to review/test/apply
patches until next week-end. So feel free to merge this without
waiting for me.

Thanks,
Nicolas

> ---
>  libsepol/cil/src/cil_parser.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> index 0038eed6..a9306218 100644
> --- a/libsepol/cil/src/cil_parser.c
> +++ b/libsepol/cil/src/cil_parser.c
> @@ -47,11 +47,11 @@ char *CIL_KEY_HLL_LMX;
>  char *CIL_KEY_HLL_LME;
>
>  struct hll_info {
> -       int hll_lineno;
> -       int hll_expand;
> +       uint32_t hll_lineno;
> +       uint32_t hll_expand;
>  };
>
> -static void push_hll_info(struct cil_stack *stack, int hll_lineno, int hll_expand)
> +static void push_hll_info(struct cil_stack *stack, uint32_t hll_lineno, uint32_t hll_expand)
>  {
>         struct hll_info *new = cil_malloc(sizeof(*new));
>
> @@ -61,7 +61,7 @@ static void push_hll_info(struct cil_stack *stack, int hll_lineno, int hll_expan
>         cil_stack_push(stack, CIL_NONE, new);
>  }
>
> -static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expand)
> +static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno, uint32_t *hll_expand)
>  {
>         struct cil_stack_item *curr = cil_stack_pop(stack);
>         struct cil_stack_item *prev = cil_stack_peek(stack);
> @@ -70,8 +70,8 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
>         free(curr->data);
>
>         if (!prev) {
> -               *hll_lineno = -1;
> -               *hll_expand = -1;
> +               *hll_lineno = 0;
> +               *hll_expand = 0;
>         } else {
>                 old = prev->data;
>                 *hll_lineno = old->hll_lineno;
> @@ -79,7 +79,7 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
>         }
>  }
>
> -static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, int line, int hll_line, void *value)
> +static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, uint32_t line, uint32_t hll_line, void *value)
>  {
>         cil_tree_node_init(node);
>         (*node)->parent = current;
> @@ -99,13 +99,14 @@ static void insert_node(struct cil_tree_node *node, struct cil_tree_node *curren
>         current->cl_tail = node;
>  }
>
> -static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int *hll_expand, struct cil_stack *stack, char *path)
> +static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno, uint32_t *hll_expand, struct cil_stack *stack, char *path)
>  {
>         char *hll_type;
>         struct cil_tree_node *node;
>         struct token tok;
>         char *hll_file;
>         char *end = NULL;
> +       unsigned long val;
>
>         cil_lexer_next(&tok);
>         hll_type = cil_strpool_add(tok.value);
> @@ -141,11 +142,19 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
>                         cil_log(CIL_ERR, "Invalid line mark syntax\n");
>                         goto exit;
>                 }
> -               *hll_lineno = strtol(tok.value, &end, 10);
> +
> +               val = strtoul(tok.value, &end, 10);
>                 if (errno == ERANGE || *end != '\0') {
>                         cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
>                         goto exit;
>                 }
> +#if ULONG_MAX > UINT32_MAX
> +               if (val > UINT32_MAX) {
> +                       cil_log(CIL_ERR, "Line mark line number > UINT32_MAX\n");
> +                       goto exit;
> +               }
> +#endif
> +               *hll_lineno = val;
>
>                 push_hll_info(stack, *hll_lineno, *hll_expand);
>
> @@ -175,7 +184,7 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
>         return SEPOL_OK;
>
>  exit:
> -       cil_log(CIL_ERR, "Problem with high-level line mark at line %d of %s\n", tok.line, path);
> +       cil_log(CIL_ERR, "Problem with high-level line mark at line %u of %s\n", tok.line, path);
>         return SEPOL_ERR;
>  }
>
> @@ -207,8 +216,8 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
>         struct cil_tree_node *current = NULL;
>         char *path = cil_strpool_add(_path);
>         struct cil_stack *stack;
> -       int hll_lineno = -1;
> -       int hll_expand = -1;
> +       uint32_t hll_lineno = 0;
> +       uint32_t hll_expand = 0;
>         struct token tok;
>         int rc = SEPOL_OK;
>
> --
> 2.26.2
>

