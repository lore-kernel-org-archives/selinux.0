Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A2C54EE9
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiIHOmk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIHOmS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 10:42:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B41FF0BC
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 07:42:10 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z22-20020a056830129600b0063711f456ceso12490314otp.7
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LLAqTactD86vLRMR6mgjQMicu0L9+hyc9RvyJwJtYbo=;
        b=WHP0XPzbGNaJB9ZLZSDjBuVegLiT7DiMCGRml5gZsYz/k5xFmk0ROv6g+8s1mmDlhT
         t8CnXLHb+rFbTCZ67X5NMN6tIh46AleblTa+yFrsIUTXJflWcJHKkQyYqUiTm6qMwBzF
         dqyBA/FCl7l2QXxyr7gvruo36zPNrdIXsX/UI6SKukudL36HWVCX/ONTM+TYYlOPcNTG
         8lSW9K5dhYpAIgl7+ERgtP0egZUAR+Sq26xUid/MZlSaC3KeZWzTwwEwFVxXvOtsx/D3
         pzEakO+pNKfZZ+7div0Q6iKJgVttVfkC53AAgiRw5ncJPtqGQI4qJRy6ExASIcu1/Byp
         cBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LLAqTactD86vLRMR6mgjQMicu0L9+hyc9RvyJwJtYbo=;
        b=OnXpHmibRAE6mbospSfXa4cJU7DQbeBWmPuAMVEeVenBWDx+nXvFjF/t5otFTKhxfd
         LXRctNMGUVm+AfJu+VzmIfmFbsrD5ijH2BV6Um/CRSGh4bUquVDh0F04+FGKNKT8UboQ
         wcOG0zXiyfzfPYnq8HhpyEY/IyOWHzI/LA6zYTCTjT2HBbJJIoULFC55efLWMwby259p
         8vAZ1DcykLap3VkR3Y9EGJDa4swvtn/Sd9QaKEEvi2haBBNe+/PIFlHmOSsp52aygE9S
         qBDtXdL+M3JnYCxG3QKKJtnABu3dj8XPG+Qw7W8PY+N7CJq5YMNBGEU5WQ6CkbH20Xjo
         jG5g==
X-Gm-Message-State: ACgBeo1aM4sOg2C0XmiV+uEPaRnoTR3XU2Xw7ZAuPA4+XdBgOpRcG/4/
        BsfTdGaPQxDJougLIdWmzywufWEWOhqE+OoUrJI0XYQqRQ==
X-Google-Smtp-Source: AA6agR4oIXg4vzZAbJ4KGLmVhdouZ5fNin0/DkeC/bdR6ACcmA0nklSiF/+XD3DVnTniSmm0y9bFAfur6ePoh5cjnBo=
X-Received: by 2002:a9d:2de3:0:b0:638:e210:c9da with SMTP id
 g90-20020a9d2de3000000b00638e210c9damr3520319otb.69.1662648129787; Thu, 08
 Sep 2022 07:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com> <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
In-Reply-To: <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 10:41:59 -0400
Message-ID: <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
> On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> > >
> > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > their fds back to its parent. I've patched systemd to call semanage to
> > > get the context for the port if it exists and create a context using
> > > the returned type when calling setsockcreatecon.
> >
> > This obviously depends on how you structure and write your policy, but
> > I don't think you want to use a port type directly as a socket type.
> > I think we talked about this a little in the other thread, but for
> > bound/listening sockets maybe you could do a transition for new child
> > sockets based on the listening socket and port types.
>
> To be clear you are suggesting to call setsockcreatecon with the port
> type but also have a transition rule to transition the port type to a
> socket type?

Two things:

* I'm not sure you want to reuse a port type as a socket type, that
seems wrong to me.

* The socket type transition I was talking about would be new as there
is not currently a type transition when the kernel creates a new
socket for incoming connections.

> > > Everything looks
> > > right i.e. the port type is retrieved, the context is created and
> > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > the listening sockets type as init_t and not the type in the
> > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > me understand why this is happening?
> >
> > You're calling setsockcreatecon() before you create the listening
> > socket, right?  I wouldn't expect this to work properly if you create
> > the listening socket and then call setsockcreatecon() hoping to have
> > the new label applied to the new child sockets.
>
> It's not my code  ;) the systemd sd-listen process code does the
> setsockccreatecon, bind and then listen.

Well, regardless of who wrote the code, setsockcreatecon() is not
going to have any effect on a socket's label if it is called *after*
the socket is created.  Additionally, setsockcreatecon() has no effect
on child sockets created by incoming connections on a listening
socket; if you want to affect the label of those child sockets today
you would need to change the label of the listening parent socket.

> Regarding how to get the port context, what would you suggest?
> Currently I'm calling semanage functions but have considered using the
> sepol instead.

I'll leave that to the folks who better understand the SELinux
libraries, my only comment would be that I'm not sure reusing the port
label is a good idea here.

-- 
paul-moore.com
