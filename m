Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99997C4361A
	for <selinux@archiver.kernel.org>; Fri,  4 Dec 2020 10:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E2C22795
	for <selinux@archiver.kernel.org>; Fri,  4 Dec 2020 10:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLDKGL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Dec 2020 05:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgLDKGL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Dec 2020 05:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607076285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGpQlDwILqJ2K7ws4QAL6Q+RhooXPBAOwSu+sV77boc=;
        b=S9YIrxSh8JDpZsZnu86IImAsvwsw+EQekHT+Y0QiJtgagrgGodYEmdZq/9WGPSdGKYJqa/
        wcYw838VlavUzFYOcpWKntqJefRm4Z4jUHAdXBzJTIHArUdqrpSGC/Y0WSPRANJCy4TYZ0
        Sl4M+mLQxO0+RJXCJhM2hCvrtVMQpj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250--FdNPLLyMQWIPoDpQWqKqA-1; Fri, 04 Dec 2020 05:04:40 -0500
X-MC-Unique: -FdNPLLyMQWIPoDpQWqKqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748C356C60;
        Fri,  4 Dec 2020 10:04:39 +0000 (UTC)
Received: from ovpn-115-36.ams2.redhat.com (ovpn-115-36.ams2.redhat.com [10.36.115.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60E445D6AC;
        Fri,  4 Dec 2020 10:04:37 +0000 (UTC)
Message-ID: <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with
 TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, Florian Westphal <fw@strlen.de>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 04 Dec 2020 11:04:36 +0100
In-Reply-To: <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
         <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
         <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com>
         <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
         <20201203235415.GD5710@breakpoint.cc>
         <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-12-03 at 21:24 -0500, Paul Moore wrote:
> On Thu, Dec 3, 2020 at 6:54 PM Florian Westphal <fw@strlen.de> wrote:
> > Paul Moore <paul@paul-moore.com> wrote:
> > > I'm not very well versed in MPTCP, but this *seems* okay to me, minus
> > > the else-crud chunk.  Just to confirm my understanding, while MPTCP
> > > allows one TCP connection/stream to be subdivided and distributed
> > > across multiple interfaces, it does not allow multiple TCP streams to
> > > be multiplexed on a single connection, yes?
> > 
> > Its the latter.  The application sees a TCP interface (socket), but
> > data may be carried over multiple individual tcp streams on the wire.
> 
> Hmm, that may complicate things a bit from a SELinux perspective.  Maybe not.
> 
> Just to make sure I understand, with MPTCP, a client that
> traditionally opened multiple TCP sockets to talk to a server would
> now just open a single MPTCP socket and create multiple sub-flows
> instead of multiple TCP sockets?

I expect most clients will not be updated specifically for MPTCP,
except changing the protocol number at socket creation time - and we
would like to avoid even that.

If a given application creates multiple sockets, it will still do that
with MPTCP. The kernel, according to the configuration provided by the
user-space and/or by the peer, may try to create additional subflows
for each MPTCP sockets, using different local or remote address and/or
port number. Each subflow is represented inside the kernel as a TCP
'struct sock' with specific ULP operations. No related 'struct socket'
is exposed to user-space.

Cheers,

Paolo

