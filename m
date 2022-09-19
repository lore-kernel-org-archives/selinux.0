Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D97AECAAD3
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 03:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiISDd7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Sep 2022 23:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISDd6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Sep 2022 23:33:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF31ADA9
        for <selinux@vger.kernel.org>; Sun, 18 Sep 2022 20:33:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f9so44165828lfr.3
        for <selinux@vger.kernel.org>; Sun, 18 Sep 2022 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j3qt9w4eBAyM/oRCkilg4a11rO3Icw8Z9tZehr6D9N8=;
        b=G2uj6LA6PQvDNot6WwOaIv/pSvzuPnpz3dCdS2cTpSFoOfwzN+HfiK3YrKD5wfFpFt
         bwo6zlQCqPf1gwmjOQiGj/h/UvHNK3dCrWgliwg5PDV2S9cyX8ge/XiRfFq9cdwRuehD
         SBOJ83nLURSeqv58dVJPeiw8c/JCZeAW8dzdE9wrzfChBdncOBRvecIb//syOb9mw/+D
         09TWM0ovUmorNBze4bf2dK/uOI5+vZMEtQSf9N/KFT24kcIs2LBPZJgeDjv5oAoL2zBP
         idCnPpobretFon5aHVU0n6x4df4ftpTQOinlZU34mON70+aYwCxP8ntpZSuDFb+MySK3
         0k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j3qt9w4eBAyM/oRCkilg4a11rO3Icw8Z9tZehr6D9N8=;
        b=vriH5qYk2IFYbzdCLQ5SkkZC/VWRmyIzgcVuI599WyEuCQ5dV6cvsDAwd5Sg5ac6gr
         cHQAtuWvin+gHB8i07IFRYKx/wuQewQbeqyv3bTjX08L3xcydg+xPP36tr/G7P7mWB9m
         obbkyW+T7p5o4LLgvGuWjSGebcDaavz41VTLs4PYcLJzuw/41NOydoNeiERE1Lyw2+UT
         0D2iJWbPhRqi7HG6xXvNXNxlbqNnUNxd8ZoGJTT4hkq0mbOiTg9nwiBsB5B7Pzgw+2ZA
         WY3PVDjh+r3puGE0uihy9GLhM5RsZfCHV3mwa1T5e8y5xqCKH5JArj1DK9PBUrNdcHr6
         wFwQ==
X-Gm-Message-State: ACrzQf08N7l4aQegUTbAZ9FUIMVJiELbJBccDIT1AYTIkBztm/nAjUQX
        CuNYWEDNJMcsljdjGqWpp53nj6V+W8B2cYEClFvS
X-Google-Smtp-Source: AMsMyM5QhMFKjAvgURH/PgIc68NC9lI+NCmrhxA+mjW0iL5E6AK75P62oGWxOaPslCdQOzXWf/tMCnlu6zOOv6BCWa4=
X-Received: by 2002:a05:6512:128d:b0:49f:4b31:90ed with SMTP id
 u13-20020a056512128d00b0049f4b3190edmr5634603lfs.118.1663558435390; Sun, 18
 Sep 2022 20:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
 <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
 <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
 <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com>
 <CAHC9VhRyaL5T_rQy+LWqFmorzCsX1UkqpoqP81y3YzsXg+Pmyw@mail.gmail.com> <CAFPpqQEfVgQ5FPTBijMYcYShPHD_nML6WXsrM8uSwC-Rs3EG_A@mail.gmail.com>
In-Reply-To: <CAFPpqQEfVgQ5FPTBijMYcYShPHD_nML6WXsrM8uSwC-Rs3EG_A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 18 Sep 2022 23:33:43 -0400
Message-ID: <CAHC9VhTZC6NL4KZvD9z455A80+bpFzibOKNrVBqOWJh7kJHoNA@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 14, 2022 at 12:44 PM Ted Toth <txtoth@gmail.com> wrote:
> On Wed, Sep 14, 2022 at 9:03 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Sep 12, 2022 at 9:11 AM Ted Toth <txtoth@gmail.com> wrote:
> > > On Thu, Sep 8, 2022 at 9:42 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
> > > > > On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> > > > > > >
> > > > > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > > > > get the context for the port if it exists and create a context using
> > > > > > > the returned type when calling setsockcreatecon.
> > > > > >
> > > > > > This obviously depends on how you structure and write your policy, but
> > > > > > I don't think you want to use a port type directly as a socket type.
> > > > > > I think we talked about this a little in the other thread, but for
> > > > > > bound/listening sockets maybe you could do a transition for new child
> > > > > > sockets based on the listening socket and port types.
> > > > >
> > > > > To be clear you are suggesting to call setsockcreatecon with the port
> > > > > type but also have a transition rule to transition the port type to a
> > > > > socket type?
> > > >
> > > > Two things:
> > > >
> > > > * I'm not sure you want to reuse a port type as a socket type, that
> > > > seems wrong to me.
> > >
> > > I was thinking I'd create an app type, port type, socket
> > > type and a type transition:
> > > type a_t;
> > > type a_port_t;
> > > type a_sock_t
> > > type_transition init_t a_port_t:tcp_socket a_socket_t;
> > >
> > > I'd use semanage or cil to set the port type.
> > > semanage port -a -p tcp -t a_port_t XXXX
> > > or:
> > > portcon ...
> >
> > That seems reasonable.
>
> Maybe you didn't notice my last comment about giving up on this approach :(

Nope.  I've been very busy lately.

> > > Then when systemd is creating the socket for the activated service it
> > > would lookup the port type in policy and call security_compute_create
> > > passing in systemds context, the port context and tcp_socket class
> > > which would return an a_socket_t context to be used in the
> > > setsockcreatecon call.
> >
> > I guess you could do it that way, but I think the better way to do
> > this is via a normal type transition in the kernel when the accept()'d
> > child socket was created in the kernel.  Not only does it not require
> > userspace changes, it avoids all the potential race issues one might
> > have with multi-threaded applications and setsockcreatecon().
>
> Are you referring to the type transition that doesn't exist yet that
> you mentioned previously?

Yep.

> If so could you give a little more detail
> about how it would work?

I believe I did in some previous post on this thread, another related
one, or some off-list email.  There has been a lot of mail on this
issue ...

Regardless, if I remember correctly I think I was talking about using
the domain and port label to do a type transition to a new type when a
socket was created as the result of accepting a new connection.  It's
pretty much the same 'type_transition ...' statement that you listed
above (in the approach you gave up on).

> Again my concern is primarily with the
> context of the listening socket as I need to be able to write policy
> to control the source types that can connect to it.

Oh, I thought you were concerned about the child sockets created by
accepting new connections on a bound/listening socket.

-- 
paul-moore.com
