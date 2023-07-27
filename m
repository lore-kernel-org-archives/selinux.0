Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F3C001E0
	for <selinux@archiver.kernel.org>; Thu, 27 Jul 2023 16:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjG0Q6b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jul 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjG0Q63 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jul 2023 12:58:29 -0400
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 09:58:26 PDT
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9F271B
        for <selinux@vger.kernel.org>; Thu, 27 Jul 2023 09:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690476184; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=kuMDgAfLfGCJEhxvzMgYtwCMf1xrUha6GPwG1uLT3zI54Q19uwE5lOhU25GKNMjEQFCSSm4l0dk+S8d1vA6Sdt6cvVaU8aff7C/1gCznEkLMbI2dGFGeXk+Ik/k1G/PvvY7OtnmFgGrw/luXcDi4rezWYtrPgfBh28fBHde/5To=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1690476184; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=kOp2iXRZRTXipByhDI+MHPTyLjpYoT7Hmbn7KwDlskY=; 
        b=NQGmrJdRrHdiqrk960crZegEDOM3GtsNhM3spfXhmiLjb2FIkW/Qsgull/Sqc8J0a0bgcO+2Y+XGROGZhEK8HhQNjWke3EEsujskDEBSmLIGVFQqoPQfJ28r57EEuKRq86mgnLN6yKI0V/3UCxId+iv5ac74dCqrWC1i1xcr2Xk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690476184;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=kOp2iXRZRTXipByhDI+MHPTyLjpYoT7Hmbn7KwDlskY=;
        b=Gvs7OZZInXNo8dwaAqKLIjiQeQ89jPD5dkxHM5Uq6LLIPCqpKe1F7lF7Pyc4uyv8
        WCk8ynd4BZ3K8MEzRjT2nShifnE1xKMCK04BvbLuHm+K3AxQdH7+pR5b+Dsqs07JWTO
        +xCmsCV70D7iDb5sGXDMGMZlON17spk3T0mVl2hg=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1690476181806135.91838607982618; Thu, 27 Jul 2023 18:43:01 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [213.175.37.10])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 850B52081F64;
        Thu, 27 Jul 2023 16:43:00 +0000 (UTC)
Date:   Thu, 27 Jul 2023 18:42:59 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20230727164259.cys5mabxa5aeonod@jmarcin-t14s-01>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
 <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
 <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01>
 <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
 <20230620075100.4wvquojo52dhrixa@jmarcin-t14s-01>
 <CAEjxPJ6RSkOXRuuUCJr2=irN4k7M_isL12Gky--ucqJ-Fmmzcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEjxPJ6RSkOXRuuUCJr2=irN4k7M_isL12Gky--ucqJ-Fmmzcg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-07-17 14:44, Stephen Smalley wrote:
> On Tue, Jun 20, 2023 at 3:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> >
> > On 2023-06-19 17:53, Paul Moore wrote:
> > > On Sun, Jun 18, 2023 at 5:41=E2=80=AFAM Juraj Marcin <juraj@jurajma=
rcin.com> wrote:
> > > >
> > > > On 2023-06-15 22:04, Paul Moore wrote:
> > > > > On Thu, Jun 1, 2023 at 1:03=E2=80=AFPM Juraj Marcin <juraj@jura=
jmarcin.com> wrote:
> > > > > > On 2023-05-31 18:24, Paul Moore wrote:
> > > > > > > On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj=
@jurajmarcin.com> wrote:
> > > > > > > >
> > > > > > > > Currently, filename transitions are stored separately fro=
m other type
> > > > > > > > enforcement rules and only support exact name matching. H=
owever, in
> > > > > > > > practice, the names contain variable parts. This leads to=
 many
> > > > > > > > duplicated rules in the policy that differ only in the pa=
rt of the name,
> > > > > > > > or it is even impossible to cover all possible combinatio=
ns.
> > > > > > > >
> > > > > > > > First, this series of patches moves the filename transiti=
ons to be part
> > > > > > > > of the avtab structures. This not only makes the implemen=
tation of
> > > > > > > > prefix/suffix matching and future enhancements easier, bu=
t also reduces
> > > > > > > > the technical debt regarding the filename transitions. Ne=
xt, the last
> > > > > > > > patch implements the support for prefix/suffix name match=
ing itself by
> > > > > > > > extending the structures added in previous patches in thi=
s series.
> > > > > > > >
> > > > > > > > Even though, moving everything to avtab increases the mem=
ory usage and
> > > > > > > > the size of the binary policy itself and thus the loading=
 time, the
> > > > > > > > ability to match the prefix or suffix of the name will re=
duce the
> > > > > > > > overall number of rules in the policy which should mitiga=
te this issue.
> > > > > > > >
> > > > > > > > This implementation has been successfully tested using th=
e existing and
> > > > > > > > also new tests in the SELinux Testsuite.
> > > > > > > >
> > > > > > > > Juraj Marcin (5):
> > > > > > > >   selinux: move transition to separate structure in avtab=
_datum
> > > > > > > >   selinux: move filename transitions to avtab
> > > > > > > >   selinux: implement new binary format for filename trans=
itions in avtab
> > > > > > > >   selinux: filename transitions move tests
> > > > > > > >   selinux: add prefix/suffix matching support to filename=
 type
> > > > > > > >     transitions
> > > > > > >
> > > > > > > Just a quick comment as I haven't had a chance to properly =
review this
> > > > > > > series yet; you show some memory usage and performance meas=
urements in
> > > > > > > some of the intermediate patches, that's good, but I don't =
see the
> > > > > > > same measurements taken when the full patchset is applied. =
 Please
> > > > > > > provide the same memory usage and performance comparisons w=
ith the
> > > > > > > full patchset applied.
> > > > > >
> > > > > > Of course, here are the measurements with the whole patchset =
applied.
> > > > > >
> > > > > > I also included measurements with new policy (based on the Fe=
dora
> > > > > > policy) that uses prefix filename transitions where possible.=
 This new
> > > > > > policy has been generated by merging existing filename transi=
tions into
> > > > > > prefix ones if it would reduce the number of transitions over=
all while
> > > > > > keeping the resulting type same.
> > > > > >
> > > > > > [1] Reference kernel (c52df19e3759), Fedora policy (format v3=
3)
> > > > > > [2] This patchset, Fedora policy (format v33)
> > > > > > [3] This patchset, Fedora policy without prefix/suffix rules =
(format v35)
> > > > > > [4] This patchset, Fedora policy with prefix rules (format v3=
5)
> > > > > >
> > > > > >
> > > > > >  Test | Mem   | Binary | Policy | Create tty      | osbench
> > > > > >       | Usage | policy | load   |                 | create
> > > > > >       |       | size   | time   | (ms/file)       | files
> > > > > >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > > > > > ------+-------+--------+--------+--------+--------+----------=
-
> > > > > >  [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
> > > > > >  [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
> > > > > >  [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
> > > > > >  [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609
> > > > >
> > > > > Thanks for performing those measurements.
> > > > >
> > > > > I apologize that I haven't had an opportunity to review your pa=
tcheset
> > > > > in detail just yet (I've been struggling with some self-inflict=
ed
> > > > > networking issues this week), but looking strictly at the numbe=
rs
> > > > > above it appears that by every metric in the table this patchse=
t
> > > > > results in a policy that is larger (both on-disk and in-memory)=
 as
> > > > > well as performance that is at best the same (although in most =
cases,
> > > > > it is worse).  Are there any improvements expected beyond test
> > > > > configuration [4] (above)?
> > > >
> > > > The main goal of this patchset is to bring the possibility to use=
 prefix
> > > > or suffix matching in filename transitions, as now it is not poss=
ible to
> > > > cover files that have fixed prefix and variable part after it. Fo=
r
> > > > example devices in /dev (the policy now enumerates all possible n=
umber
> > > > suffixes) or files with random suffix/prefix (not possible at all=
).
> > > >
> > > > The next goal is to make future improvements easier, for example
> > > > supporting filename transitions in conditional policies or inhere=
nt
> > > > support for type attributes.
> > > >
> > > > As for performance, the goal is to implement previous goals while=
 not
> > > > killing the performance by them. Christian suggested some possibl=
e
> > > > optimizations [1], but after trying them out [2] they either not =
provide
> > > > much measurable difference or the difference is small and the
> > > > implementation hacky.
> > >
> > > I understand performance improvements were not the main motivation
> > > behind this patchset, but I'm somewhat concerned that policy load t=
ime
> > > *almost* triples in the case of an unmodified policy with this patc=
h
> > > applied.  Since that will be most everyone as soon as this patch is
> > > applied, that regression does concern me ... I'm not sure just yet =
how
> > > much it concerns me, but it isn't trivial.
> >
> > I also understand your concern. That higher load time (and also memor=
y
> > usage) is the cost of doing the conversion from the older binary poli=
cy
> > format in the kernel during load.
> >
> > However, to reduce both load time and memory usage to the values in t=
he
> > third test, the only action needed is recompiling the policy with new=
er
> > checkpolicy/libsepol, patches to which I also proposed.
>=20

Hi Stephen

Sorry for late reply, but before replying, I wanted to finish the
prototype of an alternative solution to this feature, which I was
already working on, but I got stuck on other tasks. The performance
metrics of this solution can be found below.


> I'm also struggling a bit with the justification here. If the runtime
> and memory usage is worse or no better in every dimension even with a
> policy rewritten to use the new prefix/suffix matching feature, it
> seems hard to justify the change.

The main reasons to move filename transitions to avtab were to solve
issues that arise due to the separation of filename type transitions
from other type enforcement rules, which Ondrej also mentioned to me in
person while discussing this idea. By moving the filename transitions
closer to other rules, we can:

- reduce the technical debt in the code,
- support type attributes as other rules do (this could also reduce
  number of required rules),
- make other improvements easier, namely prefix/suffix matching or
  supporting filename transitions in conditional avtab as proposed by
  Christian [1].

These improvements come at a price. However, much of the performance
loss is reclaimed by simply converting the policy to the new format.
Only its size on the disk stays the same without modifying the rules.


[1]: https://lore.kernel.org/selinux/20230602135427.33897-1-cgzones@googl=
email.com/


>=20
> I'd be curious to see what results you would get if you simply added
> the new feature (prefix/suffix matching) without moving the name-based
> transitions into the avtab.

Here are the performance metrics of a prototype solution, where the
filename transition key is extended with match_type and match is found
by shortening the name from the end or the beginning if a full match is
not found.

[2] Reference kernel (447a5688005e), Fedora policy (format v33)
[3] This patchset, Fedora policy (format v33)
[4] This patchset, Fedora policy without prefix/suffix rules (format v34)
[5] This patchset, Fedora policy with prefix rules (format v34)


 Test | Mem   | Binary | Policy | Create tty      | osbench
      | Usage | policy | load   |                 | create
      |       | size   | time   | (ms/file)       | files
      | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
------+-------+--------+--------+--------+--------+-----------
 [2]  |   157 |    3.4 |     76 |  1.256 |  0.871 | 9.4492
 [3]  |   156 |    3.4 |     77 |  1.208 |  0.869 | 9.6160
 [4]  |   157 |    3.4 |     71 |  1.239 |  0.893 | 9.6297
 [5]  |   156 |    2.4 |     71 |  1.211 |  0.838 | 9.8305


>=20
> Also wondering whether you considered the simpler approach of just
> augmenting the kernel to recognize and support use of wildcards at the
> beginning and/or end of the existing name field to signify a prefix or
> suffix match. That seems more amenable to extensions beyond just
> prefix or suffix match.

I had not considered this approach in the beginning, but as I thought
about it, it did not seem as simple.

For example, along with adding the wildcard character, we also need to
add the ability to escape it; otherwise, it would be a weird edge case
of an unsupported filename. Also, possibly to escape the escape
character itself. This adds more complexity to the solution.

In addition to this, extending such solution to support wildcards
anywhere in the filename would also require reimplementing the filename
transitions structures or moving rules with wildcards away from current
filename transitions. Currently, the filename is part of the hashtab key
and prefix/suffix could work by checking all prefixes and suffixes of a
filename, which there are not that many. However, with a wildcard at any
position, this is not feasible.


Best regards

Juraj Marcin
