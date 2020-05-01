Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B3CC47254
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7CE2166E
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aAl/69RD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgEAUhH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAUhG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 16:37:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12D4C061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 13:37:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q8so8475431eja.2
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LcmHlj+yInsLHBRoqc1ld78ma9usYwynNhQVjjpc1k=;
        b=aAl/69RD09sWvFe4ip2r3tomp/UUDhep3blJnPTeaKHeR/62ubD01ejqKP3R+ai/eZ
         Ag7eEk1wiF4nFOylfdUx4oKNAGAMuJQdMj3NG5mYUteY7W9+Ru2pZ7ImCsG5S/4NI5Nb
         s2U1klq7XpNnqysPr4IFqw14zvHyfIwD2K7k+KDZCmiCxZ+poFzb6PVk47xWCz/Csw88
         JNy1GHNc0xj7Jl7ezrVNz2GzSUjIpe20dtNpFLkwSdkDZe2BgwjE7vpXQyOfYgQsCLdI
         rsvREnElw5aXLnqyrCLAVUhEGozywE2BJ06ofOa++A/7gp1ADkT49OoeLjXjTIPLrfmy
         cYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LcmHlj+yInsLHBRoqc1ld78ma9usYwynNhQVjjpc1k=;
        b=fZn+n0Pwqu7wF8Q94LW7XRpXKhav7szxLHSIltSNQZH3SjlpkMFlt6UxTw7Pf9phK8
         2xNcsDdZ2KArLHeta6fKhGb2Oi4n6+Lw1iVhMY8V9HQ20HQSRgd6B7IaEha9XghHgbhu
         MCugvnnZcBLBJLgedT271oQ7w6N5XgA2FFAAvMUjtk6tBPv15dng/gch7Kq9eNhXEwGY
         L/aj3v8r8pbJIvf5unwJ2yaWP0nftKUcHzVVFP9KJmrT7KevVVfiQnaDG/6aRyJXZss+
         tpk55LU4ZrtcVrmqRtN06jz6i5rUoo2HwMeiWJCFceo9ZPf2GQq46njb6BYluMYm4R1d
         BKww==
X-Gm-Message-State: AGi0PuY38qN+sZ3m5wf+C/3UHxRZJLC52ocumFWCSv+ekrTcq76UEc5a
        bxy5ClIJGqYKxk7xTmqR6ET/T7ciE1eBHCTUARLE
X-Google-Smtp-Source: APiQypKVavSal+iTAblC0p947XDWOWxT5Pa82oKvbJcLvByvFWT84k4mYWARk9KHpceLKovXdsBw7oKlpkmvimtoZwU=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr4785647ejf.308.1588365424493;
 Fri, 01 May 2020 13:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-3-omosnace@redhat.com>
 <CAHC9VhTr3cvYwJZyS_GPXW+8_VNoiO=qoJx2WBfpPq+MGsVunA@mail.gmail.com> <CAFqZXNt631OAZZ0i7BEXm+hVDkJNi8OtAsgO1Enhg55_SCS9yg@mail.gmail.com>
In-Reply-To: <CAFqZXNt631OAZZ0i7BEXm+hVDkJNi8OtAsgO1Enhg55_SCS9yg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 16:36:53 -0400
Message-ID: <CAHC9VhR9CeOxu9_mLWdomqf5gsUeHnM-0hmdYwofajKFpO3nGA@mail.gmail.com>
Subject: Re: [PATCH 2/4] selinux: do not allocate hashtabs dynamically
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 1, 2020 at 4:29 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 1, 2020 at 10:20 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > It is simpler to allocate them statically in the corresponding
> > > structure, avoiding unnecessary kmalloc() calls and pointer
> > > dereferencing.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/hashtab.c  |  51 ++++---------
> > >  security/selinux/ss/hashtab.h  |  13 ++--
> > >  security/selinux/ss/mls.c      |  14 ++--
> > >  security/selinux/ss/policydb.c | 126 ++++++++++++++++-----------------
> > >  security/selinux/ss/policydb.h |   6 +-
> > >  security/selinux/ss/services.c |  44 ++++++------
> > >  security/selinux/ss/symtab.c   |   5 +-
> > >  security/selinux/ss/symtab.h   |   2 +-
> > >  8 files changed, 116 insertions(+), 145 deletions(-)
> >
> > Merged into selinux/next, thanks.
>
> It looks like you didn't resolve the conflict with the return value
> fix correctly ...

There were some stgit/git issues when I was merging patches this
afternoon and my tree got a bit messed up (you likely noticed the
force pushes); this appears to be a casualty of that.  Regardless, it
should be fixed now.  Thanks for letting me know.

-- 
paul moore
www.paul-moore.com
