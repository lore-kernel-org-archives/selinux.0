Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD39C6FD1F
	for <selinux@archiver.kernel.org>; Wed, 22 Mar 2023 17:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjCVRIb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjCVRIN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Mar 2023 13:08:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61EC549E1
        for <selinux@vger.kernel.org>; Wed, 22 Mar 2023 10:07:59 -0700 (PDT)
Received: from [192.168.1.107] (ip98-168-40-103.ph.ph.cox.net [98.168.40.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 072F320FB615;
        Wed, 22 Mar 2023 10:07:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 072F320FB615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679504835;
        bh=kY6YMYjA9YqD2jQQTSzIQFgWt9PHJ5asfDbL0MThdlo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eLmTkcniXCxsZxbcODoXwd8uEwyBqtJcbucYi0NRwK0uUTSRCA0tRKFp+INASPus4
         tM41Pz59YO3N0rNxPK0zOSLoG9r4i/984IzccbsMr2TH+GYOgI6Bk5NcGdxe5Xc/Wb
         L5QnmtFgLUbzrEO75H2fX1R5r3V6+isv+qhVJFB4=
Message-ID: <3d71fc24-13f5-7e2b-c107-125ab09692ee@linux.microsoft.com>
Date:   Wed, 22 Mar 2023 10:07:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
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
Content-Language: en-US
From:   Matthew Sheets <masheets@linux.microsoft.com>
In-Reply-To: <87zg86cgje.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/21/2023 7:42 AM, Dominick Grift wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
> 
>> On Mon, Mar 20, 2023 at 9:23 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>>
>>> On Mon, Mar 20, 2023 at 2:22 PM Christian Göttsche
>>> <cgzones@googlemail.com> wrote:
>>>>
>>>> On Mon, 20 Mar 2023 at 19:14, Dominick Grift <dominick.grift@defensec.nl> wrote:
>>>>>
>>>>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>>>>
>>>>>> On Mon, Mar 20, 2023 at 1:28 PM Stephen Smalley
>>>>>> <stephen.smalley.work@gmail.com> wrote:
>>>>>>> Hmm...that's interesting. I just tried in Fedora using one of the
>>>>>>> type_transitions already defined in the default policy and although it
>>>>>>> appears to use the type_transition to compute the new SID for the
>>>>>>> create check, ls -Z of the file after creation showed it labeled
>>>>>>> cgroup_t instead. So it doesn't appear to be working or I am doing it
>>>>>>> wrong.
>>>>>
>>>>> I am totally confused now as well because Christian on IRC say's it
>>>>> works for him but I cannot get it to work here and I tried various
>>>>> combinations
>>>>>
>>>>>>
>>>>>> Reproducer, on F34,
>>>>>> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
>>>>>> mkdir: cannot create directory
>>>>>> ‘/sys/fs/cgroup/system.slice/.snapshots’: Permission denied
>>>>>> $ sudo ausearch -m AVC -ts recent -i
>>>>>> ----
>>>>>> type=AVC msg=audit(03/20/2023 13:00:04.699:47156) : avc:  denied  {
>>>>>> associate } for  pid=152325 comm=mkdir name=.snapshots
>>>>>> scontext=unconfined_u:object_r:snapperd_data_t:s0
>>>>>> tcontext=system_u:object_r:cgroup_t:s0 tclass=filesystem permissive=0
>>>>>> $ seinfo --fs_use | grep cgroup
>>>>>> $ seinfo --genfscon | grep cgroup
>>>>>>     genfscon cgroup /  system_u:object_r:cgroup_t:s0
>>>>>>     genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
>>>>>> $ sesearch -T -s unconfined_t -t cgroup_t -c dir
>>>>>> type_transition unconfined_t cgroup_t:dir snapperd_data_t .snapshots
>>>>>> $ sudo setenforce 0
>>>>>> $ sudo mkdir /sys/fs/cgroup/system.slice/.snapshots
>>>>>> $ ls -Zd /sys/fs/cgroup/system.slice/.snapshots
>>>>>> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/.snapshots
>>>>>
>>>>> --
>>>>> gpg --locate-keys dominick.grift@defensec.nl
>>>>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>>>>> Dominick Grift
>>>>
>>>> Debian sid (Linux debianBullseye 6.1.0-6-amd64 #1 SMP PREEMPT_DYNAMIC
>>>> Debian 6.1.15-1 (2023-03-05) x86_64 GNU/Linux):
>>>>
>>>> type cgroup_test_t;
>>>> allow cgroup_test_t cgroup_t:filesystem associate;
>>>> filetrans_pattern(sysadm_t, cgroup_t, cgroup_test_t, dir, "testdir")
>>>> allow sysadm_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
>>>> allow sysadm_t cgroup_test_t:file getattr;
>>>>
>>>>
>>>> $ seinfo --all | grep cgroup
>>>> genfscon cgroup /  system_u:object_r:cgroup_t:s0
>>>> genfscon cgroup2 /  system_u:object_r:cgroup_t:s0
>>>> genfscon proc /cgroups  system_u:object_r:proc_info_t:s0
>>>> cgroup_seclabel
>>>> cgroup_t
>>>> cgroup_test_t
>>>> systemd_cgroups_agent_exec_t
>>>> systemd_cgroups_agent_runtime_t
>>>> systemd_cgroups_agent_t
>>>>
>>>>
>>>> $ grep cgroup /etc/selinux/debian/contexts/files/file_contexts
>>>> /cgroup/.*              <<none>>
>>>> /sys/fs/cgroup/.*               <<none>>
>>>> /sys/fs/cgroup/[^/]+            -l      system_u:object_r:cgroup_t:s0
>>>> /cgroup         -d      system_u:object_r:cgroup_t:s0
>>>> /sys/fs/cgroup          -d      system_u:object_r:cgroup_t:s0
>>>> /usr/lib/systemd/systemd-cgroups-agent          --
>>>> system_u:object_r:systemd_cgroups_agent_exec_t:s0
>>>>
>>>>
>>>> $ mkdir /sys/fs/cgroup/system.slice/testdir
>>>> $ ls -laZ /sys/fs/cgroup/system.slice/testdir/
>>>> total 0
>>>> drwxr-x---.  2 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
>>>> .
>>>> drwxr-xr-x. 19 root root system_u:object_r:cgroup_t:s0  0 Mar 20 19:19
>>>> ..
>>>> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
>>>> cgroup.controllers
>>>> -r--r--r--.  1 root root root:object_r:cgroup_test_t:s0 0 Mar 20 19:19
>>>> cgroup.events
>>>
>>> Hmm...I don't get the same result with 6.1.14-200.fc37.x86_64, using
>>> the corresponding slightly tweaked policy module:
>>> policy_module(cgrouptest, 1.0)
>>> require {
>>> type cgroup_t;
>>> type unconfined_t;
>>> }
>>> type cgroup_test_t;
>>> allow cgroup_test_t cgroup_t:filesystem associate;
>>> filetrans_pattern(unconfined_t, cgroup_t, cgroup_test_t, dir, "testdir")
>>> allow unconfined_t cgroup_test_t:dir { create_dir_perms list_dir_perms };
>>> allow unconfined_t cgroup_test_t:file getattr;
>>>
>>> That's on Fedora 37, not 34, sorry for the typo.
>>
>> Ah, now I remembered that we made it such that the transitions would
>> only apply if the parent directory has a label explicitly set by
>> userspace (via setxattr). Not sure if we can improve it easily, since
>> we can't use the normal inode-based logic for cgroupfs (the xattrs are
>> stored in kernfs nodes, each of which can be exposed via multiple
>> inodes if there is more than one cgroupfs mount).
> 
> Thanks. I can confirm that this indeed enabled transition functionality.
> 
> It does not solve my memory.pressure challenge but I implementing it
> regardless in hopes that it addresses the races I encountered when
> solely relying on genfscon for user.slice
> 
> https://git.defensec.nl/?p=dssp5.git;a=commitdiff;h=1920c9f751445bfd51f43a7c4e9b7fedda057d15
> 
> We should probably document this "gotcha" in the selinux-notebook
> 

Just to unify some other threads of conversation that has been going on 
for this.

I helped the author of the initial PR that started this discussion.  We 
knew we needed a new unique label and I suggested that we try a named 
file trans pattern from init_t just to see if it works, and it seemed to 
right out of the gates.  We didn't need to flip any other switches on 
our test environment.

Here is an example of an AVC we are seeing:
AVC avc:  denied  { getattr } for  pid=5953 comm="systemd" 
path="/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/memory.pressure" 
dev="cgroup2" ino=27721 scontext=unconfined_u:unconfined_r:unconfined_t 
tcontext=system_u:object_r:memory_pressure_t tclass=file permissive=0

I do fear there is something different from the other folks that have 
tested this and our setup, since out setup is fairly bespoke compared to 
your standard Linux distro.  But off the top of my head I don't know any 
special setting we would have in place to make this work.
