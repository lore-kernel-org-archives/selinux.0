Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B606C433DB
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 22:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FCE23383
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 22:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbhAMWKW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 17:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbhAMWKH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 17:10:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD16C061575
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 14:09:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h205so5063557lfd.5
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 14:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SZ7VpzMNvHxCOfZsu4N6A8128RLNwbnKKo5IRbcyUc=;
        b=p8rMd+ljwThlUmVGA6D2xYBwBKiyZX+c69wsnk4sS8z5Yk6Dh2K3smnUVw02Dv8tlQ
         pMHRK6EBGAjrHBvHsiASiW1omDNVG7SxRU2c3giI9z2bGL3XkTCinG1sFig6jz8wwwqP
         4ClkemeMbZfxpS5f51kIkxiXB/VCZs4JD1ux5ZN4SybsfyHcaRszLfgzWrBzOfOhopyy
         xMcEmrC0ycHbZgNZQIaUq4fJ6N27+6yy7vmmRnAJT+RW3SZiwdjbRUzC+jcDsG3Eyfny
         sQd7y4pXArANkr5W1qcyDDtbbrkdU9R7EaBVjDhX6vWvtMM2PVTtjiRf/kBZ996VfdVV
         10Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SZ7VpzMNvHxCOfZsu4N6A8128RLNwbnKKo5IRbcyUc=;
        b=fkThWxuyC5LgkTZ0urTpHzMQIr+F4rmT7LAPhqzQ1zQ1dWVeDzNHpTYJQ4QIo9X7jW
         ZnyQPjkFlLSUzzb81/qyGFvGOxO1uwfL2qPZFqj7k4XElh5bLsvCH4kvuEzVbOwUmcTS
         Ruq231RBXVaDdd/gIBSGydDufhJXgTv414TByf4RgMMV4OATGGCJGfyV2F7K//SwYwGD
         lsk4aMGEh7YqBJkXxC2S+yTgkFWGqrz23T9roInIJFa8Jw4+UntZlatYlpRV8NG84cvo
         +mL6KM+GLqxSDs957aYmYtLRsGD1gTYzLFVwr5J9bveDM5PB8DdqHnN2oGVGkUS+jWTo
         Z7Qg==
X-Gm-Message-State: AOAM5306IIQ0FJ0aaq2LH+c0Ce1PwvP9Dt0HReMmfuT/RHNLCWTvnPpT
        qbKj/+LKFHofe2OBajb17bw1H3pLWswxfxN0ZlU=
X-Google-Smtp-Source: ABdhPJyqUTRdg6sb8G3NlhYS6ltWjUI4XhB+mCo2cG4sL8IT59e+Jv2p/5vlJqks/Dppc8wqtG5yChUQB3CRMgQr5og=
X-Received: by 2002:a19:6b04:: with SMTP id d4mr1696773lfa.322.1610575765046;
 Wed, 13 Jan 2021 14:09:25 -0800 (PST)
MIME-Version: 1.0
References: <87wnwga4wm.fsf@redhat.com>
In-Reply-To: <87wnwga4wm.fsf@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 13 Jan 2021 17:09:13 -0500
Message-ID: <CAEjxPJ6jqHX+bSwLoKratsBD47_WNAoQ4OQQN9yWcMzTRoMbzA@mail.gmail.com>
Subject: Re: can't unmount /sys/fs/selinux
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 4:52 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hi,
>
> we have few tests which uses `umount /sys/fs/selinux` trick to check how
> userspace works in SELinux "disabled" environment. But it's not possible
> with the current master:
>
>     # umount /sys/fs/selinux
>     umount: /sys/fs/selinux: target is busy.
>
>     # lsof /sys/fs/selinux
>     COMMAND      PID     USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
>     systemd        1     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     systemd        1     root   55r   REG   0,21        0   19 /sys/fs/selinux/status
>     systemd-u    875     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     systemd-u    875     root    6r   REG   0,21        0   19 /sys/fs/selinux/status
>     dbus-brok   1116     dbus  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     dbus-brok   1116     dbus    5r   REG   0,21        0   19 /sys/fs/selinux/status
>     systemd-l   1134     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     systemd-l   1134     root    4r   REG   0,21        0   19 /sys/fs/selinux/status
>     systemd     1643     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     systemd     1643     root   28r   REG   0,21        0   19 /sys/fs/selinux/status
>     (sd-pam)    1645     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     ...
>     sshd      218874     root  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     sshd      218874     root    3r   REG   0,21        0   19 /sys/fs/selinux/status
>     sshd      218880 plautrba  mem    REG   0,21        0   19 /sys/fs/selinux/status
>     sshd      218880 plautrba    3r   REG   0,21        0   19 /sys/fs/selinux/status
>
> It seems to be caused by commit 05bdc03130d7 ("libselinux: use kernel
> status page by default") which replaced avc_netlink_open() in
> avc_init_internal() with selinux_status_open()
>
> In case of sshd process, /sys/fs/selinux/status seems to be mapped by
> selinux_check_access() which is called from pam_selinux and it's left
> open as there's no selinux_status_close() in selinux_check_access().
> The similar situations probably happen in systemd and dbus.
>
> So is it expected? Is it a bug? Do we need to change other components so
> that they would call selinux_status_close() when they use check access?

What if we just close the fd after mmap and not keep it open?  I don't
see any use of selinux_status_fd beyond assignment and closing.
Tearing down the mapping and re-creating it on every access check
would defeat the purpose.
