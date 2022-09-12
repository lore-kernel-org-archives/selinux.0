Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FAECAAD5
	for <selinux@archiver.kernel.org>; Mon, 12 Sep 2022 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiILNLz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Sep 2022 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILNLy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Sep 2022 09:11:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F162B262
        for <selinux@vger.kernel.org>; Mon, 12 Sep 2022 06:11:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r18so20064483eja.11
        for <selinux@vger.kernel.org>; Mon, 12 Sep 2022 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zsPlagLRvTUrQ3kP+Dv7jgC7TFeZX76BBNIPViifedY=;
        b=FoMGHTIx2J3H40hx0NaTAxQsBbnpLBxirzAuX7xwstAf/unl2aXOzuQMby05k7R/YF
         IbQMrflbNWgghAha02sDnTtXuPUl3gTXH7JgFz/QaMPEiG2/kh2UR5qM+3VqHubMbPvZ
         VamIUW7dY+v2mVxF3Sm7CqqC5HHzLRAyxfs4+yDf1c29lpMCebX5ebPFMwu0H3pkDgc6
         X5SViduB/8hG1ipUhxKssueciV4nCQ2ZthDn7fpB2Pf2JsCvi/RqNcij3+OAqUZnIxSv
         agVyUGW89k7r/1hSAsyYt+sI1skvwNFNhM1CyZYa9th1km+jlY4z3JaP8qoYEe1JGS8h
         MuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zsPlagLRvTUrQ3kP+Dv7jgC7TFeZX76BBNIPViifedY=;
        b=Jge0LjQHVaB4gsb6Sc1W8fLj78mbffwRZ8G1n9sWwqBC6eJu13IrCfhp/y/Z8OmZ2m
         Tka4cTPkoCDpEASPPAZTJ/4IRmknDTkWxP1zyvOQCPLzhz3SYC34sziji/Es48fEJOS0
         Dfu8iAQ/OVvPlU7M8/5n14ZvdPUBfrvlCKaH3hYNyDi/5Py17O35oYg11ilStJ/iaEAM
         h7hhJGrv9eDbYpvDtF7yPCy4MZHmigRO5bnwBpmeYJ0blElOnWUMZgr48g3hEpr7rYob
         SkQz3ax0ZfIuVIv4AOq2JGq5Xpr9ymiHqgZ5bqz2YMRHbM4EBgIKSyPA+UVRfpshIFvt
         CsGA==
X-Gm-Message-State: ACgBeo1/UktBM48e3IEmEA25vyV40tzEp0JvjDC+1XB0+RxJQlZV3P8i
        GhEYVOQSJ0buTz8JIsXSj1nNI0ifmwqduwsEQ6rcCawBUp0=
X-Google-Smtp-Source: AA6agR5RLY9rFibCrUCXlzRLVbjK9ycHg5qW5SE4ndXu0tBVhOxbMfQrG2Yo8Mwcotz+Ixb5asCI8QRwQAlQiKHdkB0=
X-Received: by 2002:a17:906:cc56:b0:779:ed37:b59e with SMTP id
 mm22-20020a170906cc5600b00779ed37b59emr10536392ejb.536.1662988309559; Mon, 12
 Sep 2022 06:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
 <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com> <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
In-Reply-To: <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Mon, 12 Sep 2022 08:11:38 -0500
Message-ID: <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 9:42 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
> > On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> > > >
> > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > get the context for the port if it exists and create a context using
> > > > the returned type when calling setsockcreatecon.
> > >
> > > This obviously depends on how you structure and write your policy, but
> > > I don't think you want to use a port type directly as a socket type.
> > > I think we talked about this a little in the other thread, but for
> > > bound/listening sockets maybe you could do a transition for new child
> > > sockets based on the listening socket and port types.
> >
> > To be clear you are suggesting to call setsockcreatecon with the port
> > type but also have a transition rule to transition the port type to a
> > socket type?
>
> Two things:
>
> * I'm not sure you want to reuse a port type as a socket type, that
> seems wrong to me.

I was thinking I'd create an app type, port type, socket
type and a type transition:
type a_t;
type a_port_t;
type a_sock_t
type_transition init_t a_port_t:tcp_socket a_socket_t;

I'd use semanage or cil to set the port type.
semanage port -a -p tcp -t a_port_t XXXX
or:
portcon ...

Then when systemd is creating the socket for the activated service it
would lookup the port type in policy and call security_compute_create
passing in systemds context, the port context and tcp_socket class
which would return an a_socket_t context to be used in the
setsockcreatecon call.

>
> * The socket type transition I was talking about would be new as there
> is not currently a type transition when the kernel creates a new
> socket for incoming connections.
>
> > > > Everything looks
> > > > right i.e. the port type is retrieved, the context is created and
> > > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > > the listening sockets type as init_t and not the type in the
> > > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > > me understand why this is happening?
> > >
> > > You're calling setsockcreatecon() before you create the listening
> > > socket, right?  I wouldn't expect this to work properly if you create
> > > the listening socket and then call setsockcreatecon() hoping to have
> > > the new label applied to the new child sockets.
> >
> > It's not my code  ;) the systemd sd-listen process code does the
> > setsockccreatecon, bind and then listen.
>
> Well, regardless of who wrote the code, setsockcreatecon() is not
> going to have any effect on a socket's label if it is called *after*
> the socket is created.  Additionally, setsockcreatecon() has no effect
> on child sockets created by incoming connections on a listening
> socket; if you want to affect the label of those child sockets today
> you would need to change the label of the listening parent socket.
>
> > Regarding how to get the port context, what would you suggest?
> > Currently I'm calling semanage functions but have considered using the
> > sepol instead.
>
> I'll leave that to the folks who better understand the SELinux
> libraries, my only comment would be that I'm not sure reusing the port
> label is a good idea here.
>
> --
> paul-moore.com
