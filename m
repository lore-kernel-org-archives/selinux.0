Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6BEB64D7
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 07:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjFTHwT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFTHwG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 03:52:06 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3819B3
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 00:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687247464; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=L0gSbDyRgk/jj75gmeTFrKhutM+KHmSBsBves5g7uPirF/gBeT9SF0h5ZscMIN+xBukFQo8jPI6xB+YvNMdRBzbXXkoxnNAtGi6YLm4OUR91UZAG7s7g+FvMLSSOr1Nv/q184zH+WZp2O4EX7biV1+/YtSdhuNNTc5/ORTLNU70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687247464; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rqV1DCDeCRHrMTmgJXj4v8SPPgCFjcjmCS0yWQ6QWTw=; 
        b=YL50eFw1pQagImDMo4/fTBUaOHnGCXDzzMe+tkHUGA9cY62wQln1ikHceJTtZNj/8CstG62WBdWY2QbCqi2HhoELUgCdzlNE+DnPiBkUCNOvjpDD7Bv0jLEwTPEmFxHiZnaRdU7+lrA06UNz18st565WmHDCIBu011tvFHh0wP8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687247464;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=rqV1DCDeCRHrMTmgJXj4v8SPPgCFjcjmCS0yWQ6QWTw=;
        b=D6zui6632JCOIjpg0mDjHsi8jvr3uRBtAvtNSCYZVoTfexHeQTs5l/AtSTEdInej
        GAQnRlf/+VUYzZIZzHkyCEn/Bm90Z9lV18H1WOM3ecc5+j7BWsUme/3LKiVe1LKB7k1
        8mfIbn40M6bM/+YgH5wsg9KJbHP6x2Gn2cAbrNRA=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687247463177866.8783535744361; Tue, 20 Jun 2023 09:51:03 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [213.175.37.12])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 3CC5D2081F76;
        Tue, 20 Jun 2023 07:51:02 +0000 (UTC)
Date:   Tue, 20 Jun 2023 09:51:00 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20230620075100.4wvquojo52dhrixa@jmarcin-t14s-01>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
 <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
 <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01>
 <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-06-19 17:53, Paul Moore wrote:
> On Sun, Jun 18, 2023 at 5:41=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> >
> > On 2023-06-15 22:04, Paul Moore wrote:
> > > On Thu, Jun 1, 2023 at 1:03=E2=80=AFPM Juraj Marcin <juraj@jurajmar=
cin.com> wrote:
> > > > On 2023-05-31 18:24, Paul Moore wrote:
> > > > > On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jur=
ajmarcin.com> wrote:
> > > > > >
> > > > > > Currently, filename transitions are stored separately from ot=
her type
> > > > > > enforcement rules and only support exact name matching. Howev=
er, in
> > > > > > practice, the names contain variable parts. This leads to man=
y
> > > > > > duplicated rules in the policy that differ only in the part o=
f the name,
> > > > > > or it is even impossible to cover all possible combinations.
> > > > > >
> > > > > > First, this series of patches moves the filename transitions =
to be part
> > > > > > of the avtab structures. This not only makes the implementati=
on of
> > > > > > prefix/suffix matching and future enhancements easier, but al=
so reduces
> > > > > > the technical debt regarding the filename transitions. Next, =
the last
> > > > > > patch implements the support for prefix/suffix name matching =
itself by
> > > > > > extending the structures added in previous patches in this se=
ries.
> > > > > >
> > > > > > Even though, moving everything to avtab increases the memory =
usage and
> > > > > > the size of the binary policy itself and thus the loading tim=
e, the
> > > > > > ability to match the prefix or suffix of the name will reduce=
 the
> > > > > > overall number of rules in the policy which should mitigate t=
his issue.
> > > > > >
> > > > > > This implementation has been successfully tested using the ex=
isting and
> > > > > > also new tests in the SELinux Testsuite.
> > > > > >
> > > > > > Juraj Marcin (5):
> > > > > >   selinux: move transition to separate structure in avtab_dat=
um
> > > > > >   selinux: move filename transitions to avtab
> > > > > >   selinux: implement new binary format for filename transitio=
ns in avtab
> > > > > >   selinux: filename transitions move tests
> > > > > >   selinux: add prefix/suffix matching support to filename typ=
e
> > > > > >     transitions
> > > > >
> > > > > Just a quick comment as I haven't had a chance to properly revi=
ew this
> > > > > series yet; you show some memory usage and performance measurem=
ents in
> > > > > some of the intermediate patches, that's good, but I don't see =
the
> > > > > same measurements taken when the full patchset is applied.  Ple=
ase
> > > > > provide the same memory usage and performance comparisons with =
the
> > > > > full patchset applied.
> > > >
> > > > Of course, here are the measurements with the whole patchset appl=
ied.
> > > >
> > > > I also included measurements with new policy (based on the Fedora
> > > > policy) that uses prefix filename transitions where possible. Thi=
s new
> > > > policy has been generated by merging existing filename transition=
s into
> > > > prefix ones if it would reduce the number of transitions overall =
while
> > > > keeping the resulting type same.
> > > >
> > > > [1] Reference kernel (c52df19e3759), Fedora policy (format v33)
> > > > [2] This patchset, Fedora policy (format v33)
> > > > [3] This patchset, Fedora policy without prefix/suffix rules (for=
mat v35)
> > > > [4] This patchset, Fedora policy with prefix rules (format v35)
> > > >
> > > >
> > > >  Test | Mem   | Binary | Policy | Create tty      | osbench
> > > >       | Usage | policy | load   |                 | create
> > > >       |       | size   | time   | (ms/file)       | files
> > > >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > > > ------+-------+--------+--------+--------+--------+-----------
> > > >  [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
> > > >  [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
> > > >  [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
> > > >  [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609
> > >
> > > Thanks for performing those measurements.
> > >
> > > I apologize that I haven't had an opportunity to review your patche=
set
> > > in detail just yet (I've been struggling with some self-inflicted
> > > networking issues this week), but looking strictly at the numbers
> > > above it appears that by every metric in the table this patchset
> > > results in a policy that is larger (both on-disk and in-memory) as
> > > well as performance that is at best the same (although in most case=
s,
> > > it is worse).  Are there any improvements expected beyond test
> > > configuration [4] (above)?
> >
> > The main goal of this patchset is to bring the possibility to use pre=
fix
> > or suffix matching in filename transitions, as now it is not possible=
 to
> > cover files that have fixed prefix and variable part after it. For
> > example devices in /dev (the policy now enumerates all possible numbe=
r
> > suffixes) or files with random suffix/prefix (not possible at all).
> >
> > The next goal is to make future improvements easier, for example
> > supporting filename transitions in conditional policies or inherent
> > support for type attributes.
> >
> > As for performance, the goal is to implement previous goals while not
> > killing the performance by them. Christian suggested some possible
> > optimizations [1], but after trying them out [2] they either not prov=
ide
> > much measurable difference or the difference is small and the
> > implementation hacky.
>=20
> I understand performance improvements were not the main motivation
> behind this patchset, but I'm somewhat concerned that policy load time
> *almost* triples in the case of an unmodified policy with this patch
> applied.  Since that will be most everyone as soon as this patch is
> applied, that regression does concern me ... I'm not sure just yet how
> much it concerns me, but it isn't trivial.

I also understand your concern. That higher load time (and also memory
usage) is the cost of doing the conversion from the older binary policy
format in the kernel during load.

However, to reduce both load time and memory usage to the values in the
third test, the only action needed is recompiling the policy with newer
checkpolicy/libsepol, patches to which I also proposed.

--=20
Juraj Marcin
