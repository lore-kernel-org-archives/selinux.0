Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FCCC433FE
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD92623609
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 10:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgLIKD5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729289AbgLIKD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 05:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607508150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zs2TDojI624LnpQl6oIgsFb9ZYRnL1XUGWSWBQw2pPI=;
        b=YxFOvScEKzNXAEX0SpNgOfn/C6xC3kfcTMJweEiqAC1GxR8XTipcPTaCSrB+W5AY0qCKSn
        n2+uJ+62T4UvbjGw1nHHABfcaoA6vg4vkD9vO2+ZhCCEzOyPOlFrhWYs5xvHPA+qXb6Ydf
        l8KVyeNmlk1AtrscFUgtYEARQlgUbGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-cE74DJWOMsKt0vDs6lKmwQ-1; Wed, 09 Dec 2020 05:02:28 -0500
X-MC-Unique: cE74DJWOMsKt0vDs6lKmwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 725AA858183;
        Wed,  9 Dec 2020 10:02:26 +0000 (UTC)
Received: from ovpn-112-45.ams2.redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2C175C23D;
        Wed,  9 Dec 2020 10:02:24 +0000 (UTC)
Message-ID: <8ceb498f3fd712c4122718cf445f8e3f2a642140.camel@redhat.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with
 TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 09 Dec 2020 11:02:23 +0100
In-Reply-To: <CAHC9VhQmZ_Ra8eY3O-qNo-QN9wLXBFP3VHuHvjY8vWOMSfGafA@mail.gmail.com>
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
         <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
         <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com>
         <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
         <20201203235415.GD5710@breakpoint.cc>
         <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
         <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
         <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
         <08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com>
         <CAHC9VhQmZ_Ra8eY3O-qNo-QN9wLXBFP3VHuHvjY8vWOMSfGafA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-12-08 at 18:35 -0500, Paul Moore wrote:
> On Tue, Dec 8, 2020 at 10:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > Hello,
> > 
> > I'm sorry for the latency, I'll have limited internet access till
> > tomorrow.
> > 
> > On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> > > For SELinux the issue is that we need to track state in the sock
> > > struct, via sock->sk_security, and that state needs to be initialized
> > > and set properly.
> > 
> > As far as I can see, for regular sockets, sk_security is allocated via:
> > 
> > - sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
> > - sk_clone_lock() -> sock_copy() for server sockets
> > 
> > MPTCP uses the above helpers, sk_security should be initialized
> > properly.
> 
> At least for SELinux, the security_socket_post_create() hook is
> critical too as that is where the SELinux sock/socket state values are
> actually set; see selinux_socket_post_create() for the SELinux hook.

MPTCP sockets are created via the conventional sys_socket() call path
or sk_clone_lock(). MPTCP subflows are created via sock_create_kern()
or csk_af_ops->syn_recv_sock().

Overall the above matches what plain TCP does: client sockets and
listener sockets will hit selinux_socket_post_create(), server sockets
will hit security_sk_clone().

> > >  Similarly with TCP request_sock structs, via
> > > request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> > > otherwise creating socks or request_socks outside of the regular TCP
> > > code?
> > 
> > Request sockets are easier, I guess/hope: MPTCP handles them very
> > closely to plain TCP.
> 
> Are there a calls to security_inet_conn_request() and
> security_inet_csk_clone() in the MPTCP code path?  As an example look
> at tcp_conn_request() and inet_csk_clone_lock() for IPv4.

MPTCP subflows call both the above, via the relevant TCP call-path.
MPTCP sockets calls security_inet_conn_request() for client sockets on
connect(), but it looks like we currently lack a call
to security_inet_csk_clone() for server MPTCP sockets, as they are
created via direct call to sk_clone_lock().

I think that could be easily handled with an MPTCP patch.

> > > We would also be concerned about socket structs, but I'm
> > > guessing that code reuses the TCP code based on what you've said.
> > 
> > Only the main MPTCP 'struct socket' is exposed to the user space, and
> > that is allocated via the usual __sys_socket() call-chain. I guess that
> > should be fine. If you could provide some more context (what I should
> > look after) I can dig more.
> 
> Hopefully the stuff above should help, if not let me know :)

yes, it helped, thanks!

My understanding is that the MPTCP implementation aligns with this
proposed patch - modulo the required changed mentioned above, which
looks like a MPTCP bug.

Cheers,

Paolo

