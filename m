Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E0C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472822082E
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1HCo0MPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEXdz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:33:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36804 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXdy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 18:33:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so3962222edp.3
        for <selinux@vger.kernel.org>; Wed, 05 Feb 2020 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZbCIj//KDY7QnkbFNFKOTVIWMkHJYg7jRAMe9Z0yws=;
        b=1HCo0MPfP19UUUClOA1jhPUsQyq6ukC0FYCkiP1y24Dw3zLxba3uGVvBUX6bXw9rgb
         YSHN9a36ZQ1YjFZOgweDU+7gsNIRhQwW2kUEMs5EtWa5ecOcCq5qg2yPRbRa/GXxFKAW
         D4g9Fcx3I3isNW9UuCYFuWYOEK7TKeezR2AfghZkEXgFxsG0qT8xThmKM7DwDXTRDsfX
         k965Z4N6Y2bo6CfaCDke7fzqn9PKNxYJRdkMQi6hnyf2u30NL6+kwaiBkVhZ+89XPcT9
         +klh0Ct/JVeKPfMXmY4RATBTLnjenFAUqyUzLXDZWjNDQhWfG9S/Xlh8XtiRDDfxeh4F
         9QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZbCIj//KDY7QnkbFNFKOTVIWMkHJYg7jRAMe9Z0yws=;
        b=gSqzE0WM+8spczhMX5DcF2PLWhwlWzrP9v8xoyFgDkxldSZiniB/MqaKwDraFjh4Aw
         q8Ausizj+QXnNPAT/uE49ng68WSjH+IsXaYlYETLassF8kYw8refdUUteaQMn37C8iX0
         FZxaeuFcJUJJl6auH5O/nagXlpIgm6f6UMi+w2PNd3S3ur8LkQidn1q9Iq3BywiLLqbg
         de3a4GylNag031sZpUiF7fjxcCBfhuh7SGhQhYWrwUShHaL60bWYZxr17YC42tv2EOYH
         sxKJCanQ1MtaDFlH2sdJ9A0/EM3gVJg46UX1Ymsg6T1BHY6pwJYqR/plDhc+UJshAWBN
         8dbQ==
X-Gm-Message-State: APjAAAXJAEpeGRvCV7S99/LtcMTfOnqgraalx3y0PbeOlg1eY1Lahijc
        ZOL2CePR+noysUrCvN0rkSW0jKI6/Qy5q++E+Gkuh+fSqw==
X-Google-Smtp-Source: APXvYqyU2TlobWTEh/EYlEtFwNzKHKmGJdmsvfX5/DTMHcQR06Y6fPVxV6MKdMd/xQc5Xn3Xe2tyUNa0EMH9f9Rd6kE=
X-Received: by 2002:a50:fd15:: with SMTP id i21mr538005eds.12.1580945633152;
 Wed, 05 Feb 2020 15:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20200203085023.360612-1-omosnace@redhat.com>
In-Reply-To: <20200203085023.360612-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 18:33:42 -0500
Message-ID: <CAHC9VhSbmgw3fssW5ov8Hs740K8oT3v2ks5mTQWxpfBZ3BkN-w@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix sidtab string cache locking
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 3, 2020 at 3:50 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Avoiding taking a lock in an IRQ context is not enough to prevent
> deadlocks, as discovered by syzbot:
>
> ===
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 5.5.0-syzkaller #0 Not tainted
> -----------------------------------------------------
> syz-executor.0/8927 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> ffff888027c94098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> ffff888027c94098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
>
> and this task is already holding:
> ffffffff898639b0 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> ffffffff898639b0 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> which would create a new lock dependency:
>  (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
>
> but this new dependency connects a SOFTIRQ-irq-safe lock:
>  (&(&nf_conntrack_locks[i])->rlock){+.-.}
>
> [...]
>
> other info that might help us debug this:
>
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&s->cache_lock)->rlock);
>                                local_irq_disable();
>                                lock(&(&nf_conntrack_locks[i])->rlock);
>                                lock(&(&s->cache_lock)->rlock);
>   <Interrupt>
>     lock(&(&nf_conntrack_locks[i])->rlock);
>
>  *** DEADLOCK ***
> [...]
> ===
>
> Fix this by simply locking with irqsave/irqrestore and stop giving up on
> !in_task(). It makes the locking a bit slower, but it shouldn't make a
> big difference in real workloads. Under the scenario from [1] (only
> cache hits) it only increased the runtime overhead from the
> security_secid_to_secctx() function from ~2% to ~3% (it was ~5-65%
> before introducing the cache).
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259
>
> Fixes: d97bd23c2d7d ("selinux: cache the SID -> context string translation")
> Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/sidtab.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Merged into selinux/stable-5.6; I'll send this up to Linus next week.

-- 
paul moore
www.paul-moore.com
