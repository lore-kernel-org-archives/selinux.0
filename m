Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4504CC433F5
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 12:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2130061002
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 12:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJYMLL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230137AbhJYMLL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Oct 2021 08:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635163728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q2nyIHUTZBfxOSU9G5dR3nSveek1n7g2AoaYoezLBZo=;
        b=IKciABlCDyZqS7dpVuZYaemK+N90F2Qxe1xjRwlHfF0qL+SG84dL5NN5Ts0A6KbOM+uULX
        byTgFLVl4i8M+xzB3P4xptlaWA8FpePa8IsU2HFPDM+GUG0ek2LhOm0klOQ9/KrpkTqWAq
        AFqAebNh+M9wfpJmF+LhcuH/TrsMFQk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-uWP8hfCQMa-qo_iF_lGaJQ-1; Mon, 25 Oct 2021 08:08:47 -0400
X-MC-Unique: uWP8hfCQMa-qo_iF_lGaJQ-1
Received: by mail-yb1-f200.google.com with SMTP id m81-20020a252654000000b005c135d4efdeso15198037ybm.22
        for <selinux@vger.kernel.org>; Mon, 25 Oct 2021 05:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2nyIHUTZBfxOSU9G5dR3nSveek1n7g2AoaYoezLBZo=;
        b=P6JctczuXymcAwvRDTizLM6r6QDJ8ykVw7aRGfe6PzPMrKUlcwaXLFnZ533G7HqsYw
         iI/kR1kjtccwKsgRrWzmqe/rHVwb0l1nqQG58U9zDmJVp8A/7xTPvYm/kEnl88AUuBbM
         JbN7ByYuFzf7pMuWQWvWHXQf0oBe4FiGkKOLV0ZbMM6VPn2dCwAxT3is5ngiyjIeJh2d
         4qMgoMmJOBPF2M4wu+zEr1B5yXi+6N1n4LCqi8fFX0+Bd1qE+bf1G7gfiIvk48EcBhoh
         2Jfzq8Goj4qOYYXBQT6f5jgNTD9hzYK8v3mknSwbUv7ykYpUE/vZLs3fF8l2o558Momi
         A1mw==
X-Gm-Message-State: AOAM53140JOtu7vsB+4lx0ilhGx7kCLX3QTwaIBCH5X3CKZkHUQtDiyM
        QCyxzjYiPf19u98hPqywJtmv2YyHBuvz4VRYSllxvJufNFF57YazFZVa553XHDfD1TsTkxoUM+y
        Thwcn09ZtxZ2m8hpaPkNWzd8Ku51sccRMBg==
X-Received: by 2002:a25:e650:: with SMTP id d77mr17805937ybh.256.1635163726675;
        Mon, 25 Oct 2021 05:08:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNPXXjoC1Hire6atlbmwrb3RiUJ1ZqlMPIbH/gKHrBmj8blviifSlPipLcZCqb/f5t8Reamw//Bto7VotASlE=
X-Received: by 2002:a25:e650:: with SMTP id d77mr17805906ybh.256.1635163726434;
 Mon, 25 Oct 2021 05:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634884487.git.lucien.xin@gmail.com> <53026dedd66beeaf18a4570437c4e6c9e760bb90.1634884487.git.lucien.xin@gmail.com>
 <CAFqZXNs89yGcoXumNwavLRQpYutfnLY-SM2qrHbvpjJxVtiniw@mail.gmail.com> <CADvbK_djVKxjfRaLS0EZRY2mkzWXTMnwvbe-b7cK-T3BR8jzKQ@mail.gmail.com>
In-Reply-To: <CADvbK_djVKxjfRaLS0EZRY2mkzWXTMnwvbe-b7cK-T3BR8jzKQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 14:08:35 +0200
Message-ID: <CAFqZXNsnEwPcEXB-4O983bxGj5BfZVMB6sor7nZVkT-=uiZ2mw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] security: implement sctp_assoc_established hook
 in selinux
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 25, 2021 at 12:51 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 4:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Oct 22, 2021 at 8:36 AM Xin Long <lucien.xin@gmail.com> wrote:
> > > Different from selinux_inet_conn_established(), it also gives the
> > > secid to asoc->peer_secid in selinux_sctp_assoc_established(),
> > > as one UDP-type socket may have more than one asocs.
> > >
> > > Note that peer_secid in asoc will save the peer secid for this
> > > asoc connection, and peer_sid in sksec will just keep the peer
> > > secid for the latest connection. So the right use should be do
> > > peeloff for UDP-type socket if there will be multiple asocs in
> > > one socket, so that the peeloff socket has the right label for
> > > its asoc.
> >
> > Hm... this sounds like something we should also try to fix (if
> > possible). In access control we can't trust userspace to do the right
> > thing - receiving from multiple peers on one SOCK_SEQPACKET socket
> > shouldn't cause checking against the wrong peer_sid. But that can be
> > addressed separately. (And maybe it's even already accounted for
> > somehow - I didn't yet look at the code closely.)
> >
> > >
> > > Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> > > Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  security/selinux/hooks.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index f025fc00421b..793fdcbc68bd 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -5525,6 +5525,21 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
> > >         selinux_netlbl_sctp_sk_clone(sk, newsk);
> > >  }
> > >
> > > +static void selinux_sctp_assoc_established(struct sctp_association *asoc,
> > > +                                          struct sk_buff *skb)
> > > +{
> > > +       struct sk_security_struct *sksec = asoc->base.sk->sk_security;
> > > +       u16 family = asoc->base.sk->sk_family;
> > > +
> > > +       /* handle mapped IPv4 packets arriving via IPv6 sockets */
> > > +       if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
> > > +               family = PF_INET;
> > > +
> > > +       selinux_skb_peerlbl_sid(skb, family, &sksec->peer_sid);
> >
> > You could replace the above with
> > `selinux_inet_conn_established(asoc->base.sk, skb);` to reduce code
> > duplication.
> Hi Ondrej,
>
> will do, thanks!
>
> >
> > > +       asoc->secid = sksec->sid;
> > > +       asoc->peer_secid = sksec->peer_sid;
> > > +}
> > > +
> Now I'm thinking: 'peer_sid' should be correct here.
>
> BUT 'sid' is copied from its parent socket. Later when doing peel-off,
> asoc->secid will be set back to the peel-off socket's sksec->sid.

Hi,

I'm not sure I follow... When doing peel-off, security_sctp_sk_clone()
should be called, which sets the peel-off socket's sksec->sid to
asoc->secid, not the other way around. (Are we hitting the language
barrier here? :)

> Do you think this is okay? or should the peel-off socket have its own
> sksec->sid, which might be different from the parent socket's?
> (Note the socket's sid initially was set in selinux_socket_post_create())

I *think* in case of a client socket it is expected for the
peeloff-style child socket to just inherit the same sksec->sid. But
frankly I haven't been with SELinux and kernel development long enough
to understand the intricacies of SELinux's network connection handling
very well... Hopefully Paul/Richard/Stephen can give a more confident
answer/review here.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

