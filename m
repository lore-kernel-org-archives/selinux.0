Return-Path: <SRS0=5iRL=QT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF5C282C4
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 21:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E342222C0
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 21:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBLVBl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:01:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:53335 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBLVBl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Feb 2019 16:01:41 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 99B2E5646AF
        for <selinux@vger.kernel.org>; Tue, 12 Feb 2019 22:01:37 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id i20so248443otl.0
        for <selinux@vger.kernel.org>; Tue, 12 Feb 2019 13:01:37 -0800 (PST)
X-Gm-Message-State: AHQUAuYd2McyRJsLwgR6bZfVV8bA6bfotwjLhHU3CL1m7pm/igkbrURn
        ybjwy/78w8BkyjsbfoMajB6zsaK9XqQwT8hiWCk=
X-Google-Smtp-Source: AHgI3IYnOwFaMnjh7t0vCHd5gxbxA/3No+6+nhcTwzajjlfJDCnshk1rwBpep3zEvNeppvEfKHxbV3sngsEMW1PjqtM=
X-Received: by 2002:a9d:4b90:: with SMTP id k16mr6065776otf.165.1550005296595;
 Tue, 12 Feb 2019 13:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20190206210752.11828-1-nicolas.iooss@m4x.org> <d1643ffa-0e04-552f-9903-fa1f111029df@tycho.nsa.gov>
In-Reply-To: <d1643ffa-0e04-552f-9903-fa1f111029df@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 12 Feb 2019 22:01:24 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==NtXZBnb1MvdG4Hn97Lhaf3h1tMr=EGXAbD+rXS-9b_A@mail.gmail.com>
Message-ID: <CAJfZ7==NtXZBnb1MvdG4Hn97Lhaf3h1tMr=EGXAbD+rXS-9b_A@mail.gmail.com>
Subject: Re: [Non-DoD Source] [PATCH 1/1] libsepol/cil: silence static
 analyser's use-after-free warning
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 12 22:01:38 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 11, 2019 at 8:06 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>
> On 2/6/19 4:07 PM, Nicolas Iooss wrote:
> > clang's static analyze reports a use-after-free in
> > __cil_expr_to_string(), when __cil_expr_to_string_helper() does not
> > modify its third parameter (variable s1 here) in this loop:
> >
> >      for (curr = curr->next; curr; curr = curr->next) {
> >          __cil_expr_to_string_helper(curr, flavor, &s1);
> >          cil_asprintf(&c2, "%s %s", c1, s1);
> >          free(c1);
> >          free(s1);
> >          c1 = c2;
> >      }
> >
> > Silence this warning by making sure s1 is always NULL at the beginning
> > of every iteration of the loop.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>

Merged.

Nicolas

> > ---
> >   libsepol/cil/src/cil_binary.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index a10c3763bea4..e2eb3ebe8ff3 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -2075,6 +2075,7 @@ static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor,
> >               char *c2 = NULL;
> >               __cil_expr_to_string_helper(curr, flavor, &c1);
> >               for (curr = curr->next; curr; curr = curr->next) {
> > +                     s1 = NULL;
> >                       __cil_expr_to_string_helper(curr, flavor, &s1);
> >                       cil_asprintf(&c2, "%s %s", c1, s1);
> >                       free(c1);
> >
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency

