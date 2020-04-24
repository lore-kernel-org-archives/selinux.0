Return-Path: <SRS0=CFpO=6I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4349FC55186
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23ADC216FD
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 21:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="D1hEvZmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDXVv4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgDXVv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Apr 2020 17:51:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A26C09B04A
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2020 14:51:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f12so8471031edn.12
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2020 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQNey5J4m05taFWia4GD1NrRrq+YSdJb5hG7zAcllAA=;
        b=D1hEvZmEJ/MQA6Qze+6lehHqnQctIkcGh44n20m+tUpuRwndmDJ7PmZ9GbIzK+QO+X
         OH+W44KItPKhT5yezZvJwxSqBNhW4TQ1eIWrrLt58meBviIJ38g91QOdkrkMTVEkOUr/
         J4pcY2AkURqqGi3kYaHwuqyxoOZFA5I/iCeaCHUYcK8wNBQ/idjUBrfRyhocOq5hFgp+
         Nzk1m167MLSQRaax7FX5LvHk3BpWVWLLadAaUuD0XDIlBW73c7J9z1ldALeKmoeZQO26
         XG0Onofzngx5u60znXIsm7PWr7O3rmwi9nICCcr9FV81TKHL1VdcNG1v940lgu4I98mh
         gNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQNey5J4m05taFWia4GD1NrRrq+YSdJb5hG7zAcllAA=;
        b=O9H27FNAxYe9TGtBto9S0WXnKy0zdt5CQRsYFFuwsBaOykQhcHaVdFA5deE2ybNEm7
         nJa3GmJzHcu/PBQVTlQ0pDxAbzdDQJa+FR3iQOQWArD5d3E+5+gZAn4Ki9m3oDAZ5BLs
         FxR4v7aldmPadRI6+MFQv3hqq3Oep/5ciLdjyxHsaIP6rYmeIoxgcPra8WGyEMppe+CQ
         E2ne2ND4lrP02ht8P5IIruaMcO7sm9LKPqCVRu7J+OY0bfR4OXjdrQzGYqRwjUJ+MImN
         WdJ9d493O7kKsBfi7JUyYMnI+mQbMz/s3LuN1N7iAemMFzbx2eCOou/EuK1+El9V4sIR
         iGKQ==
X-Gm-Message-State: AGi0Pua0Ghn08qNLxSihogwhJb6oWxvtR7YXpuC9TjfJq788vEmKC0LA
        gr6RRH5yOtGAJ5fFAH7rTgIwWtz7dxVl+jollfnYumw=
X-Google-Smtp-Source: APiQypLRHoOQqlS+eTiXjiKNm2Vnp4dQTSNZByKUDEO/mfLCT00jY8KrZIOPwayS/VFghWwtEWH+81952BYl3oY4skI=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr8787931edj.196.1587765114174;
 Fri, 24 Apr 2020 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
In-Reply-To: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Apr 2020 17:51:42 -0400
Message-ID: <CAHC9VhQs6eJpX4oMrhBiDap-HhEsBBgmYWEou=ZH60YiA__T7w@mail.gmail.com>
Subject: Re: selinux_netlink_send changes program behavior
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Fri, Apr 24, 2020 at 4:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> Hi SELinux maintainers,
>
> We've hit a case where a developer wasn't able to reproduce a kernel
> bug, it turned out to be a difference in behavior between SELinux and
> non-SELinux kernels.
> Condensed version: a program does sendmmsg on netlink socket with 2
> mmsghdr's, first is completely empty/zeros, second contains some
> actual payload. Without SELinux the first mmsghdr is treated as no-op
> and the kernel processes the second one (triggers bug). However the
> SELinux hook does:
>
> static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> {
>     if (skb->len < NLMSG_HDRLEN) {
>         err = -EINVAL;
>         goto out;
>     }
>
> and fails processing on the first empty mmsghdr (does not happen
> without SELinux).
>
> Is this difference in behavior intentional/acceptable/should be fixed?

From a practical perspective, SELinux is always going to need to do a
length check as it needs to peek into the netlink message header for
the message type so it can map that to the associated SELinux
permissions.  So in that sense, the behavior is intentional and
desired; however from a bug-for-bug compatibility perspective ... not
so much.

Ultimately, my it's-Friday-and-it's-been-a-long-week-ending-in-a-long-day
thought is that this was a buggy operation to begin with and the bug
was just caught in different parts of the kernel, depending on how it
was configured.  It may not be ideal, but I can think of worse things
(and arguably SELinux is doing the Right Thing).

-- 
paul moore
www.paul-moore.com
