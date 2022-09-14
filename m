Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBE3C6FA82
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiINQon (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiINQog (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 12:44:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D064CE
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 09:44:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r18so36072925eja.11
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Xkc46p6h20mdA0Rzo+7VdGJj6K3x352Aum6O3boDpI=;
        b=NP8SXsf4jVvwdnRUBjSqPNiBTl/mqMgwBqTlCTJIqYJB5U/LAIkT/gblJmt0d1rcvr
         hKhOhosEZUZnBI1Vnqx1HNuMUExiirWE1/EkULL1PBqc2uPwlO+QyOvOpCMz9kGBbI8C
         ohJqXdZTmSDnus7aPhQxhVoRtdPJ0nT1BvXLNPll5VJQGlyv6P4tbZaV01Hqjujmb3fO
         7EH8z4Im7rBmyH8coElDEwC0jfbfxSaplbPA32o4Dgz5JK4KYD4gxmdy0aPTZuUQXIRg
         hqFEZ32XGNKfWUP0gsHaquM5KDNpWz/RXmQZ+gWxhN9tRf3q3ObD58Ldun4Tqc1qNGcT
         +Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Xkc46p6h20mdA0Rzo+7VdGJj6K3x352Aum6O3boDpI=;
        b=M3fo8J/DUIjd2ckR5wHvN5mBYkotyW4PF/aM3MCb81bMBQDxZpjEBNh1rN5iZS7M8/
         /+/8WyE06XY/BdihzXy3p/C9HCJn0TVfmvD+/k3nGzKQwthjFwADSXwkkc1AlZsa5EN5
         Xrhj5krY6W0WEpAVuEZJjE20DgjxE8l+JfujTkuyq6wMnaZl8Ovd1CCypMMvAvOwhFmt
         ChGf5K3bOINsUlm51znZDS3n7bbKAsaJ3yD52J017/jDjICT1ECEz5CT4zi4p7HsX6IV
         /KyMZOHjVQlaIgrUk26vyGWSWeohqj2EuPYl+dcmYTIi7w6FRRUbXcdi73v/tzuk29Iv
         2Ztw==
X-Gm-Message-State: ACgBeo3FQ82kIRE931Uu83/gZk2mcAxDjMXbe44GVHQL26PPn9XeB0nj
        6+1z9WqlE1FACdJtCf1qpx/v0FM1LbLyZTqSb5enAWGl
X-Google-Smtp-Source: AA6agR54x2rYhwZLX8QK67UwN/H4b+mK6rKUCY5C0KYTAOxp0MYxk5RYBKD4RMB3azRGUPeQiFNwFDKHiCBgYN7nqUQ=
X-Received: by 2002:a17:906:cc56:b0:779:ed37:b59e with SMTP id
 mm22-20020a170906cc5600b00779ed37b59emr18161352ejb.536.1663173870299; Wed, 14
 Sep 2022 09:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
 <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
 <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
 <CAFPpqQHdxB+JK3hxpGUX=KP=Dk50XSRHh7hju3BrSvZ1BjeLiQ@mail.gmail.com> <CAHC9VhRyaL5T_rQy+LWqFmorzCsX1UkqpoqP81y3YzsXg+Pmyw@mail.gmail.com>
In-Reply-To: <CAHC9VhRyaL5T_rQy+LWqFmorzCsX1UkqpoqP81y3YzsXg+Pmyw@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Wed, 14 Sep 2022 11:44:19 -0500
Message-ID: <CAFPpqQEfVgQ5FPTBijMYcYShPHD_nML6WXsrM8uSwC-Rs3EG_A@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 14, 2022 at 9:03 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Sep 12, 2022 at 9:11 AM Ted Toth <txtoth@gmail.com> wrote:
> > On Thu, Sep 8, 2022 at 9:42 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
> > > > On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> > > > > >
> > > > > > systemd uses a helper process (sd-listen) to create sockets and pass
> > > > > > their fds back to its parent. I've patched systemd to call semanage to
> > > > > > get the context for the port if it exists and create a context using
> > > > > > the returned type when calling setsockcreatecon.
> > > > >
> > > > > This obviously depends on how you structure and write your policy, but
> > > > > I don't think you want to use a port type directly as a socket type.
> > > > > I think we talked about this a little in the other thread, but for
> > > > > bound/listening sockets maybe you could do a transition for new child
> > > > > sockets based on the listening socket and port types.
> > > >
> > > > To be clear you are suggesting to call setsockcreatecon with the port
> > > > type but also have a transition rule to transition the port type to a
> > > > socket type?
> > >
> > > Two things:
> > >
> > > * I'm not sure you want to reuse a port type as a socket type, that
> > > seems wrong to me.
> >
> > I was thinking I'd create an app type, port type, socket
> > type and a type transition:
> > type a_t;
> > type a_port_t;
> > type a_sock_t
> > type_transition init_t a_port_t:tcp_socket a_socket_t;
> >
> > I'd use semanage or cil to set the port type.
> > semanage port -a -p tcp -t a_port_t XXXX
> > or:
> > portcon ...
>
> That seems reasonable.

Maybe you didn't notice my last comment about giving up on this approach :(

>
> > Then when systemd is creating the socket for the activated service it
> > would lookup the port type in policy and call security_compute_create
> > passing in systemds context, the port context and tcp_socket class
> > which would return an a_socket_t context to be used in the
> > setsockcreatecon call.
>
> I guess you could do it that way, but I think the better way to do
> this is via a normal type transition in the kernel when the accept()'d
> child socket was created in the kernel.  Not only does it not require
> userspace changes, it avoids all the potential race issues one might
> have with multi-threaded applications and setsockcreatecon().

Are you referring to the type transition that doesn't exist yet that
you mentioned previously? If so could you give a little more detail
about how it would work? Again my concern is primarily with the
context of the listening socket as I need to be able to write policy
to control the source types that can connect to it.

>
> --
> paul-moore.com
