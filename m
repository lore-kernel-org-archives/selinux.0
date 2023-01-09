Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DB8C678D6
	for <selinux@archiver.kernel.org>; Mon,  9 Jan 2023 10:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjAIKl4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbjAIKls (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Jan 2023 05:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A02DE7
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 02:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673260269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsZDVFFI4B9JFOMYA2LQvus/4YHNnW5fVh15L9NVkzE=;
        b=faAvsqQpQ9GXjxDvU+l22w0zTC4bL6q5sI4l2LDwdHqIsnEJ7FFfv+MbdHwAqTnRC8kKCt
        28HRBUUZhO7oDwFmwsGbL6ckEf+7NXecrskcxAyTiKmDIJqoGvXGDJWxYaB/5JUBwF9McJ
        lRwzFUGomLoTrVtdl2DGvS0sc+KeF+g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-lcfE_SRaOpG6d-ZoNeXopg-1; Mon, 09 Jan 2023 05:31:08 -0500
X-MC-Unique: lcfE_SRaOpG6d-ZoNeXopg-1
Received: by mail-qv1-f71.google.com with SMTP id lc30-20020a0562142c1e00b0052f5d835229so4928050qvb.5
        for <selinux@vger.kernel.org>; Mon, 09 Jan 2023 02:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wsZDVFFI4B9JFOMYA2LQvus/4YHNnW5fVh15L9NVkzE=;
        b=pctK58uHuWasibLY+/NEqx6Tj05hPaL0MMXqzfV4E8zOTeSbh40F7u2+8qSAlOIAur
         vERWUMwxKhFS9BLC3ylJ/To9Y1R4m6PEtN+m40hr+7BM2fd+zXHqgzZFozBJ9keJKJvD
         xKFv7BPf84jIE8JC0hEvkmFZvnek2pc+Z6i9U5dS3RwjFgQX0nqDQGAhK0+N70e0vK50
         alPRa6KIzvYgyju/w2Gsyl4wU5skTasy5l0ShKzDB92Xt0RTXqnM+7of8Zv/WLYx/r9q
         rWTd6kFb+DXDoZWjmbaOnJvnxsjPSJk0g2jjpg+X6RvN1GUi5J92SDB6yG1yCCzZ6bz/
         eZqA==
X-Gm-Message-State: AFqh2ko1gSvKwFC4y6sC/AGXW76JTOBqXtfq6Wl2+VrthZZdH4m/CzXX
        uQIPbYD/ja7Bhzqb3VBYP6YRcKBpRpJkZC3nFnGldUQMt4Ldvp7dQnVkt+lz4NOrbfyooYj00Ei
        SfwufcgKpRyN2lw5a2A==
X-Received: by 2002:a0c:e805:0:b0:531:91cc:3ce5 with SMTP id y5-20020a0ce805000000b0053191cc3ce5mr61446040qvn.39.1673260267913;
        Mon, 09 Jan 2023 02:31:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvE2Hq9Ndujw+JebXu00a2dNrJm2kvrPaFC6wcKDMUavqkScAAIzCCqzvyJ2AYfMBVhw7ii6Q==
X-Received: by 2002:a0c:e805:0:b0:531:91cc:3ce5 with SMTP id y5-20020a0ce805000000b0053191cc3ce5mr61446019qvn.39.1673260267463;
        Mon, 09 Jan 2023 02:31:07 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-116-99.dyn.eolo.it. [146.241.116.99])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a29d300b006ff8a122a1asm5183158qkp.78.2023.01.09.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:31:06 -0800 (PST)
Message-ID: <b318b611df77a449b162197868e0af14b2d81b68.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Date:   Mon, 09 Jan 2023 11:31:04 +0100
In-Reply-To: <CAHC9VhSBYMyjciZbX38OY_5NU-d6fszPj3xX4F3FhQYLCAWe2Q@mail.gmail.com>
References: <cover.1671469167.git.pabeni@redhat.com>
         <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
         <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
         <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
         <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com>
         <fd3ca85bbaceea0ef629c35a0a63129cb6090811.camel@redhat.com>
         <CAHC9VhSBYMyjciZbX38OY_5NU-d6fszPj3xX4F3FhQYLCAWe2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I'm sorry for the long delay:  I was on PTO with limited internet
access.

On Fri, 2022-12-23 at 12:11 -0500, Paul Moore wrote:
> On Thu, Dec 22, 2022 at 10:57 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > On Wed, 2022-12-21 at 20:21 -0500, Paul Moore wrote:
> > > On Wed, Dec 21, 2022 at 2:24 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > > > I just tested the other option and there is another problem :(
> > > 
> > > It's never easy, is it? ;)
> > > 
> > > > The first subflow creations happens inside af_inet->create, via the sk-
> > > > > sk_prot->init() hook. The security_socket_post_create() call on the
> > > > owning MPTCP sockets happens after that point. So we copy data from a
> > > > not yet initialized security context (and the test fail badly).
> > > 
> > > Hmmm.  Let's come back to this later on down this email.
> > > 
> > > > There are a few options to cope with that:
> > > > - [ugly hack] call  security_socket_post_create() on the mptcp code
> > > > before creating the subflow. I experimented this just to double the
> > > > problem and a possible solution.
> > > 
> > > I'm guessing "[ugly hack]" is probably a bit of an understatement.
> > > Let's see if we can do better before we explore this option too much
> > > further.
> > 
> > Yup, I compiled the list in "brainstom-mode", trying to include
> > whatever would be possible even if clearly not suitable.
> > 
> > [...]
> > 
> > > > WDYT?
> > > 
> > > Let's go back to the the inet_create() case for a little bit.  I'm
> > > thinking we might be able to do something by leveraging the
> > > sk_alloc()->sk_prot_alloc()->security_sk_alloc() code path.  As
> > > inet_create() is going to be called from task context here, it seems
> > > like we could do the sock's sid/sclass determination here, cached in
> > > separate fields in the sk_security_struct if necessary, and use those
> > > in a new MPTCP subflow hook.  We could also update
> > > selinux_socket_post_create() to take advantage of this as well.  We
> > > could also possibly pass the proto struct into security_sk_alloc() if
> > > we needed to identify IPPROTO_MPTCP there as well.
> > > 
> > > I'll admit to not chasing down all the details, but I suspect this may
> > > be the cleanest option - thoughts?
> > 
> > Thanks, I did not consider such possibility!
> > 
> > I think we should be careful to avoid increasing sk_security_struct
> > size. Currently it is 16 bytes, nicely matching a kmalloc slab, any
> > increase will move it on kmalloc-32 bytes slab possibly causing
> > performance and memory regressions).
> 
> FWIW, it is likely that this will end up growing in the future to
> support stacking LSMs.  It's unfortunate, messy, and generally ugly,
> but inevitable.
> 
> See the selinux_inode() function as a similar example using
> inode/inode_security_struct.
> 
> > More importantly, I think there is a problem with the
> > sk_clone_lock() -> sk_prot_alloc() -> security_sk_alloc()
> > code path.
> > 
> > sk_clone_lock() happens in BH context, if security_transition_sid()
> > needs process context that would be a problem - quickly skimming the
> > code it does not look so, I need to double check.
> 
> The problem is that in both selinux_socket_create() and
> selinux_socket_post_create() the credentials from @current are needed
> to determine the sock/sk_security_stuct label.  In
> selinux_socket_create() @current's credentials are also used to
> determine if the socket can be created.
> 
> It's looking like doing labeling determinations in the
> security_sk_alloc() struct is not going to work.  While
> sk_clone_lock() will end up calling into
> security_sk_clone()/selinux_sk_clone_security() via sock_copy(), if I
> understand you correctly that won't help as the main MPTCP socket is
> not yet setup (e.g. selinux_socket_post_create() has not yet been run
> on the main socket).
> 
> > Perhaps the cleanest option could be the one involving the mptcp
> > refactoring, moving subflow creation at a later stage. It could have
> > some minor side benefit for MPTCP, too - solving:
> > 
> > https://github.com/multipath-tcp/mptcp_net-next/issues/290
> > 
> > but I'm not fond of that option because it will require quite a bit of
> > time: we need first to have the mptcp refactor in place and then cook
> > the lsm patches. I guess such process will require at least 2 release
> > cycles, due to the needed mptcp(netdev)/lsm trees synchronization.
> 
> I generally take the long term view when it comes to Linux Kernel
> development; given the nature of the kernel, and all the constraints
> that come with it, I would much rather pursue solutions that we
> believe have the longest staying power.
> 
> I'm also happy to work on, and/or review, LSM patches in conjunction
> with a MPTCP refactor.  If the only reason to split the work over two
> kernel releases is to soften the blow during the merge window, I think
> we can work that out in a single release ... at least I say that now
> :)

I thought about doing the MPTCP and selinux patches sequentially to
both avoid the possibly untrivial conflicts resultion issues and to
ensure that the mptcp patches are in place when the selinux ones are
applied, as there is a fuctional dependency. 

> Basically when it comes down to it, I want to make sure that any fix
> we come up with *works*.  In my mind that means doing the LSM fix in
> conjunction with the rework; I would hate to see all of the rework
> happen only to find out later that it still didn't solve the LSM
> problem.
> 
> Does that make sense?

Indeed it makes sense to me.

I think we can address that concern in a quite consolidated way. We
usually include in the MPTCP tree a (very limited) number of patches
that will not be submitted to the netdev because belong to other trees
and/or are handled/owned by others devel. 

We use the above e.g. to fix build and/or functional issues in our
self-tests caused by other subsystems without the need to wait for the
proper fix to land into vanilla. When such event happen, we simply drop
the local copy of the fixup patch.

We could use a similar schema in this scenario. We can include the the
LSM patches to the mptcp in our tree while the rework is in progress to
ensure that overall the effort really addresses the LSM issue.

We can rebase the LSM patches as needed to address conflicts as
needed/if/when they pops up.

Once that the mptcp patches will land into the LSM tree, we will submit
formally the LSM ones to you. During the process I'll check and ensure
that the LSM issue is really/still fixed. Would that work for you?

> > If that would prove to be the most reasonable option, could we consider
> > to transiently merge first something alike:
> > 
> > https://lore.kernel.org/mptcp/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/T/#m06c612f84f6b6fe759e670573b2c8092df71607b
> > 
> > to have a workable short-term solution, and later revert it when the
> > final solution would be in place?
> 
> I would need to go back through that to make sure that it makes sense,
> and ensure that the hook is idempotent for SELinux, AppArmor, and
> Smack (current hook implementations), *aaaand* if we promise that this
> is just a *temporary* hack I think I would be okay with that.

I would appreciate that addtional extra mile a lot, as it will allow a
(temporary!) fix to be delivered quite earlier than what the above
process will provide. 

Of course the deal is that I'll take ownership of pursuing the complete
fix till resolution.

Many thanks!

Paolo

