Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D8AC6FA82
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiINNmy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINNmw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 09:42:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1E32062
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 06:42:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u9so34877524ejy.5
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZBLNHxdzE4OUEEYJdYwRB4ZpPD5kw1OufObTIRMX/W0=;
        b=T2nC175GT5ws/wlmaebsCeK48BoPVzYPHrKqi34aPZrD1GOhfIjeCBBnvFNFgcC/Jv
         BlF+NHKPvpuaxek6lKVEaSzcW5OI4HbU92XVFdFZP6Fuu/QVM3nVdjLe2WMI5X/OwiYV
         /DV818WvbVlwYk9xZwFsCJGB7DpZHJDtFRdI31J6Mvt6tA88lQYXlBzkyTnXEJj8Snbg
         Fc+gRUXj+lIg/cYiVbKn43+YIfdkRj63r2edx4FzCjXMf652mXvp/j69A6E68Q4erDc9
         Fma5aywC18wUOjOmFCJvPwEEKxWC+h1o4O8HgrCX+7lwggpsPsbMOp94FtabMcRoj5IJ
         Fe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZBLNHxdzE4OUEEYJdYwRB4ZpPD5kw1OufObTIRMX/W0=;
        b=pf2ICPNcKaSwQHkxWYC+c8Rtf2pCG1Dj6g0UM0QRIXgpfSh4Q8vyPLxFHrlGaKGjDg
         lhNw7c/T2pn85ArIjdFm4CRBYptrlMok21+yCzcjtP4bpwIwlrdEDu5A7T0Bdt7Ax28t
         iSk7e3EGZ3j8HYwsEEEFvGxCCaW1hwDwk2lVEcAp9qm3ogftfOfJggMX6XejRd4prZyJ
         V8DTiuRvjiYj5THj9+EYLK+oUZ155cCelFMvE3jFFT4+1EaDlndhDVoqRH3Z85rYmiUn
         ryRwZtDbx3Z2EA0Zpi1seHGpnzkAuoq9t294EbFtTEIvJEgGhSa/5SvOuNRYl0Sh7b2k
         3+6g==
X-Gm-Message-State: ACgBeo0tEs1Djg4j6dvPLDJyOBUnNTLgt5RMp/GMp+Q4uPZXvrdzp8TU
        SXSD7tlXlVwNhxingXxutpdsDjWtM5Na3I7G+Fct2NiU
X-Google-Smtp-Source: AA6agR7H2nuzi5upccWgXH5lRS5yKf61B3/otgKz56MuzAg8fViDOZemnPoVDvESbhVgj++DYTl5lbfOFOPv52jMJ3A=
X-Received: by 2002:a17:907:2cf0:b0:77b:2ad7:121b with SMTP id
 hz16-20020a1709072cf000b0077b2ad7121bmr14080919ejc.577.1663162969641; Wed, 14
 Sep 2022 06:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
 <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
 <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com> <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com>
In-Reply-To: <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Wed, 14 Sep 2022 08:42:38 -0500
Message-ID: <CAFPpqQH-Rruk2+=CF+NqUtB5R4OEaSuXQV4YMQyh0h1p33-N_A@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I talk to Karl MacMillian offline and he too is of the opinion that
the socket should be created with the target applications context. I'm
going to submit a feature request to systemd for the removal of the
special case of using systemds context when the SELinuxContextFromNet
option is set in .socket file. Thanks everyone for your input.

Ted

On Mon, Sep 12, 2022 at 8:11 AM Ted Toth <txtoth@gmail.com> wrote:
>
> On Thu, Sep 8, 2022 at 9:42 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
> > > On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> > > > >
> > > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > > get the context for the port if it exists and create a context using
> > > > > the returned type when calling setsockcreatecon.
> > > >
> > > > This obviously depends on how you structure and write your policy, but
> > > > I don't think you want to use a port type directly as a socket type.
> > > > I think we talked about this a little in the other thread, but for
> > > > bound/listening sockets maybe you could do a transition for new child
> > > > sockets based on the listening socket and port types.
> > >
> > > To be clear you are suggesting to call setsockcreatecon with the port
> > > type but also have a transition rule to transition the port type to a
> > > socket type?
> >
> > Two things:
> >
> > * I'm not sure you want to reuse a port type as a socket type, that
> > seems wrong to me.
>
> I was thinking I'd create an app type, port type, socket
> type and a type transition:
> type a_t;
> type a_port_t;
> type a_sock_t
> type_transition init_t a_port_t:tcp_socket a_socket_t;
>
> I'd use semanage or cil to set the port type.
> semanage port -a -p tcp -t a_port_t XXXX
> or:
> portcon ...
>
> Then when systemd is creating the socket for the activated service it
> would lookup the port type in policy and call security_compute_create
> passing in systemds context, the port context and tcp_socket class
> which would return an a_socket_t context to be used in the
> setsockcreatecon call.
>
> >
> > * The socket type transition I was talking about would be new as there
> > is not currently a type transition when the kernel creates a new
> > socket for incoming connections.
> >
> > > > > Everything looks
> > > > > right i.e. the port type is retrieved, the context is created and
> > > > > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > > > > the listening sockets type as init_t and not the type in the
> > > > > setsockcreatecon call, is this the expected behavior? Can anyone help
> > > > > me understand why this is happening?
> > > >
> > > > You're calling setsockcreatecon() before you create the listening
> > > > socket, right?  I wouldn't expect this to work properly if you create
> > > > the listening socket and then call setsockcreatecon() hoping to have
> > > > the new label applied to the new child sockets.
> > >
> > > It's not my code  ;) the systemd sd-listen process code does the
> > > setsockccreatecon, bind and then listen.
> >
> > Well, regardless of who wrote the code, setsockcreatecon() is not
> > going to have any effect on a socket's label if it is called *after*
> > the socket is created.  Additionally, setsockcreatecon() has no effect
> > on child sockets created by incoming connections on a listening
> > socket; if you want to affect the label of those child sockets today
> > you would need to change the label of the listening parent socket.
> >
> > > Regarding how to get the port context, what would you suggest?
> > > Currently I'm calling semanage functions but have considered using the
> > > sepol instead.
> >
> > I'll leave that to the folks who better understand the SELinux
> > libraries, my only comment would be that I'm not sure reusing the port
> > label is a good idea here.
> >
> > --
> > paul-moore.com
