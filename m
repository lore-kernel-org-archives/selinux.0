Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44926C433DB
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F155D64F3F
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 10:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBEKbj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 05:31:39 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42504 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhBEK3g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 05:29:36 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 98316565A9F
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 11:28:53 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id d7so6416238otf.3
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 02:28:53 -0800 (PST)
X-Gm-Message-State: AOAM530rRaqJwFVr2Qjgnk9SOWIupc5z65GED5hCRpGzm7TPWKqRsu7X
        xtV0jZ63SFx97JIwDr8L0ZAS0+lwiYsQjL1zkNY=
X-Google-Smtp-Source: ABdhPJxZzs86zIco/r/TTiyEpWCJRZeZ5aZZ9F4+Txq59znOciXUxUUFldYS+bZGAVdE6/HBW6i+0OI1yFRsLgi7g1g=
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr2703240ott.361.1612520932500;
 Fri, 05 Feb 2021 02:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20210204220131.229753-1-jwcart2@gmail.com>
In-Reply-To: <20210204220131.229753-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 5 Feb 2021 11:28:41 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mk77mhCh4mkNiEu8LfOt2g88cGajwo39toN0JeT=-Xww@mail.gmail.com>
Message-ID: <CAJfZ7=mk77mhCh4mkNiEu8LfOt2g88cGajwo39toN0JeT=-Xww@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix integer overflow in the handling of hll
 line marks
To:     James Carter <jwcart2@gmail.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 11:28:54 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 4, 2021 at 11:01 PM James Carter <jwcart2@gmail.com> wrote:
>
> From: James Carter <jwcart2@tycho.nsa.gov>
>
> Nicolass Iooss reports:

There is only one S in my first name ;)

>   OSS-Fuzz found an integer overflow when compiling the following
>   (empty) CIL policy:
>
>   ;;*lms 2147483647 a
>   ; (empty line)
>
> Change hll_lineno to uint32_t which is the type of the field hll_line
> in struct cil_tree_node where the line number will be stored eventually.
> Read the line number into an unsigned long variable using strtoul()
> instead of strtol(). On systems where ULONG_MAX > UINT32_MAX, set the
> value to 0 and print a warning if it is larger than UINT32_MAX before
> storing it in hll_lineno.
>
> Also change hll_expand to uint32_t, since its value will be either
> 0 or 1 and there is no need for it to be signed.
>
> Reported-by: Nicolass Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_parser.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> index b62043b9..9d3bd580 100644
>[...]
> @@ -140,11 +141,19 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
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
> +                       cil_log(CIL_WARN, "Line mark line number > UINT32_MAX\n");
> +                       val = 0;
> +               }
> +#endif
> +               *hll_lineno = val;

Using both cil_log(CIL_ERR, "Problem parsing line number for line
mark\n"); and cil_log(CIL_WARN, "Line mark line number >
UINT32_MAX\n"); is inconsistent (if a CIL file is processed on a
32-bit system and contains a line mark with a number greater than
UINT32_MAX, the compilation will fail due to the first if).

In my humble opinion, the compiler should output an error if val >
UINT32_MAX here, while accepting to (silently) wrap around UINT32_MAX
when the line number is later incremented (which is the standard
behavior with unsigned integers in C, if I remember correctly). This
way, numbers greater than UINT32_MAX are forbidden in CIL source
files, both on 32-bit and 64-bit systems. If you disagree and want to
accept line mark with any line numbers, the first if block needs to be
changed to use "cil_log(CIL_WARN, "Problem parsing line number for
line mark\n");val=0;".

Another issue: function add_hll_linemark() currently ends with:

exit:
  cil_log(CIL_ERR, "Problem with high-level line mark at line %d of
%s\n", tok.line, path);
  return SEPOL_ERR;

The %d needs to be replaced with %u in the message. Moreover if you
want to keep cil_log(CIL_WARN), it would be very useful to have ("...
at line %u of %s\n", tok.line, path) in the message.

Thanks,
Nicolas

