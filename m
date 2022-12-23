Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1CDC3DA79
	for <selinux@archiver.kernel.org>; Fri, 23 Dec 2022 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiLWRL7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Dec 2022 12:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiLWRLy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Dec 2022 12:11:54 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2206CF58D
        for <selinux@vger.kernel.org>; Fri, 23 Dec 2022 09:11:53 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so3681594pga.1
        for <selinux@vger.kernel.org>; Fri, 23 Dec 2022 09:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkee7RrYc2U/oJNyyVQMHhwa70/pKZltx8G4phukYAg=;
        b=F9HK21FJgpueXWxYyaXW6otcPqsYmX70jjKroW/3L13tKaSBM0GAPYFvv5qMk8+ZQw
         ExJ8zj0FumAcoviULNN59OHzYyrq0GUdLptYCrYLSrmvPXlR7Z9w4iLH9X3w9Yc6GBWy
         76eHES/BxNdPb3HySB1nua+D1+QAELcc0UUpbZkaDJ+zJY6uH6iDOrvAFwQxO1jlibmp
         lesxL2e0aDAM8wD2SgT7jdAVxnGZtWsp2OlYV2g3hcNZ6663m7xiY8VfQg/EJWMSPs2e
         tfm/oGnyyhIQ9yzhbj64ZioK0TTxbkAB+gXtnGIyW2Yc4cn93FXDwE1IlFrPOiq8eRSL
         8TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vkee7RrYc2U/oJNyyVQMHhwa70/pKZltx8G4phukYAg=;
        b=7pGjO8j/rQ1kYYyA5JSSdMWCeuBN7BR6KxKqNXIqv/y+kDnjogBDG5g4MRZOMxHDd6
         v7Ek6PKhRTaaZ1g0W3qPhgCpe8OO2yO18AK7HNzQFdjSiCeZqrxGk9qrwJh3sAmmuO5i
         8+3HQjTnVjO/wjjhEXEdd/UcgAOpM9yCKfx7DVZuhs+ScfksoRS+ExKu1uWinDNLdtts
         ntz7cprG36P/8ST8xBfr3o2ciFtbT4+NwsL+c8ssuDxXkyoVAExC6diSYkdkEF54C2GC
         AnOZu+3AbCcem8HgMwaF2jvduHBMYSP2OcTnkKmljMGtK44galycCriLTnYJoc+PcCJj
         tHlQ==
X-Gm-Message-State: AFqh2kpdnSDA8PeVWVClIq0919xP3F9pOmuGVRD8AUWsPqZ4GKU+k5wR
        qgT4C1bEAOsyNaRgZSPdUjmWjLMAdek+o6o3CT33
X-Google-Smtp-Source: AMrXdXsToPAmuMaeE3tIMxt6zsFbwbjkvgpaVqdsYK/dGFrAIrqQ8guM+Z7tZmVPs+0YTPoUBU3SQu7dW/bTZ++mAkg=
X-Received: by 2002:a63:4e5d:0:b0:478:42f:5a3d with SMTP id
 o29-20020a634e5d000000b00478042f5a3dmr597740pgl.3.1671815512483; Fri, 23 Dec
 2022 09:11:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671469167.git.pabeni@redhat.com> <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
 <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
 <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
 <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com> <fd3ca85bbaceea0ef629c35a0a63129cb6090811.camel@redhat.com>
In-Reply-To: <fd3ca85bbaceea0ef629c35a0a63129cb6090811.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Dec 2022 12:11:41 -0500
Message-ID: <CAHC9VhSBYMyjciZbX38OY_5NU-d6fszPj3xX4F3FhQYLCAWe2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 22, 2022 at 10:57 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Wed, 2022-12-21 at 20:21 -0500, Paul Moore wrote:
> > On Wed, Dec 21, 2022 at 2:24 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > > I just tested the other option and there is another problem :(
> >
> > It's never easy, is it? ;)
> >
> > > The first subflow creations happens inside af_inet->create, via the sk-
> > > > sk_prot->init() hook. The security_socket_post_create() call on the
> > > owning MPTCP sockets happens after that point. So we copy data from a
> > > not yet initialized security context (and the test fail badly).
> >
> > Hmmm.  Let's come back to this later on down this email.
> >
> > > There are a few options to cope with that:
> > > - [ugly hack] call  security_socket_post_create() on the mptcp code
> > > before creating the subflow. I experimented this just to double the
> > > problem and a possible solution.
> >
> > I'm guessing "[ugly hack]" is probably a bit of an understatement.
> > Let's see if we can do better before we explore this option too much
> > further.
>
> Yup, I compiled the list in "brainstom-mode", trying to include
> whatever would be possible even if clearly not suitable.
>
> [...]
>
> > > WDYT?
> >
> > Let's go back to the the inet_create() case for a little bit.  I'm
> > thinking we might be able to do something by leveraging the
> > sk_alloc()->sk_prot_alloc()->security_sk_alloc() code path.  As
> > inet_create() is going to be called from task context here, it seems
> > like we could do the sock's sid/sclass determination here, cached in
> > separate fields in the sk_security_struct if necessary, and use those
> > in a new MPTCP subflow hook.  We could also update
> > selinux_socket_post_create() to take advantage of this as well.  We
> > could also possibly pass the proto struct into security_sk_alloc() if
> > we needed to identify IPPROTO_MPTCP there as well.
> >
> > I'll admit to not chasing down all the details, but I suspect this may
> > be the cleanest option - thoughts?
>
> Thanks, I did not consider such possibility!
>
> I think we should be careful to avoid increasing sk_security_struct
> size. Currently it is 16 bytes, nicely matching a kmalloc slab, any
> increase will move it on kmalloc-32 bytes slab possibly causing
> performance and memory regressions).

FWIW, it is likely that this will end up growing in the future to
support stacking LSMs.  It's unfortunate, messy, and generally ugly,
but inevitable.

See the selinux_inode() function as a similar example using
inode/inode_security_struct.

> More importantly, I think there is a problem with the
> sk_clone_lock() -> sk_prot_alloc() -> security_sk_alloc()
> code path.
>
> sk_clone_lock() happens in BH context, if security_transition_sid()
> needs process context that would be a problem - quickly skimming the
> code it does not look so, I need to double check.

The problem is that in both selinux_socket_create() and
selinux_socket_post_create() the credentials from @current are needed
to determine the sock/sk_security_stuct label.  In
selinux_socket_create() @current's credentials are also used to
determine if the socket can be created.

It's looking like doing labeling determinations in the
security_sk_alloc() struct is not going to work.  While
sk_clone_lock() will end up calling into
security_sk_clone()/selinux_sk_clone_security() via sock_copy(), if I
understand you correctly that won't help as the main MPTCP socket is
not yet setup (e.g. selinux_socket_post_create() has not yet been run
on the main socket).

> Perhaps the cleanest option could be the one involving the mptcp
> refactoring, moving subflow creation at a later stage. It could have
> some minor side benefit for MPTCP, too - solving:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/290
>
> but I'm not fond of that option because it will require quite a bit of
> time: we need first to have the mptcp refactor in place and then cook
> the lsm patches. I guess such process will require at least 2 release
> cycles, due to the needed mptcp(netdev)/lsm trees synchronization.

I generally take the long term view when it comes to Linux Kernel
development; given the nature of the kernel, and all the constraints
that come with it, I would much rather pursue solutions that we
believe have the longest staying power.

I'm also happy to work on, and/or review, LSM patches in conjunction
with a MPTCP refactor.  If the only reason to split the work over two
kernel releases is to soften the blow during the merge window, I think
we can work that out in a single release ... at least I say that now
:)

Basically when it comes down to it, I want to make sure that any fix
we come up with *works*.  In my mind that means doing the LSM fix in
conjunction with the rework; I would hate to see all of the rework
happen only to find out later that it still didn't solve the LSM
problem.

Does that make sense?

> If that would prove to be the most reasonable option, could we consider
> to transiently merge first something alike:
>
> https://lore.kernel.org/mptcp/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/T/#m06c612f84f6b6fe759e670573b2c8092df71607b
>
> to have a workable short-term solution, and later revert it when the
> final solution would be in place?

I would need to go back through that to make sure that it makes sense,
and ensure that the hook is idempotent for SELinux, AppArmor, and
Smack (current hook implementations), *aaaand* if we promise that this
is just a *temporary* hack I think I would be okay with that.

-- 
paul-moore.com
