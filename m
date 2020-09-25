Return-Path: <SRS0=TLac=DC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A24BC4363D
	for <selinux@archiver.kernel.org>; Fri, 25 Sep 2020 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE428238E2
	for <selinux@archiver.kernel.org>; Fri, 25 Sep 2020 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601055513;
	bh=oFKfPqS5AncvvXwmc59TUjbWRS8VSeR7r9VSgAaAnAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u7zG7cvacO0iZ9QlJ8TIu4NDdRoEZ7wsr3vB0wDJWHzaqXZmqtTLj3s8s7rILSKJ8
	 xdL+oyMP/6pOJi7dx6qE+UVL+Hb6179Bb8dUeP+SB3lXCMgn6VWCotv2b3KS9qY/MR
	 qLhJLT6AqTIuGJ3ER2AKNrGnTqoq+aEwnyWYKklk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYRid (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRid (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Sep 2020 13:38:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9168C0613D3
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2020 10:38:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so3663087lfi.12
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2020 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xV1ixFKYBYzs9xQqtXfpj87vpxE9fe3bTqmPmwrmWRA=;
        b=fx6QQkhaEaLL0IKUt52H3mzpFGb3zgZouYy5OWhuqmRYp9EJXuJxfucb1VNywFmJBp
         z+VoiRTM4dfJhadiLfJOAFLLSWYu9fOPhVDXnKtf+Uut9p4/+eQ39wnmESomu2cg7F9e
         jWPjxuon8GFrLiwrLCrEukW0y5tUfyxnjOFNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xV1ixFKYBYzs9xQqtXfpj87vpxE9fe3bTqmPmwrmWRA=;
        b=pvOONfBduBYKNqXzI2Y1C1EeyYQILWbu+3z3p++3vzJ0Qcl0PbDrwuSQKgQIBGI2Ze
         RaKSf54qsoqzKEqwJfHOYy3ztN/H21VKd/suYR1yHJfnY5FiWP2vzg23Sn8kJYin/AY6
         P48mV9Ydfz6Yfp8k8sloidXo4uwpf9ESP63BJ6vTjX5jJgQeg2FLpGHVy3sbc96aAIBX
         3UASEGud6C05G7em5xR05nUULxaXkJaabmkH4z7oL335TgAhjbB620YYpO4iEIR79jWj
         FK8tmAJzGMcARKbbpf4mOz18M7yCZZg4F/DOu2Xm5Bwd47BK1S6+6FvPnE22umATsexW
         6mPg==
X-Gm-Message-State: AOAM532wGv/6a9n2HaAHB6qVYsAB+3g9a+IofjenIhLW/M1BbkIUq7LU
        NH3Q0dYhHy8gj9NDbhXuy97im9imx6Ukuw==
X-Google-Smtp-Source: ABdhPJya8l64WZfCndTitm9bAsNXFv6VeJvMumJHTRkaKdVegG92Cr72/a9a7VP+f+onliA3AdGUtg==
X-Received: by 2002:ac2:5101:: with SMTP id q1mr1602802lfb.427.1601055510584;
        Fri, 25 Sep 2020 10:38:30 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q11sm2793979lfc.309.2020.09.25.10.38.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:38:29 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y4so3122156ljk.8
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2020 10:38:29 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr1638882ljj.102.1601055508689;
 Fri, 25 Sep 2020 10:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
 <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com> <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
In-Reply-To: <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 10:38:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
Message-ID: <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 25, 2020 at 6:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Sep 24, 2020 at 4:16 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Up-thread I thought Linus indicated he didn't really want a flag to
> > disable pemission checking due to potential abuse (and I agree).
>
> IIUC he was against adding an FMODE flag, while I was rather
> suggesting a new function parameter (I realize it probably wasn't
> clear from what I wrote).

I really would prefer neither.

Any kind of dynamic behavior that depends on a flag is generally worse
than something that can be statically seen.

Now, if the flag is _purely_ a constant argument in every single user,
and there's no complex flow through multiple different layers, an
argument flag is certainly fairly close to just having two different
functions for two different behaviors.

But I don't really see much of an advantage to adding a new argument
to kernel_write() for this - because absolutely *nobody* should ever
use it apart from this very special autofs case.

So I'd rather just re-export the old __kernel_write() (or whatever it
was that broke autofs) that didn't do that particular check. We
already use it for splice and core dumping.

autofs isn't that different from those two, and I think the only real
difference is that autofs is a module. No?

So I think the fix is as simple as exporting __kernel_write() again -
and let's just make it a GPL-only export since we really don't want
anybody to use it - and revert  commit 13c164b1a186 ("autofs: switch
to kernel_write").

Hmm?

             Linus
