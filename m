Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD2C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A8C64F7F
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 21:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCPVp4 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:45:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50995 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhCPVpc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 17:45:32 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 85F61564BDA
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 22:45:24 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id w8so11332454pjf.4
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 14:45:24 -0700 (PDT)
X-Gm-Message-State: AOAM530Y20yhKb2ZO75hzFzWbcJXkvs/gwjTmnz97E1e9CO8uajH2qAg
        buD9mxztR7JmTIFIfu2M2hCHSU+FAyC71cxClbI=
X-Google-Smtp-Source: ABdhPJyrap1Mi05hPlYVSNu2y999+94Pl8B31mhfPF407izoweaVbrz3OyiZr71EN82N/o4DTnWN3dpwJcsVzOnmJCc=
X-Received: by 2002:a17:902:f702:b029:e3:5e25:85bb with SMTP id
 h2-20020a170902f702b02900e35e2585bbmr1455059plo.56.1615931123138; Tue, 16 Mar
 2021 14:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204646.52060-1-jwcart2@gmail.com> <20210316204646.52060-4-jwcart2@gmail.com>
In-Reply-To: <20210316204646.52060-4-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 16 Mar 2021 22:45:12 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nnUVB+AwEd=s9rtMApc36w75atoC=ZZC+B=zp0ONtu2Q@mail.gmail.com>
Message-ID: <CAJfZ7=nnUVB+AwEd=s9rtMApc36w75atoC=ZZC+B=zp0ONtu2Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol: Write "NO_IDENTIFIER" for empty CIL
 constraint expression
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 16 22:45:25 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 9:49 PM James Carter <jwcart2@gmail.com> wrote:
>
> If a role or user attribute with nothing associated with it is used
> in a constraint expression, then the bitmap will be empty. This is
> not a problem for the kernel, but does cause problems when converting
> a kernel policy or module to CIL.
>
> When creating a CIL policy from a kernel policy or module, if an
> empty bitmap is encountered, use the string "NO_IDENTIFIER". An
> error will occur if an attempt is made to compile the resulting
> policy, but a valid policy was not being produced before anyway.
> Treat types the same way even though empty bitmaps are not expected.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/kernel_to_cil.c |  2 +-
>  libsepol/src/module_to_cil.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 96e0f5d3..c6dd2e12 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -189,7 +189,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
>                                         names = ebitmap_to_str(&curr->names, pdb->p_role_val_to_name, 1);
>                                 }
>                                 if (!names) {
> -                                       goto exit;
> +                                       names = strdup("NO_IDENTIFIER");
>                                 }
>                                 if (strchr(names, ' ')) {
>                                         new_val = create_str("(%s %s (%s))", 3, op, attr1, names);
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 3cc75b42..2a794f57 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1793,9 +1793,13 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
>                                                 goto exit;
>                                         }
>                                 }
> -                               rc = name_list_to_string(name_list, num_names, &names);
> -                               if (rc != 0) {
> -                                       goto exit;
> +                               if (num_names == 0) {
> +                                       names = strdup("NO_IDENTIFIER");
> +                               } else {
> +                                       rc = name_list_to_string(name_list, num_names, &names);
> +                                       if (rc != 0) {
> +                                               goto exit;
> +                                       }
>                                 }
>
>                                 // length of values/oper + 2 spaces + 2 parens + null terminator

Hello,
This change somehow made gcc unhappy:

$ gcc -O2 -c module_to_cil.c
In function ‘name_list_to_string’,
    inlined from ‘constraint_expr_to_string’ at module_to_cil.c:1799:11:
module_to_cil.c:1156:8: warning: argument 1 range
[18446744071562067968, 18446744073709551615] exceeds maximum object
size 9223372036854775807 [-Walloc-size-larger-than=]
 1156 |  str = malloc(len);
      |        ^~~~~~~~~~~
In file included from module_to_cil.c:39:
module_to_cil.c: In function ‘constraint_expr_to_string’:
/usr/include/stdlib.h:539:14: note: in a call to allocation function
‘malloc’ declared here
  539 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
      |              ^~~~~~

(With gcc 10.2.0 on Arch Linux and gcc 9.3.0-17ubuntu1 on Ubuntu 20.04
which is used by GitHub Actions,
https://github.com/fishilico/selinux/runs/2125501324?check_suite_focus=true#step:9:107
; building for x86_64)

The main cause of this error is the fact that num_names is considered
as a signed integer in name_list_to_string(). This patch fixes the
issue:

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 2a794f577841..6185c7e4ccb7 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1124,7 +1124,7 @@ exit:
 }


-static int name_list_to_string(char **names, int num_names, char **string)
+static int name_list_to_string(char **names, unsigned int num_names,
char **string)
 {
        // create a space separated string of the names
        int rc = -1;

... but it would be even better if the type of num_names was
consistent. Right now, ebitmap_to_names() initializes a local variable
"uint32_t num;" and then does "*num_names = num;" with "int
*num_names". I believe the code would be more correct if the parameter
of ebitmap_to_names() was "uint32_t *num_names" or "unsigned int
*num_names" (why is uint32_t used?), and if all its callers used an
unsigned type to store this value. What do you think?

Moreover, I stumbled upon this code pattern in function name_list_to_string:

len += strlen(names[i]);
if (len < strlen(names[i])) {
    log_err("Overflow");
    return -1;
}

Nowadays, both gcc and clang provide checked arithmetic builtins and I
think the intent of this code would be clearer if it used them:

if (__builtin_add_overflow(len, strlen(names[i]), &len)) {
    log_err("Overflow");
    return -1;
}

Does anyone have an opinion about using checked arithmetic builtins?
(I have not used them much, and if someone knows of some compatibility
issues, this would be important to know)

Cheers,
Nicolas

