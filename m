Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F40AC3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E42166E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ4B6Vtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCDOpA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:45:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40593 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 09:44:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id x19so2219330otp.7
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 06:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oA2YmGgep6iRrNlMPZ276Vz/YoW1y7Rn96R3KVNUXE=;
        b=JQ4B6VtpCkHCkFvU44/Q2QtKMYhcjW8wj0yPyAOEUK80l8RxeY/SxaYB/KRc4FVsQQ
         8hNg7KRFHH6s8HCR6ow+zxv6Eg1Qz2AYi8gZizInPe3pyKOLD7j2Inn+N3kPA0tJkoNF
         Jki5R72dyTiaQZQGLWVf+OQ79XvOndbwm/BakJIBXhGKT6FQlTrg7MIMPRV8slANHmTR
         wXupH5/YoIf0ivhE2SQA6Gko4w+2jQ57ocQhlPf1RVRrTGbdsFjp/ciToVxauOnWf/9j
         d26Z/nsIJpQcn9P8Hk588vZnsZPTw31HUO7awDOAaP6ZuZROdF7Vdszr/vLm1pAifpGU
         JuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oA2YmGgep6iRrNlMPZ276Vz/YoW1y7Rn96R3KVNUXE=;
        b=GTVlcx0h/SdNDTFup7TbIUSY/vkUkjjOQNAJx9h6ZgGwvTFc7YVbRQyGl7FD4Ecs43
         qkWP3qhOUYlnu4mCNqdzdpPVN6AH8W4Epk0lRCjg2O1KfKVbf+ZHrTTg+3pzIQl2G8Wm
         giSwTV/T8uR4ckhfdlCDKqXQJ9JZlsDkejggtwVtwyjCBHO2crJ8whGefSnHN/uuDKRK
         mpXv/QTEW00v5CrKs2YiBZjZ84a2glNhiPPbgWyJ+vX+3rz4ifCn9VeIUsrDn30zT+uS
         JSb42PtJqayUIzsVFxuFkbUwJ0bWxBAeKC/cpUKL4yx/rxbYeFWdKMAZyRWWhY9R1U1D
         kzPg==
X-Gm-Message-State: ANhLgQ1WoBoNGXRjjejPddZ//DfbGcu5tkH8X5Nr4loz3vk9cf8cAcqc
        7mmrcBgiq/nmxxBHR2QrTojGI/8uU6Az2KQJM4E=
X-Google-Smtp-Source: ADFU+vsvzgODTZOck6F4ctOUxgzgN6u4x88zNnDMwkF11bn8ZDE/q9v8Cr0wWSggVMEzU7LktbjqSTRAtk0/cvzGkC8=
X-Received: by 2002:a9d:6289:: with SMTP id x9mr2635078otk.340.1583333098778;
 Wed, 04 Mar 2020 06:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20200304072940.GA1026144@brutus.lan> <20200304074251.GA1032355@brutus.lan>
 <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com> <20200304143650.GB1032355@brutus.lan>
In-Reply-To: <20200304143650.GB1032355@brutus.lan>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 09:46:10 -0500
Message-ID: <CAEjxPJ4OPGWnc1uPDmqSuFnbFhzGYxenSyZ7WmxtnJ3Y2BdAzQ@mail.gmail.com>
Subject: Re: strange pam selinux issue
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 9:36 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> On Wed, Mar 04, 2020 at 09:22:42AM -0500, Stephen Smalley wrote:
> > Are you using libselinux with or without the commit to stop using
> > security_compute_user()?
> > If still using security_compute_user(), what does compute_user
> > sys.id:sys.role:sys.isid:s0 wheel.id display?
> > If you don't have compute_user (it is in libselinux/utils but not sure
> > Fedora packages it), you can also just
> > strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > and see what it read back from /sys/fs/selinux/user.
>
> Thanks, it does not even seems to read /etc/selinux/dssp3-mcs/contexts/users/wheel.id...
> I am not if my libselinux has or has not security_compute_user():
>
> # rpm -qa libselinux
> libselinux-3.0-3.fc32.x86_64
>
> openat(AT_FDCWD, "/sys/fs/selinux/user", O_RDWR|O_CLOEXEC) = 3
> write(3, "sys.id:sys.role:sys.isid:s0 wheel.id", 36) = -1 ERANGE (Numerical result out of range)

This shows that your libselinux is still calling
security_compute_user() from get_ordered_context_list().
In this case, because the source context is allowed to transition to
many other contexts, the result returned via
/sys/fs/selinux/user would exceed the maximum size supported by the
kernel interface (one page of contexts),
and therefore it fails.  Then get_ordered_context_list() falls back to
the failsafe_context.

If you update to libselinux git, you will stop using
security_compute_user() and hence /sys/fs/selinux/user entirely.
