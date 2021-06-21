Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A2AC48BE5
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF7E61245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUU7e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFUU7e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:59:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F171C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:57:19 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso19100858otu.10
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/oG/InMi9RwnTZLZCVsenUo0CUkYh35VIUEjx/sjfJY=;
        b=XpaGUMWXJp74wWNcN2ABb+W5SsOe2PVMJyT7vk2+MQ5bZi7yqis3EL6/pJYGDLLsFn
         AOXI3bM6tubdZc7frJMetW/GaxFhTMoib20E4pF4GJxhJcwEm1wVKZGPZL0qppmrSRcu
         vyRiyXnPk/9Bhc8yx7szI8sskzjh+i7iurFRHWmCUqHC4Q29dygZEpQQiMdmPxLX5Z1+
         4fVDu/Ncf9C7k5dtQ7Lh6OUK4De1SXDBQjsJ/vNFwNWYYD0mqBDLdHI5jT/6vC6SYae6
         FA5WHU6QvQ9L2yMoPU3ZvZYOngCT5cu/R+Z9DJikcPxI2Z1I93PP4nSBuYvK7Wsq2sCH
         SAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/oG/InMi9RwnTZLZCVsenUo0CUkYh35VIUEjx/sjfJY=;
        b=mrtW7VioWNXRfOH5Na74inekjB2VOEf1wGksOfgozOgLy+YpwwHVQFOmIP50Gnh8oE
         E5RVpViS/lvNvgqg5SOWo+wIuZ/7/QdOIYYNcDRAcEeLy4OAEaM1URhhTWKEoq2DZ9UV
         pUgBwdFFODybFIubIqfl0RtE5OHgj/TUpms7AAKCvWxMIbOGms89m/KZWVF0kAhmbKRc
         etMGNb0g2++wQfSySeztinRgInLb9E089VJ04LRMMroiFYNDQWONxE9elVO3nYZFfG4p
         SLp2lOqIULOWS5cANjSw4DDSZuCjGQX86u2LJvnTixfKlBK2XSjXXLd/+8PnWTGPTRh1
         nIzA==
X-Gm-Message-State: AOAM531xkHq4kx48WN1p+tuXKGmcAI8wXuTldCNuD7h2NhuKp1aOseeL
        OYb91KoBrsHI/IySv86edz97R+YR2tfHGWgwYTo=
X-Google-Smtp-Source: ABdhPJxV5ER1B1eIYCIwTZNS2OZ/v4LuwIyn2ZtfQS/GUaCJGXIqpLdqqvvS5/foxtdTO4QLZ611yeIWb9FYKuoXnkk=
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr324685otp.295.1624309038950;
 Mon, 21 Jun 2021 13:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-8-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-8-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:57:08 -0400
Message-ID: <CAP+JOzToZ0Dy8LTg+qq0JRABCb8-+7Vw+Q1pvJa7J4R6+Au6Pg@mail.gmail.com>
Subject: Re: [PATCH 07/23] libsepol: follow declaration-after-statement
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Follow the project style of no declaration after statement.
>
> Found by the gcc warning -Wdeclaration-after-statement
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/booleans.c      |  6 ++--
>  libsepol/src/debug.c         |  2 +-
>  libsepol/src/ebitmap.c       | 11 ++++---
>  libsepol/src/module_to_cil.c | 10 +++---
>  libsepol/src/nodes.c         |  6 ++--
>  libsepol/src/services.c      | 59 ++++++++++++++++++------------------
>  libsepol/src/util.c          |  2 +-
>  7 files changed, 50 insertions(+), 46 deletions(-)
>
> diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
> index 30fcf29d..716da6b4 100644
> --- a/libsepol/src/booleans.c
> +++ b/libsepol/src/booleans.c
> @@ -19,6 +19,7 @@ static int bool_update(sepol_handle_t * handle,
>         const char *cname;
>         char *name;
>         int value;
> +       cond_bool_datum_t *datum;
>
>         sepol_bool_key_unpack(key, &cname);
>         name =3D strdup(cname);
> @@ -27,8 +28,7 @@ static int bool_update(sepol_handle_t * handle,
>         if (!name)
>                 goto omem;
>
> -       cond_bool_datum_t *datum =3D
> -           hashtab_search(policydb->p_bools.table, name);
> +       datum =3D hashtab_search(policydb->p_bools.table, name);
>         if (!datum) {
>                 ERR(handle, "boolean %s no longer in policy", name);
>                 goto err;
> @@ -84,10 +84,10 @@ int sepol_bool_set(sepol_handle_t * handle,
>                    const sepol_bool_key_t * key, const sepol_bool_t * dat=
a)
>  {
>
> +       policydb_t *policydb =3D &p->p;
>         const char *name;
>         sepol_bool_key_unpack(key, &name);
>
> -       policydb_t *policydb =3D &p->p;
>         if (bool_update(handle, policydb, key, data) < 0)
>                 goto err;
>
> diff --git a/libsepol/src/debug.c b/libsepol/src/debug.c
> index 0458e353..f6a59ae7 100644
> --- a/libsepol/src/debug.c
> +++ b/libsepol/src/debug.c
> @@ -44,6 +44,7 @@ void sepol_msg_default_handler(void *varg __attribute__=
 ((unused)),
>  {
>
>         FILE *stream =3D NULL;
> +       va_list ap;
>
>         switch (sepol_msg_get_level(handle)) {
>
> @@ -60,7 +61,6 @@ void sepol_msg_default_handler(void *varg __attribute__=
 ((unused)),
>         fprintf(stream, "%s.%s: ",
>                 sepol_msg_get_channel(handle), sepol_msg_get_fname(handle=
));
>
> -       va_list ap;
>         va_start(ap, fmt);
>         vfprintf(stream, fmt, ap);
>         va_end(ap);
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 7f425349..522e14a6 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -113,9 +113,10 @@ int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsig=
ned int maxbit)
>
>  int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigne=
d int maxbit)
>  {
> +       int rc;
>         ebitmap_t e3;
>         ebitmap_init(dst);
> -       int rc =3D ebitmap_not(&e3, e2, maxbit);
> +       rc =3D ebitmap_not(&e3, e2, maxbit);
>         if (rc < 0)
>                 return rc;
>         rc =3D ebitmap_and(dst, e1, &e3);
> @@ -138,13 +139,15 @@ unsigned int ebitmap_cardinality(ebitmap_t *e1)
>
>  int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2)
>  {
> +       int rc;
> +       ebitmap_t tmp;
> +       int distance;
>         if (ebitmap_cmp(e1, e2))
>                 return 0;
> -       ebitmap_t tmp;
> -       int rc =3D ebitmap_xor(&tmp, e1, e2);
> +       rc =3D ebitmap_xor(&tmp, e1, e2);
>         if (rc < 0)
>                 return -1;
> -       int distance =3D ebitmap_cardinality(&tmp);
> +       distance =3D ebitmap_cardinality(&tmp);
>         ebitmap_destroy(&tmp);
>         return distance;
>  }
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 41605eb8..73ec7971 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -107,8 +107,8 @@ static void cil_printf(const char *fmt, ...) {
>  __attribute__ ((format(printf, 2, 3)))
>  static void cil_println(int indent, const char *fmt, ...)
>  {
> -       cil_indent(indent);
>         va_list argptr;
> +       cil_indent(indent);
>         va_start(argptr, fmt);
>         if (vfprintf(out_file, fmt, argptr) < 0) {
>                 log_err("Failed to write to output");
> @@ -235,12 +235,14 @@ static void role_list_destroy(void)
>
>  static void attr_list_destroy(struct list **attr_list)
>  {
> +       struct list_node *curr;
> +       struct attr_list_node *attr;
> +
>         if (attr_list =3D=3D NULL || *attr_list =3D=3D NULL) {
>                 return;
>         }
>
> -       struct list_node *curr =3D (*attr_list)->head;
> -       struct attr_list_node *attr;
> +       curr =3D (*attr_list)->head;
>
>         while (curr !=3D NULL) {
>                 attr =3D curr->data;
> @@ -3525,12 +3527,12 @@ exit:
>  static int additive_scopes_to_cil(int indent, struct policydb *pdb, stru=
ct avrule_block *block, struct stack *decl_stack)
>  {
>         int rc =3D -1;
> +       struct avrule_decl *decl =3D stack_peek(decl_stack);
>         struct map_args args;
>         args.pdb =3D pdb;
>         args.block =3D block;
>         args.decl_stack =3D decl_stack;
>         args.indent =3D indent;
> -       struct avrule_decl *decl =3D stack_peek(decl_stack);
>
>         for (args.sym_index =3D 0; args.sym_index < SYM_NUM; args.sym_ind=
ex++) {
>                 if (func_to_cil[args.sym_index] =3D=3D NULL) {
> diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
> index 820346d0..97a0f959 100644
> --- a/libsepol/src/nodes.c
> +++ b/libsepol/src/nodes.c
> @@ -19,20 +19,20 @@ static int node_from_record(sepol_handle_t * handle,
>         ocontext_t *tmp_node =3D NULL;
>         context_struct_t *tmp_con =3D NULL;
>         char *addr_buf =3D NULL, *mask_buf =3D NULL;
> +       size_t addr_bsize, mask_bsize;
> +       int proto;
>
>         tmp_node =3D (ocontext_t *) calloc(1, sizeof(ocontext_t));
>         if (!tmp_node)
>                 goto omem;
>
> -       size_t addr_bsize, mask_bsize;
> -
>         /* Address and netmask */
>         if (sepol_node_get_addr_bytes(handle, data, &addr_buf, &addr_bsiz=
e) < 0)
>                 goto err;
>         if (sepol_node_get_mask_bytes(handle, data, &mask_buf, &mask_bsiz=
e) < 0)
>                 goto err;
>
> -       int proto =3D sepol_node_get_proto(data);
> +       proto =3D sepol_node_get_proto(data);
>
>         switch (proto) {
>         case SEPOL_PROTO_IP4:
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index ff91f7d2..d647c8f5 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -290,6 +290,19 @@ static char *get_class_info(sepol_security_class_t t=
class,
>  {
>         constraint_expr_t *e;
>         int mls, state_num;
> +       /* Determine statement type */
> +       const char *statements[] =3D {
> +               "constrain ",                   /* 0 */
> +               "mlsconstrain ",                /* 1 */
> +               "validatetrans ",               /* 2 */
> +               "mlsvalidatetrans ",    /* 3 */
> +               0 };
> +       size_t class_buf_len =3D 0;
> +       size_t new_class_buf_len;
> +       size_t buf_used;
> +       int len;
> +       char *class_buf =3D NULL, *p;
> +       char *new_class_buf =3D NULL;
>
>         /* Find if MLS statement or not */
>         mls =3D 0;
> @@ -300,26 +313,11 @@ static char *get_class_info(sepol_security_class_t =
tclass,
>                 }
>         }
>
> -       /* Determine statement type */
> -       const char *statements[] =3D {
> -               "constrain ",                   /* 0 */
> -               "mlsconstrain ",                /* 1 */
> -               "validatetrans ",               /* 2 */
> -               "mlsvalidatetrans ",    /* 3 */
> -               0 };
> -
>         if (xcontext =3D=3D NULL)
>                 state_num =3D mls + 0;
>         else
>                 state_num =3D mls + 2;
>
> -       size_t class_buf_len =3D 0;
> -       size_t new_class_buf_len;
> -       size_t buf_used;
> -       int len;
> -       char *class_buf =3D NULL, *p;
> -       char *new_class_buf =3D NULL;
> -
>         while (1) {
>                 new_class_buf_len =3D class_buf_len + EXPR_BUF_SIZE;
>                 new_class_buf =3D realloc(class_buf, new_class_buf_len);
> @@ -417,6 +415,8 @@ static int constraint_expr_eval_reason(context_struct=
_t *scontext,
>         char *tgt =3D NULL;
>         int rc =3D 0, x;
>         char *class_buf =3D NULL;
> +       int expr_list_len =3D 0;
> +       int expr_count;
>
>         /*
>          * The array of expression answer buffer pointers and counter.
> @@ -424,6 +424,11 @@ static int constraint_expr_eval_reason(context_struc=
t_t *scontext,
>         char **answer_list =3D NULL;
>         int answer_counter =3D 0;
>
> +       /* The pop operands */
> +       char *a;
> +       char *b;
> +       int a_len, b_len;
> +
>         class_buf =3D get_class_info(tclass, constraint, xcontext);
>         if (!class_buf) {
>                 ERR(NULL, "failed to allocate class buffer");
> @@ -431,7 +436,6 @@ static int constraint_expr_eval_reason(context_struct=
_t *scontext,
>         }
>
>         /* Original function but with buffer support */
> -       int expr_list_len =3D 0;
>         expr_counter =3D 0;
>         expr_list =3D NULL;
>         for (e =3D constraint->expr; e; e =3D e->next) {
> @@ -701,7 +705,7 @@ mls_ops:
>          * expr_list malloc's. Normally they are released by the RPN to
>          * infix code.
>          */
> -       int expr_count =3D expr_counter;
> +       expr_count =3D expr_counter;
>         expr_counter =3D 0;
>
>         /*
> @@ -715,11 +719,6 @@ mls_ops:
>                 goto out;
>         }
>
> -       /* The pop operands */
> -       char *a;
> -       char *b;
> -       int a_len, b_len;
> -
>         /* Convert constraint from RPN to infix notation. */
>         for (x =3D 0; x !=3D expr_count; x++) {
>                 if (strncmp(expr_list[x], "and", 3) =3D=3D 0 || strncmp(e=
xpr_list[x],
> @@ -778,14 +777,6 @@ mls_ops:
>                         xcontext ? "Validatetrans" : "Constraint",
>                         s[0] ? "GRANTED" : "DENIED");
>
> -       int len, new_buf_len;
> -       char *p, **new_buf =3D r_buf;
> -       /*
> -        * These contain the constraint components that are added to the
> -        * callers reason buffer.
> -        */
> -       const char *buffers[] =3D { class_buf, a, "); ", tmp_buf, 0 };
> -
>         /*
>          * This will add the constraints to the callers reason buffer (wh=
o is
>          * responsible for freeing the memory). It will handle any reallo=
c's
> @@ -796,6 +787,14 @@ mls_ops:
>
>         if (r_buf && ((s[0] =3D=3D 0) || ((s[0] =3D=3D 1 &&
>                                 (flags & SHOW_GRANTED) =3D=3D SHOW_GRANTE=
D)))) {
> +               int len, new_buf_len;
> +               char *p, **new_buf =3D r_buf;
> +               /*
> +               * These contain the constraint components that are added =
to the
> +               * callers reason buffer.
> +               */
> +               const char *buffers[] =3D { class_buf, a, "); ", tmp_buf,=
 0 };
> +
>                 for (x =3D 0; buffers[x] !=3D NULL; x++) {
>                         while (1) {
>                                 p =3D *r_buf + reason_buf_used;
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index d51750af..a47cae87 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -129,9 +129,9 @@ char *sepol_extended_perms_to_string(avtab_extended_p=
erms_t *xperms)
>         unsigned int bit;
>         unsigned int in_range =3D 0;
>         static char xpermsbuf[2048];
> -       xpermsbuf[0] =3D '\0';
>         char *p;
>         int len, xpermslen =3D 0;
> +       xpermsbuf[0] =3D '\0';
>         p =3D xpermsbuf;
>
>         if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
> --
> 2.32.0
>
