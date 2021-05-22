Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC85C04FF3
	for <selinux@archiver.kernel.org>; Sat, 22 May 2021 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A750608FE
	for <selinux@archiver.kernel.org>; Sat, 22 May 2021 02:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhEVCIT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 May 2021 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhEVCIT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 May 2021 22:08:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD6C061574
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 19:06:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i7so15227935ejc.5
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 19:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enh1CO1fRJ/3s4nFuYfV9slAcR71xCie3kXiqBTbpWg=;
        b=DCGJ5Nilo9/AGG1ArRxCjRgl6Ds9yTKWnR6U59uXzOZmtwiUQ5494CMZyReO55uwFC
         bWQGlDqLRp/uFHm5zG6la0tMj+mGyzU7/vMvuDBbNIXjksEXwzlAE5G1hmTvER3/Jo1R
         YevoCUqNHBiF6AzfOPz9cWHKzkxXERNFSCqZX0G2NyH1AsaUTr7VCU16+FNGRhBapnhO
         z+Vlj89N0pKTqThOiXfuC8DqDIO7oFc89t651Zng0mhBQGHlIVNyJva1qSub9eoR34fF
         Qv0FYzdvvK38zcP1XpSvJfH+a4AowNlrh2wC6JfqExuFDqBBSuwRE2Hl+MMhteqYRHq9
         VYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enh1CO1fRJ/3s4nFuYfV9slAcR71xCie3kXiqBTbpWg=;
        b=Zh/j/kMrYKPB3MX5PluaLTbGfop5qAtlI3zXnX7IZ5u0LBPjcj/CZM8j3r0d4I+pHL
         8OBwtqwhtcRooEtqyVy0cfBSf9mvAG1IYEUHnlGWoSvTzX+EjNsrc0G+0gQkZLD9pq6n
         BBErp/PyRueuh2Bx9uCA+oW0aD/Cff3L/sIlak1BcgsNafGuyo55WiAMZCMfIS4R+3XN
         qmxseJ9coLXSwMh+xUWzUPW1kGX560wFHIe7kU/SBklGzn9HGBXrmYQb0oJeXkYK8hWu
         6Iw1deWDHzGlEfpJZRrb7spA2nN5gb73jXBl7aPa8+N0MRYY8dZtLH75f/luPw4DeoYc
         iW5g==
X-Gm-Message-State: AOAM5322MLVSEDCDt/MTDaKiVTGfJ8iwccBuQXPgqR2QZfTNgsUWe2mB
        DjorKPHUUf9lASg9MaJiRGhVFgdazYwZu36t93F33EcTxA==
X-Google-Smtp-Source: ABdhPJwAdi1Bw98L2/qGMo17Mi+Nh8QFY/8nuxWxu+5qFeaSxXKZgxnhJ2PPUK/Xid00W60zEIsVCCAHK9qd/G6j0x4=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr13285225ejc.178.1621649212774;
 Fri, 21 May 2021 19:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl> <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
In-Reply-To: <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 22:06:41 -0400
Message-ID: <CAHC9VhRG9jD3JPbf==Bo0B+cyMG8mrQnM=RyoxenqxqePdRdsw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 21, 2021 at 8:53 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/05/22 6:49, Paul Moore wrote:
> > I've provided the SELinux
> > implementation, Casey has been nice enough to provide a Smack patch,
> > and John is working on an AppArmor patch as I write this.  I've
> > mentioned this work to the other LSM maintainers that I believe might
> > be affected but I have not heard back from anyone else at this point.
>
> I don't think any change is required for TOMOYO, for TOMOYO does not
> use "struct cred"->security where [RFC PATCH 8/9] and [RFC PATCH 9/9]
> are addressing, and TOMOYO does not call kernel/audit*.c functions.

Good to know, thank you for checking.

-- 
paul moore
www.paul-moore.com
