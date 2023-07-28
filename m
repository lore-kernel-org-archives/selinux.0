Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D3C001DE
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 17:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjG1Rwi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjG1Rwh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 13:52:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95462D60
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 10:52:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso36927721fa.3
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566754; x=1691171554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUI6IPACJgySeGbmM9TBKlFS/LqULA1ZeDinvwXoXeI=;
        b=fmNK65K0V7XiF9FCjk0Mv4EKbzY/IoJk2PdFnu8rsyJforzwkkcLkjHze4pS6K2Kaq
         V/YWSIqlYqC8bgcGlQXzEpE8lhTNHtntUzcFC07dKTp5Q0dNfte33IKJB1bL4yFXI2hQ
         mnq8NB92DIVoH57DXFYCrzM1L9p58P/oBNxphJxr6aTvF8bV9Wd8jGs9F4Qx2vngQbog
         rRiCnZmF6h97wnBLjJ8mVMKGNiq9AOyTg0Srhc70pPus8ENMyJfP0Qo8XZxveaaOVD2I
         qs9Gzg3ldbhqk1cjkaLAOvdaGxqiOXG+hv5uyzOw1pAKVLR5n+3K0Xc7nHci/tJg7DYj
         5KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566754; x=1691171554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUI6IPACJgySeGbmM9TBKlFS/LqULA1ZeDinvwXoXeI=;
        b=K7r+yMPLKdWS1fK9XS9eSLU48myBHmuGRx2CHN8HKj+ln9+ZiZ+yKM1HmbIMJnC8Od
         uDnPN9qeHf9Ynllai8AihXpLHY7KpN/U9jnld9vemKmZg4qO9J0s68qImiFomS4TIcro
         LVfbqDU+IbDqIr75YEqzzbDxbJsv9TwpfP2kmT2bM4SkVPZzgpT9EYVB0UJSQvvTTTvB
         G1uIIX6J/+OpBe+rh714AGcmSjflXya2cZUPQr2msU5QhNPbbU2qaoegrBdzpJxP8MXK
         m6c1CHnBTVmvAcQvZ76Y7ixHnzrbLoSdJXdZrYgKegX28FKItc2wNXKpQC2xdTlWDlq+
         Oj3w==
X-Gm-Message-State: ABy/qLYr94SvXhpXeYTw1pQU5jLchyYz048ecJE4LrQhzjlkh05H5c+H
        Satcj/LtuzD4JxYz7Yl/hgoZ41QbsAGYUOMmJbQ=
X-Google-Smtp-Source: APBJJlHwpIhIMoklZJlgZY6HmDUu64UDWGVYvfRvdv2Z8+Cgown/tG+tagoPkYpuJNgEy7UJqINvdxYU7VD8sOlt1aA=
X-Received: by 2002:a2e:9e51:0:b0:2b4:65ef:3af5 with SMTP id
 g17-20020a2e9e51000000b002b465ef3af5mr2693188ljk.30.1690566753837; Fri, 28
 Jul 2023 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com>
 <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01> <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
 <20230618094047.oa4o2d2qj5nvvhhs@jmarcin-t14s-01> <CAHC9VhRGgrihrYEB9VxjttUA5uQC7hD4iyBd+Rkf5_WQ=p+-9w@mail.gmail.com>
 <20230620075100.4wvquojo52dhrixa@jmarcin-t14s-01> <CAEjxPJ6RSkOXRuuUCJr2=irN4k7M_isL12Gky--ucqJ-Fmmzcg@mail.gmail.com>
 <20230727164259.cys5mabxa5aeonod@jmarcin-t14s-01> <CAEjxPJ7t6jr5gZm_mCZqPko207rh6t-CUc+gQxqLXi2QPJx9WA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7t6jr5gZm_mCZqPko207rh6t-CUc+gQxqLXi2QPJx9WA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 28 Jul 2023 13:52:22 -0400
Message-ID: <CAP+JOzSoMQkUXt7tp5qe7k0arnyeX4d--hJSqE2d4ESvcRERCQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type transitions
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Juraj Marcin <juraj@jurajmarcin.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 28, 2023 at 9:29=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 27, 2023 at 12:43=E2=80=AFPM Juraj Marcin <juraj@jurajmarcin.=
com> wrote:
> >
> > On 2023-07-17 14:44, Stephen Smalley wrote:
> > >
> > > I'd be curious to see what results you would get if you simply added
> > > the new feature (prefix/suffix matching) without moving the name-base=
d
> > > transitions into the avtab.
> >
> > Here are the performance metrics of a prototype solution, where the
> > filename transition key is extended with match_type and match is found
> > by shortening the name from the end or the beginning if a full match is
> > not found.
> >
> > [2] Reference kernel (447a5688005e), Fedora policy (format v33)
> > [3] This patchset, Fedora policy (format v33)
> > [4] This patchset, Fedora policy without prefix/suffix rules (format v3=
4)
> > [5] This patchset, Fedora policy with prefix rules (format v34)
> >
> >
> >  Test | Mem   | Binary | Policy | Create tty      | osbench
> >       | Usage | policy | load   |                 | create
> >       |       | size   | time   | (ms/file)       | files
> >       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> > ------+-------+--------+--------+--------+--------+-----------
> >  [2]  |   157 |    3.4 |     76 |  1.256 |  0.871 | 9.4492
> >  [3]  |   156 |    3.4 |     77 |  1.208 |  0.869 | 9.6160
> >  [4]  |   157 |    3.4 |     71 |  1.239 |  0.893 | 9.6297
> >  [5]  |   156 |    2.4 |     71 |  1.211 |  0.838 | 9.8305
>
> This looks more promising to me - little-to-no impact on existing
> users with old policy/userspace, reduced memory usage once fully
> transitioned. Still some degradation in runtime for osbench but not
> sure what the variance/stddev is for those numbers.
>

It does look promising.

Does this new prototype change the kernel policy format and the userspace p=
arts.
If it does, then I will go ahead and revert the previous userspace
patches and wait for the new ones.

> > > Also wondering whether you considered the simpler approach of just
> > > augmenting the kernel to recognize and support use of wildcards at th=
e
> > > beginning and/or end of the existing name field to signify a prefix o=
r
> > > suffix match. That seems more amenable to extensions beyond just
> > > prefix or suffix match.
> >
> > I had not considered this approach in the beginning, but as I thought
> > about it, it did not seem as simple.
> >
> > For example, along with adding the wildcard character, we also need to
> > add the ability to escape it; otherwise, it would be a weird edge case
> > of an unsupported filename. Also, possibly to escape the escape
> > character itself. This adds more complexity to the solution.
> >
> > In addition to this, extending such solution to support wildcards
> > anywhere in the filename would also require reimplementing the filename
> > transitions structures or moving rules with wildcards away from current
> > filename transitions. Currently, the filename is part of the hashtab ke=
y
> > and prefix/suffix could work by checking all prefixes and suffixes of a
> > filename, which there are not that many. However, with a wildcard at an=
y
> > position, this is not feasible.
>
> Fair enough. That said, I do wonder if users will immediately start
> asking for wildcards at any position, then file globbing or regexes,
> etc, and would like to allow for future extensibility in a less
> disruptive manner.

If anyone knows of any cases where a prefix or suffix match would not
work, it would be nice to hear about those cases now.
Jim
