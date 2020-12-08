Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1438C4361B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 23:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6AC23AA8
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 23:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgLHXgD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgLHXgC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Dec 2020 18:36:02 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F74C0613D6
        for <selinux@vger.kernel.org>; Tue,  8 Dec 2020 15:35:16 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so280322ejj.11
        for <selinux@vger.kernel.org>; Tue, 08 Dec 2020 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsyNJpij5PGvFSU8PlgITBtcamCnj7Q9cgkrohmXagI=;
        b=oUATB/gHSTyWWKfCVxTndCLe4lGRRBTDZ8Yek4REXWnDLXXExbykYbTvCSqxtEGnQZ
         fgzAU5o0FI0WFV6XYDCvnXrwwI6Cn+kKKu5s/bbDaHvQkYr/NxqNRysjI0p8Z2HvqDym
         WiuSe6cxUkJs+Gn5bNaomu7/8/MnwVBF3D8PSQMFNlP/ncEsnAk/GK6n6L/b3N47KC9q
         84EasdgovCHT9XnLCxuTHUCf8IiUOBu/5uxTZr3PrNrdw+kWQSb1F18iQRkvk6CmipK/
         m2VlS/3Jfp8hYlVqJcfRvFtKbp+FUE7Ackcjew8wYcy9Tb7TA/Y4AwZpyptDG1+cK677
         Nkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsyNJpij5PGvFSU8PlgITBtcamCnj7Q9cgkrohmXagI=;
        b=SAsU7uASv7MsVwjkfi0Ll17uG29IN0SwSvMJJVkFqEpiB8hmL2szCPVFoez9aVT6XY
         WXZrWiA6xOnQ4sRMjXQlShmxh7KnbJgYkKAa9OSL3KNjr7ZCUf6gKL9gBtBDVJYepU+x
         d4r5SgJoOEOxPKftzc2rjtfPuR8NxEObHRzIn7iRzK1L38kqFz4VVLA66FIq4gugHwF0
         MlDuEjy0Rg74S/h3cFwUFIs0vmxdYovdLA4m3YiawhUcisKmeFPWc4F6LU49XPMMP2TY
         D+OdWCVDO/hLyYsvQFvaf3CzvJI0F3EWsOGzafodg7qtLjDReOZa0MUAEvQhWx2Yb5bG
         QqjQ==
X-Gm-Message-State: AOAM531K2RaGdJ/9YZVrjtTXkYSf3IgdKsM78MHOQkY4sp9Z9jB/vZyt
        ZhtgbYoaYbSjwoCPBmObn0HFm3ncilZzJB5tkeo8p7TvwL2B
X-Google-Smtp-Source: ABdhPJxOVGDlGEzOsg4GzrfMZjts9prlepXkWI/yfRvBxibqpacizJfg6J+RmU6FO5mUBeFwvqQH1fVkgianeC+TXgU=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr104255ejc.178.1607470514998;
 Tue, 08 Dec 2020 15:35:14 -0800 (PST)
MIME-Version: 1.0
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
 <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
 <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com> <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
 <20201203235415.GD5710@breakpoint.cc> <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
 <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
 <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com> <08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com>
In-Reply-To: <08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Dec 2020 18:35:03 -0500
Message-ID: <CAHC9VhQmZ_Ra8eY3O-qNo-QN9wLXBFP3VHuHvjY8vWOMSfGafA@mail.gmail.com>
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

On Tue, Dec 8, 2020 at 10:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hello,
>
> I'm sorry for the latency, I'll have limited internet access till
> tomorrow.
>
> On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> > For SELinux the issue is that we need to track state in the sock
> > struct, via sock->sk_security, and that state needs to be initialized
> > and set properly.
>
> As far as I can see, for regular sockets, sk_security is allocated via:
>
> - sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
> - sk_clone_lock() -> sock_copy() for server sockets
>
> MPTCP uses the above helpers, sk_security should be initialized
> properly.

At least for SELinux, the security_socket_post_create() hook is
critical too as that is where the SELinux sock/socket state values are
actually set; see selinux_socket_post_create() for the SELinux hook.

> MPTCP goes through an additional sk_prot_alloc() for each subflow, so
> each of them will get it's own independent context. The subflows are
> not exposed to any syscall (accept()/recvmsg()/sendmsg()/poll()/...),
> so I guess selinux will mostly ignored them right?

SELinux cares quite a bit about the sock structs, they are an
important part of the per-packet access controls as well as a few
other things, so we need to make sure the SELinux state is managed
properly.

From what you have said so far, it is starting to sound like labeling
the subflows with the same label as the parent socket is a reasonable
solution.  In that case, it seems like doing a security_sk_clone()
between the main socket/sock and the new subflow sock should work.

> >  Similarly with TCP request_sock structs, via
> > request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> > otherwise creating socks or request_socks outside of the regular TCP
> > code?
>
> Request sockets are easier, I guess/hope: MPTCP handles them very
> closely to plain TCP.

Are there a calls to security_inet_conn_request() and
security_inet_csk_clone() in the MPTCP code path?  As an example look
at tcp_conn_request() and inet_csk_clone_lock() for IPv4.

> > We would also be concerned about socket structs, but I'm
> > guessing that code reuses the TCP code based on what you've said.
>
> Only the main MPTCP 'struct socket' is exposed to the user space, and
> that is allocated via the usual __sys_socket() call-chain. I guess that
> should be fine. If you could provide some more context (what I should
> look after) I can dig more.

Hopefully the stuff above should help, if not let me know :)

-- 
paul moore
www.paul-moore.com
