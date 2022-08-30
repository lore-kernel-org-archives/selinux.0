Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F0ECAAD4
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiH3WF0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiH3WFC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 18:05:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12902626
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 15:04:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h5so13318957ejb.3
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3eSw/TxgbcuFj12FjMasXoH7m2F/SN4nu9y1oubFW/Q=;
        b=dumydVtLmUedtJxCIAZ4jUr5W2m/D979eLPETlCHpaken5n7xvwO2rq1ipXdYh+I4m
         JBRUA9Un+FSGh2Y6YvDYSjXOZiAF9LsIVq4SfCzaaBNzBzRknTIyYzAw/ZCYXLYQ7QID
         TK78hjEjh6jyJn/27M4jj6nIS5chaVTu9X6M6M02E08scj4tRIYCVFlcUPSRqCYpmG+o
         x8BwkjQ6izyCD0ZKFC1KW3/WI8Y5Q27gDEj4pzcoP5/k5tmBIlm+OrFyPLHPhYTlOfCi
         LtXCURMpPk25ya6sOrq/sZKytFXRmxAaQ5AkTtcHs89eVeyy8l5pz1d96GtjhKiZYAco
         s9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3eSw/TxgbcuFj12FjMasXoH7m2F/SN4nu9y1oubFW/Q=;
        b=l4XAjNtTH492K/LB0aqpy95R4VqpaQZQ9Ne1e1PKfwW3jtqZ/0MqAMeLSk+OsEQgwN
         aOyonBy/KiCtMJGXhtHzuIPX6mzqQBn8v7UDlgZ26PLOVoAnNEZh6s6K3H2AleyBiyy3
         Vu875n8t1pLZVWXizGGk0RpfPmUgDfu7rHlZBKEL5+Q+mvCyRiA23UC3mOWCNBQWAeqd
         RFIzriowUNHxPs/ZZ9eiJY2uNrlvXcAK7lV11gtFqmTRAKKMNcofsNqBlpEW7uH9HZ8j
         fK6Sci4peMUFz4dGwYU2WvFSrK3DRH/3rtLOQzp9sW1oCihOm8S7VrTgGo5WqKUoqCvj
         JV3g==
X-Gm-Message-State: ACgBeo27bxNLqliTVHbWeePHVyXn24I5+OkOApn/WznjvOGwNF90qyrE
        HdOF9ZPVRDNl2q9bI3vkPQYJQvX/yy8CYxY37ZGf5l2T
X-Google-Smtp-Source: AA6agR6w+Rm2WtJ7ad7oWGt1L6a6cZmEwUXeaM/DWPHXdPLLYwAEthcptb1XAX5T/z2Nw3mKEzZ90GL4+1mO1ZTaB9I=
X-Received: by 2002:a17:906:9b09:b0:741:8ae4:f7a0 with SMTP id
 eo9-20020a1709069b0900b007418ae4f7a0mr8175671ejc.521.1661897082169; Tue, 30
 Aug 2022 15:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
In-Reply-To: <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Tue, 30 Aug 2022 17:04:30 -0500
Message-ID: <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     Paul Moore <paul@paul-moore.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrote:
> > I asked on the systemd-devel list about enabling systemd to set the
> > context of a socket and got the answer I've included below. I don't
> > know how a transition rule can be written to transition tcp sockets to
> > multiple different target contexts, is this possible and if so how?
>
> Ignoring setsockcreatecon(3) as that really isn't an option here,

If we determine that policy can't be written to accomplish the
transition then maybe systemd will reconsider not wanting to set the
socket context using a .socket file option.

> sockets created via socket(2) do check to see if there is a type
> transition defined in the policy.  In the case of a TCP socket the
> type transition would look something like this:
>
>   type_transition <domain> <domain>:tcp_socket <new_socket_type>
>
> ... so you can see there is not much one can select on other than the
> socket's object class.  The reason is that the socket(2) call itself
> is rather spartan, with not even any clue as to if this is a client or
> server socket in the case of TCP.

Having written many policy modules, some of which use the
type_transition statement for tcp_socket objects, I do not see how it
can be used to transition sockets created by systemd. And under this
circumstance I see that the selinux socket create hook would not be
able query the policy database for the port context since the port is
not known until the bind occurs but what about having the bind hook
set the socket context if it finds a sid for the port?

>
> Taking a step back, what are you trying to do?  Perhaps there is
> another approach that would get you where you want to go.

I want to create socket activation services using systemd and to have
the type of the socket being listened on be one that I've defined so
that I can write policy to control which source types can connect to
it.

Thanks
Ted
>
> > ---------- Forwarded message ---------
> > From: Lennart Poettering <lennart@poettering.net>
> > Date: Thu, Aug 25, 2022 at 4:19 AM
> > Subject: Re: [systemd-devel] socket activation selinux context on create
> > To: Ted Toth <txtoth@gmail.com>
> > Cc: <systemd-devel@lists.freedesktop.org>
> >
> >
> > On Mi, 24.08.22 11:50, Ted Toth (txtoth@gmail.com) wrote:
> >
> > > I don't see a way to set the context of the socket that systemd
> > > listens on. If there is a way to do this please tell me otherwise I'd
> > > like to see an option (SELinuxCreateContext?) added to be able to set
> > > the context (setsockcreatecon) to be used by systemd when creating the
> > > socket. Currently as an extra layer of security I add code called in
> > > the socket activation ExecStartPre process to check that the source
> > > context (peercon) can connect to the target context (getcon). If a
> > > sockets context was set by systemd I would have to perform this
> > > additional check as my SELinux policy would do it for me.
> >
> > This was proposed before, but SELinux maintainers really want that the
> > loaded selinux policy picks the label, and not unit files.
> >
> > i.e. as I understand their philosophy: how labels are assigned should
> > be encoded in the database and in the policy but not elsewhere,
> > i.e. in unit files. I think that philosophy does make sense.
> >
> > Lennart
>
> --
> paul-moore.com
