Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CEC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 06:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B518A64E66
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 06:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBIGxf convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Tue, 9 Feb 2021 01:53:35 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:56878 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBIGxP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Feb 2021 01:53:15 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1338256486C;
        Tue,  9 Feb 2021 07:52:28 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id y199so16382128oia.4;
        Mon, 08 Feb 2021 22:52:28 -0800 (PST)
X-Gm-Message-State: AOAM530kKkxucWQyVLNGhwNoF8vLlRmlTIvGwvoVFSlTHVXvl6l2FsBR
        xQcAAVr1JJwpVqT4sLF848rYtuFVgLwjfDXNpIE=
X-Google-Smtp-Source: ABdhPJx8AO8l9CO2Qzs97U0gimjdtamIW1c8zjB5I4XoMM0ZOT6QRtBxaKNuyPVCQFRnEuhU4e7HHVXvrmLRSxHt/e4=
X-Received: by 2002:a05:6808:918:: with SMTP id w24mr1624293oih.20.1612853546989;
 Mon, 08 Feb 2021 22:52:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=nKqT7mmE73r1K3YjBak=OmPACmDi5ccX=SzKhT9=vJ-g@mail.gmail.com>
 <30320add-03dd-202c-caf4-bf947a7c2bdf@schaufler-ca.com>
In-Reply-To: <30320add-03dd-202c-caf4-bf947a7c2bdf@schaufler-ca.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 9 Feb 2021 07:52:15 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nWJisw2RRW2AvFgpYKQK_PghudeBqiTQXNfedS2idP-Q@mail.gmail.com>
Message-ID: <CAJfZ7=nWJisw2RRW2AvFgpYKQK_PghudeBqiTQXNfedS2idP-Q@mail.gmail.com>
Subject: Re: Recommended value in CONFIG_LSM option on SELinux system?
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb  9 07:52:28 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 8, 2021 at 10:38 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/8/2021 12:35 PM, Nicolas Iooss wrote:
> > Hello,
> >
> > Recently there was a bug in Arch Linux where SELinux was no longer
> > enabled after booting [1], because the default kernel configuration
> > changed recently [2]:
> >
> > -CONFIG_LSM="lockdown,yama"
> > +CONFIG_LSM="lockdown,yama,bpf"
>
> Neither of these settings will enable SELinux by default.
>
> > By doing so, setting "security=selinux" on the kernel command line
> > seemed to break the system, because reading /proc/$PID/attr/current
> > resulted in "Invalid argument" errors.
>
> Is this in addition to an "lsm=" specification on the command line?

My description of the issue was not very clear, my apologies. Here is
another tentative.

For some years, Arch Linux developers have been compiling their
official kernel (https://archlinux.org/packages/core/x86_64/linux/ ;
https://github.com/archlinux/svntogit-packages/tree/packages/linux/trunk)
with CONFIG_SECURITY_SELINUX=y even though SELinux was disabled by
default. In order to use SELinux, users were required to install some
packages (such as systemd with SELinux support) and to add "selinux=1
security=selinux" to their kernel command line. Last week, the
official Arch Linux kernel was updated to use
CONFIG_LSM="lockdown,yama,bpf". Booting a system with this kernel and
"selinux=1 security=selinux" was broken (D-Bus refused to start, as
well as all network services, because systemd failed to get some
important SELinux contexts through /proc/$PID/attr/... files). But
using "selinux=1 lsm=selinux,lockdown,yama,bpf" fixed this issue
(before, there was no lsm= command line).

> > Replacing "security=selinux"
> > with "lsm=selinux,lockdown,yama,bpf" fixed the issue and everything is
> > now fine, but now I am wondering: how should CONFIG_LSM (and option
> > "lsm" on the kernel command line) be set, on a system which is using
> > SELinux?
>
> CONFIG_SECURITY_SELINUX=y
> CONFIG_DEFAULT_SECURITY_SELINUX=y
> CONFIG_LSM="lockdown,yama,selinux"
>
> > Such information is lacking from the documentation [3] [4]. Therefore
> > I took a look at Fedora [5] and RHEL [6]:
> >
> > * Fedora uses CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor",
> > which was the default value until Linux 5.4 [7].
> > * RHEL uses CONFIG_LSM="yama,integrity,selinux".
> >
> > It seems to be strange to have an "outdated" configuration value in
> > the configuration file, but this could be fine if the new modules are
> > not expected to be used without the kernel being booted with a
> > "lsm=..." option.
>
> Keeping the "outdated" configuration values is necessary for
> compatibility. We never intended that specifying either of
> security= or lsm= on the boot line be required. Because there
> is no way to maintain the old behavior of security=selinux
> while allowing security=lockdown,yama,selinux we had to introduce
> lsm=.
>
> > But there is something that I did not understand: setting
> > "lsm=selinux,lockdown,yama,bpf" worked, /sys/kernel/security/lsm
> > showed "capability,selinux,lockdown,yama,bpf", but this violated what
> > the documentation stated [3]:
> > "A list of the active security modules can be found by reading
> > /sys/kernel/security/lsm. This is a comma separated list, and will
> > always include the capability module. The list reflects the order in
> > which checks are made. The capability module will always be first,
> > followed by any “minor” modules (e.g. Yama) and then the one “major”
> > module (e.g. SELinux) if there is one configured."
> >
> > Is "lsm=selinux,lockdown,yama,bpf" really problematic?
>
> The documentation is out of date regarding the "major" module
> having to be last. That was true before the lsm= option was introduced.
>
> >
> > TL;DR: It would be very helpful if there were some clear guidelines
> > which were documented in the kernel documentation about how to
> > configure CONFIG_LSM on SELinux systems.
>
> Thanks for the feedback. We are at a mid-point in the development of
> module stacking. It's not too late to make things better based on your
> experience.

Thanks for your quick reply! Anyway it seems that my issue was caused
by an incompatibility between selinux and bpf LSM. On my test system
(running Linux 5.10.11):

* Using "lsm=selinux,lockdown,yama,bpf" works (SELinux is functional,
the system boots fine)
* Using "lsm=lockdown,yama,selinux,bpf" works too
* Using "lsm=lockdown,yama,bpf,selinux" does not work
(/proc/$PID/attr/current raises "Invalid argument")

So it is important that "selinux" comes before "bpf" in CONFIG_LSM
(and "lsm" parameter). This fact seems to be known, as "bpf" was added
last in the default values of CONFIG_LSM options
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/Kconfig?h=v5.11-rc7#n280).
Is this documented somewhere? It is neither in
https://www.kernel.org/doc/html/v5.11-rc7/bpf/bpf_lsm.html nor
https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/index.html.

Nicolas

> >
> > Thanks,
> > Nicolas
> >
> > [1] https://github.com/archlinuxhardened/selinux/issues/81
> > [2] https://github.com/archlinux/svntogit-packages/commit/69cb8c2d2884181e799e67b09d67fcf7944d8408
> > [3] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/index.html
> > [4] https://www.kernel.org/doc/html/v5.11-rc7/admin-guide/LSM/SELinux.html
> > [5] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a0f04170dbca7e74e8d13c7/f/kernel-x86_64-fedora.config#_3232
> > [6] https://src.fedoraproject.org/rpms/kernel/blob/dd9f5d552f96c5171a0f04170dbca7e74e8d13c7/f/kernel-x86_64-rhel.config#_2834
> > [7] commit https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=000d388ed3bbed745f366ce71b2bb7c2ee70f449
> >
>

