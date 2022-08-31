Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6202ECAAD4
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 14:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiHaO4X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiHaO4S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 10:56:18 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C72BB29
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 07:55:23 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11f4e634072so10418579fac.13
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L67tuHG2LYiBL29voiKBm6+49f/+umF/EUokpQ2akvc=;
        b=qgTEXHmZ0JGKQ+xHLnbu7EwqbGCQf6pxJJOp1a/5yn/Q2mt4mRXqKJLon4nOP5Vd4a
         iGqaBK0KmBCPUT181rXhadC7lm7h3MGlBek55zFvtSV6pU+V/7GNL60UxMceppBW7OIl
         j9zQ6dI+s5Bl7zoC/Z5inT+zQbsKu9GzEAy6+MrEG2BfoymFg+IYxLr2zZ7nxRZKWJHm
         f8+p5tVwKC6E+Qzbu9V60AleNJU+y194ac+EjZsfhuFX96XN2eYzxmcgooxNPL6nyDX7
         6NWBYEqqeMuhMhpRkvm/nwuu2Iw0BgZFR98k8lFCwDS17ViU0nTWR4gb5rlPMJ/lqWuR
         NRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L67tuHG2LYiBL29voiKBm6+49f/+umF/EUokpQ2akvc=;
        b=pkljouutQwX+ANQMGf2BxXLUGtHG5pmg9VrQmCkDDZSkq8CUGvRNDNLmGrfIbjrTPi
         9nHrR9B88xghfTD58eKXSnmLBgl4cNnt8Bw1qRERB8qGR30iH/5J5YX83hBkt+xZUF0F
         h9FxtzeyrmWme903xWirCcaBuWUJU/j2JsRlXSFgi4Kr7ioDlVNSmP3CFzyjB7JTZfzk
         6Wc4Ppl0Cagl+jqgOx/w6cV0iplu6tKDRb0G0ZzqNUrGQLFLCZUnqv6Jh6zkkA7WE0Od
         sHZMPalMRoQuu3xa0vC2Vijd5nTKgqr0cz6SBy7iuU4P7WhK0G/VJK83oAk7oU52Oci8
         W3YQ==
X-Gm-Message-State: ACgBeo2QqvbkQYeMLUmdJohk9d7Ucliwe9UZOHL48aDX9SPkeLrpddKd
        S1+ltK4v8qIuQckplvd1P7BxefSW1XND0207Ghw=
X-Google-Smtp-Source: AA6agR69aytLjqL23TAmIt9K4h77RndBpsB6UfS1Rmv/WDkt6QnoUItw+z7LK9hwFFBmbzx7SG98837mjuhjRdgnD2g=
X-Received: by 2002:a05:6871:6a1:b0:11c:7c79:6bfb with SMTP id
 l33-20020a05687106a100b0011c7c796bfbmr1741823oao.205.1661957722428; Wed, 31
 Aug 2022 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
 <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com> <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 31 Aug 2022 16:55:11 +0200
Message-ID: <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ted Toth <txtoth@gmail.com>, SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 31 Aug 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote:
> > On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrote:
> > > > I asked on the systemd-devel list about enabling systemd to set the
> > > > context of a socket and got the answer I've included below. I don't
> > > > know how a transition rule can be written to transition tcp sockets to
> > > > multiple different target contexts, is this possible and if so how?

What do you mean by "multiple different target contexts"?
How should they be different and how should systemd know?

Socket unit configurations are normally paired with service unit
configurations (e.g. dovecot.socket <-> dovecot.service).
To handle incoming traffic the service unit configuration should
contain an ExecStart= directive, to start a program to handle the
data.
By default systemd tries at socket creation to predict the context of
the started program (via security_compute_create_raw(3) in
src/shared/selinux-util.c:mac_selinux_get_create_label_from_exe()),
see src/core/socket.c:socket_determine_selinux_label().

For example if the service unit contains ExecStart=/usr/bin/myapp and
/usr/bin/myapp has the context myapp_exec_t and the policy contains
`type_transition init_t myapp_exec_t:process myapp_t` systemd should
assign the context myapp_t to the socket specified in the socket unit
configuration.

> > >
> > > Ignoring setsockcreatecon(3) as that really isn't an option here,
> >
> > If we determine that policy can't be written to accomplish the
> > transition then maybe systemd will reconsider not wanting to set the
> > socket context using a .socket file option.
>
> I think the challenge is going to be having enough information when
> the socket is created to do any useful type transition.  I'm open to
> suggestions, but I'm skeptical there is anything we can do beyond the
> current approach.
>
> > > sockets created via socket(2) do check to see if there is a type
> > > transition defined in the policy.  In the case of a TCP socket the
> > > type transition would look something like this:
> > >
> > >   type_transition <domain> <domain>:tcp_socket <new_socket_type>
> > >
> > > ... so you can see there is not much one can select on other than the
> > > socket's object class.  The reason is that the socket(2) call itself
> > > is rather spartan, with not even any clue as to if this is a client or
> > > server socket in the case of TCP.
> >
> > Having written many policy modules, some of which use the
> > type_transition statement for tcp_socket objects, I do not see how it
> > can be used to transition sockets created by systemd. And under this
> > circumstance I see that the selinux socket create hook would not be
> > able query the policy database for the port context since the port is
> > not known until the bind occurs but what about having the bind hook
> > set the socket context if it finds a sid for the port?
>
> The problem with waiting until the connect()/bind() is that you are
> effectively doing a relabel operation, which is a big no-no (but you
> already know that).  *Maybe* you could justify it in the special case
> of stream sockets, as I'm pretty sure there is no way to do anything
> useful with them as a data sink/source until they are either connected
> to a remote peer or bound to a local port, however, we would all need
> to think on that for a bit (it is still a relabel, and thus nasty) and
> probably spend some time staring at the code to make sure there is no
> way to do something sneaky with an unconnected or unbound stream
> socket.
>
> > > Taking a step back, what are you trying to do?  Perhaps there is
> > > another approach that would get you where you want to go.
> >
> > I want to create socket activation services using systemd and to have
> > the type of the socket being listened on be one that I've defined so
> > that I can write policy to control which source types can connect to
> > it.
>
> --
> paul-moore.com
