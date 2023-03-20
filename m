Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188FC6FD1C
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 20:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCTUYR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCTUYJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 16:24:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D12BF3B
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 13:23:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o2so6395974plg.4
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679343834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szH4Y4sJsvShiQqOyDiz1vjIxxRW5X7qddw6kgeIuMA=;
        b=R584N4EBRTK2Mmie03I5UmvHDd9ccK0efLEUE/XIXDA45wITVBCa4vsXtYFDtALimX
         QyE9bE/L3gp1PYjt89zTfSBV2JiMTjsmC5vaeJwPr/HN6uPma4CY8guf44dd9Xrj2khk
         YW6EnConswfXfW5HwtkdiQZsLsPvModch0EKt9dgk4AQN7mynJ2jFw2eLdAxxvbiW24f
         DLHeAnWazB2kt92BEo2+IX7Sl6x9LyQkA1lSvQI8gLUz+PZSEj+lG8lcIwIEmw6jIkDR
         7YQuGsViTLPCW8wUgdzh5nApxAWiby0ULNhV85poKb0XX/raPHWD8Yn1OZMiyjgJCZt6
         D7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679343835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szH4Y4sJsvShiQqOyDiz1vjIxxRW5X7qddw6kgeIuMA=;
        b=KZtCGgBHikxXXwA1MS2Nx2bJ8BkwTVroW+BrOkozR+zy5WWTiwMEJ/+mG6vG2rWbVj
         rt7KbNPc6AmRoQmz0gZxRXK4XEETnKrT2LbQP0lDyA5LToEeS70nkNG2VNV9tml3sFq3
         pcyqyyt6DlJ6Y4uRT2U3Q6RbdruH0mLF8EiCbiZcAF6JN+spdx8ghj5D4Fqmlt5LB8oj
         kc8GeTCEW4tsnrrrPPJMgVnxkSVZohkwUoqRx/xglSYLyH2RcFaj4ufF5SRPIWSm8Hbs
         Za71hIHLgjCkhbOre5L7Z2XGtcBglsocxwoPhI9NN0KLV994lFeu/ALZCFos6qBLHqkM
         xv5A==
X-Gm-Message-State: AO0yUKWrHgqNBvmUGGMzUY2LatZUVNeEhdxWm2GsrWPI4mqydrmmSi1B
        NBxLtmryYfewUvhDX4n0aC7sZtuuB2f1e/MDAAMb/qGZOHc=
X-Google-Smtp-Source: AK7set/tjimWQh66F65942wLCtg7g82cCQCfOL2VGRtKQS3dj09MaBnlHy6TWHyl+sfvM+mRt+XU2Vda7I/cQiLm7Fw=
X-Received: by 2002:a17:90a:c20f:b0:23d:ef4:513b with SMTP id
 e15-20020a17090ac20f00b0023d0ef4513bmr153207pjt.8.1679343834559; Mon, 20 Mar
 2023 13:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
 <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
 <87cz53e1p5.fsf@defensec.nl> <CAJ2a_DeBmv=F1ZduAYwZ1TP89g2Dw=M5q5XYXSMs6TS6REm=aQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeBmv=F1ZduAYwZ1TP89g2Dw=M5q5XYXSMs6TS6REm=aQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 16:23:43 -0400
Message-ID: <CAEjxPJ5+M7x=qtZofTvVVdqF4_85QA2eUWH0f67nsZUO3TuVLA@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 2:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 20 Mar 2023 at 19:14, Dominick Grift <dominick.grift@defensec.nl>=
 wrote:
> >
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> > > On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >> Hmm...that's interesting. I just tried in Fedora using one of the
> > >> type_transitions already defined in the default policy and although =
it
> > >> appears to use the type_transition to compute the new SID for the
> > >> create check, ls -Z of the file after creation showed it labeled
> > >> cgroup_t instead. So it doesn't appear to be working or I am doing i=
t
> > >> wrong.
> >
> > I am totally confused now as well because Christian on IRC say's it
> > works for him but I cannot get it to work here and I tried various
> > combinations
> >
> > >
> > > Reproducer, on F34,
> > > $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> > > mkdir: cannot create directory
> > > =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permission =
denied
> > > $ sudo ausearch -m AVC -ts recent -i
> > > ----
> > > type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denied =
 {
> > > associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
> > > scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
> > > tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permissi=
ve=3D0
> > > $ seinfo --fs_use | grep cgroup
> > > $ seinfo --genfscon | grep cgroup
> > >    genfscon cgroup /  system_u:object_r:cgroup_t:s0
> > >    genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> > > $ sesearch -T -s unconfined_t -t cgroup_t -c dir
> > > type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
> > > $ sudo setenforce 0
> > > $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> > > $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
> > > system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
> >
> > --
> > gpg --locate-keys dominick.grift@defensec.nl
> > Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> > Dominick Grift
>
> Debian sid (Linux debianBullseye 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC
> Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux):
>
> type cgroup_test_t;
> allow cgroup_test_t cgroup_t:filesystem associate;
> filetrans_pattern(sysadm_t, cgroup_t, cgroup_test_t, dir, "testdir")
> allow sysadm_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
> allow sysadm_t cgroup_test_t:file getattr;
>
>
> $ seinfo --all | grep cgroup
> genfscon cgroup /  system_u:object_r:cgroup_t:s0
> genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> genfscon proc /cgroups  system_u:object_r:proc_info_t:s0
> cgroup_seclabel
> cgroup_t
> cgroup_test_t
> systemd_cgroups_agent_exec_t
> systemd_cgroups_agent_runtime_t
> systemd_cgroups_agent_t
>
>
> $ grep cgroup /etc/selinux/debian/contexts/files/file_contexts
> /cgroup/.*              <<none>>
> /sys/fs/cgroup/.*               <<none>>
> /sys/fs/cgroup/[^/]+            -l      system_u:object_r:cgroup_t:s0
> /cgroup         -d      system_u:object_r:cgroup_t:s0
> /sys/fs/cgroup          -d      system_u:object_r:cgroup_t:s0
> /usr/lib/systemd/systemd-cgroups-agent          --
> system_u:object_r:systemd_cgroups_agent_exec_t:s0
>
>
> $ mkdir /sys/fs/cgroup/system.slice/testdir
> $ ls -laZ /sys/fs/cgroup/system.slice/testdir/
> total 0
> drwxr-x---.  2 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
> .
> drwxr-xr-x. 19 root root system_u:object_r:cgroup_t:s0  0 Mar 20 19:19
> ..
> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
> cgroup.controllers
> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
> cgroup.events

Hmm...I don't get the same result with 6.1.14-200.fc37.x86_64, using
the corresponding slightly tweaked policy module:
policy_module(cgrouptest, 1.0)
require {
type cgroup_t;
type unconfined_t;
}
type cgroup_test_t;
allow cgroup_test_t cgroup_t:filesystem associate;
filetrans_pattern(unconfined_t, cgroup_t, cgroup_test_t, dir, "testdir")
allow unconfined_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
allow unconfined_t cgroup_test_t:file getattr;

That's on Fedora 37, not 34, sorry for the typo.
