Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D760C433EF
	for <selinux@archiver.kernel.org>; Wed, 20 Jul 2022 22:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiGTWRl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGTWRl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jul 2022 18:17:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC2551422
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 15:17:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so28014785wrq.7
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jC4K+3dLPXdFtky2iYOCVLSI3qds71CZtD643l2Grm4=;
        b=D/WZCSbrGPidBFkO7S7MSGEpemmbH8P4SXRLh8WcduCEEgkBuSBMtSgI3D9pgt6Juz
         i4AvUjDazgm2sp8zxo/UELo57uUbflyO+o32+wGZ0Dipdjxbu+eOZx4cVliTvxEuemL7
         EYDrnr+7iWafunekMFR12mJGcj6J9asGjJwIEt1H6PkwT8tgtn1MWpFbeuA0Hb+ezV3F
         1IGm/LH1I8xsvJhw/YLy1rLcnbm0PAsYJsqcW564ltbwlMSm2XTflK9jE2GUjrWCEmnW
         fViA/V88vjJ6cZUTRxKIBqWweyu9KqFlPgoY/kgX5SDwqixHXGS9x6A3sA5fBlyeBjo+
         pufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jC4K+3dLPXdFtky2iYOCVLSI3qds71CZtD643l2Grm4=;
        b=EktSW6pF+hA028/pg9mpL7MGtQStg3hn/EB4PQfVvoYz8mew1mFGeouUl31LnI9ZJW
         mvDox23rDiSvytWrswa+LIuy5wEM7J5sVzBXRMKo37I0iVeYuI/YV8IODWzz1G8PQ89g
         8Kh6CJnVX+K4lI5p3m51glopZeeONrQnnUdK/zBU+emJ4MPzLXNwjUxG1vIiajLNZBHF
         vrC3+o4mmnOJY1sPUzV3oxevKfjDbE9mEPqlzMhbaICdD3UaFD3pLHEb7RysmN1SUO99
         DtZdQoM8sgtPUc7WSJLzm39J4dnD9vAWRHwWigDy6y9N2uWEISjEA0/mY8u3aHtZzCco
         QyuA==
X-Gm-Message-State: AJIora9QjNu+3TvIQMUqkhQIDfJUwgDF/0ouQbCF6s3nqDThsISS842o
        V08ZyR6jnfXhNqV3UAdSnj3Pu3oU/SVyRDo/lDTF7U/quQ==
X-Google-Smtp-Source: AGRyM1vs10PLFPafORCBpwXjJtBXYYxeHy+y6fUAw2hX5S3zyjg46p8jUhcYDB7pcYw5FvgPV5zfuE7Ejise1PTMnXI=
X-Received: by 2002:adf:e492:0:b0:21e:45af:5070 with SMTP id
 i18-20020adfe492000000b0021e45af5070mr5841124wrm.483.1658355458482; Wed, 20
 Jul 2022 15:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com> <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
In-Reply-To: <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Jul 2022 18:17:27 -0400
Message-ID: <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > Rework the SCTP tests slightly to remove two assumptions which are
> > > > not always guaranteed to be true (below).  This should have not any
> > > > affect on the current test suite or released kernels, but it will
> > > > help ensure that the test suite continues to work with upcoming
> > > > kernel releases.
> > > >
> > > >  * Do not rely on IP options attached to a socket.  Depending on the
> > > >    kernel configuration, the on-the-wire packet labels may be
> > > >    generated on a per-packet basis as opposed to a per-socket basis.
> > >
> > > Could you expand a bit on why this would be a problem? It's not clear
> > > to me how switching to per-packet would break the tests. (Maybe I'm
> > > just not thinking about it hard enough, but ideally the commit message
> > > would explain the problem to me so I don't have to :)
> >
> > NetLabel can either attach on-the-wire packet labels (IP options)
> > directly to the packet or to the socket, in the latter case the
> > network stack handles writing the on-the-wire labels to the packet
> > when it is generated.  Deciding on when to attach IP options
> > (on-the-wire labels) to the socket versus the packet is an
> > implementation detail and depends on the specific configuration of the
> > system and the protocols involved.  It is my opinion that going into
> > the level of detail necessary to explain the differences would involve
> > a discussion about how the Linux network stacks works, the design of
> > the NetLabel subsystem, and how the different network protocols work.
> > The important takeaway is that one can not safely rely on IP options
> > attached to a socket as a means of determining the labeling behavior
> > of a socket/connection/association/etc., this is why we have APIs such
> > as getpeercon() and the LSM specific socket options.
>
> Oh wait... I looked closer at what the test is actually doing with the
> -i options and I get it now.

The labeled networking stuff can be a little confusing at times, I'm
glad you were able to wrap your head around it.

> However, I'm pondering whether in the seq server case we shouldn't
> change the approach a bit... Currently (after your patch) we are
> basically testing the "unified" socket-level peercon and that forces
> us to restart the server.

/me nods

> But we could also ignore the socket-level
> peercon in case of SOCK_SEQPACKET and instead extract the per-packet
> peercon via IP_PASSSEC and SCM_SECURITY control messages, like we do
> in tests/inet_socket/server.c in the SOCK_DGRAM case.

Yes, we could do that.  I do think there is some value in checking the
peer label when sending SEQPACKETs and the two labels differ, but we
can do both, the tests are not mutually exclusive :)

> I think this
> should be the main way for users to get peercon when using
> SOCK_SEQPACKET SCTP sockets with multiple peers and we should test it
> with higher priority than the socket-level peercon.

I'm not entirely sure what you are suggesting, but just to be clear,
the peer label should always be the label of the remote ("peer").  If
the remote end of the connection is running with s0:c0.c10, it doesn't
matter if the local end initiates communication at s0:c5, the peer
label from the local's perspective should be s0:c0.c10 as that is
label of the remote/server.

It gets a little confusing when you start thinking about how
setsockcreatecon() affects this, and SCTP adds its own twists with the
different associations, but the core idea should remain the same.

-- 
paul-moore.com
