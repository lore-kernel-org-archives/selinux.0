Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49DC433E1
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 00:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DFE207D0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591144313;
	bh=ZFZ50+cfovPyZG+Z87lR5GTVuve0aKAAjV3/T3oj86k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LOWALHY0uuXGz/t7jwEFgxMfqh0CQyNFzH6tlz1TWmKC/PkIWVNaMBWmRgwlCVRkl
	 6lpNH59FPTnNUod7CxFrLhwQuTL+kIxY2uqwcChOrbc/KojhtnROXPCzxP0K9Cr5xJ
	 GPnEbqjsdWBaBkzh5r7q+wrKpvUprlW5b3W/TlQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFCAbw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAbw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 20:31:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F61C08C5C2
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 17:31:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so534211ljj.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y05Eb9eafJ0NXvQYL09qhaAipJ12OeTgF1kVh6EgfnQ=;
        b=BIdCjuRkcZ6AtUKiMEcL/bPMx/D1bItwVGJFF1ZfEiSaScUoFvZ1ZZsl3PQqkbQ7I+
         1pgdNd5VxSPlPrPUxZOkdE8JL51bKGr0g+MkbxHFdq1zz9DHgwUHcu6VSzZYXPad+csj
         3uML97UaIPUm1p1BiOICKjeYpqfWTK6nFQlZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y05Eb9eafJ0NXvQYL09qhaAipJ12OeTgF1kVh6EgfnQ=;
        b=JB6jlI+f9dZwTAUIxQ1B+uQKpzM4+VYS64/RBJv40r5Idu+SUKcM4CI2hkrkOA9DyE
         aM1yvzJNL6MoOMJlusIyFA7vlBNP3K78qEUggUL7wFZ+UhGUfe++16sr4qErkQbECSjN
         wN0ABFy2v32yUbsSYqbmaz1+tVlbLyRMu3hETbC219R5HzKFsu8QG0BOs90NlqwGbVSU
         m/EUf+VSxc4wcWL1CIS3l4MTczpu24PSF9WdILkvitpHFTVW3VylEFHOF1qfV6l4TTQt
         itNq8odOqPm0OJ+MtYsN8FJ0k81psokUab68kS+AN5au+DvpgK0pD51KQPqxO1vnIAjx
         fB3w==
X-Gm-Message-State: AOAM533LIafkO81krXYeMUm8pXTAA12Cy7ptromxX6MfbBYffxMWtzjD
        6TU1LufslP6I0yzzIcUnmQMMHKrrCg8=
X-Google-Smtp-Source: ABdhPJyyl3PmIMfBAw0rLsXf08M66eNoqe8byDIKjRmd5SLvGOGHApyHFKYf3IO0IiLQ5cTDd6Dj5g==
X-Received: by 2002:a05:651c:384:: with SMTP id e4mr741455ljp.410.1591144310080;
        Tue, 02 Jun 2020 17:31:50 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m13sm95863ljj.20.2020.06.02.17.31.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:31:49 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n24so477979lji.10
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 17:31:48 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr702860ljo.371.1591144308329;
 Tue, 02 Jun 2020 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
In-Reply-To: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
Message-ID: <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 1, 2020 at 6:07 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - A number of improvements to various SELinux internal data structures
> to help improve performance.  We move the role transitions into a hash
> table.  In the content structure we shift from hashing the content
> string (aka SELinux label) to the structure itself, when it is valid.
> This last change not only offers a speedup, but it helps us simplify
> the code some as well.

Side note since you mention performance work: in the past when I've
looked at SELinux performance (generally as part of pathname lookup
etc VFS loads), the biggest cost by far was that all the SELinux data
structures take a ton of cache misses.

Yes, some of the hashing shows up in the profiles, but _most_ of it
was loading the data from inode->i_security etc.

And the reason seemed to be that every single inode ends up having a
separately allocated "struct inode_security_struct" (aka "isec"). Even
if the contents are often all exactly the same for a large set of
inodes that thus _could_ conceptually share the data.

Now, it used to be - before being able to stack security layers -
SElinux would control that pointer, and it could have done some kind
of sharing scheme with copy-on-write behavior (the way we do 'struct
cred' for processes), and it would have caused a much smaller cache
footprint (and thus likely much fewer cache misses).

These days, that sharing of the i_security pointer across different
security layers makes that sound really really painful.

But I do wonder if anybody in selinux land (or general security
subsystem land) has been thinking of maybe at least having a "this
inode has no special labeling" marker that could possibly avoid having
all those extra allocations.

Because it really does end up being visible in profiles how costly it
is to look up any data behind inode->i_security.

               Linus
