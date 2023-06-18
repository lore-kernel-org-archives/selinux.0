Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E554EB64D7
	for <selinux@archiver.kernel.org>; Sun, 18 Jun 2023 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFRJlE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Jun 2023 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFRJlE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Jun 2023 05:41:04 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEF10D7
        for <selinux@vger.kernel.org>; Sun, 18 Jun 2023 02:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687081251; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=GX2x6RuYC0R6dsf3zzNf85k0HEwbXo4p2NgvUNSWxN2PJgQBzHzbAQhtxwd8tyo/q1hl/W2fEXtP109G/IPiWBNqvXvc4XzMaMQnilM5nGroJ8vl3uVBiqwblFPnR66OJkdKomqg1kmURw9Y1rspIvXsQYmDBAMPn8KvE5ft37c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687081251; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jfS9Bc1G0tITtWOEbfBobupqgm9YHKCgx9tMChHhI/Y=; 
        b=GMwac+vjc2flRflvK8uwGIcs0DKgfBDu9K6XX4zTrS8ztkYWXrMY1xazSfrB34e7LM0Fqz+dcD1vRhEybDQheaEUZRluLlAEEEHA+PaBLn40UkNqAKf2/3vABf8JcI9vLqdl4DeJQlOo2eB6TX/Ee/JltcZCkS+3uyK9ae34wlY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687081251;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jfS9Bc1G0tITtWOEbfBobupqgm9YHKCgx9tMChHhI/Y=;
        b=DPxVciXNmOS32j/fIehOdC5hXBqFOW8N5PxFuG8C7hXUZsRXY4lNct64GwyfsgIh
        YpSvuWxuatLJaX6i+vE+9LtXWRfEMa9DGr94vk34kEMlYZHaIjHOI3t+O2F3fw097B8
        nt9zjUO2SqB2XtCrVl9TsW3fQbD7CvHeJ8we8pnw=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687081250212894.14792551246; Sun, 18 Jun 2023 11:40:50 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [147.229.180.122])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id DB3C62081F76;
        Sun, 18 Jun 2023 09:40:48 +0000 (UTC)
Date:   Sun, 18 Jun 2023 11:40:47 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
 <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-06-15 22:04, Paul Moore wrote:
> On Thu, Jun 1, 2023 at 1:03=E2=80=AFPM Juraj Marcin <juraj@jurajmarcin.=
com> wrote:
> > On 2023-05-31 18:24, Paul Moore wrote:
> > > On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajma=
rcin.com> wrote:
> > > >
> > > > Currently, filename transitions are stored separately from other =
type
> > > > enforcement rules and only support exact name matching. However, =
in
> > > > practice, the names contain variable parts. This leads to many
> > > > duplicated rules in the policy that differ only in the part of th=
e name,
> > > > or it is even impossible to cover all possible combinations.
> > > >
> > > > First, this series of patches moves the filename transitions to b=
e part
> > > > of the avtab structures. This not only makes the implementation o=
f
> > > > prefix/suffix matching and future enhancements easier, but also r=
educes
> > > > the technical debt regarding the filename transitions. Next, the =
last
> > > > patch implements the support for prefix/suffix name matching itse=
lf by
> > > > extending the structures added in previous patches in this series=
.
> > > >
> > > > Even though, moving everything to avtab increases the memory usag=
e and
> > > > the size of the binary policy itself and thus the loading time, t=
he
> > > > ability to match the prefix or suffix of the name will reduce the
> > > > overall number of rules in the policy which should mitigate this =
issue.
> > > >
> > > > This implementation has been successfully tested using the existi=
ng and
> > > > also new tests in the SELinux Testsuite.
> > > >
> > > > Juraj Marcin (5):
> > > >   selinux: move transition to separate structure in avtab_datum
> > > >   selinux: move filename transitions to avtab
> > > >   selinux: implement new binary format for filename transitions i=
n avtab
> > > >   selinux: filename transitions move tests
> > > >   selinux: add prefix/suffix matching support to filename type
> > > >     transitions
> > >
> > > Just a quick comment as I haven't had a chance to properly review t=
his
> > > series yet; you show some memory usage and performance measurements=
 in
> > > some of the intermediate patches, that's good, but I don't see the
> > > same measurements taken when the full patchset is applied.  Please
> > > provide the same memory usage and performance comparisons with the
> > > full patchset applied.
> >
> > Of course, here are the measurements with the whole patchset applied.
> >
> > I also included measurements with new policy (based on the Fedora
> > policy) that uses prefix filename transitions where possible. This ne=
w
> > policy has been generated by merging existing filename transitions in=
to
> > prefix ones if it would reduce the number of transitions overall whil=
e
> > keeping the resulting type same.
> >
> > [1] Reference kernel (c52df19e3759), Fedora policy (format v33)
> > [2] This patchset, Fedora policy (format v33)
> > [3] This patchset, Fedora policy without prefix/suffix rules (format =
v35)
> > [4] This patchset, Fedora policy with prefix rules (format v35)
> >
> >
> >  Test | Mem   | Binary | Policy | Create tty      | osbench
> >       | Usage | policy | load   |                 | create
> >       |       | size   | time   | (ms/file)       | files
> >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > ------+-------+--------+--------+--------+--------+-----------
> >  [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
> >  [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
> >  [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
> >  [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609
>=20
> Thanks for performing those measurements.
>=20
> I apologize that I haven't had an opportunity to review your patcheset
> in detail just yet (I've been struggling with some self-inflicted
> networking issues this week), but looking strictly at the numbers
> above it appears that by every metric in the table this patchset
> results in a policy that is larger (both on-disk and in-memory) as
> well as performance that is at best the same (although in most cases,
> it is worse).  Are there any improvements expected beyond test
> configuration [4] (above)?

The main goal of this patchset is to bring the possibility to use prefix
or suffix matching in filename transitions, as now it is not possible to
cover files that have fixed prefix and variable part after it. For
example devices in /dev (the policy now enumerates all possible number
suffixes) or files with random suffix/prefix (not possible at all).

The next goal is to make future improvements easier, for example
supporting filename transitions in conditional policies or inherent
support for type attributes.

As for performance, the goal is to implement previous goals while not
killing the performance by them. Christian suggested some possible
optimizations [1], but after trying them out [2] they either not provide
much measurable difference or the difference is small and the
implementation hacky.

[1]: https://lore.kernel.org/selinux/CAJ2a_DfHubNBa46kcGCsTfY2OmOCJkNMstF=
ebERU3mXeEMajng@mail.gmail.com/
[2]: https://lore.kernel.org/selinux/20230608155951.osvhubn3zyqzx4ep@jmar=
cin-t14s-01/


--=20
Juraj Marcin


>=20
> --=20
> paul-moore.com
