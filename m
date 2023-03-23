Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D479AC6FD1C
	for <selinux@archiver.kernel.org>; Thu, 23 Mar 2023 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjCWQ4u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWQ4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Mar 2023 12:56:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B88D26A9
        for <selinux@vger.kernel.org>; Thu, 23 Mar 2023 09:56:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y2so9211656pfw.9
        for <selinux@vger.kernel.org>; Thu, 23 Mar 2023 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679590607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XACGckakkSXUGb05XZqsNC2YMI+37PQ8xuYLzW5WC4Q=;
        b=fv1NNIzxnSkSDVpUCoBrd/6uBd6leuT/r+1Ux52f4lLHUCIeB7ApmLuG/CcIheKci9
         sEgby4pF+LF4d5FHU/pbsm7wlVAnDnxemYkFf4UPaw3dADYvsIthldpBFM65fjrBRyGw
         NwMXO8C95yC63lFrW+A73d8NApQ2qH7Wo7EaXMey0Dz0Ohfu0dDk3TRcZ+LmyjoBPT0D
         qE4QWJqyZVi1CnUu//ydpLjHqvF4h7NqjTgXe/t86UE8VmydF/oX9fxi4IimRDPWvswK
         G5PQhWFR1Yy0u6Bp8L33SspQuMNC50MMJdIMPs2xf6uJfMleid6NQGa669jeTvLjmd4a
         38Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679590607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XACGckakkSXUGb05XZqsNC2YMI+37PQ8xuYLzW5WC4Q=;
        b=m8FyHmT40jE8W8daFUjdJmAEsuur8aN/VJ9B9yvpnVbTeVoRqp+cS9MGehMQpYYN5o
         QGxnj9rbj4sNge1kby4/6N+V/kYAgCbUPZnLvodEX379JP9oz/cLCB61RnTiE0a4ovD/
         vSuAJcMnfOxcw2CKg8Am+giMfz1mEE/Zh9lhAkvusUSkL2Vn/x3Uv+kRHDFeBnCoQ4ae
         HWUtu8vQNqsqLWtmZEOLzLjaKB9+UxP4kW9fxfiM1C2c0njuzueLWTUFshqrkFSxqZEP
         Of9H6tBSP30Nf6hGLqG7z0tkZNpAOTLRcGgre8rdbl1GEoQCMKAnZhJdrysdeqtxpR1T
         JglQ==
X-Gm-Message-State: AAQBX9dDH3M3b6M8zvPGap2IGmiUEmUfODFubAlOl9cmuXuWU8+jUk+m
        Mr9DneFApThWiNWFwEe6FO4yDC8SJOjFQv2HpWc=
X-Google-Smtp-Source: AKy350ZIwyiSC/VG51boq5pUV2J8plAKZt+vhnWgy3KYwTzgkXTcuJHrKbOSOXnzdPmjvHt/3V13Lt0SPfuD7tO1qK0=
X-Received: by 2002:a05:6a00:ace:b0:625:5949:6dc0 with SMTP id
 c14-20020a056a000ace00b0062559496dc0mr82268pfl.4.1679590606783; Thu, 23 Mar
 2023 09:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <871qljfrtz.fsf@defensec.nl>
 <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
 <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
 <87cz53e1p5.fsf@defensec.nl> <CAJ2a_DeBmv=F1ZduAYwZ1TP89g2Dw=M5q5XYXSMs6TS6REm=aQ@mail.gmail.com>
 <CAEjxPJ5+M7x=qtZofTvVVdqF4_85QA2eUWH0f67nsZUO3TuVLA@mail.gmail.com>
 <CAFqZXNtLFsmb3n+H=7Jcp1g_sLEFdRL75fzvjMvTU1rXvaQXMA@mail.gmail.com>
 <87zg86cgje.fsf@defensec.nl> <3d71fc24-13f5-7e2b-c107-125ab09692ee@linux.microsoft.com>
 <CAEjxPJ6oAUQTRp7yZNFf-CDXW+uC5xhNzahoZMu=3Vjm7GzsdQ@mail.gmail.com> <ca296b77-2314-3077-316f-c081b83b7967@linux.microsoft.com>
In-Reply-To: <ca296b77-2314-3077-316f-c081b83b7967@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 23 Mar 2023 12:56:35 -0400
Message-ID: <CAEjxPJ77ZiWTwJ=hj2DFoNCg4XZMfiU6VNSNAnyCKc0Rd+nM6Q@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Matthew Sheets <masheets@linux.microsoft.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 23, 2023 at 9:55=E2=80=AFAM Matthew Sheets
<masheets@linux.microsoft.com> wrote:
>
>
>
> On 3/22/2023 10:27 AM, Stephen Smalley wrote:
> > On Wed, Mar 22, 2023 at 1:07=E2=80=AFPM Matthew Sheets
> > <masheets@linux.microsoft.com> wrote:
> >> I helped the author of the initial PR that started this discussion.  W=
e
> >> knew we needed a new unique label and I suggested that we try a named
> >> file trans pattern from init_t just to see if it works, and it seemed =
to
> >> right out of the gates.  We didn't need to flip any other switches on
> >> our test environment.
> >>
> >> Here is an example of an AVC we are seeing:
> >> AVC avc:  denied  { getattr } for  pid=3D5953 comm=3D"systemd"
> >> path=3D"/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/me=
mory.pressure"
> >> dev=3D"cgroup2" ino=3D27721 scontext=3Dunconfined_u:unconfined_r:uncon=
fined_t
> >> tcontext=3Dsystem_u:object_r:memory_pressure_t tclass=3Dfile permissiv=
e=3D0
> >>
> >> I do fear there is something different from the other folks that have
> >> tested this and our setup, since out setup is fairly bespoke compared =
to
> >> your standard Linux distro.  But off the top of my head I don't know a=
ny
> >> special setting we would have in place to make this work.
> >
> > Questions:
> > - Did systemd or some other userspace process first set the context of
> > /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service
> > explicitly?
> > - Could you post the exact type_transition rule(s) from your policy,
> > e.g. sesearch -T -s unconfined_t -D memory_pressure_t?
> > - Does ls -Z of the file also report that context?
> > - Kernel version?
>
> 1. We believe it is systemd.  At the very least its nothing we are
>     directly doing.
> 2. type_transition init_t cgroup_t:file memory_pressure_t memory.pressure=
;
>     In the above example unconfined_t was just trying to access it but
>     we have the trans coming from init_t
> 3. Yes ls -Z shows the proper context as well.
> 4. For this specific test it was 5.10.154 but we have 5.10.x in some
>     of our other testing environments.

So if I add that type_transition to Fedora policy and reboot, some of
the memory.pressure files are labeled memory_pressure_t while others
are labeled cgroup_t, as shown below. Im guessing this has to do with
what process was current when the file was created (or some files
created before policy load), but not sure.

$ sudo find /sys/fs/cgroup -name memory.pressure -exec ls -Z {} \;
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/sys-fs-fuse-connections.mount/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/sys-kernel-config.mount/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/sys-kernel-debug.mount/memory.pressure
system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/dev-mqueue.mount/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/user.slice/user-982.slice/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/user.slice/user-982.slice/session-c1.scope/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/user.slice/user-982.slice/user@982.service/memory.pressure
unconfined_u:object_r:cgroup_t:s0
/sys/fs/cgroup/user.slice/user-982.slice/user@982.service/app.slice/memory.=
pressure
unconfined_u:object_r:cgroup_t:s0
/sys/fs/cgroup/user.slice/user-982.slice/user@982.service/app.slice/dbus.so=
cket/memory.pressure
unconfined_u:object_r:cgroup_t:s0
/sys/fs/cgroup/user.slice/user-982.slice/user@982.service/init.scope/memory=
.pressure
system_u:object_r:memory_pressure_t:s0 /sys/fs/cgroup/user.slice/memory.pre=
ssure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/user.slice/user-0.slice/session-2.scope/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/user.slice/user-0.slice/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/user.slice/user-0.slice/user@0.service/memory.pressure
unconfined_u:object_r:cgroup_t:s0
/sys/fs/cgroup/user.slice/user-0.slice/user@0.service/app.slice/memory.pres=
sure
unconfined_u:object_r:cgroup_t:s0
/sys/fs/cgroup/user.slice/user-0.slice/user@0.service/app.slice/dbus.socket=
/memory.pressure
unconfined_u:object_r:cgroup_t:s0
/sys/fs/cgroup/user.slice/user-0.slice/user@0.service/init.scope/memory.pre=
ssure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/sys-kernel-tracing.mount/memory.pressure
system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/init.scope/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/irqbalance.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/abrt-journal-core.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/mcafee.ma.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/sysroot.mount/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/nessusagent.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-udevd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-udevd.service/udev/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/dbus-broker.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-homed.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/oddjobd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/boot.mount/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/vgauthd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/cockpit.socket/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/polkit.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/chronyd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/auditd.service/memory.pressure
system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/memory.pressure
system_u:object_r:cgroup_t:s0
'/sys/fs/cgroup/system.slice/system-sshd\x2dkeygen.slice/memory.pressure'
system_u:object_r:cgroup_t:s0
'/sys/fs/cgroup/system.slice/system-dbus\x2d:1.3\x2dorg.fedoraproject.Setro=
ubleshootPrivileged.slice/memory.pressure'
system_u:object_r:cgroup_t:s0
'/sys/fs/cgroup/system.slice/system-dbus\x2d:1.3\x2dorg.fedoraproject.Setro=
ubleshootPrivileged.slice/dbus-:1.3-org.fedoraproject.SetroubleshootPrivile=
ged@1.service/memory.pressure'
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/dev-zram0.swap/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/abrt-xorg.service/memory.pressure
system_u:object_r:cgroup_t:s0
'/sys/fs/cgroup/system.slice/system-systemd\x2dzram\x2dsetup.slice/memory.p=
ressure'
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/system-modprobe.slice/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/libvirtd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/ModemManager.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/atd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/sshd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/crond.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/NetworkManager.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-machined.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/gssproxy.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/rpc-gssd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/rsyslog.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/abrtd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/tmp.mount/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/firewalld.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-userdbd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/setroubleshootd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/vmtoolsd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/sssd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/cups.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-oomd.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/mcelog.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-resolved.service/memory.pressure
system_u:object_r:cgroup_t:s0
'/sys/fs/cgroup/system.slice/system-lvm2\x2dpvscan.slice/memory.pressure'
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/system-getty.slice/getty@tty1.service/memory.pr=
essure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/system-getty.slice/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/avahi-daemon.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/systemd-logind.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/abrt-oops.service/memory.pressure
system_u:object_r:cgroup_t:s0
/sys/fs/cgroup/system.slice/var-lib-nfs-rpc_pipefs.mount/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/machine.slice/memory.pressure
system_u:object_r:memory_pressure_t:s0
/sys/fs/cgroup/dev-hugepages.mount/memory.pressure
