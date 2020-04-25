Return-Path: <SRS0=uu7d=6J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF38C55191
	for <selinux@archiver.kernel.org>; Sat, 25 Apr 2020 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2232071E
	for <selinux@archiver.kernel.org>; Sat, 25 Apr 2020 12:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsU1C/1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgDYMBK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDYMBK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Apr 2020 08:01:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549EC09B04D
        for <selinux@vger.kernel.org>; Sat, 25 Apr 2020 05:01:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so13098513qke.2
        for <selinux@vger.kernel.org>; Sat, 25 Apr 2020 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOf+YtIxqlA+vl8j/T3L4DQ0rhzMujQoBXYncPg9CwE=;
        b=fsU1C/1TekNM/J4lIICbn7Kod/+dJYtICtLmNIMHQi8uZ3ihHyXXbvI6ahzFmdFC7R
         ctcxjzLJc1gJXTOO6Addj4GHHY6243xGLeG4qhhraks/AyYXVBGwyYwqQ6/0Fy76oAPy
         j8tEjVUnJS2IWOP9JI9jECMPLMq70YN46O149ZuExFNDa96ks+UMmlGXvbWQDJa/XkwA
         Py+dguhLUro816U1CNT4nbK64R0kRqFDKK0MqlvGvtB/8t/R8xIm5m/Vn+bFy0ee3fNp
         YoP19YJiTLNShLVEC+jxna4mcJDnqag356cAckMLffr7eIavND68l7nKdPLjQ8nD6cpJ
         Ihaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOf+YtIxqlA+vl8j/T3L4DQ0rhzMujQoBXYncPg9CwE=;
        b=EdWyUyBTN/cxbVeknB+LLBM4BC2HNjFYDcxaDoifCRsMiUKBYYTGuNhq26QZzogr6w
         w/yGj5+1fv9ZhQuVDCYOpcxTeQlU0YGI+mD8gr70Ew4L20d/uqRWrRyjdlC7jnVtqS+d
         Kxeot//hCZ6LKF9uRBpS2rime6KMtt5HRyByRDrtZc87EgiJiY4ZHKp1MN/7MechhrKw
         50qt/n26thWL0lwQF/F7LHvDfhJl4Kl1nGlzORzBhWdEDWB8XqRQNDgs4fBCUSDa1s9b
         tbEmgxx2lEP4fWeRDMASe3A/NOOP7pUbsVJTFDhyMUJO78UT6z6mNoe2XphcbsQV+NX/
         VG3w==
X-Gm-Message-State: AGi0PuZ2fNRH84U4f6w0ZkvOErZDNR6LPOyQREoefhuKkNdGyodLVdxZ
        aF20jp8o724FJb2rxaG3axnHSXEWYPoooN8VuPCP8w==
X-Google-Smtp-Source: APiQypKCycAK1f+Of16hZKq/XjPeyzEyzN0WTmXPWU6IkkHeZxa+Yrd9GonvEuWpI1Pn+GH7RW9H3RU6dANkQ3nUN3c=
X-Received: by 2002:a05:620a:12b6:: with SMTP id x22mr6979328qki.8.1587816068633;
 Sat, 25 Apr 2020 05:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
 <CAHC9VhQs6eJpX4oMrhBiDap-HhEsBBgmYWEou=ZH60YiA__T7w@mail.gmail.com>
 <CACT4Y+b8HiV6KFuAPysZD=5hmyO4QisgxCKi4DHU3CfMPSP=yg@mail.gmail.com> <171b1244748.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <171b1244748.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 25 Apr 2020 14:00:57 +0200
Message-ID: <CACT4Y+b43uGr-44TVT9eTu_Lh=8CkKXJdSxz6tB9+BjRe9WF1A@mail.gmail.com>
Subject: Re: selinux_netlink_send changes program behavior
To:     Paul Moore <paul@paul-moore.com>
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

On Sat, Apr 25, 2020 at 1:42 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Fri, Apr 24, 2020 at 4:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>> Hi SELinux maintainers,
> >>>
> >>> We've hit a case where a developer wasn't able to reproduce a kernel
> >>> bug, it turned out to be a difference in behavior between SELinux and
> >>> non-SELinux kernels.
> >>> Condensed version: a program does sendmmsg on netlink socket with 2
> >>> mmsghdr's, first is completely empty/zeros, second contains some
> >>> actual payload. Without SELinux the first mmsghdr is treated as no-op
> >>> and the kernel processes the second one (triggers bug). However the
> >>> SELinux hook does:
> >>>
> >>> static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> >>> {
> >>> if (skb->len < NLMSG_HDRLEN) {
> >>>  err = -EINVAL;
> >>>  goto out;
> >>> }
> >>>
> >>> and fails processing on the first empty mmsghdr (does not happen
> >>> without SELinux).
> >>>
> >>> Is this difference in behavior intentional/acceptable/should be fixed?
> >>
> >> From a practical perspective, SELinux is always going to need to do a
> >> length check as it needs to peek into the netlink message header for
> >> the message type so it can map that to the associated SELinux
> >> permissions.  So in that sense, the behavior is intentional and
> >> desired; however from a bug-for-bug compatibility perspective ... not
> >> so much.
> >>
> >> Ultimately, my it's-Friday-and-it's-been-a-long-week-ending-in-a-long-day
> >> thought is that this was a buggy operation to begin with and the bug
> >> was just caught in different parts of the kernel, depending on how it
> >> was configured.  It may not be ideal, but I can think of worse things
> >> (and arguably SELinux is doing the Right Thing).
> >
> > +netlink maintainers for intended semantics of empty netlink messages
> >
> > If it's a bug, or intended behavior depends on the intended
> > behavior... which I assume is not documented anywhere officially.
>
> Your original email gave the impression that there was a big in the non-SELinux case; if that is not the case my response changes.


There is no bug... Well, there is a crash, but it is somewhere in the
routing subsystem and is caused by the contents of the second netlink
message. This is totally unrelated to this SELinux check and that
crash is totally reproducible with SELinux as well if we just don't
send the first empty message.
The crux is really a difference in behavior in SELinux and non-SELinux cases.



> > However, most of the netlink families use netlink_rcv_skb, which does:
> >
> > int netlink_rcv_skb(struct sk_buff *skb, int (*cb)(struct sk_buff *,
> >                           struct nlmsghdr *,
> >                           struct netlink_ext_ack *))
> > {
> >    ...
> >    while (skb->len >= nlmsg_total_size(0)) {
> >    ...
> >       skb_pull(skb, msglen);
> >    }
> >    return 0;
> > }
> >
> > 1. How intentional is this while loop logic vs sloppy error checking?
> > 2. netlink_rcv_skb seems to be able to handle 2+ messages in the same
> > skb, while selinux_netlink_send only checks the first one... so can I
> > skip SELinux checks by putting a malicious message after a permitted
> > one?..
>
>
>
