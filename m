Return-Path: <SRS0=uu7d=6J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04615C55186
	for <selinux@archiver.kernel.org>; Sat, 25 Apr 2020 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF7620857
	for <selinux@archiver.kernel.org>; Sat, 25 Apr 2020 05:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbhLhZvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDYFPG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgDYFPF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Apr 2020 01:15:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9DEC09B04A
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2020 22:15:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so12598860qke.2
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2020 22:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1SBatyiXpIiTu8qbFEdAJrtrObabCrqo/oadnwsGtc=;
        b=rbhLhZvQDnG6p+e0PJwLpEu/dK/fw/igKekR9oZcCnflWf7m0TDjvkmh2zlY2Jv+5j
         w17JME6X4TKTpcDvBRLmVs49deqkl3eJyKh1L7vRMmxnfdsOYENY7JF9Whdd3EV1sXlw
         c6glcoi7MT1uFTPCvpl9PN9cZ4LDTrB4oVbz/1sOgiOUHLE8sWHINGMxicPcLr2uMAR6
         O2Z2F96Hglf1mJT3R+FvM3jHj0K3wNzZ+0skd/nSM8FWXhmOAOPvELMGo1vMwGBlSbz+
         4EDDdd0s96V29n+ylk1YxweDQAJG1IJaXvpTu+NWrxKzLbWNk3R9kdM3yD7wZ2xjOvNS
         ASeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1SBatyiXpIiTu8qbFEdAJrtrObabCrqo/oadnwsGtc=;
        b=EK1XMBRKLHXr3wSlyUzo112yTPkiOXNZgv0SpBRXblJ0qnFzNJ1az7Z8IYgi93PzBk
         jG1DIKc41mOR6Lfj5EiYQ0q/IXDoTTB3ERklSfQ+qFl/ZvRLq+MH2v3pyRJfIjvaTq93
         j23OO4RKMnIzmdOswUsPpMsUXczvB5cMDh08qP7wSSQPn/dBrpwPhWojLFvRoermoE8m
         hiDyhyha0VwpV/SUgM1jEACL7VWX2UqMEXlIe3KHZrEUiIhd40f5kBQetBFwD4arzPdH
         P3aAWw0H943h0gxOXFwW+gTFgI2iAu9aAG+0BZ5lMy/YpJLv8EVrn7X3U36mS7SYgGUw
         ZYpw==
X-Gm-Message-State: AGi0Pubh2N/oMela/XI1ZPX/xLXPYRf9KGn9PdNYb1W0SvMUlP4K0oT7
        ov6wjU39P8GpFnEAN3VxM1kpbhPZHzEv6NEU/0T/vA==
X-Google-Smtp-Source: APiQypKWjPa+EY2ioHZfTJG/+Df1shHqevoVywrRu+bXUnHcbJQlizj6CkbA7d5bq/V5+oeDZk48ITG0Le0/PUrjfNE=
X-Received: by 2002:a05:620a:1362:: with SMTP id d2mr12003772qkl.256.1587791704265;
 Fri, 24 Apr 2020 22:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
 <CAHC9VhQs6eJpX4oMrhBiDap-HhEsBBgmYWEou=ZH60YiA__T7w@mail.gmail.com>
In-Reply-To: <CAHC9VhQs6eJpX4oMrhBiDap-HhEsBBgmYWEou=ZH60YiA__T7w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 25 Apr 2020 07:14:52 +0200
Message-ID: <CACT4Y+b8HiV6KFuAPysZD=5hmyO4QisgxCKi4DHU3CfMPSP=yg@mail.gmail.com>
Subject: Re: selinux_netlink_send changes program behavior
To:     Paul Moore <paul@paul-moore.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        netdev <netdev@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 24, 2020 at 11:51 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Apr 24, 2020 at 4:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > Hi SELinux maintainers,
> >
> > We've hit a case where a developer wasn't able to reproduce a kernel
> > bug, it turned out to be a difference in behavior between SELinux and
> > non-SELinux kernels.
> > Condensed version: a program does sendmmsg on netlink socket with 2
> > mmsghdr's, first is completely empty/zeros, second contains some
> > actual payload. Without SELinux the first mmsghdr is treated as no-op
> > and the kernel processes the second one (triggers bug). However the
> > SELinux hook does:
> >
> > static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> > {
> >     if (skb->len < NLMSG_HDRLEN) {
> >         err = -EINVAL;
> >         goto out;
> >     }
> >
> > and fails processing on the first empty mmsghdr (does not happen
> > without SELinux).
> >
> > Is this difference in behavior intentional/acceptable/should be fixed?
>
> From a practical perspective, SELinux is always going to need to do a
> length check as it needs to peek into the netlink message header for
> the message type so it can map that to the associated SELinux
> permissions.  So in that sense, the behavior is intentional and
> desired; however from a bug-for-bug compatibility perspective ... not
> so much.
>
> Ultimately, my it's-Friday-and-it's-been-a-long-week-ending-in-a-long-day
> thought is that this was a buggy operation to begin with and the bug
> was just caught in different parts of the kernel, depending on how it
> was configured.  It may not be ideal, but I can think of worse things
> (and arguably SELinux is doing the Right Thing).

+netlink maintainers for intended semantics of empty netlink messages

If it's a bug, or intended behavior depends on the intended
behavior... which I assume is not documented anywhere officially.
However, most of the netlink families use netlink_rcv_skb, which does:

int netlink_rcv_skb(struct sk_buff *skb, int (*cb)(struct sk_buff *,
                           struct nlmsghdr *,
                           struct netlink_ext_ack *))
{
    ...
    while (skb->len >= nlmsg_total_size(0)) {
    ...
       skb_pull(skb, msglen);
    }
    return 0;
}

1. How intentional is this while loop logic vs sloppy error checking?
2. netlink_rcv_skb seems to be able to handle 2+ messages in the same
skb, while selinux_netlink_send only checks the first one... so can I
skip SELinux checks by putting a malicious message after a permitted
one?..
