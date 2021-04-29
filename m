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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F6C433ED
	for <selinux@archiver.kernel.org>; Thu, 29 Apr 2021 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA23613F9
	for <selinux@archiver.kernel.org>; Thu, 29 Apr 2021 20:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhD2UZ1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhD2UZ0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Apr 2021 16:25:26 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0DC06138B
        for <selinux@vger.kernel.org>; Thu, 29 Apr 2021 13:24:39 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id e9-20020a4ada090000b02901f91091e5acso2902348oou.0
        for <selinux@vger.kernel.org>; Thu, 29 Apr 2021 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLkjtvL2WkbpffQz/3a9+SGF51l7rdW/3Qq75W0FfzA=;
        b=qm3u3jbSFSR5f8TTg51ShFAl0jFvSW/aqyiBeBTsVi02Phkd47vL4cUTpqwuuya/S9
         FJyzzEmYhhIRGG4Em0GSLeD7pjfqxrZEfjXFrw+ROnZe++dTyV9nh9PXlv3Odvo5NM8l
         Y0jF1PodMex8syXxq1N6j6Z4rQzxsj9xZD4AJor5aXAasuQWMZMXvHQR9KWREX6gQui/
         q/DF+8cB+c7jFqB8TW09jYcb7U0NbphWTab6VouZKlShGQlejK/Z2V8/Oo1I56I9lxf3
         yBAJ6cidVf1aphFgpPZwFaEEcYf/nWtFctKAZEfNBKC9uRG94htZ72b7kUhc5YlIAqPh
         /tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLkjtvL2WkbpffQz/3a9+SGF51l7rdW/3Qq75W0FfzA=;
        b=roWjygsGktEH+mrjRhjmMd/Zjs1/U5tBuzo0TQ8sGVcLXMfar51DgFUjvB2xehcxiv
         S7ZqaK9UuZsxw27NwFnyGc/H7/ryX0MwbPODitW891rC3kGLwYBLR7YyRWuqyYjYxuPy
         HlBARSoJZykbFYCrrszEvv5l0v1VL75by5+P94RZ2L2PtL2IXkHE0Y3OHtmIhVA8XwJb
         RI17hrJOz+jks05s94QG1Jct6vMk3VhpszaqTek91PgmcWG3CR53YYg77jlrT5g1IRBY
         4dodRrNKbjqNknZv7TOQjgTfVvEosuDDAb2XMHqMA6G6/5Sneq0mHnQEMERepNSziUAo
         sp2w==
X-Gm-Message-State: AOAM530zde3O6P7fe6QztQBYMYOhvjPZSgLf7EXi9+CTa1lPFwjchDql
        IGbcZCgERgccEQKUoG3FB7pk9a8CetlVAHOyzDLwCTt6j4AjVw==
X-Google-Smtp-Source: ABdhPJw1vcKCmlV/ViIlYxVBl3W3jwLZheNOhD4+UG0GNevAVF5AMYVLYhHBZvtvJJNJ8gWcZpU/v9OG5fTskzpNxQM=
X-Received: by 2002:a4a:bd04:: with SMTP id n4mr1403637oop.35.1619727877323;
 Thu, 29 Apr 2021 13:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210422064604.270374-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210422064604.270374-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 29 Apr 2021 16:24:26 -0400
Message-ID: <CAP+JOzRS4Q684v+y-Q0hAb_AsoQQqKi1XG0bncOWdSt2L+iRsg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use checked arithmetic builtin to perform safe addition
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 22, 2021 at 2:46 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Checking whether an overflow occurred after adding two values can be
> achieved using checked arithmetic builtin functions such as:
>
>     bool __builtin_add_overflow(type1 x, type2 y, type3 *sum);
>
> This function is available at least in clang
> (at least since clang 3.8.0,
> https://releases.llvm.org/3.8.0/tools/clang/docs/LanguageExtensions.html#checked-arithmetic-builtins)
> and gcc
> (https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html,
> since gcc 5 according to https://gcc.gnu.org/gcc-5/changes.html)
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/context_record.c | 29 ++++++-----------------------
>  libsepol/src/module_to_cil.c  |  6 ++----
>  2 files changed, 8 insertions(+), 27 deletions(-)
>
> diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
> index 317a42133884..435f788058c4 100644
> --- a/libsepol/src/context_record.c
> +++ b/libsepol/src/context_record.c
> @@ -267,31 +267,13 @@ int sepol_context_from_string(sepol_handle_t * handle,
>         return STATUS_ERR;
>  }
>
> -
> -static inline int safe_sum(size_t *sum, const size_t augends[], const size_t cnt) {
> -
> -       size_t a, i;
> -
> -       *sum = 0;
> -       for(i=0; i < cnt; i++) {
> -               /* sum should not be smaller than the addend */
> -               a = augends[i];
> -               *sum += a;
> -               if (*sum < a) {
> -                       return i;
> -               }
> -       }
> -
> -       return 0;
> -}
> -
>  int sepol_context_to_string(sepol_handle_t * handle,
>                             const sepol_context_t * con, char **str_ptr)
>  {
>
>         int rc;
>         char *str = NULL;
> -       size_t total_sz, err;
> +       size_t total_sz = 0, i;
>         const size_t sizes[] = {
>                         strlen(con->user),                 /* user length */
>                         strlen(con->role),                 /* role length */
> @@ -300,10 +282,11 @@ int sepol_context_to_string(sepol_handle_t * handle,
>                         ((con->mls) ? 3 : 2) + 1           /* mls has extra ":" also null byte */
>         };
>
> -       err = safe_sum(&total_sz, sizes, ARRAY_SIZE(sizes));
> -       if (err) {
> -               ERR(handle, "invalid size, overflow at position: %zu", err);
> -               goto err;
> +       for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> +               if (__builtin_add_overflow(total_sz, sizes[i], &total_sz)) {
> +                       ERR(handle, "invalid size, overflow at position: %zu", i);
> +                       goto err;
> +               }
>         }
>
>         str = (char *)malloc(total_sz);
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 58df0d4f6d77..496693f4616e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1134,16 +1134,14 @@ static int name_list_to_string(char **names, unsigned int num_names, char **stri
>         char *strpos;
>
>         for (i = 0; i < num_names; i++) {
> -               len += strlen(names[i]);
> -               if (len < strlen(names[i])) {
> +               if (__builtin_add_overflow(len, strlen(names[i]), &len)) {
>                         log_err("Overflow");
>                         return -1;
>                 }
>         }
>
>         // add spaces + null terminator
> -       len += num_names;
> -       if (len < (size_t)num_names) {
> +       if (__builtin_add_overflow(len, (size_t)num_names, &len)) {
>                 log_err("Overflow");
>                 return -1;
>         }
> --
> 2.31.0
>
