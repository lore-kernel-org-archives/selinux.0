Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7DAC43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 23:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A18214E0
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 23:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NqMVDD56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKLXOX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:14:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43664 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKLXOW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 18:14:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id q5so254663lfo.10
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2019 15:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3spwaKAP9luSwH87PztR61WxByqgTRoqOhUng92Z7yE=;
        b=NqMVDD56Tr7ayIuoSywCdi9pH96zvgUwI9e9FAIOM4S+rGbBsh9dOrM/P9ynI0xRI5
         DWrL/1NbLQubT5ibF/CnBXFXj0mTf3dAUJAzkn8tekyKKtiygIRqVxZXpd7SySRv9ghU
         z5ifN00mWlOvPoiznq3cdGw5hphYfJqfDMxzOZtPBUCl28HEcx8QVKq/C1Vv4GkzzKXL
         7dwQ2kp4RnFxnxuRDiJtHjWQOXsRVBVk5mWjWkDE7AK1A8ZnVJRXAepb9pH23JMHSh9h
         rR1XXson3Zy5jlrUbH5NycDYgre4uWkUjGl6XPDZS/rCQOkmMb3Hiz02eVwmS8Anip4v
         n/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3spwaKAP9luSwH87PztR61WxByqgTRoqOhUng92Z7yE=;
        b=YnVdjglvkcwb7KOmWbPI0HiZ05GAHGiQH9LpeHR6SENSNwiJOxYzKC2GYceqQUm9ya
         FlBKJOQNcUV9hMVvvUINmeGirTsEC2SR1kfPSVIC84usBZhxbGEZ+GBQPo2thcpZg23U
         RUFAh4zxLAT2uHZZaijsQu/EHYRe4GSIxGElWrmP/P/AemgLasSuYQFfEsVotoOVHZSU
         gTIWPo5DO4e15aUjRuZp0ODPqCShcS61ezvDz/gLahG/cBq/30+IOmsnITX1McixPXSt
         Df+grffw3EhvJEssrHYZLl09zLhK96IxwfyIg1gniyBDrvhM42IRnEiqyezQLfwVyL80
         UWNA==
X-Gm-Message-State: APjAAAWfHwidVPnkCOtSNpUdguEiAJyqjAd0X6Fj+vRMYUG5oKoVbngl
        stkjv7jJYfMBYuzT4bC7nLXyLsUCgS2EBrdrVA6ewJc=
X-Google-Smtp-Source: APXvYqwYvcQYmDSfP2bSy7bK63W7zdVhwz7mygxqzpL6Kj3/VhGVxSLBDaPvq6EniVxftWSnduz8PYGfbISN0KEncIo=
X-Received: by 2002:ac2:5967:: with SMTP id h7mr226011lfp.119.1573600458865;
 Tue, 12 Nov 2019 15:14:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_DdN4koR+9+5UvYSp8U0KGA8Gq_ND9qTdAu6b8yQYmy82A@mail.gmail.com>
 <069d698d-9067-fc90-e666-b35d919df2ee@tycho.nsa.gov> <c2dea4c1-d67b-d872-284f-acde6e9ba58a@tycho.nsa.gov>
In-Reply-To: <c2dea4c1-d67b-d872-284f-acde6e9ba58a@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Nov 2019 18:14:07 -0500
Message-ID: <CAHC9VhTp0CesJurTf3y8VbwnWTpVTTZJAYEs2Mun+F6MCjvUsQ@mail.gmail.com>
Subject: Re: How to see SELinux denials late at shutdown
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 12, 2019 at 11:49 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/12/19 11:40 AM, Stephen Smalley wrote:
> > On 11/12/19 8:08 AM, Christian G=C3=B6ttsche wrote:
> >> While trying to confine systemd-shutdown, I am unable to see any
> >> SELinux denials late at shutdown.
> >> I tested on Debian sid with systemd 242/243 and Linux 4.19.67-2/5.3.9-=
1.
> >> The command line is: `BOOT_IMAGE=3D/boot/vmlinuz-5.3.0-2-amd64
> >> root=3DUUID=3D0a22bd66-a082-4b76-b96b-ca5cff3ffdf6 ro security=3Dselin=
ux
> >> console=3DttyS0 console=3Dtty0 log_buf_len=3D1M printk.devkmsg=3Don`.
> >> When running poweroff or reboot, systemd-shutdown stalls but no denial
> >> is printed.
> >> With a script like [1] dmesg does not print any information.
> >> In permissive mode the system powers off/reboots, but no denials are
> >> printed.
> >> Trying to stop auditd/systemd-journald beforehand does not help.
> >>
> >> Does the kernel itself shuts down the ring buffer, or can systemd
> >> interfere somehow?
> >
> > systemd could be setting the console loglevel
> > (SYSLOG_ACTION_CONSOLE_LEVEL) or disabling console logging altogether
> > (SYSLOG_ACTION_CONSOLE_OFF).  Not sure why it would however.
> >
> > Android had a nice facility for capturing kernel log messages after a
> > reboot, originally via /proc/last_kmsg and later via
> > /sys/fs/pstore/console-ramoops, but I don't think the Linux distros
> > provide any equivalent.
>
> I've seen lossage of SELinux avc denials due to the printk or audit
> ratelimits in the past, FWIW, but you are supposed to then get a notice
> that there were lost records...

In this particular case I suppose it is also possible that the audit
records are stuck in the kernel audit queue and aren't fully flushed
before the system halts/reboots.

--=20
paul moore
www.paul-moore.com
