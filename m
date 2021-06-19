Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8665CC2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD37611BD
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 13:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhFSNpQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 09:45:16 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37711 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhFSNpP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 09:45:15 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jun 2021 09:45:15 EDT
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 30CF8564936
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 15:36:20 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id w31so10242256pga.6
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 06:36:20 -0700 (PDT)
X-Gm-Message-State: AOAM531cBAv6a/xTSo5OXEuBxJZ1McRDDmhcmfVciUoBg6nADfXCWjvC
        Ova6CpLI9lBd4Vpa2Hml0mNpfn7lW36mh2A8XEs=
X-Google-Smtp-Source: ABdhPJzo/6/BFZlfvS7fF0cuGnqUDfhZm4Amtf5E/r1JYDPqgwRV5Uxi6XKNc9EcGjQ3MtsEhr7aAhpd9FJ5C6EOQbo=
X-Received: by 2002:a62:b502:0:b029:2ec:a539:e29b with SMTP id
 y2-20020a62b5020000b02902eca539e29bmr10299528pfe.37.1624109778902; Sat, 19
 Jun 2021 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-3-jwcart2@gmail.com>
In-Reply-To: <20210614150546.512001-3-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 19 Jun 2021 15:36:07 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kHN7b9LoHDrRwkORUNNDS-q8OsVyh21TLe0JHdbEBvyQ@mail.gmail.com>
Message-ID: <CAJfZ7=kHN7b9LoHDrRwkORUNNDS-q8OsVyh21TLe0JHdbEBvyQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] libsepol/cil: Fix syntax checking of defaultrange rule
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 19 15:36:20 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> The syntax array that cil_gen_defaultrange() called __cil_verify_syntax()
> with was wrong. It had the range (which should be low, high, or low-high)
> as optional when it is not.
>
> Use the correct syntax array to check the syntax of the defaultrange rule.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_build_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 71f14e20..a5f617d8 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5862,7 +5862,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
>                 CIL_SYN_STRING,
>                 CIL_SYN_STRING | CIL_SYN_LIST,
>                 CIL_SYN_STRING,
> -               CIL_SYN_STRING | CIL_SYN_END,
> +               CIL_SYN_STRING,
>                 CIL_SYN_END
>         };
>         int syntax_len = sizeof(syntax)/sizeof(*syntax);
> --
> 2.26.3

Hello,
This patch will break selinux-testsuite with:

/usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
test_overlay_defaultrange.cil test_userfaultfd.cil test_add_levels.cil
test_glblub.cil
Invalid syntax
Bad defaultrange declaration at
/var/lib/selinux/targeted/tmp/modules/400/test_glblub/cil:1
Failed to build AST
/usr/sbin/semodule: Failed!

... because it currently uses, in
https://github.com/SELinuxProject/selinux-testsuite/blob/0b78a9d433e8c4f956d18dc0db901f0a1a58c003/policy/test_glblub.cil
:

    (defaultrange db_table glblub)

If I understand the commit message correctly, a range (low, high or
low-high) has to be added to this statement. I am not familiar with
glbulb and do not know how the testsuite should be modified. Could the
policy used by the testsuite be fixed before applying this patch?

Cheers,
Nicolas

(PS : I was quite busy last month but now I have some time again to
catch up with SELinux patches :) )

