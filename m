Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A2C433E0
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19D9206B6
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ2hshuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETPNc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETPNc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 11:13:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D211BC061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:13:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so3433030iog.13
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bN0OU6At5m69ShKtzGd81Iqaay2o6apH4oXs9X7kVUc=;
        b=iZ2hshuCohPFRQV/5STvaWjhrDFks1S/YkvZafP+XmXVY+SzLqzyJ+XCO8RRWPBNiK
         1SAovINAO3e6Ff4q/MlEOYywymeuUzhUfGOqKmfSQrB5Axn7yQo6Vu9cDPC+gjZbT94r
         gXVuXoAT8lLsR1e7nG7XOLbVtQo9DQgKY2niUZuOm2tscoAL75gpZ8qh/F7+Nl6yoAEM
         QYSPbRQBSaTTPWCoiY9QUfbBhv1AcqHN0Elk2Z5RZF7ja9lV2xYu3friqNmqfRs1ks2S
         XYDL1kn/yW6f6cVA1w+6nBvngTuHxMMWhFZGQvKm47wIHIr76owlyC8DnrPMyLhezjYq
         9Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bN0OU6At5m69ShKtzGd81Iqaay2o6apH4oXs9X7kVUc=;
        b=L4NnhCmfXlwYgMw8LRdrMCNkSY9Q0FIenjDDkN4i5VQ8nd0j47KZf6ISofDgLr1cfO
         s8WilAf010Yvl9gRf2TUScnBdX4xKvgwyvWQ/J2eJOtHkdpEIfIPxdiyHCMA7hGQP2pY
         dvZo/+O2/eG+E9WBGNn/NrlehIXpxjoYg7FUWaH0xPbEfrpbELlPNUGn2CtA7T75cUFm
         cuNMd1k8snPfEzPa2K6Q+J+ipikfkWviu5Ka1zWTd8a/RXq7TGlU4XuKW7gxlvYP9lYV
         3Uva76oP3SOrmXdRP7XsD1ryU4aeWVOu07K3J98jG4IzHwf8BA7G1poIpNI35Xog/g4u
         dcLA==
X-Gm-Message-State: AOAM531qPdAmlsmaUy3QH7GCQu3aQ8OJScU/EX/RE17kHyt/B1R2UsQq
        NBxIqnUDMAGL9TxijyPwvP7uTgfq63/EX602lzM=
X-Google-Smtp-Source: ABdhPJwQNtZyMOa+h5gdYav4UWzs6EOlBDvAa3J24SPpDmV74bo3rYqGaZ32+PdYsyycXRB+HGI2D/Zx0b5thPifL1s=
X-Received: by 2002:a6b:f911:: with SMTP id j17mr3711204iog.139.1589987610531;
 Wed, 20 May 2020 08:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200519151457.31618-1-william.c.roberts@intel.com>
 <20200519151457.31618-2-william.c.roberts@intel.com> <CAHC9VhRfWHPkz+rCSAa8kvwVu3dds9q47VfnBFSCJbV3GdMjwQ@mail.gmail.com>
 <CAFftDdpPS0wt3VHiMS6sMKTqAgviNB-TBRT1YqbrzgJftPFj_w@mail.gmail.com> <CAHC9VhS8rV_bF1j9Q7bT97916TKeEpNoCDTmjit9YAyMcJ+chQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS8rV_bF1j9Q7bT97916TKeEpNoCDTmjit9YAyMcJ+chQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 20 May 2020 10:13:19 -0500
Message-ID: <CAFftDdrWNZVvmvAfrLcO61GnTSOs0h5DvZsM7X1mcEP88HM-aA@mail.gmail.com>
Subject: Re: [PATCH] ci: run SE Linux kernel test suite
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 5:23 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, May 19, 2020 at 6:16 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Tue, May 19, 2020 at 5:00 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, May 19, 2020 at 11:15 AM <bill.c.roberts@gmail.com> wrote:
>
> ...
>
> > > > +dnf install -y \
> > >
> > > Another speaking from experience comment: you probably want to add
> > > "--allowerasing" and "--skip-broken" to the dnf command line.  If you
> > > can cope with the extra overhead, I would even suggest a "dnf clean
> > > all -y" at the start.
> >
> > I don't see why we couldn't.
> >
> > Not really sure if it matters for those first two things, considering
> > that were starting
> > in the same state each time. Its not like we need to work on a system
> > that's already
> > been played with.
>
> FWIW, the VM I use for my automated kernel testing doesn't get played
> with (other than to fix dnf/Rawhide problems) and I can tell you from
> experience that Rawhide finds itself broken in new and exciting ways
> :)
>
> You are using a stable Fedora release so it probably won't be too bad,
> I'm just trying to share some of the lessons I've learned.
>

Sure, and I appreciate that. It actually doesn't add any time, to give
you an idea
the CI build time went from 14 to 11 mins. So that'll show you how much
jitter there is. Ill send a V2 all fixed up shortly
