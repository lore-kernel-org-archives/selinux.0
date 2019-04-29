Return-Path: <SRS0=3b0v=S7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B47C43219
	for <selinux@archiver.kernel.org>; Mon, 29 Apr 2019 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C6E20656
	for <selinux@archiver.kernel.org>; Mon, 29 Apr 2019 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jxCRQIk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfD2OrR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:47:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43747 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfD2OrN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Apr 2019 10:47:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id k2so9595905lje.10
        for <selinux@vger.kernel.org>; Mon, 29 Apr 2019 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sxDBiGIfXC/ZiB8rBSK37wy0gqfF4x7jFrHPYHvbvA=;
        b=jxCRQIk8xd5/68/ic6ZDupRiHo0z7xsxLRb0PfkjP1kbZ9SxgCDXwTf9uUqJJ990Dj
         VHGckJD0/Q0f2eFix1OtHyOiSJQZo+Eeoxa07sSHKsOu3rWotlnHSTItFWOiltlhm9Zu
         H5mq3z0HojQmiK1VfzTQs/o6b8qYXk19zC6I9Xy6+AAO8xFoV8U1d8N8cG5b0Yz651nQ
         KdTxSuvFnIkgcloxLqLE6FK4pQbAQRlPsqU4+lsTiB+Aaipr18hnzvPvz27bSZuFqyFr
         /XkaLzZnTTrDYWXSROP9UPEBCdfJmr70CiQQ0QyPvx/DPzhfK7OK+HxkDXKlcpbd+wZd
         IlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sxDBiGIfXC/ZiB8rBSK37wy0gqfF4x7jFrHPYHvbvA=;
        b=UUQ2jqTIxOl38bLHeujTN49BzgVxXYvpvFmjR2ctmmPkZR7RPDAyDpk4un/Pr7/gbM
         I4DCXer5uB9NcRa0OY/LqhPcy726dS56jE+PUmqV/Dl93BuF3Sn+xO2ii8aMSP2zK7NE
         QoP4S1xzxkTylnBazA5dEZKPyZQzLg8YgV1AVnI1mAU3kkbCiWVZnMwcV8iLN/3rYwZM
         Ac71KqM10LekFvFxme9wTwNQpE+Lp9Rh19GFj9BSHP7EtL6gMGj2dz+K9g7+PzWedCYc
         4Du/RypkKHpv2AEWZN5Brhjg01xzw0HvpjyvwAL8Yenq9r7vNCVtN7WQ8+rNTheogVJj
         V2qQ==
X-Gm-Message-State: APjAAAUDxqPPhx68xSAQ8cYKgUr2+SUulZR1ErUMnGkrvX4xW/gGRqYM
        /ORta9KLmudVK++IJlFYciYliAO3vBT+mhTdQjcNct0=
X-Google-Smtp-Source: APXvYqwnGM3bgmafa0PUo1+A4uuPdo7L9ALPkS2QAvxAQutzf1VOfe4H+Tvfe5KUnuBe3FLFr4zwVXZvgtYpTXAqMM0=
X-Received: by 2002:a2e:810f:: with SMTP id d15mr7819224ljg.38.1556549231239;
 Mon, 29 Apr 2019 07:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190422210041.GA21711@archlinux-i9> <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
 <20190423132926.GK17719@sasha-vm> <CAHC9VhRcdY7G_ES2VqNVpkoU=CRJkJySb3m1sFdgKJwh3JQ2oA@mail.gmail.com>
 <20190429124002.GB31371@kroah.com> <CAHC9VhQxrtYJTOj=aOL4FY=myA4ZO-rcY7TdCeFbjVnCmgOxew@mail.gmail.com>
 <20190429140906.GA7412@kroah.com>
In-Reply-To: <20190429140906.GA7412@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Apr 2019 10:47:00 -0400
Message-ID: <CAHC9VhRDoYd=vfz3Sm8NKpMW_QoX7t_VohumUxU5i6AjTwCRyQ@mail.gmail.com>
Subject: Re: scripts/selinux build error in 4.14 after glibc update
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 29, 2019 at 10:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Apr 29, 2019 at 10:02:29AM -0400, Paul Moore wrote:
> > On Mon, Apr 29, 2019 at 8:40 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Apr 23, 2019 at 09:43:09AM -0400, Paul Moore wrote:
> > > > On Tue, Apr 23, 2019 at 9:29 AM Sasha Levin <sashal@kernel.org> wrote:
> > > > > On Mon, Apr 22, 2019 at 09:59:47PM -0400, Paul Moore wrote:
> > > > > >On Mon, Apr 22, 2019 at 5:00 PM Nathan Chancellor
> > > > > ><natechancellor@gmail.com> wrote:
> > > > > >> Hi all,
> > > > > >>
> > > > > >> After a glibc update to 2.29, my 4.14 builds started failing like so:
> > > > > >
> > > > > >...
> > > > > >
> > > > > >>   HOSTCC  scripts/selinux/genheaders/genheaders
> > > > > >> In file included from scripts/selinux/genheaders/genheaders.c:19:
> > > > > >> ./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
> > > > > >>  #error New address family defined, please update secclass_map.
> > > > > >>   ^~~~~
> > > > > >
> > > > > >This is a known problem that has a fix in the selinux/next branch and
> > > > > >will be going up to Linus during the next merge window.  The fix is
> > > > > >quite small and should be relatively easy for you to backport to your
> > > > > >kernel build if you are interested; the patch can be found at the
> > > > > >archive link below:
> > > > > >
> > > > > >https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac
> > > > >
> > > > > Why is it waiting for the next merge window? It fixes a build bug that
> > > > > people hit.
> > > >
> > > > I place a reasonably high bar on patches that I send up to Linus
> > > > outside of the merge window and I didn't feel this patch met that
> > > > criteria.  Nathan is only the second person I've seen who has
> > > > encountered this problem, the first being the original patch author.
> > > > As far as I've seen, the problem is only seen by users building older
> > > > kernels on very new userspaces (e.g. glibc v2.29 was released in
> > > > February 2019, Linux v4.14 was released in 2017); this doesn't appear
> > > > to be a large group of people and I didn't want to risk breaking the
> > > > main kernel tree during the -rcX phase for such a small group.
> > >
> > > Ugh, this breaks my local builds, I would recommend getting it to Linus
> > > sooner please.
> >
> > Well, we are at -rc7 right now and it looks like an -rc8 is unlikely
> > so the question really comes down to can/do you want to wait a week?
>
> It's a regression in the 5.1-rc tree, that is hitting people now.  Why
> do you want to have a 5.1-final that is known to be broken?

I believe I answered that in my reply to Sasha.  Can you answer the
question I asked of you above?

-- 
paul moore
www.paul-moore.com
