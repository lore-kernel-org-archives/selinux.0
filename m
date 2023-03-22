Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B5C6FD1F
	for <selinux@archiver.kernel.org>; Wed, 22 Mar 2023 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCVR2M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCVR2L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Mar 2023 13:28:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81E5FEF
        for <selinux@vger.kernel.org>; Wed, 22 Mar 2023 10:28:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w4so11859917plg.9
        for <selinux@vger.kernel.org>; Wed, 22 Mar 2023 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679506089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSHATbmty9W4Kb810d69sXcwhEFYyFIHe9RR1jEdcy4=;
        b=WQTjCnQ5OX+UiexNs8IeQQ/d9aDHSZcAZ/Y6kkfzHreKQ2tqk5Xw4A+pd/Zhnx+oAt
         FlJJxnRxzRL3VQbyg7tXVNy+nqQnPFtWnFZTxdWBlhDoRhZ3CJLCmwQlxXI1seKwOBC6
         0pfIiR+L7cmrfuEYOJ1c1hZrFq3ZjIzTA/iDHgvbXee9i9/EniRXVFnfI0iFh2XoaWzs
         kFuuhyAtu1xSAbEs9EyJYKFB/d5DHYFR0LJaxOxta3bC4cMbu50SL2nURMDSzJeCh0wB
         jBA3ynlx3MpoOBJOIzUVvKUKu1MkZl7PMVn4WkF+aYgyN6cSv1/rZ2GtXWHHQrGLf2O4
         eJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSHATbmty9W4Kb810d69sXcwhEFYyFIHe9RR1jEdcy4=;
        b=WAbxbyZBpc8eQ9hyWRUST97jHfs1Rh6p4s0CATIwk1Q5ggrttf8cG00k5JghwIsWWx
         LMnAJeWoyLTQc4WzZQB8qr3whh65hcLdE1YrRKAoyFtUIS2rw5PGi3Ie9PR92qQ0G0oD
         N0YnjybT97MX5+dxAskIYnvwp+IUArFF5FJp9Cd8q9Pn6BJfBJH7bRXRHK/Sg+0btj1I
         ghBA7aRSqxbbQHoPt3I0J2gc8JJYNO6u4WSanSaqBHxeQ49gEwPQLqtqZAZwo2XkoGBA
         0V8sczcqnhdc1VmfOxYBNqvaDEcOBc2XV46yeyeNMyzZ1H0aonjTVs5FO0+BCpWCXKgH
         gD9g==
X-Gm-Message-State: AO0yUKWrz5OnaHJkx7sLs/y6CRsxzIUoJcj9RJQ3a1lchd3gtt73UwD4
        wUnaFglY4Ih4Mdh8xqHMIh8ZzWZMgc7EKVlX1K6Nvdzx
X-Google-Smtp-Source: AK7set/46SrOAlZrpwGDzomnEp8FJJztGYi1LcYiIVPvJSCihYXEpb2fC1gR0zfa3/YlAwCXHjqfFIXbzkbQtEKNTN0=
X-Received: by 2002:a17:90b:188e:b0:23d:3ff1:87b8 with SMTP id
 mn14-20020a17090b188e00b0023d3ff187b8mr1335298pjb.8.1679506088780; Wed, 22
 Mar 2023 10:28:08 -0700 (PDT)
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
 <CAFqZXNtLFsmb3n+H=7Jcp1g_sLEFdRL75fzvjMvTU1rXvaQXMA@mail.gmail.com>
 <87zg86cgje.fsf@defensec.nl> <3d71fc24-13f5-7e2b-c107-125ab09692ee@linux.microsoft.com>
In-Reply-To: <3d71fc24-13f5-7e2b-c107-125ab09692ee@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 22 Mar 2023 13:27:57 -0400
Message-ID: <CAEjxPJ6oAUQTRp7yZNFf-CDXW+uC5xhNzahoZMu=3Vjm7GzsdQ@mail.gmail.com>
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

On Wed, Mar 22, 2023 at 1:07=E2=80=AFPM Matthew Sheets
<masheets@linux.microsoft.com> wrote:
>
> On 3/21/2023 7:42 AM, Dominick Grift wrote:
> > Ondrej Mosnacek <omosnace@redhat.com> writes:
> >
> >> On Mon, Mar 20, 2023 at 9:23=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>>
> >>> On Mon, Mar 20, 2023 at 2:22=E2=80=AFPM Christian G=C3=B6ttsche
> >>> <cgzones@googlemail.com> wrote:
> >>>>
> >>>> On Mon, 20 Mar 2023 at 19:14, Dominick Grift <dominick.grift@defense=
c.nl> wrote:
> >>>>>
> >>>>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >>>>>
> >>>>>> On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
> >>>>>> <stephen.smalley.work@gmail.com> wrote:
> >>>>>>> Hmm...that's interesting. I just tried in Fedora using one of the
> >>>>>>> type_transitions already defined in the default policy and althou=
gh it
> >>>>>>> appears to use the type_transition to compute the new SID for the
> >>>>>>> create check, ls -Z of the file after creation showed it labeled
> >>>>>>> cgroup_t instead. So it doesn't appear to be working or I am doin=
g it
> >>>>>>> wrong.
> >>>>>
> >>>>> I am totally confused now as well because Christian on IRC say's it
> >>>>> works for him but I cannot get it to work here and I tried various
> >>>>> combinations
> >>>>>
> >>>>>>
> >>>>>> Reproducer, on F34,
> >>>>>> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> >>>>>> mkdir: cannot create directory
> >>>>>> =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permissi=
on denied
> >>>>>> $ sudo ausearch -m AVC -ts recent -i
> >>>>>> ----
> >>>>>> type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  deni=
ed  {
> >>>>>> associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
> >>>>>> scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
> >>>>>> tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permi=
ssive=3D0
> >>>>>> $ seinfo --fs_use | grep cgroup
> >>>>>> $ seinfo --genfscon | grep cgroup
> >>>>>>     genfscon cgroup /  system_u:object_r:cgroup_t:s0
> >>>>>>     genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> >>>>>> $ sesearch -T -s unconfined_t -t cgroup_t -c dir
> >>>>>> type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapsho=
ts
> >>>>>> $ sudo setenforce 0
> >>>>>> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
> >>>>>> $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
> >>>>>> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapsho=
ts
> >>>>>
> >>>>> --
> >>>>> gpg --locate-keys dominick.grift@defensec.nl
> >>>>> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4=
098
> >>>>> Dominick Grift
> >>>>
> >>>> Debian sid (Linux debianBullseye 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMI=
C
> >>>> Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux):
> >>>>
> >>>> type cgroup_test_t;
> >>>> allow cgroup_test_t cgroup_t:filesystem associate;
> >>>> filetrans_pattern(sysadm_t, cgroup_t, cgroup_test_t, dir, "testdir")
> >>>> allow sysadm_t cgroup_test_t:dir { create_dir_perms list_dir_perms }=
;
> >>>> allow sysadm_t cgroup_test_t:file getattr;
> >>>>
> >>>>
> >>>> $ seinfo --all | grep cgroup
> >>>> genfscon cgroup /  system_u:object_r:cgroup_t:s0
> >>>> genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
> >>>> genfscon proc /cgroups  system_u:object_r:proc_info_t:s0
> >>>> cgroup_seclabel
> >>>> cgroup_t
> >>>> cgroup_test_t
> >>>> systemd_cgroups_agent_exec_t
> >>>> systemd_cgroups_agent_runtime_t
> >>>> systemd_cgroups_agent_t
> >>>>
> >>>>
> >>>> $ grep cgroup /etc/selinux/debian/contexts/files/file_contexts
> >>>> /cgroup/.*              <<none>>
> >>>> /sys/fs/cgroup/.*               <<none>>
> >>>> /sys/fs/cgroup/[^/]+            -l      system_u:object_r:cgroup_t:s=
0
> >>>> /cgroup         -d      system_u:object_r:cgroup_t:s0
> >>>> /sys/fs/cgroup          -d      system_u:object_r:cgroup_t:s0
> >>>> /usr/lib/systemd/systemd-cgroups-agent          --
> >>>> system_u:object_r:systemd_cgroups_agent_exec_t:s0
> >>>>
> >>>>
> >>>> $ mkdir /sys/fs/cgroup/system.slice/testdir
> >>>> $ ls -laZ /sys/fs/cgroup/system.slice/testdir/
> >>>> total 0
> >>>> drwxr-x---.  2 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:=
19
> >>>> .
> >>>> drwxr-xr-x. 19 root root system_u:object_r:cgroup_t:s0  0 Mar 20 19:=
19
> >>>> ..
> >>>> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:=
19
> >>>> cgroup.controllers
> >>>> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:=
19
> >>>> cgroup.events
> >>>
> >>> Hmm...I don't get the same result with 6.1.14-200.fc37.x86_64, using
> >>> the corresponding slightly tweaked policy module:
> >>> policy_module(cgrouptest, 1.0)
> >>> require {
> >>> type cgroup_t;
> >>> type unconfined_t;
> >>> }
> >>> type cgroup_test_t;
> >>> allow cgroup_test_t cgroup_t:filesystem associate;
> >>> filetrans_pattern(unconfined_t, cgroup_t, cgroup_test_t, dir, "testdi=
r")
> >>> allow unconfined_t cgroup_test_t:dir { create_dir_perms list_dir_perm=
s };
> >>> allow unconfined_t cgroup_test_t:file getattr;
> >>>
> >>> That's on Fedora 37, not 34, sorry for the typo.
> >>
> >> Ah, now I remembered that we made it such that the transitions would
> >> only apply if the parent directory has a label explicitly set by
> >> userspace (via setxattr). Not sure if we can improve it easily, since
> >> we can't use the normal inode-based logic for cgroupfs (the xattrs are
> >> stored in kernfs nodes, each of which can be exposed via multiple
> >> inodes if there is more than one cgroupfs mount).
> >
> > Thanks. I can confirm that this indeed enabled transition functionality=
.
> >
> > It does not solve my memory.pressure challenge but I implementing it
> > regardless in hopes that it addresses the races I encountered when
> > solely relying on genfscon for user.slice
> >
> > https://git.defensec.nl/?p=3Ddssp5.git;a=3Dcommitdiff;h=3D1920c9f751445=
bfd51f43a7c4e9b7fedda057d15
> >
> > We should probably document this "gotcha" in the selinux-notebook
> >
>
> Just to unify some other threads of conversation that has been going on
> for this.
>
> I helped the author of the initial PR that started this discussion.  We
> knew we needed a new unique label and I suggested that we try a named
> file trans pattern from init_t just to see if it works, and it seemed to
> right out of the gates.  We didn't need to flip any other switches on
> our test environment.
>
> Here is an example of an AVC we are seeing:
> AVC avc:  denied  { getattr } for  pid=3D5953 comm=3D"systemd"
> path=3D"/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memor=
y.pressure"
> dev=3D"cgroup2" ino=3D27721 scontext=3Dunconfined_u:unconfined_r:unconfin=
ed_t
> tcontext=3Dsystem_u:object_r:memory_pressure_t tclass=3Dfile permissive=
=3D0
>
> I do fear there is something different from the other folks that have
> tested this and our setup, since out setup is fairly bespoke compared to
> your standard Linux distro.  But off the top of my head I don't know any
> special setting we would have in place to make this work.

Questions:
- Did systemd or some other userspace process first set the context of
/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service
explicitly?
- Could you post the exact type_transition rule(s) from your policy,
e.g. sesearch -T -s unconfined_t -D memory_pressure_t?
- Does ls -Z of the file also report that context?
- Kernel version?
