Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC4EB64DD
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHAItR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Aug 2023 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAItQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Aug 2023 04:49:16 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE78C10FA
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 01:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690879746; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=jvXBofyT6BSpnvUDMs6svC3np7T+MgLZhONJzO88OsaaN/deiH7J4kV6IhM+MVdUTaVYkf1/d/zA9rleFnD2NM2A/+6InZD6gW9BqxeQj8O+1DZLa0oDIsn+eHzc8X3MNSX3PBBXV6EDPHPTuDd9K2JzzeoaH7/1dMO3DP+CPK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1690879746; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Bnk6eFhpQMFKwOmdPbdCadjtAj10MMSQwgr1nS63zIw=; 
        b=IDg6aWZkvQafOsXx/tgSYb3rLAGtDVXLc3pfguXlqRXXsKWjIcVz6O4aXVtbcZmgZFDKzxEHMgUxkbgrsYBAjKV7Ah+0fnmdCKIZA5EMbjPigK4tlRFKD5DX4PFTsynBHu3PlrT6jRqTqMHRaQu0wliGvWmUTXgyJjDlkCuTGQw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690879746;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Bnk6eFhpQMFKwOmdPbdCadjtAj10MMSQwgr1nS63zIw=;
        b=U4QFEYFQbghRfaRDgQM77Q9LYwPdgt0FGEGhhC4E+DEe5TuG42y2SPXd58z3Fpxj
        Gwv4nRwGqfMteVebvlFR7Z+TX4JB9JztnD3pWjR3rEMwROBCj4kCPOdiKu6NSNJSbMa
        GbQ1HEc53rhk0y+yukYSR4tZmVM37GnXQg645Rsk=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1690879744125850.0329668493632; Tue, 1 Aug 2023 10:49:04 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [213.175.37.10])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id E7A022081F64;
        Tue,  1 Aug 2023 08:49:02 +0000 (UTC)
Date:   Tue, 1 Aug 2023 10:49:01 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     James Carter <jwcart2@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20230801084901.sxqzvu7noh2b6tyk@jmarcin-t14s-01>
References: <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
 <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
 <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01>
 <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
 <20230620075100.4wvquojo52dhrixa@jmarcin-t14s-01>
 <CAEjxPJ6RSkOXRuuUCJr2=irN4k7M_isL12Gky--ucqJ-Fmmzcg@mail.gmail.com>
 <20230727164259.cys5mabxa5aeonod@jmarcin-t14s-01>
 <CAEjxPJ7t6jr5gZm_mCZqPko207rh6t-CUc+gQxqLXi2QPJx9WA@mail.gmail.com>
 <CAP+JOzSoMQkUXt7tp5qe7k0arnyeX4d--hJSqE2d4ESvcRERCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP+JOzSoMQkUXt7tp5qe7k0arnyeX4d--hJSqE2d4ESvcRERCQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-07-28 13:52, James Carter wrote:
> On Fri, Jul 28, 2023 at 9:29=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 27, 2023 at 12:43=E2=80=AFPM Juraj Marcin <juraj@jurajmar=
cin.com> wrote:
> > >
> > > On 2023-07-17 14:44, Stephen Smalley wrote:
> > > >
> > > > I'd be curious to see what results you would get if you simply ad=
ded
> > > > the new feature (prefix/suffix matching) without moving the name-=
based
> > > > transitions into the avtab.
> > >
> > > Here are the performance metrics of a prototype solution, where the
> > > filename transition key is extended with match_type and match is fo=
und
> > > by shortening the name from the end or the beginning if a full matc=
h is
> > > not found.
> > >
> > > [2] Reference kernel (447a5688005e), Fedora policy (format v33)
> > > [3] This patchset, Fedora policy (format v33)
> > > [4] This patchset, Fedora policy without prefix/suffix rules (forma=
t v34)
> > > [5] This patchset, Fedora policy with prefix rules (format v34)
> > >
> > >
> > >  Test | Mem   | Binary | Policy | Create tty      | osbench
> > >       | Usage | policy | load   |                 | create
> > >       |       | size   | time   | (ms/file)       | files
> > >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > > ------+-------+--------+--------+--------+--------+-----------
> > >  [2]  |   157 |    3.4 |     76 |  1.256 |  0.871 | 9.4492
> > >  [3]  |   156 |    3.4 |     77 |  1.208 |  0.869 | 9.6160
> > >  [4]  |   157 |    3.4 |     71 |  1.239 |  0.893 | 9.6297
> > >  [5]  |   156 |    2.4 |     71 |  1.211 |  0.838 | 9.8305
> >
> > This looks more promising to me - little-to-no impact on existing
> > users with old policy/userspace, reduced memory usage once fully
> > transitioned. Still some degradation in runtime for osbench but not
> > sure what the variance/stddev is for those numbers.
> >
>=20
> It does look promising.
>=20
> Does this new prototype change the kernel policy format and the userspa=
ce parts.
> If it does, then I will go ahead and revert the previous userspace
> patches and wait for the new ones.

It does as I tried to keep the kernel policy format as close to the
internal representation as possible.

>=20
> > > > Also wondering whether you considered the simpler approach of jus=
t
> > > > augmenting the kernel to recognize and support use of wildcards a=
t the
> > > > beginning and/or end of the existing name field to signify a pref=
ix or
> > > > suffix match. That seems more amenable to extensions beyond just
> > > > prefix or suffix match.
> > >
> > > I had not considered this approach in the beginning, but as I thoug=
ht
> > > about it, it did not seem as simple.
> > >
> > > For example, along with adding the wildcard character, we also need=
 to
> > > add the ability to escape it; otherwise, it would be a weird edge c=
ase
> > > of an unsupported filename. Also, possibly to escape the escape
> > > character itself. This adds more complexity to the solution.
> > >
> > > In addition to this, extending such solution to support wildcards
> > > anywhere in the filename would also require reimplementing the file=
name
> > > transitions structures or moving rules with wildcards away from cur=
rent
> > > filename transitions. Currently, the filename is part of the hashta=
b key
> > > and prefix/suffix could work by checking all prefixes and suffixes =
of a
> > > filename, which there are not that many. However, with a wildcard a=
t any
> > > position, this is not feasible.
> >
> > Fair enough. That said, I do wonder if users will immediately start
> > asking for wildcards at any position, then file globbing or regexes,
> > etc, and would like to allow for future extensibility in a less
> > disruptive manner.
>=20
> If anyone knows of any cases where a prefix or suffix match would not
> work, it would be nice to hear about those cases now.
> Jim

--=20
Juraj Marcin
