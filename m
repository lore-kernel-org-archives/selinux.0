Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96848C7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 18:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjCTSbB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCTSa1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 14:30:27 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3210D
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:23:03 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id ay14so8549869uab.13
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679336574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpbdG4KJ3U106TXIKc3yC5tz6gIkrTFHYtNSBQVg+x4=;
        b=bDlnVcM0mwt/j5UO9MdwMX6kPTOs32OdAdo//NH7RA3L4dqjsXatsat8Ir0cO34N1D
         44XvYFA3e5Ogw8NVhlWFqnyuMQRET9TlXmUmOA/rbw+pIl7+jYcRf7JOkvpcFShZUQej
         Rlln207fNHRf+9qWozRpJFh/1BoVy4L03/qzHVNoblXQh4ZIEFkVfgu05LCSmFeH2H5K
         1mj1qUaZlM/Tu7WRKgIRNNTjWsXiGqaNezNZy3d1FT4sfOdVf5CM2uOjgiBPea2caGth
         oUdiK9fFoCB3AKc5ZOQtCsTReuohTd7yBiv2tEydHqZ+zf5JvKwP2a2i8zV+ofe02hvd
         8RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpbdG4KJ3U106TXIKc3yC5tz6gIkrTFHYtNSBQVg+x4=;
        b=yoOFoSwSnsTR2YmeGG96B7oqzTVpQaF6L8AgWnsI41X+ECaKyX6nS8ZsX/t6keL8LT
         n9bzwGx6Y86ddxWvud3RixlQtfv/LP1fZQdU6zYq1T7YM/F+vwnkK7mxbyCbDSnEytNO
         8Rr93GLrNMM1fzwh/7S8ovNHGz+Fulve6QM2jFyHMD82NCqJ79CUEM2IfFDzUlvaaPTx
         2K25PIWJ86KOz/ehdGi0+N1HUjvUpyHLtr3I/CAJAhPUiJfuYTf+peboMAygkh9hWQ6c
         Y/wV3Flz//o970NENIenlZN/i7H7WZm3Gv3vKAsMKgVtyHAmxaxVXH8+mJ8u1IxsPHM7
         4Jvg==
X-Gm-Message-State: AO0yUKVEyB5Etw3vhgxj6OV+TJyyQ4cuerlvdo7YOaqtGqtVYfUTt/Ch
        XtcW3jBeBAPQlrAVN0SYpabvTKxuQ+OOg/TZesk=
X-Google-Smtp-Source: AK7set+3f0/JqyS5olx1oeqrx6KpsD3fvfEBemtZVe7NjJqAjC4hAGoqrXpxZ5mmUYi+FduY8d4W86dWUJHMogZyi18=
X-Received: by 2002:a05:6130:213:b0:68b:94c5:7683 with SMTP id
 s19-20020a056130021300b0068b94c57683mr4913668uac.0.1679336573746; Mon, 20 Mar
 2023 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl> <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
 <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
 <87lejre9b2.fsf@defensec.nl> <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
 <87h6ufe5um.fsf@defensec.nl> <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
 <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com> <87cz53e1p5.fsf@defensec.nl>
In-Reply-To: <87cz53e1p5.fsf@defensec.nl>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 20 Mar 2023 19:22:42 +0100
Message-ID: <CAJ2a_DeBmv=F1ZduAYwZ1TP89g2Dw=M5q5XYXSMs6TS6REm=aQ@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 20 Mar 2023 at 19:14, Dominick Grift <dominick.grift@defensec.nl> w=
rote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> Hmm...that's interesting. I just tried in Fedora using one of the
> >> type_transitions already defined in the default policy and although it
> >> appears to use the type_transition to compute the new SID for the
> >> create check, ls -Z of the file after creation showed it labeled
> >> cgroup_t instead. So it doesn't appear to be working or I am doing it
> >> wrong.
>
> I am totally confused now as well because Christian on IRC say's it
> works for him but I cannot get it to work here and I tried various
> combinations
>
> >
> > Reproducer, on F34,
> > $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> > mkdir: cannot create directory
> > =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permission de=
nied
> > $ sudo ausearch -m AVC -ts recent -i
> > ----
> > type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denied  {
> > associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
> > scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
> > tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permissive=
=3D0
> > $ seinfo --fs_use | grep cgroup
> > $ seinfo --genfscon | grep cgroup
> >    genfscon cgroup /  system_u:object_r:cgroup_t:s0
> >    genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> > $ sesearch -T -s unconfined_t -t cgroup_t -c dir
> > type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
> > $ sudo setenforce 0
> > $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> > $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
> > system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift

Debian sid (Linux debianBullseye 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC
Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux):

type cgroup_test_t;
allow cgroup_test_t cgroup_t:filesystem associate;
filetrans_pattern(sysadm_t, cgroup_t, cgroup_test_t, dir, "testdir")
allow sysadm_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
allow sysadm_t cgroup_test_t:file getattr;


$ seinfo --all | grep cgroup
genfscon cgroup /  system_u:object_r:cgroup_t:s0
genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
genfscon proc /cgroups  system_u:object_r:proc_info_t:s0
cgroup_seclabel
cgroup_t
cgroup_test_t
systemd_cgroups_agent_exec_t
systemd_cgroups_agent_runtime_t
systemd_cgroups_agent_t


$ grep cgroup /etc/selinux/debian/contexts/files/file_contexts
/cgroup/.*              <<none>>
/sys/fs/cgroup/.*               <<none>>
/sys/fs/cgroup/[^/]+            -l      system_u:object_r:cgroup_t:s0
/cgroup         -d      system_u:object_r:cgroup_t:s0
/sys/fs/cgroup          -d      system_u:object_r:cgroup_t:s0
/usr/lib/systemd/systemd-cgroups-agent          --
system_u:object_r:systemd_cgroups_agent_exec_t:s0


$ mkdir /sys/fs/cgroup/system.slice/testdir
$ ls -laZ /sys/fs/cgroup/system.slice/testdir/
total 0
drwxr-x---.  2 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
.
drwxr-xr-x. 19 root root system_u:object_r:cgroup_t:s0  0 Mar 20 19:19
..
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.controllers
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.events
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.freeze
--w-------.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.kill
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.max.depth
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.max.descendants
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.pressure
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.procs
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.stat
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.subtree_control
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.threads
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cgroup.type
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cpu.pressure
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
cpu.stat
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
io.pressure
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.current
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.events
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.events.local
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.high
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.low
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.max
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.min
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.numa_stat
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.oom.group
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.peak
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.pressure
--w-------.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.reclaim
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.stat
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.swap.current
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.swap.events
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.swap.high
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.swap.max
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.zswap.current
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
memory.zswap.max
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
pids.current
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
pids.events
-rw-r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19 pids=
.max
-r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19 pids=
.peak
