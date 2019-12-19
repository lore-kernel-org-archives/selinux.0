Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B349C2D0C0
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78F024672
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 14:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bWaPQth1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLSOQe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:16:34 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41506 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSOQe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 09:16:34 -0500
Received: by mail-vk1-f195.google.com with SMTP id p191so1658713vkf.8
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 06:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H1kGBYi/p/8arJytPdkN2R6svEU26h576SE4MXs3/L4=;
        b=bWaPQth1XmyHI6hojX/Ckdv5sSkO6T0CpdO0cjCqqWimPurbnpwleO5Mbj9RqrFk8S
         Mm2vothfm6DWP5VpgNPlIp9KIDcA+85qhaMycKco0kpzcVhBcWW1o2dX69tc+d9nOOqT
         1tZtO0pIgxe4HImWPFFPEHqpnJ9yFYyK1QUlNeePMyKSGfgS6godyA+ihaxmkszgrLAS
         g8ocipU9nolKFw3k1/qHjPvL732YyuLuYmEMO15acx4OUQkLjIMYsjHs/RjSEI3yOBRb
         ih63/mISBBgrpu25ciXyAxllPV10Cf8ahV2+fC+/somLei8jryJMVrrYliQwc4T98Fi7
         y0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H1kGBYi/p/8arJytPdkN2R6svEU26h576SE4MXs3/L4=;
        b=Uhfe/kwmzndDOkJgZaJ0IosokJ1DXGwwQWh+olh4YCAdRiKO9vAnPkGqgra0O8o2x0
         ebREtBebg10cEwiCYYeO+FQjrw/9srVY/zY2ElDFCcDNnfUDFtk+9FHef2WdXADgoPCx
         GuW+AC1n/UZZKixpa+uftZ/7BJxN54iIkJaYEL5IxNACh27XV0FvDDeWuze/mdFdv6HG
         8nGhRSbkKjUXpk8h/7ohQ6j328ad6o5JxFBsJnPwO/BGxy4aJ6nLh8Gr8E00tV4fxLpo
         ULtLnX6Y+jlXRx63qZZTtMIMD7wGn9cxNpEjXlelucI7mc4OXZzGU9tNGMQf3ZZnzRD9
         ethw==
X-Gm-Message-State: APjAAAVR/0lN/iMdJ6ryh4ClFpti5yGuJo6TpsRXeyT5RCXpB4Y/KBTw
        wfuTSxRK3AvPu0SXjFmNkQHoGbcHoGqcZkBCNGDnqwF8
X-Google-Smtp-Source: APXvYqyB15zHM3wZ6pdDjdw+4SSO3BpWLuKUR8dTnla0+eCCLvFH5zCe0ckyOfvLvCLFp/lh/VXKZwezMolZo+heZRE=
X-Received: by 2002:a1f:7d43:: with SMTP id y64mr6046122vkc.15.1576764991542;
 Thu, 19 Dec 2019 06:16:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
In-Reply-To: <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 19 Dec 2019 15:16:19 +0100
Message-ID: <CAJ2a_DcEnxg4w92ayqg7y76_5AvkGnzFBU32FpV_qzcxuUN_Pg@mail.gmail.com>
Subject: Re: incorrect sysfs contexts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mi., 18. Dez. 2019 um 16:35 Uhr schrieb Stephen Smalley <sds@tycho.nsa.g=
ov>:
>
> On 12/18/19 10:13 AM, Christian G=C3=B6ttsche wrote:
> > Hi,
> >
> > I am trying to refine contexts of sysfs.
> >
> > When using genfscon statements like:
> >      genfscon sysfs /  system_u:object_r:sysfs_t:s0
> >      genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
> >      genfscon sysfs /devices  system_u:object_r:generic_device_sysfs_t:=
s0
> >      genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs_t:=
s0
> >      genfscon sysfs /devices/system/cpu/online
> > system_u:object_r:cpu_online_sysfs_t:s0
> >      genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
> >      genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sysfs_=
t:s0
> >
> > and file context definitions like:
> >      /sys(/.*)?
> > gen_context(system_u:object_r:sysfs_t,s0)
> >      /sys/module/apparmor(/.*)?
> > gen_context(system_u:object_r:apparmor_sysfs_t,s0)
> >      /sys/devices/system/cpu(/.*)?
> > gen_context(system_u:object_r:cpu_sysfs_t,s0)
> >      /sys/devices/system/cpu/online          --
> > gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
> >      /sys/firmware(/.*)?
> > gen_context(system_u:object_r:firmware_sysfs_t,s0)
> >      /sys/devices(/.*)?
> > gen_context(system_u:object_r:generic_device_sysfs_t,s0)
> >      /sys/devices/.*/sd[a-z](/.*)?
> > gen_context(system_u:object_r:harddrive_sysfs_t,s0)
> >      /sys/devices/.*/hwmon(/.*)?
> > gen_context(system_u:object_r:hwmon_sysfs_t,s0)
> >      /sys/class/net(/.*)?
> > gen_context(system_u:object_r:net_sysfs_t,s0)
> >      /sys/devices/.*/net(/.*)?
> > gen_context(system_u:object_r:net_sysfs_t,s0)
> >
> > with a systemd tmpfiles entry:
> >      #Type Path        Mode UID  GID  Age Argument
> >      Z     /sys        -    -    -    -   -
> >
> > I still get incorrect labeled entries after boot:
> >
> > $ restorecon -v -R -n /
> > Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
> > system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC=
0/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC=
0/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c=
/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c=
/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c=
/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c=
/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsyste=
m
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p=
/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p=
/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> >
> > Using auditallow statements reveals no accesses.
> >
> > How can I enforce these entries to be created with correct labels?
>
> kernel version? v5.2 introduced improved sysfs/kernfs support for
> inheritance of SELinux labels, circa commit
> e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security
> of newly created nodes").

Default Debian sid kernel:
Linux debian-test 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07)
x86_64 GNU/Linux

Somehow symlinks do not inherit their parent label.
They all have the root-sysfs label.

Remounting sysfs with `mount -o remount -t sysfs /sys` leaves all
symlinks with the root-sysfs label.

Notes:
This is a custom refpolicy based policy. (the kernel module was modified)
Also happens in permissive mode.
$ compute_create system_u:system_r:kernel_t:s0
system_u:object_r:generic_device_sysfs_t:s0 lnk_file
system_u:object_r:generic_device_sysfs_t:s0
