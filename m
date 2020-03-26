Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0088FC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C472073E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="Dq7qe4Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgCZPRI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:17:08 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37803 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgCZPRI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:17:08 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so5663588ilr.4
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHmnsb94Pd1YpLoa+/h92g+P/0utxNXdSfzbmYYej5M=;
        b=Dq7qe4Dl94X7M8nuRu4IRt/6655Yl1GWzi3THa/kXaAGF1I619VVXeuwbED/oUh4m+
         zDitLkXqgJSX6nngR6juzc5pJiMcZRvactcZEJ5IHwTGKY4/l9tEmRk4A9POYesvoqyb
         hSeTeol7x7Rg/HXLiWhNZ7d8bng3qBRRRrQbX9Hl3Hc6xJP5Hkq6EYV/inXHJm9oPbys
         re5oU9ZGFxxy9YnvbxLCRCZ9Jo3gF+OCoyIjgQnDsmkU16shiWDGt65Oy06a0ETj+uG1
         B7HNL3BlA64OSbsQttt0G8sywY4mAdwYtapwZH3QeGJCtnKWglWK/Y30IIjfSSEFM46J
         6Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHmnsb94Pd1YpLoa+/h92g+P/0utxNXdSfzbmYYej5M=;
        b=BPCAKDCyzZclM2TdhAIUIaJx6QUW6ARgd4NIavT5g5Gb3boIEYjYNvGYri1+QrAOr2
         ycApiKzu/nui1AezLBunr9Jna2mb82F4vLLuB/Vm7iYkrQczqtxyWAS3LNE1rSBB3oqy
         qlNPHBsFusq5M3E0Ws5rJkRlPpncXkgsdHXndBl5P2E7J6NC/I1ZPqUQelNBbTqChzgr
         Izh2WSTXjo6Z3i6YcuB2DciQbNtQhybGWDyhKHrYRsXDMuw66A0iPs59XuuYCJJVRVfQ
         2sVrjwTG28UeiB7Ugm8fwlVAS+f7wZCvWpZ0OE0PsmTAYeMjhz3hMnNMyTwn23FhMOjo
         75AA==
X-Gm-Message-State: ANhLgQ0xHtf6RRZEd5xq5ww5zg2h1XCgDuxNfMIJlQ3q/W6VQB4TUjrM
        bMhMyu/6VnSOJEz1DKP0OwZDTlbTdRmnt0qqu4z3pg==
X-Google-Smtp-Source: ADFU+vu8NuZmgFOsK6Oocw33dW1Cx8LmBlhz6O/C3Id9JltWpu28lfZrSATZxHoC2sCEf5i9pEBZd+aEx+tg13PZpj0=
X-Received: by 2002:a92:4896:: with SMTP id j22mr8507778ilg.158.1585235826499;
 Thu, 26 Mar 2020 08:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
 <20200319194853.15709-1-william.c.roberts@intel.com> <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
 <CAFftDdoizXnNMOsyPdSeU15VmOgjpeAEU80DLLGSLzgyUC5gpQ@mail.gmail.com>
In-Reply-To: <CAFftDdoizXnNMOsyPdSeU15VmOgjpeAEU80DLLGSLzgyUC5gpQ@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 26 Mar 2020 11:16:55 -0400
Message-ID: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
Subject: Re: [PATCH] cil: drop remaining dso.h include
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 23, 2020 at 11:35 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Mar 20, 2020 at 3:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Mar 19, 2020 at 8:49 PM <bill.c.roberts@gmail.com> wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  libsepol/cil/src/cil.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > index c010ca2aeaf4..12cc28eff389 100644
> > > --- a/libsepol/cil/src/cil.c
> > > +++ b/libsepol/cil/src/cil.c
> > > @@ -50,7 +50,6 @@
> > >  #include "cil_binary.h"
> > >  #include "cil_policy.h"
> > >  #include "cil_strpool.h"
> > > -#include "dso.h"
> > >
> > >  #ifndef DISABLE_SYMVER
> > >  asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
> > > --
> > > 2.17.1
> > >
> >
> > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> Merged: https://github.com/SELinuxProject/selinux/pull/210
>
> Thanks

It looks like this change broke building on MacOS:

<inline asm>:1:1: error: unknown directive
.symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0
^

(on all of them).

Previously dso.h defined DISABLE_SYMVER for Android and Apple, is
support for those intended to go away?
