Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F4C6FD1D
	for <selinux@archiver.kernel.org>; Tue, 21 Mar 2023 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCUNlJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Mar 2023 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCUNlI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Mar 2023 09:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79C6A70
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679406027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2aqnoitshpfXz7eA8Fs7yw9FEtd+hTBZLGnbjoH7pg8=;
        b=PnXK6zfO7Lm3dVINsvbnY6zINlEvuwYzLdHtRHj0OiZYRB1EPQq3bY+s888frG68R51SEj
        R6MEL/NQ6h85sj/D/ZadHNU0vMwHZ262YaMJiDEH3+lpQNP6R1ZBrii7Sgeiubj/YveRCh
        OS77R/2feLnR66a0u+sLXmDaPBgJEtM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-jojanezCOlKJQMtotgnLXQ-1; Tue, 21 Mar 2023 09:40:25 -0400
X-MC-Unique: jojanezCOlKJQMtotgnLXQ-1
Received: by mail-pg1-f198.google.com with SMTP id t12-20020a65608c000000b005091ec4f2d4so3543525pgu.20
        for <selinux@vger.kernel.org>; Tue, 21 Mar 2023 06:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aqnoitshpfXz7eA8Fs7yw9FEtd+hTBZLGnbjoH7pg8=;
        b=qtDDomh1kAp28mPqIYxggytENeD5VQCRGPN4npxWeTcw+7pMZKBvT6rAzM7cjN9dwy
         VM4/ZD4lUrBHi5ytZvZLlAicvl4A8dKKFnTqbZ3mhDXDknjF1oXUOsj+iqIuW+vs5lYU
         Un48+bfmn2pJfDudYghD9mH/JjqJ+Jc6RcGRCtjKTbeobi8C53i3H+9m+zUbI03fBx/j
         SWU8ZVR3TkD+Qpb/7BwfxGfnT7btwTELxe5b9qvooVeDGFhT2CyM4zip02Vy0gUxavEb
         /eiD6DqrWeHpERME24PjLDn6nC6GtU+vbPBjRKs+K1MaT9Vlwde5PsDe3enKn93SA6uS
         r7bg==
X-Gm-Message-State: AO0yUKWgHVhjfViCbCkqIIjjipCSXzLy3LkXSXPtWeENRKD7IvPjFZf/
        2AJXdwQcns2pP9TnZM1tc6LmUyfRKs1j2HgWa3f9PnJEVxpEox8Rl8D2huqAtOFyhFX3Zo8xbsz
        gHqrEbUzqh4+NE8s3JlmJfkdXkPMaPCmHCg==
X-Received: by 2002:a65:51c5:0:b0:50b:dca1:b6f9 with SMTP id i5-20020a6551c5000000b0050bdca1b6f9mr657695pgq.1.1679406024386;
        Tue, 21 Mar 2023 06:40:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set+uIGcMUXpPdsu05nZpmLgT+EqU0tYFX7VacH4ezk8ytnuN9iraRkkql2cvaM6627dwiiQSLp8HsMGcxAre04o=
X-Received: by 2002:a65:51c5:0:b0:50b:dca1:b6f9 with SMTP id
 i5-20020a6551c5000000b0050bdca1b6f9mr657688pgq.1.1679406024076; Tue, 21 Mar
 2023 06:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
 <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
 <87cz53e1p5.fsf@defensec.nl> <CAJ2a_DeBmv=F1ZduAYwZ1TP89g2Dw=M5q5XYXSMs6TS6REm=aQ@mail.gmail.com>
 <CAEjxPJ5+M7x=qtZofTvVVdqF4_85QA2eUWH0f67nsZUO3TuVLA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5+M7x=qtZofTvVVdqF4_85QA2eUWH0f67nsZUO3TuVLA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 21 Mar 2023 14:40:12 +0100
Message-ID: <CAFqZXNtLFsmb3n+H=7Jcp1g_sLEFdRL75fzvjMvTU1rXvaQXMA@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 9:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 20, 2023 at 2:22=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Mon, 20 Mar 2023 at 19:14, Dominick Grift <dominick.grift@defensec.n=
l> wrote:
> > >
> > > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> > >
> > > > On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > >> Hmm...that's interesting. I just tried in Fedora using one of the
> > > >> type_transitions already defined in the default policy and althoug=
h it
> > > >> appears to use the type_transition to compute the new SID for the
> > > >> create check, ls -Z of the file after creation showed it labeled
> > > >> cgroup_t instead. So it doesn't appear to be working or I am doing=
 it
> > > >> wrong.
> > >
> > > I am totally confused now as well because Christian on IRC say's it
> > > works for him but I cannot get it to work here and I tried various
> > > combinations
> > >
> > > >
> > > > Reproducer, on F34,
> > > > $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> > > > mkdir: cannot create directory
> > > > =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permissio=
n denied
> > > > $ sudo ausearch -m AVC -ts recent -i
> > > > ----
> > > > type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denie=
d  {
> > > > associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
> > > > scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
> > > > tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permis=
sive=3D0
> > > > $ seinfo --fs_use | grep cgroup
> > > > $ seinfo --genfscon | grep cgroup
> > > >    genfscon cgroup /  system_u:object_r:cgroup_t:s0
> > > >    genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> > > > $ sesearch -T -s unconfined_t -t cgroup_t -c dir
> > > > type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshot=
s
> > > > $ sudo setenforce 0
> > > > $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> > > > $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
> > > > system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshot=
s
> > >
> > > --
> > > gpg --locate-keys dominick.grift@defensec.nl
> > > Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 409=
8
> > > Dominick Grift
> >
> > Debian sid (Linux debianBullseye 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC
> > Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux):
> >
> > type cgroup_test_t;
> > allow cgroup_test_t cgroup_t:filesystem associate;
> > filetrans_pattern(sysadm_t, cgroup_t, cgroup_test_t, dir, "testdir")
> > allow sysadm_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
> > allow sysadm_t cgroup_test_t:file getattr;
> >
> >
> > $ seinfo --all | grep cgroup
> > genfscon cgroup /  system_u:object_r:cgroup_t:s0
> > genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> > genfscon proc /cgroups  system_u:object_r:proc_info_t:s0
> > cgroup_seclabel
> > cgroup_t
> > cgroup_test_t
> > systemd_cgroups_agent_exec_t
> > systemd_cgroups_agent_runtime_t
> > systemd_cgroups_agent_t
> >
> >
> > $ grep cgroup /etc/selinux/debian/contexts/files/file_contexts
> > /cgroup/.*              <<none>>
> > /sys/fs/cgroup/.*               <<none>>
> > /sys/fs/cgroup/[^/]+            -l      system_u:object_r:cgroup_t:s0
> > /cgroup         -d      system_u:object_r:cgroup_t:s0
> > /sys/fs/cgroup          -d      system_u:object_r:cgroup_t:s0
> > /usr/lib/systemd/systemd-cgroups-agent          --
> > system_u:object_r:systemd_cgroups_agent_exec_t:s0
> >
> >
> > $ mkdir /sys/fs/cgroup/system.slice/testdir
> > $ ls -laZ /sys/fs/cgroup/system.slice/testdir/
> > total 0
> > drwxr-x---.  2 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
> > .
> > drwxr-xr-x. 19 root root system_u:object_r:cgroup_t:s0  0 Mar 20 19:19
> > ..
> > -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
> > cgroup.controllers
> > -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
> > cgroup.events
>
> Hmm...I don't get the same result with 6.1.14-200.fc37.x86_64, using
> the corresponding slightly tweaked policy module:
> policy_module(cgrouptest, 1.0)
> require {
> type cgroup_t;
> type unconfined_t;
> }
> type cgroup_test_t;
> allow cgroup_test_t cgroup_t:filesystem associate;
> filetrans_pattern(unconfined_t, cgroup_t, cgroup_test_t, dir, "testdir")
> allow unconfined_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
> allow unconfined_t cgroup_test_t:file getattr;
>
> That's on Fedora 37, not 34, sorry for the typo.

Ah, now I remembered that we made it such that the transitions would
only apply if the parent directory has a label explicitly set by
userspace (via setxattr). Not sure if we can improve it easily, since
we can't use the normal inode-based logic for cgroupfs (the xattrs are
stored in kernfs nodes, each of which can be exposed via multiple
inodes if there is more than one cgroupfs mount).

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

