Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF114C433E6
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE20A22B2B
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbhANQZw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbhANQZw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 11:25:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBBCC0613C1
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 08:25:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o17so8869481lfg.4
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7pY4LEEioExlW4yWDhnYeiyl5pXvdolofN+0QDIPNk=;
        b=qwhoDb0Wfuf2iMA0lHD2EKrF3qedarEGyiB6BAHMptztXM86S38MKgQj/oPbWfms73
         vsjau+0nMg4lYXetOlofUAiscmzxqWt6HT2lTNdQRpQDar37YM83RODXmzsZlGdliilO
         +C3qlP2ylaY8bjWRPe/IdqHk5yIzD+29vcD1JjS78p2uPWjRdzrl2Zkvx1x3qPmaiYw5
         tdrsw9eObg4G7mCT5mueeX+vLj4aByun+cw5U03AIAsVO66FyA8u+D27oNU9y5Od1Air
         lNuteqN82D84gLSKVct86GhqpG37PSO9Go2hxfx1LrlkZtqCzAvhBvxeuBnEAf9HhdeX
         zfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7pY4LEEioExlW4yWDhnYeiyl5pXvdolofN+0QDIPNk=;
        b=rDyMmJz1nx7hLoivjWDyhjHlHNHyz2sYAqkWIJxW6M71CGFNcJ3DpOCOGMfe+aaQ8Q
         SKcr3xCgC/1V89k/DMA1hnMpaAAukklbMgIaMIDlIH6YWDMZz8Vi2n0S1XtnfEYt5ouP
         hpZHeUCa+VMGjEj5XBaMiwr3gmtBlAHtcowytwwMVnIeimql9MH1HAWhNPqIX+16ZyU0
         XigDIh7e9LrqMkbfFAJdTul54VqJRL7Jy6k7yrD/Pju028Gp1+XE1wPlb1unZ0BB0ieO
         OdO1aKKdvzjJMMUCrBrAraticQSVFRqt6G2HnMqbQSTj/gjLxGLe7XzvBZXsjv8Ts/T0
         XlLw==
X-Gm-Message-State: AOAM5339CAUbzufWr9tc5/UNISnG8Cd15xKvR2Pmx/5gCAPoc5NofVmj
        aNXojoVOMpn1KoUssOtUYn6BRwmsmfQGGFEZnwav9dOm
X-Google-Smtp-Source: ABdhPJwclETHxKzNFXDImTxMLvw2iioYERcm9/fmEtgqWeF4BLaFs4CVTwvQ9wjs2wG/2IeB3ccWjzVoC0jSAySh3iU=
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr3440362lfu.40.1610641509943;
 Thu, 14 Jan 2021 08:25:09 -0800 (PST)
MIME-Version: 1.0
References: <87wnwga4wm.fsf@redhat.com> <CAEjxPJ6jqHX+bSwLoKratsBD47_WNAoQ4OQQN9yWcMzTRoMbzA@mail.gmail.com>
 <87k0sga1jl.fsf@redhat.com> <87czy7a9a6.fsf@redhat.com>
In-Reply-To: <87czy7a9a6.fsf@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 Jan 2021 11:24:58 -0500
Message-ID: <CAEjxPJ4B7GG38b7umMQNXPhWnLFVZWFN8iFEwxv7g45YNDn3Bw@mail.gmail.com>
Subject: Re: can't unmount /sys/fs/selinux
To:     Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 9:22 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> >> On Wed, Jan 13, 2021 at 4:52 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> we have few tests which uses `umount /sys/fs/selinux` trick to check how
> >>> userspace works in SELinux "disabled" environment. But it's not possible
> >>> with the current master:
> >>>
> >>>     # umount /sys/fs/selinux
> >>>     umount: /sys/fs/selinux: target is busy.
> >>>
> >>>     # lsof /sys/fs/selinux
> >>>     COMMAND      PID     USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> >>>     systemd        1     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd        1     root   55r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd-u    875     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd-u    875     root    6r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>     dbus-brok   1116     dbus  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     dbus-brok   1116     dbus    5r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd-l   1134     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd-l   1134     root    4r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd     1643     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     systemd     1643     root   28r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>     (sd-pam)    1645     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     ...
> >>>     sshd      218874     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     sshd      218874     root    3r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>     sshd      218880 plautrba  mem    REG   0,21        0   19 /sys/fs/selinux/status
> >>>     sshd      218880 plautrba    3r   REG   0,21        0   19 /sys/fs/selinux/status
> >>>
> >>> It seems to be caused by commit 05bdc03130d7 ("libselinux: use kernel
> >>> status page by default") which replaced avc_netlink_open() in
> >>> avc_init_internal() with selinux_status_open()
> >>>
> >>> In case of sshd process, /sys/fs/selinux/status seems to be mapped by
> >>> selinux_check_access() which is called from pam_selinux and it's left
> >>> open as there's no selinux_status_close() in selinux_check_access().
> >>> The similar situations probably happen in systemd and dbus.
> >>>
> >>> So is it expected? Is it a bug? Do we need to change other components so
> >>> that they would call selinux_status_close() when they use check access?
> >>
> >> What if we just close the fd after mmap and not keep it open?  I don't
> >> see any use of selinux_status_fd beyond assignment and closing.
> >> Tearing down the mapping and re-creating it on every access check
> >> would defeat the purpose.
> >
> > Thanks for this hint! I've checked mmap(2) and it's there: After the
> > mmap() call has returned, the file descriptor, fd, can be closed
> > immediately without invalidating the mapping.
> >
> > I'll try it tomorrow.
>
> https://patchwork.kernel.org/project/selinux/patch/20210114133910.282686-1-plautrba@redhat.com/
>
> With this patch fd's are closed but the mapped memory is still there:
>
>     # umount /sys/fs/selinux
>     umount: /sys/fs/selinux: target is busy.
>
>     # lsof /sys/fs/selinux
>     COMMAND   PID            USER  FD   TYPE DEVICE SIZE/OFF NODE NAME
>     systemd     1            root mem    REG   0,21        0   19 /sys/fs/selinux/status
>     systemd-u 363            root mem    REG   0,21        0   19 /sys/fs/selinux/status
>     systemd-r 393 systemd-resolve mem    REG   0,21        0   19 /sys/fs/selinux/status
>     dbus-brok 432            dbus mem    REG   0,21        0   19 /sys/fs/selinux/status
>     ...
>
>
> For now we have a workaround for our tests - `umount -l /sys/fs/selinux` works.
>
> But we should document the side effect of selinux status page change in
> release notes if there's no better solution.

Is this a problem for clean shutdown/reboot as well or does that
already use lazy unmount?
Keeping the status page mapped is by design to avoid needing to
perform system calls each time to check enforcing status, policy
seqno, etc.
