Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC5CEB64DC
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 21:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFSVyF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjFSVx4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jun 2023 17:53:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3980E74
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:53:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5701eaf0d04so43035077b3.2
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687211630; x=1689803630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf1xPvG7SSQwED7EJmNGpy9fF+ilsVBdYnMmfLghWgk=;
        b=U7C275Ssz9zrn5j12of2rHZqeMyh0embt4AEpAOVBOX4vqUjW9Thid8XL65zIQjJZv
         rQIuHEAs2RqMVW1szljfd/YiDcwe+Pvr1/l4EvweB2iAYFsMpWBg1lu5N/fOzm63G+1J
         rS+EVVKNDKK0xA/K7yE9HMarE/mk3RK1zwd2SF+71NU+2sU1IM3881YyocDWvFYfrMpK
         vjoJiU0GF2IdZJsljyY1o6NmRDhMXAod1adr4GNBO9FVC0POX7j2msnNeD4vsD5onsuq
         MP6wr4tnCe8KYRwBsOzbxN99PlJn8KDsg/MX2hrF/aAQ1NqEUsXXne3AIuM83HaK+GaN
         d6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687211630; x=1689803630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf1xPvG7SSQwED7EJmNGpy9fF+ilsVBdYnMmfLghWgk=;
        b=UMD+6yox8LQq4IauVZBPFzB9BYfVkmSSSoOlgGxDFqta6Oi9w7tntvah9t8scLWVPV
         NNseeOzLA/0ZayGdMFd874m6sne64Fnji+aIwgj6n1Tze6smbYl5+rTdoXwhPYu622mx
         OBJj70/pzBIHM4ZFGFdlLbZIvizTPBrbApBfYwts3yrALH7VTnKa4zuWT2zbAQkKLEni
         BndP+1j3ZCjFbjt3iF9u/O6FBglmWXoJ36bF67FpWpTKp+nIZ8zroEos1nmOU0YRv94O
         6eqWc0v1b1mqC3COm6ZC+aFxY/BuPa+lj1oerOUZwrJM8TR3PYVdWp5uiZDSZMiV6mAK
         MsZw==
X-Gm-Message-State: AC+VfDye/VpyRO9Ka5rLYUjlmKrpWg5QaJ6fdpv6nrj4LKzBqZJFuaWF
        uzruISn5hd+BVqmSwKcuwR18odjRfQQp8C13kkbJ
X-Google-Smtp-Source: ACHHUZ7BDbPjp+xZ+FSU5yPRX3DeAQOvhvBjJKAqG4kJAdX3Ar+YLye9bCK/GgH0YpAy+751NEO55JJwmzKhDjLTSYY=
X-Received: by 2002:a81:7206:0:b0:570:209a:a4fe with SMTP id
 n6-20020a817206000000b00570209aa4femr10777437ywc.32.1687211629851; Mon, 19
 Jun 2023 14:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01> <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
 <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01>
In-Reply-To: <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jun 2023 17:53:39 -0400
Message-ID: <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jun 18, 2023 at 5:41=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> On 2023-06-15 22:04, Paul Moore wrote:
> > On Thu, Jun 1, 2023 at 1:03=E2=80=AFPM Juraj Marcin <juraj@jurajmarcin.=
com> wrote:
> > > On 2023-05-31 18:24, Paul Moore wrote:
> > > > On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajma=
rcin.com> wrote:
> > > > >
> > > > > Currently, filename transitions are stored separately from other =
type
> > > > > enforcement rules and only support exact name matching. However, =
in
> > > > > practice, the names contain variable parts. This leads to many
> > > > > duplicated rules in the policy that differ only in the part of th=
e name,
> > > > > or it is even impossible to cover all possible combinations.
> > > > >
> > > > > First, this series of patches moves the filename transitions to b=
e part
> > > > > of the avtab structures. This not only makes the implementation o=
f
> > > > > prefix/suffix matching and future enhancements easier, but also r=
educes
> > > > > the technical debt regarding the filename transitions. Next, the =
last
> > > > > patch implements the support for prefix/suffix name matching itse=
lf by
> > > > > extending the structures added in previous patches in this series=
.
> > > > >
> > > > > Even though, moving everything to avtab increases the memory usag=
e and
> > > > > the size of the binary policy itself and thus the loading time, t=
he
> > > > > ability to match the prefix or suffix of the name will reduce the
> > > > > overall number of rules in the policy which should mitigate this =
issue.
> > > > >
> > > > > This implementation has been successfully tested using the existi=
ng and
> > > > > also new tests in the SELinux Testsuite.
> > > > >
> > > > > Juraj Marcin (5):
> > > > >   selinux: move transition to separate structure in avtab_datum
> > > > >   selinux: move filename transitions to avtab
> > > > >   selinux: implement new binary format for filename transitions i=
n avtab
> > > > >   selinux: filename transitions move tests
> > > > >   selinux: add prefix/suffix matching support to filename type
> > > > >     transitions
> > > >
> > > > Just a quick comment as I haven't had a chance to properly review t=
his
> > > > series yet; you show some memory usage and performance measurements=
 in
> > > > some of the intermediate patches, that's good, but I don't see the
> > > > same measurements taken when the full patchset is applied.  Please
> > > > provide the same memory usage and performance comparisons with the
> > > > full patchset applied.
> > >
> > > Of course, here are the measurements with the whole patchset applied.
> > >
> > > I also included measurements with new policy (based on the Fedora
> > > policy) that uses prefix filename transitions where possible. This ne=
w
> > > policy has been generated by merging existing filename transitions in=
to
> > > prefix ones if it would reduce the number of transitions overall whil=
e
> > > keeping the resulting type same.
> > >
> > > [1] Reference kernel (c52df19e3759), Fedora policy (format v33)
> > > [2] This patchset, Fedora policy (format v33)
> > > [3] This patchset, Fedora policy without prefix/suffix rules (format =
v35)
> > > [4] This patchset, Fedora policy with prefix rules (format v35)
> > >
> > >
> > >  Test | Mem   | Binary | Policy | Create tty      | osbench
> > >       | Usage | policy | load   |                 | create
> > >       |       | size   | time   | (ms/file)       | files
> > >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > > ------+-------+--------+--------+--------+--------+-----------
> > >  [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
> > >  [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
> > >  [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
> > >  [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609
> >
> > Thanks for performing those measurements.
> >
> > I apologize that I haven't had an opportunity to review your patcheset
> > in detail just yet (I've been struggling with some self-inflicted
> > networking issues this week), but looking strictly at the numbers
> > above it appears that by every metric in the table this patchset
> > results in a policy that is larger (both on-disk and in-memory) as
> > well as performance that is at best the same (although in most cases,
> > it is worse).  Are there any improvements expected beyond test
> > configuration [4] (above)?
>
> The main goal of this patchset is to bring the possibility to use prefix
> or suffix matching in filename transitions, as now it is not possible to
> cover files that have fixed prefix and variable part after it. For
> example devices in /dev (the policy now enumerates all possible number
> suffixes) or files with random suffix/prefix (not possible at all).
>
> The next goal is to make future improvements easier, for example
> supporting filename transitions in conditional policies or inherent
> support for type attributes.
>
> As for performance, the goal is to implement previous goals while not
> killing the performance by them. Christian suggested some possible
> optimizations [1], but after trying them out [2] they either not provide
> much measurable difference or the difference is small and the
> implementation hacky.

I understand performance improvements were not the main motivation
behind this patchset, but I'm somewhat concerned that policy load time
*almost* triples in the case of an unmodified policy with this patch
applied.  Since that will be most everyone as soon as this patch is
applied, that regression does concern me ... I'm not sure just yet how
much it concerns me, but it isn't trivial.

--=20
paul-moore.com
