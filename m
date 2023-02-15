Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C47C636D4
	for <selinux@archiver.kernel.org>; Wed, 15 Feb 2023 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBOPHw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBOPHv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Feb 2023 10:07:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB3572A7
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 07:07:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d8-20020a17090ad98800b002344fa17c8bso2151672pjv.5
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqtyIRfQTq/kqrgSknzRxD9WhM8Ccllf4k+BYRnOjes=;
        b=HGQ5G1CKyzb8z3Y61Q1EslaCeaqiiE1NofIP5Xd528rZf6EhHHaF5IDBzUVuv5CG/l
         J9EZnWZR5fDEhGSQMY5Ey85TNZfEQg2OAM+tE8iHhZR0Bw7TmE2fCQp6h9Q4Xrq7xeDB
         xAU5yA5dNiCFvNrdSduOj7u2/YoMAL54BbfqK99hMgXuIqFUCp+oN82vYbF5ZYBCZ7Vr
         Jp4ZDyLxin4hth5oaO57wlW6wLUF3CkIqhut9/uj9Uw5bzF7nHikGENVDjdxoyxDiu0K
         YmbH6NzFgL0DirLbtltLL4vvvfCWRncWV82Ef9vVlCyhqthZXRsNSS6mp64tfZQYyJNQ
         0bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqtyIRfQTq/kqrgSknzRxD9WhM8Ccllf4k+BYRnOjes=;
        b=oMrFhTNGckNIN7Cz7CJeX5EMDFMSgJCKeZ1RowByvuJaD39lvGt4CLeV3dvroq9LPg
         QOErVvCAyZxczukmXnXf/bNtrFnfnZv1haUY4iNKtm00ejyc1PG2slyTDty70uzcBn5U
         5RBrkFZZpor66BkMQWws758tzdJPZZidKItn2rvJFjlkIOHGeucsFb07ybq5Ud/NGvCX
         fJ+H+EZOy38PdyjgFi3BItaIOGUx4qPS1dTZ8PmWvuWYal/HkjuBKTfeCxm1nGzW1For
         YeXIQFRTxSblxlWC0wQPjEhXBcNqNVHxtLBZQ2FrPJexF+48lJDuTNh3CybFHgZfFXFB
         xsoA==
X-Gm-Message-State: AO0yUKU1QnRDI6U9WGjwaanh89EEauVgmf8lGfOXzF3GEWAvhfjBPH4b
        FJVb/EPOZ3LQsJ+Q5BtOdoFQNrrrayhMqKbBZqG4
X-Google-Smtp-Source: AK7set/zsFXdpXknWj1KhezTLNe5lWtBKcUdZEL2UxIBVEmLI1CoWnA9e09LynodiEW8TzxDsEFXU7VNP4cbzJE6Vu4=
X-Received: by 2002:a17:90a:c783:b0:233:c521:271f with SMTP id
 gn3-20020a17090ac78300b00233c521271fmr794468pjb.139.1676473664413; Wed, 15
 Feb 2023 07:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20230215141709.305399-1-omosnace@redhat.com> <CAEjxPJ7+s-w37GsKesL5SVd4mPctxgrrf1yW=BBjdFghzbtmKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7+s-w37GsKesL5SVd4mPctxgrrf1yW=BBjdFghzbtmKA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Feb 2023 10:07:33 -0500
Message-ID: <CAHC9VhSoPkUK+YBkpawHNP60PSKHKLYDzRiHdMkTVeJFbFSGxw@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow to opt-out from skipping kernel sockets in sock_has_perm()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 15, 2023 at 9:30 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Feb 15, 2023 at 9:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > There is currently a very suspicious condition in sock_has_perm() that
> > basically skips any permission checking in sock_has_perm() if the target
> > socket is labeled with SECINITSID_KERNEL. This seems bad for several
> > reasons:
> > 1. If a user-space process somehow gets its hands on such a socket, it
> >    will be able to don any socket operation on it without any SELinux
> >    restriction, even if it is not allowed to do such operations by the
> >    policy.
> > 2. The exception is inconsistent, since one can e.g. write to a stream
> >    socket not only via send(2)/sendto(2)/..., but also via write(2),
> >    which doesn't go through sock_has_perm() and isn't subject to the
> >    SECINITSID_KERNEL exception.
> > 3. The exception also allows operations on sockets that were created
> >    before the SELinux policy was loaded (even by user space), since
> >    these will always inherit the SECINITSID_KERNEL label.
> >
> > Additionally, it's unclear what is the rationale behind this exception.
> > For sockets created by the kernel that are expected to be passed to
> > user space, it seems better to let them undergo normal access checks to
> > avoid misuse. A possible rationale is to skip checking on operations on
> > sockets created with kern=1 passed to __sock_create(), which can happen
> > under user-space credentials even thogh executed internally by the
> > kernel - notice that such sockets are always labeled with
> > SECINITSID_KERNEL. However, the operations on these sockets already
> > normally bypass LSM checks entirely, so arguably this not necessary. On
> > the contrary, it's better if actual user-space operations on these
> > sockets go through SELinux checks, since there may be a possibility that
> > such a socket accidentally leaks into user space and we definitely want
> > SELinux to detect that and prevent privilege escalation.
> >
> > Since removing this condition could lead to regressions (notably due to
> > bullet point (3.) above), add a new policy capability that allows the
> > policy to opt-out from the condition. This allows policy writers or
> > distributors to test for impact, add any missing rules, and then enable
> > the capability.
> >
> > I tested a kernel with the condition removed on my Fedora workstation
> > and noted only one new denial, related to a user-space socket created by
> > systemd-journald before the policy is loaded, which is then continued to
> > be used by systemd-journald while the system is running.
> >
> > Also selinux-testsuite is passing without new denials when the check is
> > removed.
>
> I'll have to dig a bit in history to fully recover the original
> motivation/background but IIRC, this had to do with kernel-internal
> sockets created and used by the kernel on behalf of userspace.  For
> example, sockets associated with NFS mounting and subsequent RPC. In
> these cases, we don't necessarily want to allow the userspace process
> to directly create/use such sockets and from the userspace
> perspective, it is just acting on NFS files and not performing any
> socket I/O. Open to doing it in a better way, or finding out that it
> is no longer necessary.

I know that some network filesystems and netlink use kernel sockets
for their in-kernel endpoints.  Looking quickly at the code I see
several other potential candidates include the Plan 9 filesystem and
RDS.

I'm not opposed to removing the concept of a kernel socket, or
improving the consistency of how we enforce policy with respect to
kernel sockets, but I'm going to need to see a lot more justification
and testing than booting a system and running the test suite.

-- 
paul-moore.com
