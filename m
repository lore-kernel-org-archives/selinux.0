Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD69AC433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B0E206A5
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQeukTGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENPaF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPaE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 11:30:04 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DFAC061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 08:30:04 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c12so23879545oic.1
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5xjyI4uQ1KCrNdPttZmobl+X+eqe9qLz2noHDryHo0=;
        b=aQeukTGVA4FjWvZj0qRl+wuZESStKqNAVeKzfni+aR2CPR3RNYY+oNbqeyIZqKMSsH
         3mnUsFtC5nh26re/l4t5DnhowANc2zYy7ydkRNXpb/T81+o8gKVFjf0RRs5171IfGnSj
         AgwXGoWuE9IyUB5R8yFkpUGakRVlsy8V7wWg/A0e6bvrG/mAluRFNuKyknRl1bkcGbL8
         GqoiwX1Bo1n9CDKkwz7/N1mqAoHTMTKU7pcRpZUbUsVkMuEA4jBYioOD48y5hC2ItAAu
         mMF4kAU8Sp+Y4xWXcjSxGpa3XLtTlOVfQ1cN46ZaPWIW612q6+kIyKVTQjt6aN44lKsv
         ++KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5xjyI4uQ1KCrNdPttZmobl+X+eqe9qLz2noHDryHo0=;
        b=POE6XiHgTc5ekCWs5qCl2Fy6QgaS3MBKdBSPn8szhX4H6LcWWt+Rwcufj0456VQHvv
         L5e+0FTdQAyPvaje7PEa0x2GnnyPNMVdQfx8VAGMwDRbjVHqrGRf+YljK9/mic9TUfDq
         pnQ/DEd0QHEQICYjCmvl9Fch6NRfdr4sOds2P4kyjqqpFpW/S2HoDvO7soylNlr5cryD
         dsYt9s3nrabXiM+hotHY76F1Hhf5i2b5FE53bdglOXQKa/ScQltuyb9bV0MoZy4sIxJF
         EnJB29JJ8DmZTWu3XOvOT5Y+CrtitEU+OjLMxWEG2Ja6HF0A2F5ZIoyZ3bhBeXt13xEu
         inJg==
X-Gm-Message-State: AGi0PuY4kTP9utqOsq9snq9yw8PyV2SOmKeFvpnABKQgBtXi5Ghf3Zam
        aS5zLeFT3FUIc3FgIiqLErEBZRmPdxgSi2gGrbo=
X-Google-Smtp-Source: APiQypLHJOvowmmPWKkTnRZINkgUS+kUePhe5mwXt0X/s7FF39dfFp8NSmK/021YXO68b/DLFtsJTqq7ksukRP0Mm7U=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr29440591oib.160.1589470203957;
 Thu, 14 May 2020 08:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
 <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com>
 <CAO6P2QS78aTzCvMHgUWmgmkVjEN9v0Wq0Lgys2puL6eRW+CLjg@mail.gmail.com>
 <CAEjxPJ4ePzeuhiRdLndM3U7sybjG8QUO8xhd5RuFNH-YB8NB1w@mail.gmail.com> <CAO6P2QS0ze4e7qRfZBkemZTaM9QQUwUwhNs2bG4gfTkenwcsiA@mail.gmail.com>
In-Reply-To: <CAO6P2QS0ze4e7qRfZBkemZTaM9QQUwUwhNs2bG4gfTkenwcsiA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 May 2020 11:29:53 -0400
Message-ID: <CAEjxPJ7kF-TB22fZmYPuH0jtBTUBzfd=BcKryPs0t-1H+CwN5g@mail.gmail.com>
Subject: Re: Configuring MLS with a daemon operating at multiple sensitivities
To:     Paul Tagliamonte <paultag@debian.org>
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 10:57 AM Paul Tagliamonte <paultag@debian.org> wrote:
>
> > Was computing the MLS label the only part you needed?  With respect to
> > having the daemon run in the same label as the peer (or the label
> > derived from the intersection of the peer and the daemon), you may
> > wish to have a look at mod_selinux for Apache and/or the old xinetd
> > LABELED option, although neither of those would have included the new
> > glblub support so you'll have to integrate that yourself.
>
> Ah, really helpful pointers, thank you very much!
>
> > Or your daemon can just use setcon(3) directly if allowed by policy.
>
> My assumption was that I can use the greatest lower bound, and then
> preform a `setexeccon` and `exec` to transition to the new security
> context provided I can pass the open fd according to policy (for
> now -- at least until I can find a better way to restrict a thread -- I'll
> do some reading in mod_selinux / xinetd). Is this the case, or am
> I going to wind up in a world of hurt?

setcon(3) would avoid the need for a separate exec but requires more
trust in the caller. Up to you as to which model works for your use
case.  Originally SELinux only supported setexeccon(3) but setcon(3)
was added particularly for MLS users and has since been leveraged
elsewhere.  mod_selinux uses setcon(3).  xinetd LABELED uses
setexeccon(3) since it was already exec'ing a separate child daemon.

> The use-case here is to allow an RPC server to listen to network
> traffic, and when properly authenticated, raise the sensitivity level
> and category as required, both so the RPC server can logically
> handle access controls (not shocked the crunchy folks hit this first)
> as well as a system level protection in case there's a slip up and
> the server attempts to read a secure file (less urgent but still
> very nice to have!).
>
> I'm very much still learning the MLS ropes here, so if someone
> sees me hurtling to the edge of a cliff, do let me know!
