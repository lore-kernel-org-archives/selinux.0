Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A3BC432BE
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 19:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5514561056
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 19:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIATVY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:21:24 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48630 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhIATVY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Sep 2021 15:21:24 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7E544561209
        for <selinux@vger.kernel.org>; Wed,  1 Sep 2021 21:20:18 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so455738pjx.5
        for <selinux@vger.kernel.org>; Wed, 01 Sep 2021 12:20:18 -0700 (PDT)
X-Gm-Message-State: AOAM531hvdNmLNqob45KpIF27LHr+bUtg5OsiGoqsx2HbOBG2IOxFIvr
        s2IcuYkSdECLtRxGEfmT0e0n05jHTJ0UK8YqHWU=
X-Google-Smtp-Source: ABdhPJzYfLj2y22yTtgVAdKTiG0K5lGTX35z2PQFxs9/KNLEPwhDFVsERvcrkRCun7BQ+TLVros9NKVpbj5Q1R78Qoc=
X-Received: by 2002:a17:902:e8d1:b0:138:b1e2:9818 with SMTP id
 v17-20020a170902e8d100b00138b1e29818mr872274plg.35.1630524017018; Wed, 01 Sep
 2021 12:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210819165332.58896-1-jwcart2@gmail.com> <20210819165332.58896-2-jwcart2@gmail.com>
In-Reply-To: <20210819165332.58896-2-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 1 Sep 2021 21:20:05 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kDfeogsPobxmgDdTjin6qkvoB4TvddNgmHoojQe9nr6g@mail.gmail.com>
Message-ID: <CAJfZ7=kDfeogsPobxmgDdTjin6qkvoB4TvddNgmHoojQe9nr6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol/cil: Fix syntax checking in __cil_verify_syntax()
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Sep  1 21:20:19 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 19, 2021 at 6:53 PM James Carter <jwcart2@gmail.com> wrote:
>
> The function __cil_verify_syntax() is used to check the syntax of
> CIL rules (and a few other common things like contexts and class
> permissions). It does not correctly check the syntax combination
> "CIL_SYN_STRING | CIL_SYN_N_LISTS, CIL_SYN_N_LISTS | CIL_SYN_END".
> This should mean either a string followed by any number of lists
> or any number of lists followed by the end of the rule. Instead,
> while allowing the correct syntax, it allows any number of lists
> followed by a string followed by any number of more lists followed
> by the end of the rule and, also, any number of lists followed by a
> string followed by the end of the rule.
>
> Refactor the function to make it clearer to follow and so that once
> checking begins for CIL_SYN_N_LISTS or CIL_SYN_N_STRINGS, then only
> strings or lists are allowed until the end of the rule is found. In
> addition, always check for CIL_SYN_END at the end.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Hello,

This looks much clearer, thanks! I have two minor comments:

* I find "if (s[i] & CIL_SYN_... && ...)" harder to read than "if
((s[i] & CIL_SYM_...) && ...)" and I would prefer using parenthesis
around the bitwise operations.
* The variables i and len can be "unsigned int" instead of "int" (or
even "size_t", all the more when the length is computed with
"syntax_len = sizeof(syntax)/sizeof(*syntax);" in one caller of
__cil_verify_syntax).

As these comments are more about making the code clearer to my mind
than fixing things, I do not consider them to be blocker. Feel free to
apply this patch without change or to send another version.

For these 2 patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  libsepol/cil/src/cil_verify.c | 71 ++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 48 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index fc8a8a40..b1c2270e 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -146,68 +146,43 @@ exit:
>
>  int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len)
>  {
> -       int rc = SEPOL_ERR;
> -       int num_extras = 0;
>         struct cil_tree_node *c = parse_current;
>         int i = 0;
> -       while (i < len) {
> -               if ((s[i] & CIL_SYN_END) && c == NULL) {
> -                       break;
> -               }
>
> -               if (s[i] & CIL_SYN_N_LISTS || s[i] & CIL_SYN_N_STRINGS) {
> -                       if (c == NULL) {
> -                               if (num_extras > 0) {
> -                                       i++;
> -                                       continue;
> +       while (i < len && c != NULL) {
> +               if (s[i] & CIL_SYN_STRING && c->data != NULL && c->cl_head == NULL) {
> +                       c = c->next;
> +                       i++;
> +               } else if (s[i] & CIL_SYN_LIST && c->data == NULL && c->cl_head != NULL) {
> +                       c = c->next;
> +                       i++;
> +               } else if (s[i] & CIL_SYN_EMPTY_LIST && c->data == NULL && c->cl_head == NULL) {
> +                       c = c->next;
> +                       i++;
> +               } else if (s[i] & CIL_SYN_N_LISTS || s[i] & CIL_SYN_N_STRINGS) {
> +                       while (c != NULL) {
> +                               if (s[i] & CIL_SYN_N_LISTS && c->data == NULL && c->cl_head != NULL) {
> +                                       c = c->next;
> +                               } else if (s[i] & CIL_SYN_N_STRINGS && c->data != NULL && c->cl_head == NULL) {
> +                                       c = c->next;
>                                 } else {
>                                         goto exit;
>                                 }
> -                       } else if ((s[i] & CIL_SYN_N_LISTS) && (c->data == NULL && c->cl_head != NULL)) {
> -                               c = c->next;
> -                               num_extras++;
> -                               continue;
> -                       } else if ((s[i] & CIL_SYN_N_STRINGS) && (c->data != NULL && c->cl_head == NULL)) {
> -                               c = c->next;
> -                               num_extras++;
> -                               continue;
>                         }
> -               }
> -
> -               if (c == NULL) {
> +                       i++;
> +                       break; /* Only CIL_SYN_END allowed after these */
> +               } else {
>                         goto exit;
>                 }
> +       }
>
> -               if (s[i] & CIL_SYN_STRING) {
> -                       if (c->data != NULL && c->cl_head == NULL) {
> -                               c = c->next;
> -                               i++;
> -                               continue;
> -                       }
> -               }
> -
> -               if (s[i] & CIL_SYN_LIST) {
> -                       if (c->data == NULL && c->cl_head != NULL) {
> -                               c = c->next;
> -                               i++;
> -                               continue;
> -                       }
> -               }
> -
> -               if (s[i] & CIL_SYN_EMPTY_LIST) {
> -                       if (c->data == NULL && c->cl_head == NULL) {
> -                               c = c->next;
> -                               i++;
> -                               continue;
> -                       }
> -               }
> -               goto exit;
> +       if (i < len && s[i] & CIL_SYN_END && c == NULL) {
> +               return SEPOL_OK;
>         }
> -       return SEPOL_OK;
>
>  exit:
>         cil_log(CIL_ERR, "Invalid syntax\n");
> -       return rc;
> +       return SEPOL_ERR;
>  }
>
>  int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor)
> --
> 2.31.1
>

