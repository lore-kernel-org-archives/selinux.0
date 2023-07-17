Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E5EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGQSpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGQSpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 14:45:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C499
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 11:45:08 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7835ae70e46so219599439f.3
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619507; x=1692211507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu8SQW+lwdFmvqeXchEGwf5IMaLc+DR3+fYgCgNbhz8=;
        b=jTayVOM1YK//68z3VpqXhnzKabOOfB/UzUWXXR4reDveWB+78f2piBFaGABln69s07
         zpgu2mfxiXJAH2lPtRAWkX3dPu43wBdQdtT8IcYMb1zar4mMjE4ukk2SVpwDgDlJvTH2
         Iv6KOIIVufRbPCgvfzpGm2ZG6G8kaVK0pE4TxMT2QMK8be9o4+lsa7bzmq8LaM6IcAyM
         hMkOKVdBpRW+4YenJLsa4Fn8k9dZpUBBhu0/X3Wyl8O6bopLC4JxQrZZ0cL7XiAb+nnd
         tyrfmSkHXrxFpVd5HYN9S5l0bp47Tw1LRcgzIYTYDKsQK+p0ZHkp8+sQnbURABg1/lsp
         Wc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619507; x=1692211507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu8SQW+lwdFmvqeXchEGwf5IMaLc+DR3+fYgCgNbhz8=;
        b=SxaHGFXDxm9Aeox0DvOukqe7iNG7VUTy6eDduRZynAfnJpEsku+BmRBMZrGU9Mwtk4
         SzMK/ogoLTql4s8YzKUMkkp1ym1hH+GCSGEp4oytqpyKd4ykP1TVgj7sgyTeGxchPvah
         yiRg1j2Vpz2ox+lwiaR1YOB6sPRxaNrGJblLHNEWXjXfWUAqr42gUaAuTLy7GOgbGA+R
         IKMFyjTILF2BS5vc9Omq6CA7qGesDMzj9vU3Vg/OiAsstSASvcftH0Raau+YtRI4m+Wo
         daSKpBvALUUx3Hgk80AUIT8IA2b+BJn4JlIcBDncKnz0P9aqvPd4Ib5k5R5WREJuWFee
         fQ5A==
X-Gm-Message-State: ABy/qLasn2AznpfBO3BsAKdAmioTYr+4fo7UsHNLQj+LRN8xZAa9SHCx
        R+bW6Aosrogd4g1Mf1w0yXPOsVMGE2knhm4qWwKq7nSQ
X-Google-Smtp-Source: APBJJlHEGMrtVhrmu7OyyFyYY9WlzAn1EgxBXLgsPy1oOvsfCKeRbwvdgrht2EonNShrIDoAL9230rkr1Y/QDvLSWA4=
X-Received: by 2002:a05:6e02:15c2:b0:347:73b4:9cf6 with SMTP id
 q2-20020a056e0215c200b0034773b49cf6mr681498ilu.23.1689619507392; Mon, 17 Jul
 2023 11:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01> <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
 <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01> <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
 <20230620075100.4wvquojo52dhrixa@jmarcin-t14s-01>
In-Reply-To: <20230620075100.4wvquojo52dhrixa@jmarcin-t14s-01>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 17 Jul 2023 14:44:56 -0400
Message-ID: <CAEjxPJ6RSkOXRuuUCJr2=irN4k7M_isL12Gky--ucqJ-Fmmzcg@mail.gmail.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 20, 2023 at 3:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> On 2023-06-19 17:53, Paul Moore wrote:
> > On Sun, Jun 18, 2023 at 5:41=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> > >
> > > On 2023-06-15 22:04, Paul Moore wrote:
> > > > On Thu, Jun 1, 2023 at 1:03=E2=80=AFPM Juraj Marcin <juraj@jurajmar=
cin.com> wrote:
> > > > > On 2023-05-31 18:24, Paul Moore wrote:
> > > > > > On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jur=
ajmarcin.com> wrote:
> > > > > > >
> > > > > > > Currently, filename transitions are stored separately from ot=
her type
> > > > > > > enforcement rules and only support exact name matching. Howev=
er, in
> > > > > > > practice, the names contain variable parts. This leads to man=
y
> > > > > > > duplicated rules in the policy that differ only in the part o=
f the name,
> > > > > > > or it is even impossible to cover all possible combinations.
> > > > > > >
> > > > > > > First, this series of patches moves the filename transitions =
to be part
> > > > > > > of the avtab structures. This not only makes the implementati=
on of
> > > > > > > prefix/suffix matching and future enhancements easier, but al=
so reduces
> > > > > > > the technical debt regarding the filename transitions. Next, =
the last
> > > > > > > patch implements the support for prefix/suffix name matching =
itself by
> > > > > > > extending the structures added in previous patches in this se=
ries.
> > > > > > >
> > > > > > > Even though, moving everything to avtab increases the memory =
usage and
> > > > > > > the size of the binary policy itself and thus the loading tim=
e, the
> > > > > > > ability to match the prefix or suffix of the name will reduce=
 the
> > > > > > > overall number of rules in the policy which should mitigate t=
his issue.
> > > > > > >
> > > > > > > This implementation has been successfully tested using the ex=
isting and
> > > > > > > also new tests in the SELinux Testsuite.
> > > > > > >
> > > > > > > Juraj Marcin (5):
> > > > > > >   selinux: move transition to separate structure in avtab_dat=
um
> > > > > > >   selinux: move filename transitions to avtab
> > > > > > >   selinux: implement new binary format for filename transitio=
ns in avtab
> > > > > > >   selinux: filename transitions move tests
> > > > > > >   selinux: add prefix/suffix matching support to filename typ=
e
> > > > > > >     transitions
> > > > > >
> > > > > > Just a quick comment as I haven't had a chance to properly revi=
ew this
> > > > > > series yet; you show some memory usage and performance measurem=
ents in
> > > > > > some of the intermediate patches, that's good, but I don't see =
the
> > > > > > same measurements taken when the full patchset is applied.  Ple=
ase
> > > > > > provide the same memory usage and performance comparisons with =
the
> > > > > > full patchset applied.
> > > > >
> > > > > Of course, here are the measurements with the whole patchset appl=
ied.
> > > > >
> > > > > I also included measurements with new policy (based on the Fedora
> > > > > policy) that uses prefix filename transitions where possible. Thi=
s new
> > > > > policy has been generated by merging existing filename transition=
s into
> > > > > prefix ones if it would reduce the number of transitions overall =
while
> > > > > keeping the resulting type same.
> > > > >
> > > > > [1] Reference kernel (c52df19e3759), Fedora policy (format v33)
> > > > > [2] This patchset, Fedora policy (format v33)
> > > > > [3] This patchset, Fedora policy without prefix/suffix rules (for=
mat v35)
> > > > > [4] This patchset, Fedora policy with prefix rules (format v35)
> > > > >
> > > > >
> > > > >  Test | Mem   | Binary | Policy | Create tty      | osbench
> > > > >       | Usage | policy | load   |                 | create
> > > > >       |       | size   | time   | (ms/file)       | files
> > > > >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > > > > ------+-------+--------+--------+--------+--------+-----------
> > > > >  [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
> > > > >  [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
> > > > >  [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
> > > > >  [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609
> > > >
> > > > Thanks for performing those measurements.
> > > >
> > > > I apologize that I haven't had an opportunity to review your patche=
set
> > > > in detail just yet (I've been struggling with some self-inflicted
> > > > networking issues this week), but looking strictly at the numbers
> > > > above it appears that by every metric in the table this patchset
> > > > results in a policy that is larger (both on-disk and in-memory) as
> > > > well as performance that is at best the same (although in most case=
s,
> > > > it is worse).  Are there any improvements expected beyond test
> > > > configuration [4] (above)?
> > >
> > > The main goal of this patchset is to bring the possibility to use pre=
fix
> > > or suffix matching in filename transitions, as now it is not possible=
 to
> > > cover files that have fixed prefix and variable part after it. For
> > > example devices in /dev (the policy now enumerates all possible numbe=
r
> > > suffixes) or files with random suffix/prefix (not possible at all).
> > >
> > > The next goal is to make future improvements easier, for example
> > > supporting filename transitions in conditional policies or inherent
> > > support for type attributes.
> > >
> > > As for performance, the goal is to implement previous goals while not
> > > killing the performance by them. Christian suggested some possible
> > > optimizations [1], but after trying them out [2] they either not prov=
ide
> > > much measurable difference or the difference is small and the
> > > implementation hacky.
> >
> > I understand performance improvements were not the main motivation
> > behind this patchset, but I'm somewhat concerned that policy load time
> > *almost* triples in the case of an unmodified policy with this patch
> > applied.  Since that will be most everyone as soon as this patch is
> > applied, that regression does concern me ... I'm not sure just yet how
> > much it concerns me, but it isn't trivial.
>
> I also understand your concern. That higher load time (and also memory
> usage) is the cost of doing the conversion from the older binary policy
> format in the kernel during load.
>
> However, to reduce both load time and memory usage to the values in the
> third test, the only action needed is recompiling the policy with newer
> checkpolicy/libsepol, patches to which I also proposed.

I'm also struggling a bit with the justification here. If the runtime
and memory usage is worse or no better in every dimension even with a
policy rewritten to use the new prefix/suffix matching feature, it
seems hard to justify the change.

I'd be curious to see what results you would get if you simply added
the new feature (prefix/suffix matching) without moving the name-based
transitions into the avtab.

Also wondering whether you considered the simpler approach of just
augmenting the kernel to recognize and support use of wildcards at the
beginning and/or end of the existing name field to signify a prefix or
suffix match. That seems more amenable to extensions beyond just
prefix or suffix match.
