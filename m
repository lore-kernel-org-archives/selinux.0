Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD33C2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E813A61264
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhFSOX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:23:57 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50178 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhFSOX5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 10:23:57 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B3F3B560791
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 16:21:43 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id z26so10051379pfj.5
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 07:21:43 -0700 (PDT)
X-Gm-Message-State: AOAM5316bbJhPS86KlOLAMmx57u6k0iYnaBdxNKa+Wl0hxpgg/ZeLtqr
        ufbXKsVpXEdKi2eQfks9Wmq7u1pVBNuLivKPGsc=
X-Google-Smtp-Source: ABdhPJwGnjT/p0MGKuT/ZYkf7ikBiozTOqL1POyUJ7L9TBe5jKGGwQq2qw8Uz0ExzFVNNagzqCKyP3qjSB0L02NPh4Y=
X-Received: by 2002:a63:d242:: with SMTP id t2mr15061520pgi.210.1624112502674;
 Sat, 19 Jun 2021 07:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-4-jwcart2@gmail.com>
In-Reply-To: <20210614150546.512001-4-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 19 Jun 2021 16:21:31 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mK2d6u=AKoefzG=YChjT0T5Ni6e9cjz_oOBsLf3hWtVQ@mail.gmail.com>
Message-ID: <CAJfZ7=mK2d6u=AKoefzG=YChjT0T5Ni6e9cjz_oOBsLf3hWtVQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] libsepol/cil: Check for empty list when marking
 neverallow attributes
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 19 16:21:44 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> When marking a type attribute as used in a neverallow (to help determine
> whether or not it should be expanded), check if the attribute's expression
> list is empty (no attributes are associated with it) before iterating
> over the list.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For this patch:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

> ---
>  libsepol/cil/src/cil_post.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 05842b64..38544aef 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -1494,6 +1494,10 @@ static void __mark_neverallow_attrs(struct cil_list *expr_list)
>  {
>         struct cil_list_item *curr;
>
> +       if (!expr_list) {
> +               return;
> +       }
> +
>         cil_list_for_each(curr, expr_list) {
>                 if (curr->flavor == CIL_DATUM) {
>                         if (FLAVOR(curr->data) == CIL_TYPEATTRIBUTE) {
> --
> 2.26.3
>

