Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11465C433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD05613FA
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhD1OLM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhD1OLM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 10:11:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D0CC061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:10:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t4so11558058ejo.0
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hl2FZ8bOQwivGktCFonOJE4amDIJ0G0w1VDsl/tk0lk=;
        b=0CP9JmaIsfZhUog0hb6K27AIYW1t+r5vTVcA2aDNQsYfmzrzKsbJLUG2CnommSxBrJ
         C9JzafELsXeLaRYVQJO+RbQXox9Ac2gdxetQXfZHiVox8oTffjkER4rOOIUflK/Axq7s
         hpFeFrRoi7Dgn9pl3ROW5jwGnyXK1bwOJSDZcXfqa3ZKU86ZktMloreKhyFEtG1oBnzr
         EzskT1SKaUXNZ4GfqYk1VzA2IRcPNb+vD9k7hehYl9A7ti0vcr5CE2zyW3I48109rLMX
         69bnhqkIHJa/VYWB0NFQkkEA7EtUL2qrBIXYpI8pAxLwoIz7tdDBnxE9BkWwoLeor9BA
         ABng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hl2FZ8bOQwivGktCFonOJE4amDIJ0G0w1VDsl/tk0lk=;
        b=E0vP6KtrPa8lgLXW+P6/BZItmwTgnxn3k6SAWI3rvTUb4ZFSJIQyP1eyQs5t2mx1FP
         T3NXpvrRmPOxppOUBUIs+vUK4U0DqapVMYke8hKv0RM2PC4BUZ40S+G5aSkrX4Nrk73Q
         vcMBc5Z2sDaCTdcYxkMnpctUsPAN+jbBcrb3MXCKm03wR+ycg0duyVJkOBSlFGqmAwjJ
         2clplYoHICkrt9xCB9u7hszL76gfnHmyqOIz/0lWylRIItsZBKX3sX/Vjp4zXeIICIrk
         L1DtuPP1Mua9rcWgr4CeCd31O1dOLNYp4C1E34bqBG32WrK9pnXo4r+iAYbaPrmae6o4
         6kBw==
X-Gm-Message-State: AOAM5316QneQ6ki1KIh3EkN6kw0dOwH1twU2LRoYzh+G1vBsdZOSkSfN
        ZiWjplxhV9XBJflT1+AuPCRKP16UNAxhiiYFqi4LOZqXYw==
X-Google-Smtp-Source: ABdhPJweR1pqMm1wBaPmj0dlOeMuI8UD8oXknD8AisKnYIkEKpJAxiValKkj20SU4p1EnmByDTeqS5nd73v/o4KfGOc=
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr29027437ejo.546.1619619023763;
 Wed, 28 Apr 2021 07:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210413122508.24745-1-cgzones@googlemail.com> <CAP+JOzQkEWgMvNXw87-fDM_SiyT7=no7+RZHg_q8DynHmewsOw@mail.gmail.com>
In-Reply-To: <CAP+JOzQkEWgMvNXw87-fDM_SiyT7=no7+RZHg_q8DynHmewsOw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Apr 2021 10:10:13 -0400
Message-ID: <CAHC9VhRheYG-S8QjiZd86K17QRPz31yKwSSpvvR501bMu3vyUQ@mail.gmail.com>
Subject: Re: [RFC SHADOW PATCH 0/7] SELinux modernizations
To:     James Carter <jwcart2@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 10:02 AM James Carter <jwcart2@gmail.com> wrote:
> On Tue, Apr 13, 2021 at 10:58 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Modernize SELinux parts of shadow
> > (https://github.com/shadow-maint/shadow).
> >
> > Upstream pull request: https://github.com/shadow-maint/shadow/pull/323
> >
> >
> > Christian G=C3=B6ttsche (7):
> >   struct commonio_db[selinux]: do not use deprecated type
> >     security_context_t
> >   vipw[selinux]: do not use deprecated typedef and skip context
> >     translation
> >   selinux.c: do not use deprecated typedef and skip context translation
> >   selinux.c:reset_selinux_file_context(): do not fail in permissive mod=
e
> >   selinux.c: use modern selabel interface instead of deprecated
> >     matchpathcon
> >   set_selinux_file_context(): prepare context for actual file type
> >   selinux: only open selabel database once
> >
> >  lib/commonio.c    |  4 ++--
> >  lib/commonio.h    |  6 +----
> >  lib/prototypes.h  |  2 +-
> >  lib/selinux.c     | 60 ++++++++++++++++++++++++++++++++---------------
> >  libmisc/copydir.c |  8 +++----
> >  src/useradd.c     |  7 ++++--
> >  src/userdel.c     |  3 +++
> >  src/usermod.c     |  3 +++
> >  src/vipw.c        | 10 ++++----
> >  9 files changed, 65 insertions(+), 38 deletions(-)
> >
> > --
> > 2.31.0
>
> These patches look good to me.
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks James.

--=20
paul moore
www.paul-moore.com
