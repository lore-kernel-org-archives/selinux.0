Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E0C10F1B
	for <selinux@archiver.kernel.org>; Tue, 13 Dec 2022 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiLMTZo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiLMTZn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Dec 2022 14:25:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC36324F0D
        for <selinux@vger.kernel.org>; Tue, 13 Dec 2022 11:25:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q71so510710pgq.8
        for <selinux@vger.kernel.org>; Tue, 13 Dec 2022 11:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9kbOYAAjnKyXvg23pjUMzGuz9DSgOAIhX9TM1FNy+0Q=;
        b=YQ8ZSNFzPrq2HNtcykvnHhbINRe8kgBNKOS/PDvQ0iunDkAHLiPBwJ6kju5zXBtI9q
         0zeXx6hqc6oO0/pLFG/8TRpUHW/c2kLm7aIVq2JGPzUmim6kLRmMnezJ2G7i+M1dIOFM
         EcrT222rB5pje2tUP9DxsQuohumAy5kfzjRt2w23C+ZPASM6arGfIYdP/xP4YeEKxRkW
         gGV74nhJJDmG5vV8WC7ICjn72Bl+l+KbujJsmQAy49Aq6a5rL2F8MNQJ3+F8+Ke/EkWL
         EaD7boOE6no4Xbf0RLHkdBjd3kFJuRt4UOLQ481H+ltMmqf52GHyE4Kuy+zhN1elABPY
         omqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kbOYAAjnKyXvg23pjUMzGuz9DSgOAIhX9TM1FNy+0Q=;
        b=W7NK52d9tqE5igfoqCif5TJQrk7zmYRZTs+ZQcZsWqw/GtbtpPflJsTVxup+kCnmlW
         Z9Xar2HaF4E1kOhqnSfBmU7ZYIQ1SFE3xUq/ZVkx5aRatAMmSBdGKytapSJeboNNIc3W
         sZ2eQEiBgKwwZLzTaPYM5Gxp+OFnEc8yzedcwwRtnU+1o8bYIRa83+lkwh7vrc+pTfCF
         KGnQ/XbYBNJsnpeLBp+FfQDlW1hkDN7/wGNwu3wZYZRmMaKkzmF/c1GhtztRI12c6GdU
         zjvPuyY1APgd6CkBlExhCu22YTNMFZwzP8/jyV3jj8tosFzUEtnqtLrXCJIHapPPHpvK
         wIFg==
X-Gm-Message-State: ANoB5pnrZJGE2cRyhd+HXgAUlpjdFKHUZwFLN69VfsGtd7p3l/g8dVUk
        5kTmcpQydJpBtYxOagwJXolDG4jTXZ8IEvtgFv20
X-Google-Smtp-Source: AA0mqf57kSqmNwGBjDyzVN0hyalSVuFVRwFQQjhF9S/cz0ORzHKxAexfG5G7j/186DQnoY80k93z3j9qhUTRlV3Jv/I=
X-Received: by 2002:a63:4424:0:b0:477:96e2:9065 with SMTP id
 r36-20020a634424000000b0047796e29065mr70173881pga.533.1670959542176; Tue, 13
 Dec 2022 11:25:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSmJHDRroUJifUuDNF+KvVPVtW17CuMzb_RrUKBBkTabA@mail.gmail.com>
 <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
In-Reply-To: <CAHk-=whH53GKhcT0+cKGwCVOHXD0_Gh82w2SVojjgoN7XZ-71g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Dec 2022 14:25:31 -0500
Message-ID: <CAHC9VhThEUiyVL2E5sAiQhiKhqV8nJbRE7TGOAq0QOJ2qzGjPw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 13, 2022 at 12:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Dec 12, 2022 at 7:05 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> >   Unfortunately, this pull request does
> > conflict with fixes that were merged during the v6.1-rcX cycle so you
> > will either need to do some manual fixup or you can pull the tag below
> > which has the necessary fixes and has been sanity tested today.
>
> I did the merge manually, but compared to your version. They were
> identical except that you hadn't added the documentation entry for the
> gfp_flags parameter.

Ah, thanks for catching that.

> That said, I'm not super-happy with that merge ... It feels to me like
> that thing shouldn't be an allocation at all, but that selinux should
> use ref-counted strings instead (and just increase the refcount).

It is something worth looking into for the future.  I'm in the middle
of reworking the audit code, and one of the changes is heavy use of
string refcounts to reduce the copies needed.

-- 
paul-moore.com
