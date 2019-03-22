Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB8C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A00321900
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 20:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCVUft (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:35:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42975 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCVUfs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 16:35:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so4034153qtc.9;
        Fri, 22 Mar 2019 13:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXxQnRDNbnuxXP7bXuOZ11OG9/q91mbntkleNw0PwLo=;
        b=nrGEwWSwmtHGlZfOD8lUDAHdVHiTANoILHYktTtnXd5AC7d7jPjv0PE0S/2AqV3Yl3
         4Dv2WlVdbwatwzy+90ZjF5qPxy7ZfHcQQcANJt4WfH6A+9KqVVe7ZGlP51qM4Xz5OCf1
         S/B6nE9V9UrAwiChRC4ncVmC7lCVR4fH++fqpH//iB5ZFTSuFiV5oi2bBCPpeLOjAF3o
         ADzpYb0jsOM7VuIJrz9um1GTEFXIi2vM3jnFAcuT6Orxk3dQRPef+SQC5Ymh+JJN6cls
         f21t3XCQ6eCYZO+GkeMGa8EytFWl5NNVabsanQdd+Ak8KFNgelWrdqQc5YQDOd6cukKa
         XQIw==
X-Gm-Message-State: APjAAAWyP9VLEEZ/dzCQzJakYTs11i20ORwhDTp8ke1uF762Nim7LaWf
        DO3l5hoG8T70p9c6psAdf1g5T4p9T1QUC8rbeR0=
X-Google-Smtp-Source: APXvYqzUlKJb4IxCjsGWdLShq+8Q1vx1PUEjVNBeSszoGq4puPUXowX7PAFBpRMTHAKcL2aEdpDGgYkNQv7kof7xwzQ=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr9905246qth.319.1553286947667;
 Fri, 22 Mar 2019 13:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190322141414.496017-1-arnd@arndb.de> <CAHC9VhQuSQr7+y1z3SmY=3s608zYo3JXhF3m_jUWXAo8i8swgw@mail.gmail.com>
In-Reply-To: <CAHC9VhQuSQr7+y1z3SmY=3s608zYo3JXhF3m_jUWXAo8i8swgw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 21:35:30 +0100
Message-ID: <CAK8P3a0EF-T7fySTCDBAFftWTKXPTBcCzj7afcVTP=_pemQdug@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid uninitialized variable warning
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        selinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 22, 2019 at 9:15 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Mar 22, 2019 at 10:14 AM Arnd Bergmann <arnd@arndb.de> wrote:

> Hi Arnd,
>
> Thanks for pointing this out and providing a fix.  I think you're
> right in that the should be pretty harmless, but I also agree that we
> should fix it; some thoughts on the patch below ...
>
> > diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> > index 186e727b737b..d0e549d4f486 100644
> > --- a/security/selinux/netlabel.c
> > +++ b/security/selinux/netlabel.c
> > @@ -288,7 +288,6 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
> >         int rc;
> >         struct netlbl_lsm_secattr secattr;
> >         struct sk_security_struct *sksec = ep->base.sk->sk_security;
> > -       struct sockaddr *addr;
> >         struct sockaddr_in addr4;
> >  #if IS_ENABLED(CONFIG_IPV6)
> >         struct sockaddr_in6 addr6;
> > @@ -310,16 +309,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
> >         if (ip_hdr(skb)->version == 4) {
> >                 addr4.sin_family = AF_INET;
> >                 addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
> > -               addr = (struct sockaddr *)&addr4;
> > +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
> >  #if IS_ENABLED(CONFIG_IPV6)
> >         } else {
> >                 addr6.sin6_family = AF_INET6;
> >                 addr6.sin6_addr = ipv6_hdr(skb)->saddr;
> > -               addr = (struct sockaddr *)&addr6;
> > +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
> >  #endif
>
> While we are hardening the code a bit, I'm thinking we should probably
> refactor this if-else a bit, some pseudo code for example:
>
>     if (ip_hdr == 4) {
>       rc = netlbl_conn_setattr();
>   #if CONFIG_IPV6
>     } else if (ip_hdr == 6) {
>       rc = netlbl_conn_setattr();
>   #endif
>     } else {
>       rc = -EAFNOSUPPORT;
>     }
>
> Thoughts?
>

Seems fine. We could go a step further and use IS_ENABLED()
as C code here to get rid of the two #ifdef checks as well, like

        if (ip_hdr(skb)->version == 4 ) {
                addr4.sin_family = AF_INET;
                addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
                rc = netlbl_conn_setattr(ep->base.sk, &addr4, &secattr);
        } else if (IS_ENABLED(CONFIG_IPV6) && ip_hdr(skb)->version == 6) {
                addr6.sin6_family = AF_INET6;
                addr6.sin6_addr = ipv6_hdr(skb)->saddr;
                rc = netlbl_conn_setattr(ep->base.sk, &addr6, &secattr);
        } else {
               rc = -EAFNOSUPPORT;
        }

  Arnd
