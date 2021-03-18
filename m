Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1281FC433E9
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 17:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AA364F1D
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 17:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhCRRpg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhCRRpQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 13:45:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F20AC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 10:45:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so5287372ejc.10
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oFPPIkExFM4y7zlOPv9/3ksVtAXxsKVQUIqy3SsSIk=;
        b=WhffEd4cTgxtK3AxryMlEEWjISnSE+3kmFeU7q4Wmt9UpuYNsI2c/yrosnUr7htNZ/
         daCStTAL8P6omvyAAzHxTfORyn3zGxm0k5xPHJ6pLBQrS6OjZkzaB8lbTbhN9ANjl6e7
         G1Xv1AhaRZL9COtyYCE/WjPCACtyCSdMrZRYL93Wd8PAHH8WICvkWNNvGNhVsTEy1cy3
         oKIG+a58W6Papc0V3/k8o6nkYckGkMWdEVJ1z5ShReWNgYcaFMtRHeg8jRhW45s6Nncj
         BkfTsuqWIlZCSiF3Mr2kBK6+VVgb9Po4HSpH9Zt6Tx11oEZ755RmhLMEAG8TE4DOS56U
         5gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oFPPIkExFM4y7zlOPv9/3ksVtAXxsKVQUIqy3SsSIk=;
        b=uKiZ1RZNomB0cVqmBSyVx5UG7Vf9r6qlb9kOg9EdBUpCdJpUKmwBK1l/AWsRHyCYCV
         i1qTKwe78T2sTubbUd91bxByOxRDxN3YHb0Xv1x3l1uaACv5o04TtW6Y32zv0S5tHcf+
         /aUGGsapf6jyd5xOYvGCyyftJf5noADsSbqWWoI8le1VJKnZpvbE9IodmOe2KqC3ER+l
         gjrhuaSJWXWYtA+DeZr5CUPUschS4FioXwuOnQYohZxqjkc7wAUkT98DZmoJZ0VdGi29
         jG+X6VmhCjZo9EGxbZoeJfxCnB0BQfHHSfjiDu7UTLpPU/P8YSljg1rLJj97EpQIx/GQ
         3keg==
X-Gm-Message-State: AOAM532kety3LU2A1sqWbx22cNHFow4MaERmcGbLlyTdkvbj86Rc5e2t
        9s7s6+wZeS6QpmoGCbKC6ppsF45dSwYCSuPj8JvT
X-Google-Smtp-Source: ABdhPJwNn83w6WeDMA1D2CEIEuYFzuzxtiI8bPYsIIPwGrQeFYvLnKt9MgPGBPemImHe6evgXOun+icy7Gp0C3p8N30=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr43044222ejd.106.1616089514824;
 Thu, 18 Mar 2021 10:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <2ed7a55e-7def-7faf-fc47-991b867bff9e@iogearbox.net>
 <CANYvDQOfygmqv0V-1PuzXV8ZFzk0uD566oEF3v9uX21G4fSFKg@mail.gmail.com>
 <1e410caf-019a-ade7-465d-3d936d2f7dc6@iogearbox.net> <5845cef9-5aaf-f85e-8280-472f61ddaeed@iogearbox.net>
 <CANYvDQNCKmEy9ZzPRvhNYvK0=TKk1pRS=seUuAkby92ic8tVqw@mail.gmail.com>
 <f97bd923-bf12-69a0-f0a8-c9a764abbed2@iogearbox.net> <YFIwzhE00OpU1zro@krava>
 <ff0db44e-aa55-da94-785f-ba10792a5ae1@iogearbox.net> <YFKOeGqUwBPTkPzT@krava>
 <61494cfb-1ceb-4886-3023-1ac0b35697d6@iogearbox.net> <YFM+Ijeu4bN4IzH1@krava>
 <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com>
 <CANYvDQOH5ZDpQBAHtz13YNiJ2Bhd56wnoas71UdYco62g-xBDg@mail.gmail.com> <CAHC9VhRMsWJmRr=OZ7FSj2sBmNRJHKNGMPv5nLY6RGX_dxroPA@mail.gmail.com>
In-Reply-To: <CAHC9VhRMsWJmRr=OZ7FSj2sBmNRJHKNGMPv5nLY6RGX_dxroPA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 13:45:03 -0400
Message-ID: <CAHC9VhQQ48yDLWObTjO0Su6mQ2R0QgAWqnuWCb2cZC5qUp_Fqg@mail.gmail.com>
Subject: Re: deadlock bug related to bpf,audit subsystems
To:     Serhei Makarov <smakarov@redhat.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Jerome Marchand <jmarchan@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        Frank Eigler <fche@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        guro@fb.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 1:44 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 18, 2021 at 12:57 PM Serhei Makarov <smakarov@redhat.com> wrote:
> > On Thu, Mar 18, 2021 at 10:43 AM Serhei Makarov <smakarov@redhat.com> wrote:
> > > Jiri Olsa also reports seeing a similar deadlock at v5.10. I'm in the
> > > middle of double-checking my bisection which ended up at a
> > > seemingly-unrelated commit [2]
> > >
> > > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1938312
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=2dcb3964544177c51853a210b6ad400de78ef17d
> >
> > I've confirmed that my first bisection was incorrect by testing
> > @1c2f67308af4 mm: thp: fix MADV_REMOVE deadlock on shmem THP
> > and reproducing the deadlock. Previously this commit was marked as
> > good, so it seems a kernel with the bug can sometimes pass the test.
> >
> > I'll double check rc6 next since I have the kernel handy. If
> > 5.11.0-rc6 can also be made to fail, with Jiri Olsa's report it'd be
> > necessary to do a wider search.
> > There may be commits with intent similar to
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d92db5c04d103
> > which tightened some of the behaviour of kernel reads, but affecting
> > the audit subsystem?
> > The actual stack trace that leads to deadlock goes through
> > security_locked_down() which was present since the original patch
> > reworking probe_read into separate probe_read_{user,kernel} helpers
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=6ae08ae3dea2
>
> Added thee SELinux list to the To/CC line; they should really be
> involved.  I'm also CC'ing the LSM list for good measure as there may
> be other people that care about this.

Argh, hit send a bit too quickly :/

> FYI, the first instance of this thread that I saw can be found here
> via the linux-audit list:
>
> https://lore.kernel.org/linux-audit/CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com/

-- 
paul moore
www.paul-moore.com
