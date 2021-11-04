Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3A7C4332F
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86A361241
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 20:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhKDUKe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhKDUKd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Nov 2021 16:10:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326DC061203
        for <selinux@vger.kernel.org>; Thu,  4 Nov 2021 13:07:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r12so25455159edt.6
        for <selinux@vger.kernel.org>; Thu, 04 Nov 2021 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32eKwvwSC2TbEbjQwE3qOFh+LqTWwRQrTGzfIUBib6Y=;
        b=1UoI/Ei5Rx/7y/lZRgwjoMm4Lx4ivAQFlpHplwwOVbUQC7kkQ1Fnboaz8MdFWUakD3
         ZOg8TfYQ2FCjqpc7prpHW/7+kktg/b/dQP8wIXfbR2ctxOOYvD52Fu5IxfENXUQpwkiO
         hItQ6XWbFo1AM+iV94CXzIHS+iyk/mnLTcBihDKc+qTKgKVAiARSuIQYsZqEov+yJ9UA
         50U8XrYqkG/hhYjYvFn1LUMH2A3YwjLcLqEH8oBaRa6HDOGMlx2R7acFlSeLwNq30mV/
         9XBGkJfeNfmhIvJ4IYxY43E/yhknHt+zzwdmZJ0j9gIlLEBXk86gzZu+NE0F3E6vwoXf
         gkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32eKwvwSC2TbEbjQwE3qOFh+LqTWwRQrTGzfIUBib6Y=;
        b=b6Fts/QxXYccS90KQcZSLqWCWXifhjcqHpevNMIMqZpbfI+p2fUhEuhQfLY76yedkD
         /XZwFSNy3d2WJwwfgKLv4vq0q35yov0u0Ihq0TCc30RPL+Wv/ub3E2khnihVfKVU2C6G
         JMzdfzdjh/nzFGTh7e3ojHnB1NRilvN/vz8m2wkOVkmPWhDrUxYvxD1vmNhWbCdqBHPT
         LekonYAbqUUnk2YpUigJu4MoEFLjtD5hVNj3CqzVm/RoqSFyJ2AgG+54g6q2BsQk+NDc
         heLI8KAMR2M7H66cEWhrUNSlKFrYJV8oucGeR1yiaFTAG3osJm2pOJon+Qo8zOWp/fen
         PzAg==
X-Gm-Message-State: AOAM531bJr7aEVnXXWL+gj+TS/kK2CTW2edmmC4pjA1KRmXfR6QUMw5L
        F59k5gk83lsNIFXYyu44DTkb4YmUbVGh6MomTjOu
X-Google-Smtp-Source: ABdhPJwJy/Jf/YG7EhdohcU/l4B741Q+VsTW+pPOnxuyZ+OCM2Bzqqj0V54aEq0vBBRY8vsUP5GmmCZ7bogWs6h5SbY=
X-Received: by 2002:a17:906:7632:: with SMTP id c18mr2624351ejn.104.1636056473625;
 Thu, 04 Nov 2021 13:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRQ3wGRTL1UXEnnhATGA_zKASVJJ6y4cbWYoA19CZyLbA@mail.gmail.com>
 <CADvbK_fVENGZhyUXKqpQ7mpva5PYJk2_o=jWKbY1jR_1c-4S-Q@mail.gmail.com>
 <CAHC9VhSjPVotYVb8-ABescHmnNnDL=9B3M0J=txiDOuyJNoYuw@mail.gmail.com>
 <20211104.110213.948977313836077922.davem@davemloft.net> <CAHC9VhQUdU6iXrnMTGsHd4qg7DnHDVoiWE9rfOQPjNoasLBbUA@mail.gmail.com>
 <CADvbK_f7XyL8uvHdSgdvbphfw6QzTPFMvwZdW0P4R7qFJPc=yQ@mail.gmail.com>
In-Reply-To: <CADvbK_f7XyL8uvHdSgdvbphfw6QzTPFMvwZdW0P4R7qFJPc=yQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Nov 2021 16:07:42 -0400
Message-ID: <CAHC9VhQFBL4JA4KwtKJyaB=NEa4mL89uVzj32WCyhZqFhWqvJg@mail.gmail.com>
Subject: Re: [PATCHv2 net 4/4] security: implement sctp_assoc_established hook
 in selinux
To:     Xin Long <lucien.xin@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        jmorris <jmorris@namei.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 4, 2021 at 3:49 PM Xin Long <lucien.xin@gmail.com> wrote:
> On Thu, Nov 4, 2021 at 3:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Nov 4, 2021 at 7:02 AM David Miller <davem@davemloft.net> wrote:
> > > From: Paul Moore <paul@paul-moore.com>
> > > Date: Wed, 3 Nov 2021 23:17:00 -0400
> > > >
> > > > While I understand you did not intend to mislead DaveM and the netdev
> > > > folks with the v2 patchset, your failure to properly manage the
> > > > patchset's metadata *did* mislead them and as a result a patchset with
> > > > serious concerns from the SELinux side was merged.  You need to revert
> > > > this patchset while we continue to discuss, develop, and verify a
> > > > proper fix that we can all agree on.  If you decide not to revert this
> > > > patchset I will work with DaveM to do it for you, and that is not
> > > > something any of us wants.
> > >
> > > I would prefer a follow-up rathewr than a revert at this point.
> > >
> > > Please work with Xin to come up with a fix that works for both of you.
> >
> > We are working with Xin (see this thread), but you'll notice there is
> > still not a clear consensus on the best path forward.  The only thing
> > I am clear on at this point is that the current code in linux-next is
> > *not* something we want from a SELinux perspective.  I don't like
> > leaving known bad code like this in linux-next for more than a day or
> > two so please revert it, now.  If your policy is to merge substantive
> > non-network subsystem changes into the network tree without the proper
> > ACKs from the other subsystem maintainers, it would seem reasonable to
> > also be willing to revert those patches when the affected subsystems
> > request it.
> >
> > I understand that if a patchset is being ignored you might feel the
> > need to act without an explicit ACK, but this particular patchset
> > wasn't even a day old before you merged into the netdev tree.  Not to
> > mention that the patchset was posted during the second day of the
> > merge window, a time when many maintainers are busy testing code,
> > sending pull requests to Linus, and generally managing merge window
> > fallout.
>
> Hi Paul,
>
> It's applied on net tree, I think mostly because I posted this on net.git tree.
> Also, it's well related to the network part and affects SCTP protocol
> quite a lot.

Yes, I know it is in the net tree, that is how it made its way into
linux-next.  I wouldn't have merged it yet, and if not me who else
would have merged it beside the netdev folks?

Am I misunderstanding your comment?

> I wanted to post it on selinux tree: pcmoore/selinux.git, but I noticed the
> commit on top is written in 2019:
>
> commit 6e6934bae891681bc23b2536fff20e0898683f2c (HEAD -> main,
> origin/main, origin/HEAD)
> Author: Paul Moore <paul@paul-moore.com>
> Date:   Tue Sep 17 15:02:56 2019 -0400
>
>     selinux: add a SELinux specific README.md
>
>     DO NOT SUBMIT UPSTREAM
>
> Then I thought this tree was no longer active, sorry about that.

Like many kernel trees the default/main branch for the SELinux tree
doesn't contain anything useful, for the SELinux tree (and audit for
that matter) it is basically just the most recent major/minor tag from
Linus tree with a single tree specific README.md file patch so that
the GitHub mirror has a pretty landing page and a canonical reference
for how the tree is maintained.

* https://github.com/SELinuxProject/selinux-kernel

The general approach to the SELinux tree, as documented in the
README.md, is to do all of the linux-next work in the selinux/next
branch with the stable work happening in the selinux/stable-X.Y
branches.

FWIW, once we've resolved things I would be happy to have the patchset
live in the SELinux tree as opposed to the netdev tree.

-- 
paul moore
www.paul-moore.com
