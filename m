Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C26C433EF
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 08:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiGUIO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGUIOZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 04:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28490785BA
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658391263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JID7iFRH196xATPYpsw4Ioaqobxf5S15NjnkhwLJRZc=;
        b=X0p5M6yUlFRESKgHqsLUrD/OuRtE6qGYL2hCQzETeGRFNB9qvepYM4PMcLOGtLV5Z09rWs
        zov+SGYpRvO4d0sXefBpPfKGMvNF/f0MFuzDKAas2Jw4rSml4cUCduVA2gyViT1cH+HqMm
        Kbgen+3UC9OeU8b+6BvoU5RoEBoTuKU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-A8x9ewmRNW2Y6j1E-C9snQ-1; Thu, 21 Jul 2022 04:14:21 -0400
X-MC-Unique: A8x9ewmRNW2Y6j1E-C9snQ-1
Received: by mail-yb1-f200.google.com with SMTP id y4-20020a25b9c4000000b0066e573fb0fcso793427ybj.21
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 01:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JID7iFRH196xATPYpsw4Ioaqobxf5S15NjnkhwLJRZc=;
        b=NRXgcjTWMj343/nusHzTfh3TL1/O7byKBHtHJQRZjFBzmkoGm4bY/IMgnxS20BeugK
         yRdJvrVE0SUBexhcIzHEzs6O6TIzQl8ocpwLih1rrcuO31wcoNSULrwGqS8eJLjCzCzx
         G3lWZPDw1oUnd6haauauL7KGxLdhlRjzjGd8t4eFIuRjDnxCDfrwEZry0sdcWWK3PYxD
         BS7Dz4cAuGtrC77U2PhdLo5sbclZYUFhMAbC5xhmUey8QdTrhOZ3CqrGtsS1pD/LriD5
         /QsJWj1fvwZ75CTayl3G2W2PayUR+zwUnoAUDw0aCyACkiObm7xJ7fO/+wxsP/xLAA/k
         Dylg==
X-Gm-Message-State: AJIora+SHnQEoEpb1u8LzkGphuR+e2odFsNkyrUQtC69+vI1nYT366I0
        7eUwB2pVhww0wAqVU6ZMrEPGHCpYwDe2IzDt8lqueYPTe1B9JDG+v4gsos02kkqvB8ijzouRodT
        UzxtOQbN5lUPNeD58s9DDBTvrOn+Fw2v+hA==
X-Received: by 2002:a81:1442:0:b0:31e:7d43:59a6 with SMTP id 63-20020a811442000000b0031e7d4359a6mr1329781ywu.247.1658391260597;
        Thu, 21 Jul 2022 01:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uOktEfXCvSJt1BunCAo1cusJqGl7eemAHpFG70CqPtQvXBWoaEguM6OnUJARfeFT4XFEM/I7MIG26cd9EJf2Q=
X-Received: by 2002:a81:1442:0:b0:31e:7d43:59a6 with SMTP id
 63-20020a811442000000b0031e7d4359a6mr1329766ywu.247.1658391260288; Thu, 21
 Jul 2022 01:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
 <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com> <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
In-Reply-To: <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Jul 2022 10:14:08 +0200
Message-ID: <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 12:17 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > Rework the SCTP tests slightly to remove two assumptions which are
> > > > > not always guaranteed to be true (below).  This should have not any
> > > > > affect on the current test suite or released kernels, but it will
> > > > > help ensure that the test suite continues to work with upcoming
> > > > > kernel releases.
> > > > >
> > > > >  * Do not rely on IP options attached to a socket.  Depending on the
> > > > >    kernel configuration, the on-the-wire packet labels may be
> > > > >    generated on a per-packet basis as opposed to a per-socket basis.
> > > >
> > > > Could you expand a bit on why this would be a problem? It's not clear
> > > > to me how switching to per-packet would break the tests. (Maybe I'm
> > > > just not thinking about it hard enough, but ideally the commit message
> > > > would explain the problem to me so I don't have to :)
> > >
> > > NetLabel can either attach on-the-wire packet labels (IP options)
> > > directly to the packet or to the socket, in the latter case the
> > > network stack handles writing the on-the-wire labels to the packet
> > > when it is generated.  Deciding on when to attach IP options
> > > (on-the-wire labels) to the socket versus the packet is an
> > > implementation detail and depends on the specific configuration of the
> > > system and the protocols involved.  It is my opinion that going into
> > > the level of detail necessary to explain the differences would involve
> > > a discussion about how the Linux network stacks works, the design of
> > > the NetLabel subsystem, and how the different network protocols work.
> > > The important takeaway is that one can not safely rely on IP options
> > > attached to a socket as a means of determining the labeling behavior
> > > of a socket/connection/association/etc., this is why we have APIs such
> > > as getpeercon() and the LSM specific socket options.
> >
> > Oh wait... I looked closer at what the test is actually doing with the
> > -i options and I get it now.
>
> The labeled networking stuff can be a little confusing at times, I'm
> glad you were able to wrap your head around it.
>
> > However, I'm pondering whether in the seq server case we shouldn't
> > change the approach a bit... Currently (after your patch) we are
> > basically testing the "unified" socket-level peercon and that forces
> > us to restart the server.
>
> /me nods
>
> > But we could also ignore the socket-level
> > peercon in case of SOCK_SEQPACKET and instead extract the per-packet
> > peercon via IP_PASSSEC and SCM_SECURITY control messages, like we do
> > in tests/inet_socket/server.c in the SOCK_DGRAM case.
>
> Yes, we could do that.  I do think there is some value in checking the
> peer label when sending SEQPACKETs and the two labels differ, but we
> can do both, the tests are not mutually exclusive :)

True, but then we need to preserve the server restarting to work
around the "pinning" of the socket-level peercon, which is a bit
awkward... Or we could separate the expected values for the two
peercons and test that the socket-level one is always the one from the
first connection, while the packet-level ones correspond to the actual
peer.

> > I think this
> > should be the main way for users to get peercon when using
> > SOCK_SEQPACKET SCTP sockets with multiple peers and we should test it
> > with higher priority than the socket-level peercon.
>
> I'm not entirely sure what you are suggesting, but just to be clear,
> the peer label should always be the label of the remote ("peer").  If
> the remote end of the connection is running with s0:c0.c10, it doesn't
> matter if the local end initiates communication at s0:c5, the peer
> label from the local's perspective should be s0:c0.c10 as that is
> label of the remote/server.
>
> It gets a little confusing when you start thinking about how
> setsockcreatecon() affects this, and SCTP adds its own twists with the
> different associations, but the core idea should remain the same.

The problem with the socket-level peercon on a SOCK_SEQPACKET socket
is that due to the multi-peer nature of it we resort to setting it
based on the first peer and then just revalidate any new differing
peer contexts through the SCTP_SOCKET__ASSOCIATION permission. To me
it feels like a sort of desperate attempt to provide at least some
peer context, even if it might not be meaningful. It can be convenient
if you know you are going have just one peer context per socket (and
the policy enforces it), but other than that it's better to ignore the
socket peercon and just look at the packet peercons (which are always
accurate) or peel off each new association into a 1-to-1 socket, where
the socket's peer context is accurate.

I'm of the opinion that it would be better to not return any peercon
at all for sockets that might end up receiving from multiple peers,
like we do with SOCK_DGRAM/UDP sockets. (Now it's probably too late to
change it, but that's what I would propose if the SCTP support was
being introduced now.)

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

