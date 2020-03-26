Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207BEC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CD220714
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghyPGZif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZPfO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37891 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZPfO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:35:14 -0400
Received: by mail-io1-f65.google.com with SMTP id m15so6480874iob.5
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhiXM1YOxuKZjWkEB8R+f+KI6KvUOBr//qdKWzVpuEg=;
        b=ghyPGZifUIc8gsXGUw/Twjp5VD0C5otpjZomjdtROjPaIkPyTrCWGdvadAzVOkzAYH
         cOYn1q0qugjan2ERbnuTccoMNWiiOedIMiLX3AGM0ZxPklHYKioiKmK2LcXCbo84R+hf
         S2UPpFXQW7nYTRET73hn3488/Iwf+DDiEJCIgq5nZjxZ1iUtJheNYu3Q3X3g0cVjLlRn
         Z6n7/5xaxojHd3Mxbwwl1GlQnj28Se3C2fn95QgzrYpAfhwzusC6abNMjXMMUy6zpLoX
         PB6Uda5X597ipNy8g2xa0YVBkh+YwhtOKmgDZdasLqh5gSDzRNcdAQV3ki57vdBZOe1p
         htZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhiXM1YOxuKZjWkEB8R+f+KI6KvUOBr//qdKWzVpuEg=;
        b=YIIb0jxlJ7/xUUquNBaCtJ7bJYAHnl9oo7IGf75vx3BcZUHUOC34NL2VRKHjAb2GYC
         ZmnI/BLABGNFRRPdrdMGcEVsfzrjD15F7iS6WGGEOIRTOz8GFBSed4IrlxeMqzKQ5gjg
         QQa9DPIJ0/YzPHGGstfRfqnReugu3h1X0J45qqHPm6PKvYjJG6xgkuuOkMMcqimKOyI3
         BJYfzbqLdfEIaFOQTHiHtkT36bWku8zGmw/RHM0BLSWQJbtu390a5bAp8Nj3yWdyxTaQ
         /lT6AUoH2NeOUp801ds4Spp5oRP6VipuGhLxfweHAULkz0pPlZVJASCKvFrkvhiLmRT6
         2vow==
X-Gm-Message-State: ANhLgQ2uxzfsv0OveBfAXgKzWjpKFolzJymlwPXwwIvmpRpxKcYlDRIb
        vzIpKFGv3Fhyfu1eBdyZh/75fZQ8+1UzGl+3bAA=
X-Google-Smtp-Source: ADFU+vuwixpgM6ieX9xr4qkroPAskVuX1n+DQEImyMoVSy19rTxZU6axCpBg1I90Zpi42UAPxUcwnXRNJTrLsnhsvDs=
X-Received: by 2002:a02:bb11:: with SMTP id y17mr8688840jan.130.1585236913251;
 Thu, 26 Mar 2020 08:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
 <20200319194853.15709-1-william.c.roberts@intel.com> <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
 <CAFftDdoizXnNMOsyPdSeU15VmOgjpeAEU80DLLGSLzgyUC5gpQ@mail.gmail.com> <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
In-Reply-To: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Mar 2020 10:35:02 -0500
Message-ID: <CAFftDdo8D3h=cag8cO3M2r0zL-DmaWGWXyzeDF3ZWeSbm64qYg@mail.gmail.com>
Subject: Re: [PATCH] cil: drop remaining dso.h include
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 10:17 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:35 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, Mar 20, 2020 at 3:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Thu, Mar 19, 2020 at 8:49 PM <bill.c.roberts@gmail.com> wrote:
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > ---
> > > >  libsepol/cil/src/cil.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > > index c010ca2aeaf4..12cc28eff389 100644
> > > > --- a/libsepol/cil/src/cil.c
> > > > +++ b/libsepol/cil/src/cil.c
> > > > @@ -50,7 +50,6 @@
> > > >  #include "cil_binary.h"
> > > >  #include "cil_policy.h"
> > > >  #include "cil_strpool.h"
> > > > -#include "dso.h"
> > > >
> > > >  #ifndef DISABLE_SYMVER
> > > >  asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > Merged: https://github.com/SELinuxProject/selinux/pull/210
> >
> > Thanks
>
> It looks like this change broke building on MacOS:
>
> <inline asm>:1:1: error: unknown directive
> .symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0
> ^
>
> (on all of them).
>
> Previously dso.h defined DISABLE_SYMVER for Android and Apple, is
> support for those intended to go away?

No, patches forthcoming.
