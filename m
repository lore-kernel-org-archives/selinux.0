Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E8C433EF
	for <selinux@archiver.kernel.org>; Wed, 20 Jul 2022 11:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGTLOW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLOW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jul 2022 07:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 335756D551
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658315660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ThpoUlcE2jvjnb/dMMNPUwp86Lv8shbNU9u2u3RcrBY=;
        b=bUt6LBAf4bGD6iCt4cIaW2Le8imeusRHrkQp0A4NgpVfM7gO0jXZFLwUmcLiCs8n1goq2x
        7UCt5cMJvH8Og8OUXoPMBcnwEVC/WbSAMAqi/CuN8KypN065/zJkAGchGRg41+sIb3vo8H
        yo90aUOeLnTPUDTT3gbqMoviUFp4BvY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-ApkRj5u3MTqMDHDozWkMRQ-1; Wed, 20 Jul 2022 07:14:19 -0400
X-MC-Unique: ApkRj5u3MTqMDHDozWkMRQ-1
Received: by mail-yb1-f198.google.com with SMTP id v1-20020a259d81000000b0066ec7dff8feso12992354ybp.18
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 04:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThpoUlcE2jvjnb/dMMNPUwp86Lv8shbNU9u2u3RcrBY=;
        b=5ENhBUxlUdDQjBmxvT2p2zdqM1nZt6QeqEUrinm22v5fpMBwH9CPVQjiIQG7HuGtps
         XEGRI/oapuaYiE357eD6OgnPq5GoRQ8KYWFwHvoGylcCWomVzkjRGBiH2a/qc+9TaIPa
         Y001XKX6v+IsyYKruK38ATB9Rh7SyyUjjvmtzVYxRvI9ozUyd+5xUjxdymFtCaRJCurP
         PR9sVJLZiIIfjmwI3Yprx/Nw6cXSBteB1Xk61Kob7mvoVywN3wyBcGs4WDiR40rHsMH4
         z64HvQVXWv2QhUKW0VnXt39zp59jz+d4qIIrvN1jKQ/+tsTj424m1hiNuOg0izUyGdZj
         NB3w==
X-Gm-Message-State: AJIora8F9KeAwQDeE79/lEQutCteAhnzlA+swYT2+mMEiWRyd/UWGLaB
        ssOp2sd7zui6l18OorJ7iZPxZ/pNmRZEHW1yON3JgXUlcE7LfYQd5YHsVDuF1+uGT2f4x3xZLxD
        bYgHHdf0It2Z0Ik6JBGrBIw5QKmbR/zlXjA==
X-Received: by 2002:a25:dc52:0:b0:66e:ef32:6316 with SMTP id y79-20020a25dc52000000b0066eef326316mr38299256ybe.197.1658315658271;
        Wed, 20 Jul 2022 04:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tou5ad+QQyYm5FEb92VfL1pPvV5DTQDLjSAmfV1bXUZYQAmVa6eyo1eBQVxAC1DlZBtzr+XwfnfCBh0ZK2bz4=
X-Received: by 2002:a25:dc52:0:b0:66e:ef32:6316 with SMTP id
 y79-20020a25dc52000000b0066eef326316mr38299240ybe.197.1658315658008; Wed, 20
 Jul 2022 04:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com> <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 Jul 2022 13:14:06 +0200
Message-ID: <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> > > Rework the SCTP tests slightly to remove two assumptions which are
> > > not always guaranteed to be true (below).  This should have not any
> > > affect on the current test suite or released kernels, but it will
> > > help ensure that the test suite continues to work with upcoming
> > > kernel releases.
> > >
> > >  * Do not rely on IP options attached to a socket.  Depending on the
> > >    kernel configuration, the on-the-wire packet labels may be
> > >    generated on a per-packet basis as opposed to a per-socket basis.
> >
> > Could you expand a bit on why this would be a problem? It's not clear
> > to me how switching to per-packet would break the tests. (Maybe I'm
> > just not thinking about it hard enough, but ideally the commit message
> > would explain the problem to me so I don't have to :)
>
> NetLabel can either attach on-the-wire packet labels (IP options)
> directly to the packet or to the socket, in the latter case the
> network stack handles writing the on-the-wire labels to the packet
> when it is generated.  Deciding on when to attach IP options
> (on-the-wire labels) to the socket versus the packet is an
> implementation detail and depends on the specific configuration of the
> system and the protocols involved.  It is my opinion that going into
> the level of detail necessary to explain the differences would involve
> a discussion about how the Linux network stacks works, the design of
> the NetLabel subsystem, and how the different network protocols work.
> The important takeaway is that one can not safely rely on IP options
> attached to a socket as a means of determining the labeling behavior
> of a socket/connection/association/etc., this is why we have APIs such
> as getpeercon() and the LSM specific socket options.

Oh wait... I looked closer at what the test is actually doing with the
-i options and I get it now. On the client side it extracts the
per-socket IP option and expects to receive that from the server as
its reported peercon. And on the server side, it also doesn't actually
send the peercon, but rather sends whatever is set on its socket's IP
options... That is indeed wrong and your patch fixes it correctly.

However, I'm pondering whether in the seq server case we shouldn't
change the approach a bit... Currently (after your patch) we are
basically testing the "unified" socket-level peercon and that forces
us to restart the server. But we could also ignore the socket-level
peercon in case of SOCK_SEQPACKET and instead extract the per-packet
peercon via IP_PASSSEC and SCM_SECURITY control messages, like we do
in tests/inet_socket/server.c in the SOCK_DGRAM case. I think this
should be the main way for users to get peercon when using
SOCK_SEQPACKET SCTP sockets with multiple peers and we should test it
with higher priority than the socket-level peercon. This means we
would have to use plain recvmsg() instead of sctp_recvmsg() in
sctp_server.c, but that shouldn't be a problem as we don't need to
extract sctp_sndrcvinfo nor msg_flags there.

If you don't want to mess with it, I can take this patch as-is (maybe
with improved commit message) and propose the above in a separate
patch.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

