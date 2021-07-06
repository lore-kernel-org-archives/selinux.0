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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B76C07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E246139A
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 15:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhGFPnU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhGFPnU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 11:43:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD1C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 08:40:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so22000582oti.2
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmEelBIjb4Ct5OvBv1rVOyX/ncgLxNspO+0szPtd1ag=;
        b=QGctOMjm5Nd2DnqWEcg9INo1aaJt5W+VOYbFdmz2JkL7eTE9t4IruOEtLQcwq2qKci
         Ei+Jl2eZWH9akCylEwkPO0Rglapoq8L+sJDb0/zPPWmg8p/vtbJL/b39C5G+GulM8KLq
         aU6XC+LSL99AuX0Wr66yr3n0cKG/Z9I02y0vY2Ow3wjdUQTt8sIWdFIs2D4bqzdQuQPd
         T+Rnro3+ES7pf+KRNGgOApON3UWSPmqzjtFl2OXtdf+dsPlNJqQYqTJV17c76WrpCU93
         0gtsYICFgMiygheUyDn4gtNwzF2W7Y8Wje32hIEeRw+Gv3PQl43+MyUasmitaH4Bwy97
         VZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmEelBIjb4Ct5OvBv1rVOyX/ncgLxNspO+0szPtd1ag=;
        b=abeuJx7G5o0/ZZaPIO7Oe0bi8K57wqVMkCjgSna/oB8ewVGPdkyGOrMA4Ywywwus/i
         xmT4MepqLor2DWcQpaWnUJ6YL5ATC8AjrK39uazUIwIrt9MVmHSEYU0ty+EVGFwnXOdl
         w5dGyVrXtB9jUC7Hcd/VDEylxjkoNGo511olBmQU7VAmEsNiZzQgIf4UB2QtvJmNCDAO
         Kb18vQqN9z9xgfn5IgdgGR5h1QHufQiUz0vHL/yudMGx09Nr6XsbBOf7UglPAK0asGtf
         S/BDiCd1ruLw+Z5uvUmFWPaxWorqMTH04F8rS33E8D+Xx1+jLmB1PJxJZId3NfOpIPv4
         TyuA==
X-Gm-Message-State: AOAM531br0NeSbKPg5oX/vnzaYDQWH+QEfLAgslk15XlzFtOr+VtMGE6
        OE0D2EyS50VlyE+30nj/d+d7t4PwqlWATe4H3r0=
X-Google-Smtp-Source: ABdhPJwQnwGO3t2N/JlCaG7tVJ/pTjrjSVEp9/+f0ACRql15cCqMz+U2loSmZEJFPIgyfBmBxjojgqGtN+koITUMFZQ=
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr865887otr.196.1625586040956;
 Tue, 06 Jul 2021 08:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 6 Jul 2021 11:40:29 -0400
Message-ID: <CAP+JOzQN3gcViy-3JRyVmLT6G6LvigerT8Fm=3Ukxn=BHzaTUw@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol: silence -Wextra-semi-stmt warning
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jul 3, 2021 at 10:32 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Ubuntu 20.04, when building with clang -Werror -Wextra-semi-stmt
> (which is not the default build configuration), the compiler reports:
>
>   ../cil/src/cil_binary.c:4293:22: error: empty expression statement
>   has no effect; remove unnecessary ';' to silence this warning
>   [-Werror,-Wextra-semi-stmt]
>           mix(k->target_class);
>                               ^
>   ../cil/src/cil_binary.c:4294:21: error: empty expression statement
>   has no effect; remove unnecessary ';' to silence this warning
>   [-Werror,-Wextra-semi-stmt]
>           mix(k->target_type);
>                              ^
>   ../cil/src/cil_binary.c:4295:21: error: empty expression statement
>   has no effect; remove unnecessary ';' to silence this warning
>   [-Werror,-Wextra-semi-stmt]
>           mix(k->source_type);
>                              ^
>   ../cil/src/cil_binary.c:4296:19: error: empty expression statement
>   has no effect; remove unnecessary ';' to silence this warning
>   [-Werror,-Wextra-semi-stmt]
>           mix(k->specified);
>                            ^
>
> Use a do { ... } while (0) construction to silence this warning.
>
> Moreover the same warning appears when using two semicolons to end a
> statement. Remove such occurrences, like what was already done in commit
> 811185648af2 ("libsepol: drop repeated semicolons").
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

For all six patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c      |  4 ++--
>  libsepol/cil/src/cil_resolve_ast.c |  2 +-
>  libsepol/src/avtab.c               |  4 ++--
>  libsepol/tests/libsepol-tests.c    | 18 +++++++++++-------
>  4 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 54d13f2f3945..41105c122bc3 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4277,7 +4277,7 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hash
>
>         uint32_t hash = 0;
>
> -#define mix(input) { \
> +#define mix(input) do { \
>         uint32_t v = input; \
>         v *= c1; \
>         v = (v << r1) | (v >> (32 - r1)); \
> @@ -4285,7 +4285,7 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hash
>         hash ^= v; \
>         hash = (hash << r2) | (hash >> (32 - r2)); \
>         hash = hash * m + n; \
> -}
> +} while (0)
>
>         mix(k->target_class);
>         mix(k->target_type);
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 32ea64e39b21..9a02e3867659 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2825,7 +2825,7 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
>                         return SEPOL_OK;
>                 } else {
>                         cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
> -                       return SEPOL_ERR;;
> +                       return SEPOL_ERR;
>                 }
>         }
>         if (call->args_tree == NULL) {
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 88e9d510f981..5e16a0e9899e 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -63,7 +63,7 @@ static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
>
>         uint32_t hash = 0;
>
> -#define mix(input) { \
> +#define mix(input) do { \
>         uint32_t v = input; \
>         v *= c1; \
>         v = (v << r1) | (v >> (32 - r1)); \
> @@ -71,7 +71,7 @@ static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
>         hash ^= v; \
>         hash = (hash << r2) | (hash >> (32 - r2)); \
>         hash = hash * m + n; \
> -}
> +} while (0)
>
>         mix(keyp->target_class);
>         mix(keyp->target_type);
> diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
> index 544c792d2ab5..dc8fd5ce5f6c 100644
> --- a/libsepol/tests/libsepol-tests.c
> +++ b/libsepol/tests/libsepol-tests.c
> @@ -36,13 +36,17 @@
>  int mls;
>
>  #define DECLARE_SUITE(name) \
> -       suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
> -       if (NULL == suite) { \
> -               CU_cleanup_registry(); \
> -               return CU_get_error(); } \
> -       if (name##_add_tests(suite)) { \
> -               CU_cleanup_registry(); \
> -               return CU_get_error(); }
> +       do { \
> +               suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
> +               if (NULL == suite) { \
> +                       CU_cleanup_registry(); \
> +                       return CU_get_error(); \
> +               } \
> +               if (name##_add_tests(suite)) { \
> +                       CU_cleanup_registry(); \
> +                       return CU_get_error(); \
> +               } \
> +       } while (0)
>
>  static void usage(char *progname)
>  {
> --
> 2.32.0
>
