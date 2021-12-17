Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1659FC433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 20:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbhLQU3G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbhLQU3E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 15:29:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E6C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 12:29:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so12202322eda.12
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaFNELIHWLkYtxS9FFKaGccYxYikTbeuDKRkMvnLyI8=;
        b=QrR95jjjA5DtmjUr6mFxmIKgd/mtTLy/CxzdjUM08QWAD2GpaBBjiPP/+aK8nw4vLp
         R9K2jq6+gZXkk+m+/FkrT1sl4t+C7VQ1JiYlWxLtxwAZ+ZQm20oFc+linFWeEI6n4O1T
         oS2ZXHcs7KFJNvk5V0KAQtcQGVF+8ts+0xYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaFNELIHWLkYtxS9FFKaGccYxYikTbeuDKRkMvnLyI8=;
        b=IDZ8mSmMqobVAej7bPBSE4W+Qo8MLqNwloLz2b9Y2IuanTY+5Or54WyZsHK7M7RcXt
         ORjqo4qjZ/CPeo1QqUaQbzQYrc35vGRvzuiJvzGEoraXsFIGpcpc0Nd0uLjoxOTW4QJb
         qo8nqeNQBTa3+tu5PdI4o20k3ou6Xad3IFX0rwdVA+f2p1hAd5eUa8Om4O8WuaGRygfZ
         xVFpRRaQ8S+C5PC7PU7B28UfUp3iS75DaCQaXvAwnqApBrFTL4JQK0kX1jSjXzMNdnug
         MAFnbUohJlxirkHKFpDWJ7Dxxr62PYb8H3pTdCfIGyfBeEzkST5i2kPiC7a7J81AWsi5
         Ce5A==
X-Gm-Message-State: AOAM530aCnDcfNdjSTdIqSOHnJ2VP9pIGUDAd7VFdCMPjX4PrMyfCipv
        Gn73qIu7ZlV9anShUTNf5HiWn9v/9CmJOpn2
X-Google-Smtp-Source: ABdhPJznFWnwARVP5wCvCfVXYy6EqLIprlL6wRG9NE3IL15BEaGOJC/RspP9XgOePYQUzzzMUkq93A==
X-Received: by 2002:a17:907:1c07:: with SMTP id nc7mr3789133ejc.546.1639772942622;
        Fri, 17 Dec 2021 12:29:02 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 3sm3120209ejr.20.2021.12.17.12.29.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:29:02 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2240128wms.3
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 12:29:02 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr11004673wmq.8.1639772941784;
 Fri, 17 Dec 2021 12:29:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
In-Reply-To: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:28:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
Message-ID: <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 17, 2021 at 12:02 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Another small SELinux fix for v5.16 to ensure that we don't block on
> memory allocations while holding a spinlock.  This passes all our
> tests without problem, please merge this for the next v5.16-rcX
> release.

Ugh, pulled.

GFP_NOWAIT can very easily fail, so I'm not convinced your tests would
catch any of the interesting cases.

There is only one single caller of the new
security_sb_mnt_opts_compat() callback, and I get the feeling that
maybe we could parse the options first - into a temporary new
superblock, and then at "test" time (when we're under that sb_lock) it
could compare that temporary sb with pre-existing ones?

That would also avoid the need for doing that mount option parsing
over and over and over again for each sb on the 'fs_supers' lists.

I've pulled this, bit it does smell bad to me, and I think that
original commit 69c4a42d72eb ("lsm,selinux: add new hook to compare
new mount to an existing mount") and ec1ade6a0448 ("nfs: account for
selinux security context when deciding to share superblock") may not
have been fully thought out.

It may have *looked* like just adding that check  to
'nfs_compare_super' was a simple and good idea, but it really doesn't
look great.

Adding a few more people to the cc.

                 Linus
