Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D9C4743E
	for <selinux@archiver.kernel.org>; Fri,  4 Jun 2021 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB7D613F4
	for <selinux@archiver.kernel.org>; Fri,  4 Jun 2021 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFDRB6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:01:58 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44909 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFDRB5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Jun 2021 13:01:57 -0400
Received: by mail-ot1-f41.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so9681944otp.11
        for <selinux@vger.kernel.org>; Fri, 04 Jun 2021 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHxmBj6l0caCH6kz0zRGVTOigiFx8Y3kroalroTbDPk=;
        b=DKtpT8Pzr2xx0/PYpg7nyMe+qroO5C84cSY3hEyP7uvdX4b0eoYRWPIvSaW9KhYsqc
         4x0OTt8Vo7DpFS0TnzS+A0/5hKoTEreJyXQeDBTmRy9ZflgRqpsd6KKGQAv8F8gp4LHG
         4K1duFbYwB4gHL0UK0v9zpTozdQ2Cgamyxhitcnp+kcoDW2ZoYHJQEyGcl4e/CEmnnI4
         ILNnRC2Xc3rEUuvirfObnAqZldeJSeaSDjpFpTa9bgIqFfpBDVuHQsq2a1CCsPC8EI0S
         pkOO6z8C9ueUhMLzJwriLI0KGbIfoyDj9PBRC+CtOzXcyC3WZ4SStvqgL+bXj/1TGK2X
         Vhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHxmBj6l0caCH6kz0zRGVTOigiFx8Y3kroalroTbDPk=;
        b=P9uvOiFtVMcrZUB7P7z6C7aB2ihOo/lnq616Bzrw4vi6Eyz+mHghZCQ5e1K/CCwyRU
         Ozn0PR5NrgtgWoQNIRjuXrv+Po7COO6K41KaXFfEztLsM5EGZey0U0kYo/o5iFS3+ERh
         ht4ri4+BTl0tCfs6n/N37g8qh88muewTdbhEANIMbOPGR+O4OR74EBL/uLfFSCQY2c1n
         FaUsu+s8vBRUzx97GOFANPdDbOdkMYkkpFwL+MKgB3aG59dla3f9lapqRRYFd6mGYiUp
         s/ln89k/zSFtC0xAVA38z/AfWRAwZykyGkaCqHqghmkNt9pEvZBI0MEFjqIUlTgEM0PD
         YFCg==
X-Gm-Message-State: AOAM530kLM3jSMrBQvtfDta5In0t0qrMc5vjuZUatuqVLQMfuNdWrFB7
        Xd2r+f/ZPK8y389ZSW+X442yW8oIixFNuc1auT1pAEYV
X-Google-Smtp-Source: ABdhPJw2RXQwDMFdUWjfHxmRSly9Kh+ppDYq/gBphoVwp31D0wx66jI7W8YNSLcu9OPFbrVQ2Bm0gk07nrEGHZgVb88=
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr4433565otp.295.1622825934376;
 Fri, 04 Jun 2021 09:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210513185254.559588-1-jwcart2@gmail.com> <CAP+JOzQkcAdJVB5K11EFtPFcY111qX0k_Onza7okuOKHF0N4KQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQkcAdJVB5K11EFtPFcY111qX0k_Onza7okuOKHF0N4KQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Jun 2021 12:58:43 -0400
Message-ID: <CAP+JOzRoc4armwsDTMmQwY8fyQ92rybrqCrc9fgbvXB=J6Nhzg@mail.gmail.com>
Subject: Re: [PATCH 0/6] More secilc-fuzzer problems fixed
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 3, 2021 at 1:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, May 13, 2021 at 2:53 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Patches 1-4 fix bug found directly by the secilc-fuzzer.
> > Patch 6 is the same class of bug as that fixed with patch 4.
> > Patch 5 fixes problems found while investigating patch 4 and 6.
> >
> > James Carter (6):
> >   libsepol/cil: Handle disabled optional blocks in earlier passes
> >   libsepol/cil: Destroy the permission nodes when exiting with an error
> >   libsepol/cil: Limit the number of open parenthesis allowed
> >   libsepol/cil: Resolve anonymous class permission sets only once
> >   libsepol/cil: Pointers to datums should be set to NULL when resetting
> >   libsepol/cil: Resolve anonymous levels only once
> >
> >  libsepol/cil/src/cil_build_ast.c   |  2 +
> >  libsepol/cil/src/cil_parser.c      |  7 +++-
> >  libsepol/cil/src/cil_reset_ast.c   | 56 +++++++++++++++++++++++++--
> >  libsepol/cil/src/cil_resolve_ast.c | 62 +++++++++++++++++-------------
> >  4 files changed, 97 insertions(+), 30 deletions(-)
> >
> > --
> > 2.26.3
> >
>
> There haven't been any comments on this series, and it has been three
> weeks, so I plan on merging it tomorrow.
> Jim

This series has been merged.
Jim
