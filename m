Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E52C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D602F64F2B
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 18:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCRST1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhCRSTT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 14:19:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FE5C06175F
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 11:19:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k10so5465966ejg.0
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sse64bqIOWwkx9kqYUy4ajU7Bzc2Pb4HNGntqpA0mM=;
        b=1WNUJrDfvEhcj70yijsJeUt9Yq8eCTCc2Xlu19qqYJiwqfU18DiPMLx1LVkoxxkDhh
         NtJMzw/0gCG2gAfazKZktFJTCyOZaj4gV1+R5WiMhF4ggQG3NDbwQ9th9mqNHmam56nw
         6TC5HQcry7vhch0Nh1tXa70Z7QLJ7XJ+ocYeTLhspTTOBtKz+3tmyky/BcAhO9OL1RVD
         qP4VrSOyIP/wnSHzeA4o8TJjFinF6WSvyr5qON1JKvWpLGq9FqZwM2kQJa8dkTcrDxpD
         xtQsKpv1xgFbGdfYwjJ0aHt/y+T6Gs8gul6AVt+5t7yu/mEbXWCUTqknt6NZPSP5VBRZ
         ko4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sse64bqIOWwkx9kqYUy4ajU7Bzc2Pb4HNGntqpA0mM=;
        b=AETsfMk38Fcq3QvLLLiS1NV7X6OJXPflwHmrDU65D6/VHD2HQZ4PfX/XzxSMI/0zoi
         mGdtzuEzuaI+Oznu/VbsspINcgbZDcuv2FNM7Pbg7H6Sg2eq7sbGhHa2+n+GDgoFZtkl
         xgFaUMH0lsPYZf4Db4B/N4dPuD2czxt8zGEdjwl2OceGVgR+GYBNZCzuy/zMj/QON3Uv
         S0NvBEEehG3vbp23eFWChG/duLvLJptcJGdQ5aPnZQxu3fORH7vQJfzGDIfgSH8s23aJ
         C0O6hksc9WiW0waYacLW1zkR9iL+DAuVcy9mpoKxDSiLzTJHxbaRNiwGVBg8v7zeR5Rj
         vMXQ==
X-Gm-Message-State: AOAM531pdbvwbp8QVeHYsG4WIISdomy1kDnrnowiNNdJ7CGIao7f6kJl
        tv3yhceP/XeOUg1eO5Z6xoa1ZQBxmwPIHuWlblroAoy/E4Nk
X-Google-Smtp-Source: ABdhPJz3ZhyPn56X7wMia/HfV+uHSUf5OdJlPqCXRQwY+sZNLIXnrBAWLfGC9myUp3XOXqFIONy9n0/+0d2i9slNCo0=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr41708535ejf.488.1616091557890;
 Thu, 18 Mar 2021 11:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <2ed7a55e-7def-7faf-fc47-991b867bff9e@iogearbox.net>
 <CANYvDQOfygmqv0V-1PuzXV8ZFzk0uD566oEF3v9uX21G4fSFKg@mail.gmail.com>
 <1e410caf-019a-ade7-465d-3d936d2f7dc6@iogearbox.net> <5845cef9-5aaf-f85e-8280-472f61ddaeed@iogearbox.net>
 <CANYvDQNCKmEy9ZzPRvhNYvK0=TKk1pRS=seUuAkby92ic8tVqw@mail.gmail.com>
 <f97bd923-bf12-69a0-f0a8-c9a764abbed2@iogearbox.net> <YFIwzhE00OpU1zro@krava>
 <ff0db44e-aa55-da94-785f-ba10792a5ae1@iogearbox.net> <YFKOeGqUwBPTkPzT@krava>
 <61494cfb-1ceb-4886-3023-1ac0b35697d6@iogearbox.net> <YFM+Ijeu4bN4IzH1@krava>
 <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com>
 <CANYvDQOH5ZDpQBAHtz13YNiJ2Bhd56wnoas71UdYco62g-xBDg@mail.gmail.com>
 <CAHC9VhRMsWJmRr=OZ7FSj2sBmNRJHKNGMPv5nLY6RGX_dxroPA@mail.gmail.com> <CAHC9VhQQ48yDLWObTjO0Su6mQ2R0QgAWqnuWCb2cZC5qUp_Fqg@mail.gmail.com>
In-Reply-To: <CAHC9VhQQ48yDLWObTjO0Su6mQ2R0QgAWqnuWCb2cZC5qUp_Fqg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 14:19:05 -0400
Message-ID: <CAHC9VhTD3+-tvC2Nxj0bpmcK2SaS50wUQmKtqQ1FSPcO1a-P3A@mail.gmail.com>
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

On Thu, Mar 18, 2021 at 1:45 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 18, 2021 at 1:44 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Mar 18, 2021 at 12:57 PM Serhei Makarov <smakarov@redhat.com> wrote:
> > > On Thu, Mar 18, 2021 at 10:43 AM Serhei Makarov <smakarov@redhat.com> wrote:
> > > > Jiri Olsa also reports seeing a similar deadlock at v5.10. I'm in the
> > > > middle of double-checking my bisection which ended up at a
> > > > seemingly-unrelated commit [2]
> > > >
> > > > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1938312
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=2dcb3964544177c51853a210b6ad400de78ef17d
> > >
> > > I've confirmed that my first bisection was incorrect by testing
> > > @1c2f67308af4 mm: thp: fix MADV_REMOVE deadlock on shmem THP
> > > and reproducing the deadlock. Previously this commit was marked as
> > > good, so it seems a kernel with the bug can sometimes pass the test.
> > >
> > > I'll double check rc6 next since I have the kernel handy. If
> > > 5.11.0-rc6 can also be made to fail, with Jiri Olsa's report it'd be
> > > necessary to do a wider search.
> > > There may be commits with intent similar to
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d92db5c04d103
> > > which tightened some of the behaviour of kernel reads, but affecting
> > > the audit subsystem?
> > > The actual stack trace that leads to deadlock goes through
> > > security_locked_down() which was present since the original patch
> > > reworking probe_read into separate probe_read_{user,kernel} helpers
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=6ae08ae3dea2
> >
> > Added thee SELinux list to the To/CC line; they should really be
> > involved.  I'm also CC'ing the LSM list for good measure as there may
> > be other people that care about this.
>
> Argh, hit send a bit too quickly :/
>
> > FYI, the first instance of this thread that I saw can be found here
> > via the linux-audit list:
> >
> > https://lore.kernel.org/linux-audit/CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com/

Previously in the thread there was a question about why audit events
are being generated inside bpf_probe_read_compat(); the answer is
pretty simple, we do an access check in the security_locked_down()
hook, inside the call to bpf_probe_read_kernel_common(), and that can
result in an audit event depending on the LSM and it's policy.
Skipping the audit event in the case of a LSM access denial, e.g. a
SELinux AVC denial, could result in a silent access denial which can
be maddening both to users and admins.

-- 
paul moore
www.paul-moore.com
