Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8DC433FE
	for <selinux@archiver.kernel.org>; Fri,  4 Dec 2020 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2E224BE
	for <selinux@archiver.kernel.org>; Fri,  4 Dec 2020 23:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLDXXL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLDXXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Dec 2020 18:23:10 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DB9C061A4F
        for <selinux@vger.kernel.org>; Fri,  4 Dec 2020 15:22:24 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so10988179ejb.13
        for <selinux@vger.kernel.org>; Fri, 04 Dec 2020 15:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlS3C6WuGwoBn7IObI4+YTjRX0/xv/TM3dmDMkafGlw=;
        b=FPM0PRzrYdMcK1zg3P9Wu0xJvL3z6vDGp5YNtp5fKJcuOddtsm8WOeC20JJzhSLaNH
         D+NNNWLUVM0BGkeeQUTlPd9v/oNB+bLWeOnTZWgvGe9Htk0ALBY4cHazx1MTEkIJ/rLB
         BYWt5/wuiXK9XlgUlUeKcjC9ypilxegwkbP/GF0E2sWNGea+rX7twJyOexEYi1/nWukW
         WU9nEjec6CNEgQnbnTmpqwxjOLDQPMvVpBKPkVmjWEjp7ldxtmTL50hdIxpis822zyCN
         koujM6BUbbzVfM+5k3XwkkU+gtMj/uD5fbLwBolQDCjFNddqfw5CYMDQOBiIbA+uYJ5y
         yU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlS3C6WuGwoBn7IObI4+YTjRX0/xv/TM3dmDMkafGlw=;
        b=lygBpnaTGaWayEqK28BaExfcReVhc9gb1zBOWf2UlN7JEeXEt46PWT+CBH1IEPCpae
         kFe+LI6F5pD2PJ8Zp8q94BZgVHsj4Um/eKb4OOSkC5OEjxauQ3YZDRpuog0jv6VAGvJF
         hHRy48jnhScBMgzAdZuVS+UUVeiXZj6WIwjzmrQ2fkXdWYC49i/bYWT+u8kh81fixlkT
         KHCiVOw2+VuyahRn/cVTem6UUlhQopPNunvc9/nGK27md8SBux8oSY/G3lX3ZQYVbpy9
         MsJN9p1xdEYneXt5yP6d4zHR/Xdd7M9DSpJMcVv4O/Q/vTPrtwS+ZOMzu7Fv6y7he7Q9
         6I7A==
X-Gm-Message-State: AOAM533pEtd4ZJjEm65qmagJ3i/Lr5i1/m9MRE1+tUV5RlTV0p/VYSfU
        QG9iO4LkguX6FkJgQzdu0EOV9PJsMYk9FCYWttwu
X-Google-Smtp-Source: ABdhPJyralX6EO3PtSqy1eB+Kk4U1fsGsLAzxcLe/3O1w/Nv5j7MlLXXrZ+NiPUhiLtwFqNVy3lBR1szM+0ofdHR8rw=
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr9222051ejs.542.1607124143374;
 Fri, 04 Dec 2020 15:22:23 -0800 (PST)
MIME-Version: 1.0
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
 <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
 <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com> <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
 <20201203235415.GD5710@breakpoint.cc> <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
 <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
In-Reply-To: <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Dec 2020 18:22:12 -0500
Message-ID: <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 4, 2020 at 5:04 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Thu, 2020-12-03 at 21:24 -0500, Paul Moore wrote:
> > On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw@strlen.de> wrote:
> > > Paul Moore <paul@paul-moore.com> wrote:
> > > > I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> > > > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > > > allows one TCP connection/stream to be subdivided and distributed
> > > > across multiple interfaces, it does not allow multiple TCP streams to
> > > > be multiplexed on a single connection, yes?
> > >
> > > Its the latter.  The application sees a TCP interface (socket), but
> > > data may be carried over multiple individual tcp streams on the wire.
> >
> > Hmm, that may complicate things a bit from a SELinux perspective.  Maybe not.
> >
> > Just to make sure I understand, with MPTCP, a client that
> > traditionally opened multiple TCP sockets to talk to a server would
> > now just open a single MPTCP socket and create multiple sub-flows
> > instead of multiple TCP sockets?
>
> I expect most clients will not be updated specifically for MPTCP,
> except changing the protocol number at socket creation time - and we
> would like to avoid even that.
>
> If a given application creates multiple sockets, it will still do that
> with MPTCP. The kernel, according to the configuration provided by the
> user-space and/or by the peer, may try to create additional subflows
> for each MPTCP sockets, using different local or remote address and/or
> port number. Each subflow is represented inside the kernel as a TCP
> 'struct sock' with specific ULP operations. No related 'struct socket'
> is exposed to user-space.

Hmm, okay, there are probably a few other things we need to worry
about then from a SELinux point of view.  Smack may be okay since it
largely ignores sockets as a security entity, but Casey would be the
one to comment on that.  I'm not certain of the current AppArmor
network controls, or the other LSMs for that matter, but they should
be seeing this conversation on the LSM list so I assume they will
comment as necessary.

For SELinux the issue is that we need to track state in the sock
struct, via sock->sk_security, and that state needs to be initialized
and set properly.  Similarly with TCP request_sock structs, via
request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
otherwise creating socks or request_socks outside of the regular TCP
code?  We would also be concerned about socket structs, but I'm
guessing that code reuses the TCP code based on what you've said.

-- 
paul moore
www.paul-moore.com
