Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB2FC83002
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 01:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4ABD206D6
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 01:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mtPP7ztM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgD1ByL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1ByL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 21:54:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35ADC03C1A9
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 18:54:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so15895746ejx.5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 18:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5tYdGjSsZlu5Ne+dsC8P4f1ZDRmzcjVVvV9xH9KECg=;
        b=mtPP7ztM8aHi21wYH8FHLeYnqI6H4zToRQjs46GgQDe0r3XY70D438jCjjf8kovPvE
         d24Bd6f9zUDF6ucZTLQNM4FXghTJB85YvfXwleSdI9xBIrV9fyezSxqtgzw6IrSAg/6g
         w/2xxHpV6y/40Kh3b2CwHgkWr7VxcJXKHlHyB51J2DWkK+MFlr9xkcFGlVKITCItQ75Y
         x35BwPT/7jNT2fOJVjUN/9dRmSnFmAsoeNNxFxke7Xibs1WHyutb4WzQWRRU15jYCNk5
         YgC/+Bl5PEUfskXms5dSe5gtVx14hIo5c5zZx8uH9gCtaCZ41i8b/iCMF7O8RINkF5if
         Xo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5tYdGjSsZlu5Ne+dsC8P4f1ZDRmzcjVVvV9xH9KECg=;
        b=Txetj6xjb7qmuE78qM3F6old/0TEjN5qGZgjSTcwmbBaW4zA2cd2+W6FSbwdjUggOi
         GhfSY9xlMrP9JO+O6H/y7PQAyxzGiSBAOIV7E3dgmZLz1/vQ8rTBxK/FOjkM4nIrfBYM
         fvI5WVei1VX98NpsMW9T4EWUkAc50saw8WGkfj1yDjX3egUqVGGYwjYsXqZhBCmoTsJY
         0SkmAJGIxs7WAYFjh02a+yvKQV2F0OJZvoL08Lgg1Ja5+wMkXTr88FQsfFbrqHIno0jW
         B49neHFYSRW3VYVXnx17P/siexW7bclSx3eVRyqnbn2IvD1PDWytL0wUR3kkjMHtkBy0
         Lo5A==
X-Gm-Message-State: AGi0PuZqZiHs3HvKOXW86BXbmBHaZmfXrdBE++OePYSvMr5FnHHIbxjO
        LiJAxzEo267POGI6EczJUsh7BNa+lkjjgwyfNAv4AFA=
X-Google-Smtp-Source: APiQypKo+7RBQ8YXfiTLN9hjP7+5SV5BdEn0N9W2Mh9Ys+ZswbMHotR74NT4i1pnxP61KnKPrrcWQZJyUzimj1vKfuk=
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr23076033ejb.271.1588038849206;
 Mon, 27 Apr 2020 18:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
 <CAHC9VhQs6eJpX4oMrhBiDap-HhEsBBgmYWEou=ZH60YiA__T7w@mail.gmail.com>
 <CACT4Y+b8HiV6KFuAPysZD=5hmyO4QisgxCKi4DHU3CfMPSP=yg@mail.gmail.com>
 <171b1244748.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CACT4Y+b43uGr-44TVT9eTu_Lh=8CkKXJdSxz6tB9+BjRe9WF1A@mail.gmail.com>
In-Reply-To: <CACT4Y+b43uGr-44TVT9eTu_Lh=8CkKXJdSxz6tB9+BjRe9WF1A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Apr 2020 21:53:57 -0400
Message-ID: <CAHC9VhR9CN5RzuUonhhFs+L07jt7DWJbDYicf6NEu0z05MpA4g@mail.gmail.com>
Subject: Re: selinux_netlink_send changes program behavior
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Miller <davem@davemloft.net>, kuba@kernel.org,
        netdev <netdev@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 25, 2020 at 8:01 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Sat, Apr 25, 2020 at 1:42 PM Paul Moore <paul@paul-moore.com> wrote:
> > >> On Fri, Apr 24, 2020 at 4:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >>> Hi SELinux maintainers,
> > >>>
> > >>> We've hit a case where a developer wasn't able to reproduce a kernel
> > >>> bug, it turned out to be a difference in behavior between SELinux and
> > >>> non-SELinux kernels.
> > >>> Condensed version: a program does sendmmsg on netlink socket with 2
> > >>> mmsghdr's, first is completely empty/zeros, second contains some
> > >>> actual payload. Without SELinux the first mmsghdr is treated as no-op
> > >>> and the kernel processes the second one (triggers bug). However the
> > >>> SELinux hook does:
> > >>>
> > >>> static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> > >>> {
> > >>> if (skb->len < NLMSG_HDRLEN) {
> > >>>  err = -EINVAL;
> > >>>  goto out;
> > >>> }
> > >>>
> > >>> and fails processing on the first empty mmsghdr (does not happen
> > >>> without SELinux).
> > >>>
> > >>> Is this difference in behavior intentional/acceptable/should be fixed?
> > >>
> > >> From a practical perspective, SELinux is always going to need to do a
> > >> length check as it needs to peek into the netlink message header for
> > >> the message type so it can map that to the associated SELinux
> > >> permissions.  So in that sense, the behavior is intentional and
> > >> desired; however from a bug-for-bug compatibility perspective ... not
> > >> so much.
> > >>
> > >> Ultimately, my it's-Friday-and-it's-been-a-long-week-ending-in-a-long-day
> > >> thought is that this was a buggy operation to begin with and the bug
> > >> was just caught in different parts of the kernel, depending on how it
> > >> was configured.  It may not be ideal, but I can think of worse things
> > >> (and arguably SELinux is doing the Right Thing).
> > >
> > > +netlink maintainers for intended semantics of empty netlink messages
> > >
> > > If it's a bug, or intended behavior depends on the intended
> > > behavior... which I assume is not documented anywhere officially.
> >
> > Your original email gave the impression that there was a big in the non-SELinux case; if that is not the case my response changes.
>
>
> There is no bug... Well, there is a crash, but it is somewhere in the
> routing subsystem and is caused by the contents of the second netlink
> message. This is totally unrelated to this SELinux check and that
> crash is totally reproducible with SELinux as well if we just don't
> send the first empty message.
> The crux is really a difference in behavior in SELinux and non-SELinux cases.

We're taking a closer look from the SELinux side of things.

-- 
paul moore
www.paul-moore.com
