Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA12C433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2741820674
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 19:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFCF30Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgERTGD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgERTGD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 15:06:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055CC05BD09
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 12:06:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f18so4956617otq.11
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abx037K1ugXVgSaoRSxtO6qSat9FFCwJqIymTxQ7gfU=;
        b=KFCF30Aqy0ZEJHK6kA9ztDKXETlVd1SCpUxmBjuun+wjGq2TXDuI8lDNvdLGo5MoC8
         QPa11d9fJzQowiCFEbcmLNKUIdTjDuhhjpIJmi2VMgghsiKkGCDmHpMG6c//bsKa789s
         byfOwHEyInQ5qXa1bMju2td8cvYEJEz1ZCn/qh+L4UBmddvkvJwHfUlP/ACrBkOxhcXF
         88IryIFA0JQD2u/F++DQvCsHKF5Kr7pBsax/Ioi1uDDeo+BFH6jYovhwZjFX8/eQAMdU
         byq4+1IdXflr02e6xhLzEaXI8S4PSqPn9c3/6/xAzQ255JRcDRnETv0OGC0hydApjQik
         GKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abx037K1ugXVgSaoRSxtO6qSat9FFCwJqIymTxQ7gfU=;
        b=sa73NwVAVsFa96YBkWOIEIQ4Iq6FZbLXDDs6jej1/kjPR8jjkctGK0rijUiCWsRHPZ
         WiqPgBAXEgfM6wh6Lgr2XgA4+ldlJCHKZfQ0H1iX/fW5IEOb784E/tJjdck4wb++fb2c
         /evuaVDRgy7r56FzD1LBbGWQyiQWaSs7ieP7pzYVVa9tdlLccukyk1NOfFn3LBrFlFnj
         npSI6JcjYtKBciYw+fiDvxI570ShsvwCwJUf+ONb58xZD7zMoIq3Z+qS733L1d77CqAY
         d5Kw9TrXOYOASZ+eyo7Zicxnl63Q2xd3PJZqwcfNqokblPcHXs/Mvvehbmv9dRkB2u/7
         HnGg==
X-Gm-Message-State: AOAM533fEp+Q1XmRQSrBgZC/oWatv+DXvFqQW3LCYcGj+wcHu850z8SV
        Pu/P+q9MUQe0Xmqp0WaFk7fRKsv5ElCNSswQbqM=
X-Google-Smtp-Source: ABdhPJz29NNq+wHquQKd4CI7xiIE6fTL7SonOSPwR5QtGpER/jtj2QAFeTQzJClzbu3D2Ur0uFqJtGxcu6RmzhZ7x0U=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr13654964oto.295.1589828761225;
 Mon, 18 May 2020 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200518181251.31862-1-jwcart2@gmail.com> <CAEjxPJ7tZNm71eZOOXy55Qw6X4a=HWRw6c8SnotCc6yc_odgKQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7tZNm71eZOOXy55Qw6X4a=HWRw6c8SnotCc6yc_odgKQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 May 2020 15:05:49 -0400
Message-ID: <CAP+JOzRRF67czZzibS5EOXevY0zYPoEZ7S=_EzSxzPK4e686xg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Initialize the multiple_decls field of the
 cil db
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 18, 2020 at 2:33 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 2:14 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Initialize the multiple_decls field when intializing the structure
> > cil_db.
> >
> > Issue reported by: Topi Miettinen <toiwoton@gmail.com>
> >
> > Fixes: fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
> >        types[attributes]")
>
> I guess this explains the non-deterministic behavior and valgrind
> warning about uninitialized data, but what about the segfault?
> Don't we still need to fix the case when multiple_decls is set to TRUE?

Yes. I am working on that. I believe the segfault occurs when you
declare something both a type and a typeattribute.

Jim

>
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index 4a77aa9c..a3c6a293 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -459,6 +459,7 @@ void cil_db_init(struct cil_db **db)
> >         (*db)->preserve_tunables = CIL_FALSE;
> >         (*db)->handle_unknown = -1;
> >         (*db)->mls = -1;
> > +       (*db)->multiple_decls = CIL_FALSE;
> >         (*db)->target_platform = SEPOL_TARGET_SELINUX;
> >         (*db)->policy_version = POLICYDB_VERSION_MAX;
> >  }
> > --
> > 2.25.4
