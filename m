Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0DC433EF
	for <selinux@archiver.kernel.org>; Mon, 25 Jul 2022 09:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiGYJwN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jul 2022 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiGYJwL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jul 2022 05:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67FFAA474
        for <selinux@vger.kernel.org>; Mon, 25 Jul 2022 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658742728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGVSyl7lD3KgSTfYwPSGHlAs7vnrL+Q1VcCc/aALsSI=;
        b=U32KpbU9uG1HFfDXpUnuotLXSxfTJKNbj7SfkxpGGERTAF6jkLxxUkr1nsQZDkeMo7phUx
        7gGey2Ik0ptg275eBBvaqBB3+lgoCDAZwepZ0a6pKrqdqdREeHhiY/LYnxT1cwOpUDsaCV
        TCPitKL8ZIHxfxFwx2dg/9F6NOenWFU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-4IH-WiioO6SHxiQQbcFeXQ-1; Mon, 25 Jul 2022 05:52:07 -0400
X-MC-Unique: 4IH-WiioO6SHxiQQbcFeXQ-1
Received: by mail-yb1-f197.google.com with SMTP id k64-20020a253d43000000b0067080eb57fdso8280403yba.5
        for <selinux@vger.kernel.org>; Mon, 25 Jul 2022 02:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGVSyl7lD3KgSTfYwPSGHlAs7vnrL+Q1VcCc/aALsSI=;
        b=UDN96v+OdybaW83jNy6MNyb36opGCE9aokcG0iT9Qw7lQl5W7Fl3DsGqnF3jQPmlpq
         EO2gtQ1ZkCq5io34ebQEBNnVNz2GWEgrJuwPHicNGhSM2x4JvFWaGY66odHl4Iwm4n9c
         40W7m/L7OPZBEI35d2EGqeB1XGLSEtfFZJSCX4G8c3bzbfxIYKpMK7E3oRR5jjKzSzog
         9+8AsQbEkQQXf6y5ndcKPDl/qmtJyQzj5NVmLMQ1PYIKr2IHNcp+ig6O6+OmIGvLcsyb
         5osqSuynSXloC/DufEZzEhOeR8xdv26NUtl0szlbfaa4iwBzgRf4m4kPyitPqoRW4wLO
         XZXg==
X-Gm-Message-State: AJIora/EGAyEVF2/RAOYtZSFh96kemcIQTweO3hLW6UUIM7b9d2JHtek
        s/iiDyQPAlL8Wpp+4HVbglj2Nh8CulZPklHp0KB4aaR0Soo2r3vEnyFPAXlo2kKEEwBrBo+cJ5h
        +V7XOLXPwyznRUiZ9InCXviV9FdBd53HmKA==
X-Received: by 2002:a5b:c84:0:b0:670:6c6f:4028 with SMTP id i4-20020a5b0c84000000b006706c6f4028mr9256870ybq.196.1658742726476;
        Mon, 25 Jul 2022 02:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tNOeTMVkDwhx+Y1f2BsNIXad1/V8wJEvQnX51PQH03jGEhQhzZv+cQEVwf33UAm5hZJcHQpuu6tv1HMe9yAeE=
X-Received: by 2002:a5b:c84:0:b0:670:6c6f:4028 with SMTP id
 i4-20020a5b0c84000000b006706c6f4028mr9256855ybq.196.1658742726168; Mon, 25
 Jul 2022 02:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
 <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
 <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
 <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com> <CAHC9VhT_JvJfafywYiHHdV93TAvgKZAPKQooshpG3CWyF+870w@mail.gmail.com>
In-Reply-To: <CAHC9VhT_JvJfafywYiHHdV93TAvgKZAPKQooshpG3CWyF+870w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Jul 2022 11:51:54 +0200
Message-ID: <CAFqZXNuCb+ugR0btKdBbQb7-MiHhEnm2L7XEKByVBf8+yb-x9Q@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jul 21, 2022 at 4:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Jul 21, 2022 at 12:17 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > Rework the SCTP tests slightly to remove two assumptions which are
> > > > > > > not always guaranteed to be true (below).  This should have not any
> > > > > > > affect on the current test suite or released kernels, but it will
> > > > > > > help ensure that the test suite continues to work with upcoming
> > > > > > > kernel releases.
> > > > > > >
> > > > > > >  * Do not rely on IP options attached to a socket.  Depending on the
> > > > > > >    kernel configuration, the on-the-wire packet labels may be
> > > > > > >    generated on a per-packet basis as opposed to a per-socket basis.
> > > > > >
> > > > > > Could you expand a bit on why this would be a problem? It's not clear
> > > > > > to me how switching to per-packet would break the tests. (Maybe I'm
> > > > > > just not thinking about it hard enough, but ideally the commit message
> > > > > > would explain the problem to me so I don't have to :)
> > > > >
> > > > > NetLabel can either attach on-the-wire packet labels (IP options)
> > > > > directly to the packet or to the socket, in the latter case the
> > > > > network stack handles writing the on-the-wire labels to the packet
> > > > > when it is generated.  Deciding on when to attach IP options
> > > > > (on-the-wire labels) to the socket versus the packet is an
> > > > > implementation detail and depends on the specific configuration of the
> > > > > system and the protocols involved.  It is my opinion that going into
> > > > > the level of detail necessary to explain the differences would involve
> > > > > a discussion about how the Linux network stacks works, the design of
> > > > > the NetLabel subsystem, and how the different network protocols work.
> > > > > The important takeaway is that one can not safely rely on IP options
> > > > > attached to a socket as a means of determining the labeling behavior
> > > > > of a socket/connection/association/etc., this is why we have APIs such
> > > > > as getpeercon() and the LSM specific socket options.
> > > >
> > > > Oh wait... I looked closer at what the test is actually doing with the
> > > > -i options and I get it now.
> > >
> > > The labeled networking stuff can be a little confusing at times, I'm
> > > glad you were able to wrap your head around it.
> > >
> > > > However, I'm pondering whether in the seq server case we shouldn't
> > > > change the approach a bit... Currently (after your patch) we are
> > > > basically testing the "unified" socket-level peercon and that forces
> > > > us to restart the server.
> > >
> > > /me nods
> > >
> > > > But we could also ignore the socket-level
> > > > peercon in case of SOCK_SEQPACKET and instead extract the per-packet
> > > > peercon via IP_PASSSEC and SCM_SECURITY control messages, like we do
> > > > in tests/inet_socket/server.c in the SOCK_DGRAM case.
> > >
> > > Yes, we could do that.  I do think there is some value in checking the
> > > peer label when sending SEQPACKETs and the two labels differ, but we
> > > can do both, the tests are not mutually exclusive :)
> >
> > True, but then we need to preserve the server restarting to work
> > around the "pinning" of the socket-level peercon, which is a bit
> > awkward... Or we could separate the expected values for the two
> > peercons and test that the socket-level one is always the one from the
> > first connection, while the packet-level ones correspond to the actual
> > peer.
>
> I believe the latter is closer to what I was thinking: keep the
> existing tests, add additional ones to test what you want.  The SCTP
> test already haa a bunch of individual tests (over a hundred I
> believe), a few more shouldn't be a big problem.  If we need to add
> functionality to the SCTP test server and client programs we can do
> that too.

Ok, I'm going to merge this patch with some minor edits (see [1]) if
you're okay with them and then I'll look into further improvements.

[1] https://github.com/WOnder93/selinux-testsuite/commit/0f7bb1696a15972a555d997377348b8e4ae56b38

> > > > I think this
> > > > should be the main way for users to get peercon when using
> > > > SOCK_SEQPACKET SCTP sockets with multiple peers and we should test it
> > > > with higher priority than the socket-level peercon.
> > >
> > > I'm not entirely sure what you are suggesting, but just to be clear,
> > > the peer label should always be the label of the remote ("peer").  If
> > > the remote end of the connection is running with s0:c0.c10, it doesn't
> > > matter if the local end initiates communication at s0:c5, the peer
> > > label from the local's perspective should be s0:c0.c10 as that is
> > > label of the remote/server.
> > >
> > > It gets a little confusing when you start thinking about how
> > > setsockcreatecon() affects this, and SCTP adds its own twists with the
> > > different associations, but the core idea should remain the same.
> >
> > The problem with the socket-level peercon on a SOCK_SEQPACKET socket
> > is that due to the multi-peer nature of it we resort to setting it
> > based on the first peer and then just revalidate any new differing
> > peer contexts through the SCTP_SOCKET__ASSOCIATION permission.
>
> This is one of the awkward parts of SCTP and mapping its behavior to
> the existing socket approach.  I believe we discussed some of the
> difficulties around locking an association to the first
> peer/connection when the patches went in and we couldn't think of a
> better way at the time.  If you, or anyone else, has a different
> approach that you believe would work better, let's discuss it; just
> keep in mind we can't affect/relabel existing things, that's a big
> no-no :)

I don't think it makes sense to change it at this point, since the
user can always simply choose to ignore the socket peercon when using
the SOCK_SEQPACKET SCTP socket. My point really was that we obviously
can't test everything and if we have to choose between testing a less
meaningful interface and testing a more meaningful interface, we
should choose the latter. But it seems that in this case it won't be
too hard/costly to test both, so that point is no longer relevant.

>
> > To me
> > it feels like a sort of desperate attempt to provide at least some
> > peer context, even if it might not be meaningful.
>
> I would argue that it is still meaningful.  I would also mention that
> the association labeling isn't just the peer label, but the
> association's label itself.

I disagree, but it doesn't matter as we can't remove it at this point anyway.

> > It can be convenient
> > if you know you are going have just one peer context per socket (and
> > the policy enforces it), but other than that it's better to ignore the
> > socket peercon and just look at the packet peercons (which are always
> > accurate) or peel off each new association into a 1-to-1 socket, where
> > the socket's peer context is accurate.
>
> Unfortunately we can't force a 1-to-1 socket/association as SCTP
> supports both 1-to-1 and 1-to-many.  I agree it would be nice, but
> that decision has already been made for us.

No, we can't force that, but we could have refused to provide a
socket-level peer context on (potentially) 1-to-many sockets. I'm also
saying that we (the kernel) made it hard to enforce via policy that
the peer label returned corresponds to the actual peer. On the type
level it's easy as you can just not define any
SCTP_SOCKET__ASSOCIATION rules, but on MLS level you would have to
(AFAICT) add some non-trivial constraints to prevent peers with
non-matching levels to connect to the same socket (and thus basically
pretend to have different level if the userspace relies on the
socket's peer context).

> The getpeercon() API returns the label of the remote
> peer/node/socket/association based on the initial network traffic.
> This should remain unchanged.  If an SELinux aware SCTP application
> that leverages the sequential/datagram behavior of SCTP instead of the
> stream behavior, wants to know the label on an individual datagram it
> should use IP_PASSSEC/SCM_SECURITY just as a SELinux aware UDP
> application would.
>
> > I'm of the opinion that it would be better to not return any peercon
> > at all for sockets that might end up receiving from multiple peers,
> > like we do with SOCK_DGRAM/UDP sockets. (Now it's probably too late to
> > change it, but that's what I would propose if the SCTP support was
> > being introduced now.)
>
> The difference being that with SCTP an association exists whereas
> there is no similar state for UDP.

That's irrelevant as the association doesn't correspond 1-to-1 to the
socket. If we really really wanted to provide a way to get the
association's peer context without peeling it off, we should do it via
some SCTP-specific getsockopt that would take assoc ID as an argument
(same as SCTP provides access to assoc-level info/properties). But
IMHO it wouldn't be worth the effort as peeling off the assoc or using
IP_PASSSEC should be a viable alternative in most if not all cases. I
still stand behind my opinion that providing no
socket-or-association-level peercon interface for SOCK_SEQPACKET would
have been better than providing a bad one. (But anyway, this
discussion is merely academic as it can't be undone now due to
backwards compatibility.)

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

