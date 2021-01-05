Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54531C433DB
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 23:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D9722E00
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 23:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAEXTj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 18:19:39 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:32828 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbhAEXTj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 18:19:39 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4212F561233
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 00:18:56 +0100 (CET)
Received: by mail-oi1-f179.google.com with SMTP id q205so1430793oig.13
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 15:18:56 -0800 (PST)
X-Gm-Message-State: AOAM533/vHh6n2o9q4TWR/NO0nFdT/6CymzeYTbgpG8hLMmqQPpgIoTQ
        RPGJbiceFOFyEdhp3SNl4xFR5vI2fyy4QJg3V3I=
X-Google-Smtp-Source: ABdhPJye60lPoV/DQHctDOB8IYXJIo+LWgYsy+m/68n4Evv28nkPRY/8fmlcGqx/lWbj3LkK3QTh3qxpDwZDfF9BDso=
X-Received: by 2002:a05:6808:99a:: with SMTP id a26mr1470499oic.40.1609888735120;
 Tue, 05 Jan 2021 15:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20210105215443.238513-1-jwcart2@gmail.com>
In-Reply-To: <20210105215443.238513-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Jan 2021 00:18:44 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==zWr2b9upXx2RZi0cisp0p8apajXYE3zvea+x96ExUiw@mail.gmail.com>
Message-ID: <CAJfZ7==zWr2b9upXx2RZi0cisp0p8apajXYE3zvea+x96ExUiw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 00:18:56 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 5, 2021 at 10:54 PM James Carter <jwcart2@gmail.com> wrote:
>
> Nicolas Iooss reports:
>   A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
>   policy compiler (cf.
>   https://github.com/SELinuxProject/selinux/issues/215 and
>   https://github.com/google/oss-fuzz/pull/4790). It reported a bunch of
>   simple issues, for which I will submit patches. There are also more
>   subtle bugs, like the one triggered by this CIL policy:
>
>   (class CLASS (PERM))
>   (classorder (CLASS))
>   (sid SID)
>   (sidorder (SID))
>   (sensitivity SENS)
>   (sensitivityorder (SENS))
>   (type TYPE)
>   (allow TYPE self (CLASS (PERM)))
>
>   (block b
>       (optional o
>           (sensitivitycategory SENS (C)) ; Non-existing category
>   triggers disabling the optional
>           (common COMMON (PERM1))
>           (classcommon CLASS COMMON)
>           (allow TYPE self (CLASS (PERM1)))
>       )
>   )
>
>   On my computer, secilc manages to build this policy fine, but when
>   clang's Address Sanitizer is enabled, running secilc leads to the
>   following report:
>
>   $ make -C libsepol/src CC=clang CFLAGS='-g -fsanitize=address' libsepol.a
>   $ clang -g -fsanitize=address secilc/secilc.c libsepol/src/libsepol.a
>   -o my_secilc
>   $ ./my_secilc -vv testcase.cil
>   Parsing testcase.cil
>   Building AST from Parse Tree
>   Destroying Parse Tree
>   Resolving AST
>   Failed to resolve sensitivitycategory statement at testcase.cil:12
>   Disabling optional 'o' at testcase.cil:11
>   Resetting declarations
>   =================================================================
>   ==181743==ERROR: AddressSanitizer: heap-use-after-free on address
>   0x6070000000c0 at pc 0x55ff7e445d24 bp 0x7ffe7eecfba0 sp
>   0x7ffe7eecfb98
>   READ of size 4 at 0x6070000000c0 thread T0
>       #0 0x55ff7e445d23 in __class_reset_perm_values
>   /git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:17:17
>
> The problem is that the optional branch is destroyed when it is disabled,
> so the common has already been destroyed when the reset code tries to
> access the number of common permissions, so that it can change the
> value of the class permissions back to their original values.
>
> The solution is to count the number of class permissions and then
> calculate the number of common permissions.
>
> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_reset_ast.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 43e6b88e..569f630b 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -9,6 +9,16 @@ static inline void cil_reset_level(struct cil_level *level);
>  static inline void cil_reset_levelrange(struct cil_levelrange *levelrange);
>  static inline void cil_reset_context(struct cil_context *context);
>
> +static int __class_count_perms(__attribute__((unused)) hashtab_key_t k, __attribute__((unused)) hashtab_datum_t d, void *args)
> +{
> +       int *num = (int *)args;
> +
> +       (*num)++;
> +
> +       *((int *)args) = *num;
> +
> +       return SEPOL_OK;
> +}
>
>  static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
>  {
> @@ -22,11 +32,15 @@ static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, ha
>  static void cil_reset_class(struct cil_class *class)
>  {
>         if (class->common != NULL) {
> -               struct cil_class *common = class->common;
> -               cil_symtab_map(&class->perms, __class_reset_perm_values, &common->num_perms);
> +               /* Must assume that the common has been destroyed */
> +               int num_class_perms = 0;
> +               int num_common_perms;
> +               cil_symtab_map(&class->perms, __class_count_perms, &num_class_perms);
> +               num_common_perms = class->num_perms - num_class_perms;
> +               cil_symtab_map(&class->perms, __class_reset_perm_values, &num_common_perms);
>                 /* during a re-resolve, we need to reset the common, so a classcommon
>                  * statement isn't seen as a duplicate */
> -               class->num_perms -= common->num_perms;
> +               class->num_perms = num_class_perms;
>                 class->common = NULL; /* Must make this NULL or there will be an error when re-resolving */
>         }
>         class->ordered = CIL_FALSE;
> --
> 2.25.4
>

I confirm this patch fixes the issue reported in
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28467.
Nevertheless counting the items of a symtab_t using a callback feels
strange. Can class->perms.table->nel (or a new accessor function that
returns the table->nel of a symtab_t structure) be used to replace
num_class_perms?

Thanks,
Nicolas

