Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC83C4167B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B9823A9B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgLHPg7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:36:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730084AbgLHPg7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Dec 2020 10:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607441733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpc5ulSPymtnGLIAKsGuqY9zEvlWjcFpdT/KvjBlxaY=;
        b=S9ED+OF9PbECG0y+cripL8JpIR2V6wseNm6NheOTiwnxBseITs4tkiqKssKEtTSYUTXnZe
        FuwJxe6jeq6/6woPISRimhNhelmW1yCSMfGtZjJZeAAlAHW9XSbOsz5lmRf1zQnx3zilQY
        NomczOnOTX1YiMq6n9H6VKucDiAIzNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Zp-LDso9MhmVtPgdgKZQag-1; Tue, 08 Dec 2020 10:35:29 -0500
X-MC-Unique: Zp-LDso9MhmVtPgdgKZQag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B2E4A0C2D;
        Tue,  8 Dec 2020 15:35:15 +0000 (UTC)
Received: from ovpn-113-218.ams2.redhat.com (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA3D100238C;
        Tue,  8 Dec 2020 15:35:11 +0000 (UTC)
Message-ID: <08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with
 TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 08 Dec 2020 16:35:05 +0100
In-Reply-To: <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
         <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
         <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com>
         <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
         <20201203235415.GD5710@breakpoint.cc>
         <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
         <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
         <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I'm sorry for the latency, I'll have limited internet access till
tomorrow.

On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> For SELinux the issue is that we need to track state in the sock
> struct, via sock->sk_security, and that state needs to be initialized
> and set properly. 

As far as I can see, for regular sockets, sk_security is allocated via:

- sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
- sk_clone_lock() -> sock_copy() for server sockets

MPTCP uses the above helpers, sk_security should be initialized
properly.

MPTCP goes through an additional sk_prot_alloc() for each subflow, so
each of them will get it's own independent context. The subflows are
not exposed to any syscall (accept()/recvmsg()/sendmsg()/poll()/...),
so I guess selinux will mostly ignored them right?

The kernel will pick some of them to actually send the data, and, on
the receive side, will move the data from the subflows into the user-
space visible mptcp socket.

>  Similarly with TCP request_sock structs, via
> request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> otherwise creating socks or request_socks outside of the regular TCP
> code?  

Request sockets are easier, I guess/hope: MPTCP handles them very
closely to plain TCP.

> We would also be concerned about socket structs, but I'm
> guessing that code reuses the TCP code based on what you've said.

Only the main MPTCP 'struct socket' is exposed to the user space, and
that is allocated via the usual __sys_socket() call-chain. I guess that
should be fine. If you could provide some more context (what I should
look after) I can dig more.

Thanks!

Paolo

