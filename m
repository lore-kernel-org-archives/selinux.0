Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1555C433DB
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B2822AAA
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbhAEMwX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbhAEMwW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 07:52:22 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C4C061574
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 04:51:42 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q5so28453081ilc.10
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9a9VHKjegEEg2LIE5cZ0eHpUSra06BEQwhF9s2Oqbwc=;
        b=GlqyVy8Hrd8GHxPdc6K0N+hplqOyNdL2a2bj0t6QlaBYdqx5cyekqzy3QGKXlE0Mj3
         4ujHOIkhH4ivBOOCuDXL/8ZKMUq4SAQRLMHubRCt4NRo8zyGkMI3qImUDIvQ8t5cwqUE
         wy8rr1HSe6C3l8bI8YqloWsOdeaRzEinFYikNzQmGphu6Zr3WVGdtjZeGp5L2xZ7x7Ol
         RrsplaH72kPVTaFCSerzN4/lePhnEdtmsdAUaMKhtbRq+3mqdnG8XrwPkIuDncGNWXPj
         p3BC6FeB8unRcwTnYVVI+UfxyISrqfWWfPUDgHJ6R6goEduT3pziU4rOx1SC7QT5IpO3
         VQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9a9VHKjegEEg2LIE5cZ0eHpUSra06BEQwhF9s2Oqbwc=;
        b=AcyhK1XojpE7rneUKVRyPuxMvNruCqzQU0hrx7vVugohy+bbEUOfPUsGrjxfzYLpH4
         N9VTMkZf7QYwY7+BauG7AuOjJ0YifDujG25tRj5Ser033k3ouzSyJ3hsuB5BPrUAHEsU
         10N9iP1j0AkvnQP8pEmYZIurdCdwUd8AG9sxrAcOyW6B7ThF1ze1IPgqDi0Y/gRuqb9F
         PEN+4JdA6rhkk14DObRPj+HxZRMizQqmZP/BdyuPOm/yUkT2JTFQHvZ5JYK6W5ahBDBI
         QmuLQ0T+1C4Bthh87SfIoC7HCd5rsOsFq0DB2ibJ7z+y+5qYXlWyH+JMqk2A4SUnQY1T
         q/4Q==
X-Gm-Message-State: AOAM5309wFFFrppXxSnn3NERGFH1+Ej6sqoesv5zMx2tGgg1BWUOVV4s
        L2HEb+Xg5jCg9sbjWXuKxwJyh3TaDTzSa8Vhr3w=
X-Google-Smtp-Source: ABdhPJyWqOYTRU4eMCjn6hff+Cwz30psooTb66fbmGj7gancvemBMtqpKYyMAkFxwbWRfedzi7+Bd0HLj1KvoFSFOvk=
X-Received: by 2002:a05:6e02:8d:: with SMTP id l13mr74958540ilm.163.1609851101465;
 Tue, 05 Jan 2021 04:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <20201230100746.2549568-4-nicolas.iooss@m4x.org> <CAP+JOzROWvSkvB8rYEJmJv9VGrrFkWUM7=T96hGbuBwhRNq2OA@mail.gmail.com>
In-Reply-To: <CAP+JOzROWvSkvB8rYEJmJv9VGrrFkWUM7=T96hGbuBwhRNq2OA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 5 Jan 2021 06:51:30 -0600
Message-ID: <CAFftDdoUF1fbGDBt2891dT8Jwv0txw_TigF7jdvqkmMJ2q9Z9A@mail.gmail.com>
Subject: Re: [PATCH 4/6] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
To:     James Carter <jwcart2@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 4, 2021 at 11:03 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 5:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
> > compile a policy with an invalid integer:
> >
> >     $ echo '(ioportcon(2())n)' > tmp.cil
> >     $ secilc tmp.cil
> >     Segmentation fault (core dumped)
> >
> > This is because strtol() is called with a NULL pointer, in
> > cil_fill_integer().
> >
> > Fix this by checking that int_node->data is not NULL. While at it, use
> > strtoul() instead of strtol() to parse an unsigned integer.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 67801def0dc0..0c9015cef578 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -5566,15 +5566,15 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
> >  {
> >         int rc = SEPOL_ERR;
> >         char *endptr = NULL;
> > -       int val;
> > +       unsigned long val;
> >
> > -       if (int_node == NULL || integer == NULL) {
> > +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
> >                 goto exit;
> >         }
> >
> >         errno = 0;
> > -       val = strtol(int_node->data, &endptr, base);
> > -       if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
> > +       val = strtoul(int_node->data, &endptr, base);
> > +       if (errno != 0 || endptr == int_node->data || *endptr != '\0' || val > UINT32_MAX) {
> >                 rc = SEPOL_ERR;
> >                 goto exit;
> >         }
> > @@ -5594,7 +5594,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
> >         char *endptr = NULL;
> >         uint64_t val;
> >
> > -       if (int_node == NULL || integer == NULL) {
> > +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
> >                 goto exit;
> >         }
> >
> > --
> > 2.29.2
> >

It turns out when GCC fixes a bug with -Wtype-limits, this will cause
a regression. The current top-level Makefile includes
exporting CFLAGS -Wextra which will enable this warning. I find it
surprising this has been a known gcc issue for some time
and that clang has the same bug.

See:
  - https://gcc.gnu.org/pipermail/gcc-help/2021-January/139755.html

I would fix it now.

Bill
