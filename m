Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9705CC6FD1F
	for <selinux@archiver.kernel.org>; Wed, 22 Mar 2023 17:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjCVRQi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCVRQX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Mar 2023 13:16:23 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB60637F7
        for <selinux@vger.kernel.org>; Wed, 22 Mar 2023 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1679505346;
        bh=kMhiyL/n58ur6BuUeJ9m5ZlOgC2oIY2AK7VZaUkpvfM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GARxGNOEmj5NTdNJA8Y3uTMMohTFtkJ/+fUuxdtid04n95yjCYT8lRaF8HE5hUL4t
         2pg34Igb1hMboTNOHhFmqIwngFpItT29kmuORxFDDKGXSd6gpGt1mgmF8VjN7ANvnm
         GdAe6vRXykOVHehKLM+Uyl3PMM2C7b6HyKOxJeAg=
Received: from paulus (paulus.lan [IPv6:2a10:3781:2099::515])
        by markus.defensec.nl (Postfix) with ESMTPSA id C90633CC;
        Wed, 22 Mar 2023 18:15:46 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Matthew Sheets <masheets@linux.microsoft.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: cgroup2 labeling question
References: <87mt47ga29.fsf@defensec.nl>
        <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
        <871qljfrtz.fsf@defensec.nl>
        <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
        <87wn3bec97.fsf@defensec.nl>
        <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
        <CAEjxPJ6tYSPEVJV1usgpsT=kXBisQwAcYDkUv20br=gxQZV9eA@mail.gmail.com>
        <87lejre9b2.fsf@defensec.nl>
        <CAEjxPJ4gsGseRtSDBrAkLEsFzu5QUXbespYESU0+LyEFJUjo=g@mail.gmail.com>
        <87h6ufe5um.fsf@defensec.nl>
        <CAEjxPJ5JWjhLpOavUsqH-ZU_NHYOc_dKmc8YBQA5jv-XcWazhw@mail.gmail.com>
        <CAEjxPJ7gf5seRK59Gf8ZPRSC+WL1iQWOX1bTimdBmBxuMHPkxw@mail.gmail.com>
        <87cz53e1p5.fsf@defensec.nl>
        <CAJ2a_DeBmv=F1ZduAYwZ1TP89g2Dw=M5q5XYXSMs6TS6REm=aQ@mail.gmail.com>
        <CAEjxPJ5+M7x=qtZofTvVVdqF4_85QA2eUWH0f67nsZUO3TuVLA@mail.gmail.com>
        <CAFqZXNtLFsmb3n+H=7Jcp1g_sLEFdRL75fzvjMvTU1rXvaQXMA@mail.gmail.com>
        <87zg86cgje.fsf@defensec.nl>
        <3d71fc24-13f5-7e2b-c107-125ab09692ee@linux.microsoft.com>
Date:   Wed, 22 Mar 2023 18:15:46 +0100
In-Reply-To: <3d71fc24-13f5-7e2b-c107-125ab09692ee@linux.microsoft.com>
        (Matthew Sheets's message of "Wed, 22 Mar 2023 10:07:14 -0700")
Message-ID: <87v8isd7wd.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Matthew Sheets <masheets@linux.microsoft.com> writes:

> On 3/21/2023 7:42 AM, Dominick Grift wrote:
>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>>=20
>>> On Mon, Mar 20, 2023 at 9:23=E2=80=AFPM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>>
>>>> On Mon, Mar 20, 2023 at 2:22=E2=80=AFPM Christian G=C3=B6ttsche
>>>> <cgzones@googlemail.com> wrote:
>>>>>
>>>>> On Mon, 20 Mar 2023 at 19:14, Dominick Grift <dominick.grift@defensec=
.nl> wrote:
>>>>>>
>>>>>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>>>>>
>>>>>>> On Mon, Mar 20, 2023 at 1:28=E2=80=AFPM Stephen Smalley
>>>>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>>>>> Hmm...that's interesting. I just tried in Fedora using one of the
>>>>>>>> type_transitions already defined in the default policy and althoug=
h it
>>>>>>>> appears to use the type_transition to compute the new SID for the
>>>>>>>> create check, ls -Z of the file after creation showed it labeled
>>>>>>>> cgroup_t instead. So it doesn't appear to be working or I am doing=
 it
>>>>>>>> wrong.
>>>>>>
>>>>>> I am totally confused now as well because Christian on IRC say's it
>>>>>> works for him but I cannot get it to work here and I tried various
>>>>>> combinations
>>>>>>
>>>>>>>
>>>>>>> Reproducer, on F34,
>>>>>>> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
>>>>>>> mkdir: cannot create directory
>>>>>>> =E2=80=98/sys/fs/cgroup/system.slice/.snapshots=E2=80=99: Permissio=
n denied
>>>>>>> $ sudo ausearch -m AVC -ts recent -i
>>>>>>> ----
>>>>>>> type=3DAVC msg=3Daudit(03/20/2023 13:00:04.699:47156) : avc:  denie=
d  {
>>>>>>> associate } for  pid=3D152325 comm=3Dmkdir name=3D.snapshots
>>>>>>> scontext=3Dunconfined_u:object_r:snapperd_data_t:s0
>>>>>>> tcontext=3Dsystem_u:object_r:cgroup_t:s0 tclass=3Dfilesystem permis=
sive=3D0
>>>>>>> $ seinfo --fs_use | grep cgroup
>>>>>>> $ seinfo --genfscon | grep cgroup
>>>>>>>     genfscon cgroup /  system_u:object_r:cgroup_t:s0
>>>>>>>     genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
>>>>>>> $ sesearch -T -s unconfined_t -t cgroup_t -c dir
>>>>>>> type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
>>>>>>> $ sudo setenforce 0
>>>>>>> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
>>>>>>> $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
>>>>>>> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
>>>>>>
>>>>>> --
>>>>>> gpg --locate-keys dominick.grift@defensec.nl
>>>>>> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 40=
98
>>>>>> Dominick Grift
>>>>>
>>>>> Debian sid (Linux debianBullseye 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC
>>>>> Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux):
>>>>>
>>>>> type cgroup_test_t;
>>>>> allow cgroup_test_t cgroup_t:filesystem associate;
>>>>> filetrans_pattern(sysadm_t, cgroup_t, cgroup_test_t, dir, "testdir")
>>>>> allow sysadm_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
>>>>> allow sysadm_t cgroup_test_t:file getattr;
>>>>>
>>>>>
>>>>> $ seinfo --all | grep cgroup
>>>>> genfscon cgroup /  system_u:object_r:cgroup_t:s0
>>>>> genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
>>>>> genfscon proc /cgroups  system_u:object_r:proc_info_t:s0
>>>>> cgroup_seclabel
>>>>> cgroup_t
>>>>> cgroup_test_t
>>>>> systemd_cgroups_agent_exec_t
>>>>> systemd_cgroups_agent_runtime_t
>>>>> systemd_cgroups_agent_t
>>>>>
>>>>>
>>>>> $ grep cgroup /etc/selinux/debian/contexts/files/file_contexts
>>>>> /cgroup/.*              <<none>>
>>>>> /sys/fs/cgroup/.*               <<none>>
>>>>> /sys/fs/cgroup/[^/]+            -l      system_u:object_r:cgroup_t:s0
>>>>> /cgroup         -d      system_u:object_r:cgroup_t:s0
>>>>> /sys/fs/cgroup          -d      system_u:object_r:cgroup_t:s0
>>>>> /usr/lib/systemd/systemd-cgroups-agent          --
>>>>> system_u:object_r:systemd_cgroups_agent_exec_t:s0
>>>>>
>>>>>
>>>>> $ mkdir /sys/fs/cgroup/system.slice/testdir
>>>>> $ ls -laZ /sys/fs/cgroup/system.slice/testdir/
>>>>> total 0
>>>>> drwxr-x---.  2 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
>>>>> .
>>>>> drwxr-xr-x. 19 root root system_u:object_r:cgroup_t:s0  0 Mar 20 19:19
>>>>> ..
>>>>> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
>>>>> cgroup.controllers
>>>>> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
>>>>> cgroup.events
>>>>
>>>> Hmm...I don't get the same result with 6.1.14-200.fc37.x86_64, using
>>>> the corresponding slightly tweaked policy module:
>>>> policy_module(cgrouptest, 1.0)
>>>> require {
>>>> type cgroup_t;
>>>> type unconfined_t;
>>>> }
>>>> type cgroup_test_t;
>>>> allow cgroup_test_t cgroup_t:filesystem associate;
>>>> filetrans_pattern(unconfined_t, cgroup_t, cgroup_test_t, dir, "testdir=
")
>>>> allow unconfined_t cgroup_test_t:dir { create_dir_perms list_dir_perms=
 };
>>>> allow unconfined_t cgroup_test_t:file getattr;
>>>>
>>>> That's on Fedora 37, not 34, sorry for the typo.
>>>
>>> Ah, now I remembered that we made it such that the transitions would
>>> only apply if the parent directory has a label explicitly set by
>>> userspace (via setxattr). Not sure if we can improve it easily, since
>>> we can't use the normal inode-based logic for cgroupfs (the xattrs are
>>> stored in kernfs nodes, each of which can be exposed via multiple
>>> inodes if there is more than one cgroupfs mount).
>> Thanks. I can confirm that this indeed enabled transition
>> functionality.
>> It does not solve my memory.pressure challenge but I implementing it
>> regardless in hopes that it addresses the races I encountered when
>> solely relying on genfscon for user.slice
>> https://git.defensec.nl/?p=3Ddssp5.git;a=3Dcommitdiff;h=3D1920c9f751445b=
fd51f43a7c4e9b7fedda057d15
>> We should probably document this "gotcha" in the selinux-notebook
>>=20
>
> Just to unify some other threads of conversation that has been going
> on for this.
>
> I helped the author of the initial PR that started this discussion.
> We knew we needed a new unique label and I suggested that we try a
> named file trans pattern from init_t just to see if it works, and it
> seemed to right out of the gates.  We didn't need to flip any other
> switches on our test environment.
>
> Here is an example of an AVC we are seeing:
> AVC avc:  denied  { getattr } for  pid=3D5953 comm=3D"systemd"
> path=3D"/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memor=
y.pressure"
> dev=3D"cgroup2" ino=3D27721
> scontext=3Dunconfined_u:unconfined_r:unconfined_t
> tcontext=3Dsystem_u:object_r:memory_pressure_t tclass=3Dfile permissive=
=3D0
>
> I do fear there is something different from the other folks that have
> tested this and our setup, since out setup is fairly bespoke compared
> to your standard Linux distro.  But off the top of my head I don't
> know any special setting we would have in place to make this work.
>

I just retested it here and i can't get it to work. (but i might be
overlooking something)

recorded the test for people interested:

https://www.defensec.nl/~kcinimod/stuff/cgroup8.mp4

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
