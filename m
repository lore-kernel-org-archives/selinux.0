Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662FC433EF
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiGUNvg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGUNvV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 09:51:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9432A714
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 06:51:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so2356015wrb.11
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHw50Ud3bvkj1yX6nlbamNcqA7kSj84E+s48eqJkg2A=;
        b=02JPhJUi6o9T1mOaJgURzrFOtsyWjuPN8CvMLFkYLpUrHKmjVvIEUGY3/J5gMjhlQq
         5nb8btXxxHXzo1mXcWV0Ltj4K/ovqydo/C/WvFgvb5Um+3PusfkmznrSPUoyGjCHzyXs
         KgMbVHvNyyNugUwHFSGR3EdytfCulv8VF4KHeWTlz4cmzSWYRRknaSQqLECGCS4Nqylf
         O2Q9RXmpgCdfmPFYy9MqNZQlkwnJ5df80Cm4fDzticdPaDSSSjChn2o6gWnqpXXhMSbs
         6txjz4/X47ge7xBPd233tqoYWfBzhK5u8dyPUXOHTggHnjV0UWDjnuZeJF1bym+h7xxI
         z17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHw50Ud3bvkj1yX6nlbamNcqA7kSj84E+s48eqJkg2A=;
        b=JkXK693yqwEYJAlzYLGm2ndQMm4G98p4JWhbwl+LDNTP1m4vEj4M3MFL5J7DBOKOBM
         JViMyw6w8v7iM4VwspfkQUDtk/fdAKCPgbsPijiC5YraQqfcYNFG6f7SROJn7gEwhjjh
         XKs1OZFZ4Ig8EoXt42yrlipISiEHq8LkXjOxbygp01x7GI6RIB4WGh5YCU0OBhLNqeBs
         o96o8Lkg14CQKfTv2rq0hWKldx8fAlDLwDqd0lZr1VuXAscoWhg9K7OlhvovzJTuLfs0
         9CxIanhsUW413InQPXSJe583SGhLKz/ukoAW840nPELYSYUuALSC+gBX6YVjM611KUX1
         0hvw==
X-Gm-Message-State: AJIora+F+RJcaIstuXq5hDaY9mGlVj8PTof6RqEFOp0GxJE4sikPPzCI
        sEBrEltdRI3ZzS0jViXBcae2VSd/eNw5lAHddnZCMP65kA==
X-Google-Smtp-Source: AGRyM1tBrQnpTra22Ki18nY/kxb2yf9R9Gxd5WrcJtq4sqxaz3zPCiqw3Y2KimcNpro2aj5WyaDer3acWix43hD4IpM=
X-Received: by 2002:a5d:498f:0:b0:21e:4074:8c49 with SMTP id
 r15-20020a5d498f000000b0021e40748c49mr10015940wrq.70.1658411467897; Thu, 21
 Jul 2022 06:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
 <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
 <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com> <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com>
In-Reply-To: <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Jul 2022 09:50:56 -0400
Message-ID: <CAHC9VhT_JvJfafywYiHHdV93TAvgKZAPKQooshpG3CWyF+870w@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 4:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jul 21, 2022 at 12:17 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > Rework the SCTP tests slightly to remove two assumptions which are
> > > > > > not always guaranteed to be true (below).  This should have not any
> > > > > > affect on the current test suite or released kernels, but it will
> > > > > > help ensure that the test suite continues to work with upcoming
> > > > > > kernel releases.
> > > > > >
> > > > > >  * Do not rely on IP options attached to a socket.  Depending on the
> > > > > >    kernel configuration, the on-the-wire packet labels may be
> > > > > >    generated on a per-packet basis as opposed to a per-socket basis.
> > > > >
> > > > > Could you expand a bit on why this would be a problem? It's not clear
> > > > > to me how switching to per-packet would break the tests. (Maybe I'm
> > > > > just not thinking about it hard enough, but ideally the commit message
> > > > > would explain the problem to me so I don't have to :)
> > > >
> > > > NetLabel can either attach on-the-wire packet labels (IP options)
> > > > directly to the packet or to the socket, in the latter case the
> > > > network stack handles writing the on-the-wire labels to the packet
> > > > when it is generated.  Deciding on when to attach IP options
> > > > (on-the-wire labels) to the socket versus the packet is an
> > > > implementation detail and depends on the specific configuration of the
> > > > system and the protocols involved.  It is my opinion that going into
> > > > the level of detail necessary to explain the differences would involve
> > > > a discussion about how the Linux network stacks works, the design of
> > > > the NetLabel subsystem, and how the different network protocols work.
> > > > The important takeaway is that one can not safely rely on IP options
> > > > attached to a socket as a means of determining the labeling behavior
> > > > of a socket/connection/association/etc., this is why we have APIs such
> > > > as getpeercon() and the LSM specific socket options.
> > >
> > > Oh wait... I looked closer at what the test is actually doing with the
> > > -i options and I get it now.
> >
> > The labeled networking stuff can be a little confusing at times, I'm
> > glad you were able to wrap your head around it.
> >
> > > However, I'm pondering whether in the seq server case we shouldn't
> > > change the approach a bit... Currently (after your patch) we are
> > > basically testing the "unified" socket-level peercon and that forces
> > > us to restart the server.
> >
> > /me nods
> >
> > > But we could also ignore the socket-level
> > > peercon in case of SOCK_SEQPACKET and instead extract the per-packet
> > > peercon via IP_PASSSEC and SCM_SECURITY control messages, like we do
> > > in tests/inet_socket/server.c in the SOCK_DGRAM case.
> >
> > Yes, we could do that.  I do think there is some value in checking the
> > peer label when sending SEQPACKETs and the two labels differ, but we
> > can do both, the tests are not mutually exclusive :)
>
> True, but then we need to preserve the server restarting to work
> around the "pinning" of the socket-level peercon, which is a bit
> awkward... Or we could separate the expected values for the two
> peercons and test that the socket-level one is always the one from the
> first connection, while the packet-level ones correspond to the actual
> peer.

I believe the latter is closer to what I was thinking: keep the
existing tests, add additional ones to test what you want.  The SCTP
test already haa a bunch of individual tests (over a hundred I
believe), a few more shouldn't be a big problem.  If we need to add
functionality to the SCTP test server and client programs we can do
that too.

> > > I think this
> > > should be the main way for users to get peercon when using
> > > SOCK_SEQPACKET SCTP sockets with multiple peers and we should test it
> > > with higher priority than the socket-level peercon.
> >
> > I'm not entirely sure what you are suggesting, but just to be clear,
> > the peer label should always be the label of the remote ("peer").  If
> > the remote end of the connection is running with s0:c0.c10, it doesn't
> > matter if the local end initiates communication at s0:c5, the peer
> > label from the local's perspective should be s0:c0.c10 as that is
> > label of the remote/server.
> >
> > It gets a little confusing when you start thinking about how
> > setsockcreatecon() affects this, and SCTP adds its own twists with the
> > different associations, but the core idea should remain the same.
>
> The problem with the socket-level peercon on a SOCK_SEQPACKET socket
> is that due to the multi-peer nature of it we resort to setting it
> based on the first peer and then just revalidate any new differing
> peer contexts through the SCTP_SOCKET__ASSOCIATION permission.

This is one of the awkward parts of SCTP and mapping its behavior to
the existing socket approach.  I believe we discussed some of the
difficulties around locking an association to the first
peer/connection when the patches went in and we couldn't think of a
better way at the time.  If you, or anyone else, has a different
approach that you believe would work better, let's discuss it; just
keep in mind we can't affect/relabel existing things, that's a big
no-no :)

> To me
> it feels like a sort of desperate attempt to provide at least some
> peer context, even if it might not be meaningful.

I would argue that it is still meaningful.  I would also mention that
the association labeling isn't just the peer label, but the
association's label itself.

> It can be convenient
> if you know you are going have just one peer context per socket (and
> the policy enforces it), but other than that it's better to ignore the
> socket peercon and just look at the packet peercons (which are always
> accurate) or peel off each new association into a 1-to-1 socket, where
> the socket's peer context is accurate.

Unfortunately we can't force a 1-to-1 socket/association as SCTP
supports both 1-to-1 and 1-to-many.  I agree it would be nice, but
that decision has already been made for us.

The getpeercon() API returns the label of the remote
peer/node/socket/association based on the initial network traffic.
This should remain unchanged.  If an SELinux aware SCTP application
that leverages the sequential/datagram behavior of SCTP instead of the
stream behavior, wants to know the label on an individual datagram it
should use IP_PASSSEC/SCM_SECURITY just as a SELinux aware UDP
application would.

> I'm of the opinion that it would be better to not return any peercon
> at all for sockets that might end up receiving from multiple peers,
> like we do with SOCK_DGRAM/UDP sockets. (Now it's probably too late to
> change it, but that's what I would propose if the SCTP support was
> being introduced now.)

The difference being that with SCTP an association exists whereas
there is no similar state for UDP.

-- 
paul-moore.com
