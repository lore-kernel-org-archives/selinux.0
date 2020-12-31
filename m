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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A65EC433DB
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562D0223E4
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLaPF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Dec 2020 10:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLaPF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Dec 2020 10:05:28 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B45C061573
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 07:04:47 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id r17so17523923ilo.11
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gttAAtwsOMGEXc6rRqoOf4+g+eqU5WQQYwhEqqEanc=;
        b=svGkpvZ2N2qy+P4kFyaL2vxNP03rRDdCyFYNkXM0Uuk4R6yWDn+s42ES/E1AXktNdX
         WBueVfxZsaN5AmA39zsliQM5FDjrg0oh0QH0tdY5UK2kmchTbDlxTggNQAGl93yGZROr
         yLvtnMlKl2BjPBy8+GdvNwpfXHd0R3GksOeOSvLK0OwmQWLocmtUMTYQiJ1K5GmSM66A
         SZ53mKv+wgTgvzGFfMJ3iWQiOToB5mSKJYB5RpRvin5T8iX6+c8fYa+J4k33+yvn6+f3
         LtWHZtx0iI3CWiIq9gmQKLu1NMe5hmxulDNl53Yl2yaA19JUeEklRg4L15NzYt/bByvf
         9j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gttAAtwsOMGEXc6rRqoOf4+g+eqU5WQQYwhEqqEanc=;
        b=jxnbuNOOPngM3z9RWC2LdHhJ9ImuUxvs65CuFudR19KCMO3Aj3HWns98oQPqMi5yWz
         hpc+aTSbh3JZI6q4fMqjQMRdQllQwaoQugYy4foPz4RyxaqgQGL5hTYymMhW4AJyEFX0
         ZOZAhK5zekPB1NHTkm4yw4KsOOyHBUuNH9X9q54jmhHYcJWzuTGqoaH/90JbJXTzU3I/
         gD/VXVeuU6YQIcOuOf9wMX1LvVH9uu3zxWkk5+Mp/oASGl2wVO+aPtthzNkz8DDyZsJM
         xTKLhQf6H8sipAusfZfJZiaLUhnFv0/O86aZpmK6NV+twBc0Qyz0iJZSNBaFqoF21CHH
         nY9A==
X-Gm-Message-State: AOAM531IXEFHIRwcAzWJTzmqzXeo87vXI2BMdGpGaMOHeL0+0UDLDzI8
        zw7pwSgDIQy0YtfcVJ3lmt9ydd0cokm4z6jrFC4=
X-Google-Smtp-Source: ABdhPJwRYQvtwyCvVpsN7UTpiF4CFR2koOjO4oDOdfOHu9gC7toLi7K1EiGXwtqJMoGWgZwue3PwgifPYa3GASKfGOo=
X-Received: by 2002:a05:6e02:8d:: with SMTP id l13mr55930278ilm.163.1609427086184;
 Thu, 31 Dec 2020 07:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-4-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-4-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 31 Dec 2020 09:04:35 -0600
Message-ID: <CAFftDdoohaTHhQCXrYPWg1B6AbQ4157eoOOy1Tp_qnYFCwE1cw@mail.gmail.com>
Subject: Re: [PATCH 4/6] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 4:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
> compile a policy with an invalid integer:
>
>     $ echo '(ioportcon(2())n)' > tmp.cil
>     $ secilc tmp.cil
>     Segmentation fault (core dumped)
>
> This is because strtol() is called with a NULL pointer, in
> cil_fill_integer().
>
> Fix this by checking that int_node->data is not NULL. While at it, use
> strtoul() instead of strtol() to parse an unsigned integer.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/cil/src/cil_build_ast.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 67801def0dc0..0c9015cef578 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5566,15 +5566,15 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
>  {
>         int rc = SEPOL_ERR;
>         char *endptr = NULL;
> -       int val;
> +       unsigned long val;
>
> -       if (int_node == NULL || integer == NULL) {
> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>                 goto exit;
>         }
>
>         errno = 0;
> -       val = strtol(int_node->data, &endptr, base);
> -       if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
> +       val = strtoul(int_node->data, &endptr, base);
> +       if (errno != 0 || endptr == int_node->data || *endptr != '\0' || val > UINT32_MAX) {

I wonder if compilers/static analysis tools will balk on this as
strtoul's return, an unsigned long,
on a 32 bit machine will be 32 bits, so this could have a dead
expression as val > UINT32_MAX
will always be false. Perhaps use the strtoull variant to always have 64 bits?

>                 rc = SEPOL_ERR;
>                 goto exit;
>         }
> @@ -5594,7 +5594,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
>         char *endptr = NULL;
>         uint64_t val;
>
> -       if (int_node == NULL || integer == NULL) {
> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>                 goto exit;
>         }
>
> --
> 2.29.2
>
