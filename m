Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B927BC433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 15:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FCE2311A
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 15:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbhAFPFg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 10:05:36 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:59080 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbhAFPFf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Jan 2021 10:05:35 -0500
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 0EF0B2A0FFE;
        Wed,  6 Jan 2021 16:04:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 0EF0B2A0FFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1609945494;
        bh=e7RNBTx4+aJW+DQgIO3kwyMcHzYed2MfkDr+rfu/SOA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=p0YmGmC/nJYydZmahjQLyUV9K6C/4JLWgzu80sITrOv5pj8DxqY97kMamocLDjgLI
         G/X/IOJjUg1uHOeyAs7JZDj+k6G4EUqWmBIOXuMOED9N0ESilnV7amqMc+JXnqW1QN
         DHzxVBr3Jt73xVco+mSO4zDe4BnSmX4u5tW+2jmI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Selinux context type is same for root & normal user both
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
        <ypjlzh1o523g.fsf@defensec.nl>
        <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
        <ypjlv9cc50hj.fsf@defensec.nl>
        <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
        <ypjla6tmgoka.fsf@defensec.nl>
        <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
        <ypjl5z4agmt4.fsf@defensec.nl>
        <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
Date:   Wed, 06 Jan 2021 16:04:50 +0100
In-Reply-To: <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
        (Ashish Mishra's message of "Wed, 6 Jan 2021 20:25:44 +0530")
Message-ID: <ypjlsg7ef6nh.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Dominick ,
> Thanks for your valuable time and inputs .
>
> As a background w.r.t ROOTFS :
> a) We had an custom SDK which is a basic makefile based SDK .
>
> b) The rootfs was RAMFS based .
>      For selinux we switched from RAMFS to TEMPFS
>
> c) It was not having SELINUX , so we added refpolicy & selinux-userland
>      Expectation was we will get working selinux context & policy.
>      I have the policy but the context is being the same for each file
> and folder .

You also have to address labeling. If your filesystem is ram-based
(volatile) then I
suspect you will have to address labeling at runtime (ie run
setfiles/restorecon to label the filesystem). The point is that
your filesystem is currently not labeled according to the reference
policy.

>
> d)  The setup is being evaluated for tempfs ( INITRAMFS-as -TEMPFS +
> SELINUX ) w.r.t output of mount command :
> ~ # mount
> rootfs on / type rootfs (rw,seclabel,size=253620k,nr_inodes=63405)
> sysfs on /sys type sysfs (rw,seclabel,relatime)
> selinuxfs on /sys/fs/selinux type selinuxfs (rw,nosuid,noexec,relatime)
> nodev on /dev type devtmpfs
> (rw,seclabel,relatime,size=253620k,nr_inodes=63405,mode=755)
> none on /proc type proc (rw,relatime)
> none on /dev/shm type tmpfs (rw,seclabel,relatime)
> none on /dev/pts type devpts (rw,seclabel,relatime,mode=600,ptmxmode=000)
> none on /sys/kernel/debug type debugfs (rw,seclabel,relatime)
> none on /mnth type hugetlbfs (rw,seclabel,relatime)
> cgroup on /sys/fs/cgroup type tmpfs (rw,seclabel,relatime,mode=755)
> cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,relatime,cpuset)
> cgroup on /sys/fs/cgroup/cpu type cgroup (rw,relatime,cpu)
> cgroup on /sys/fs/cgroup/cpuacct type cgroup (rw,relatime,cpuacct)
> cgroup on /sys/fs/cgroup/blkio type cgroup (rw,relatime,blkio)
> cgroup on /sys/fs/cgroup/memory type cgroup (rw,relatime,memory)
> cgroup on /sys/fs/cgroup/devices type cgroup (rw,relatime,devices)
> cgroup on /sys/fs/cgroup/freezer type cgroup (rw,relatime,freezer)
> cgroup on /sys/fs/cgroup/net_cls type cgroup (rw,relatime,net_cls)
> cgroup on /sys/fs/cgroup/net_prio type cgroup (rw,relatime,net_prio)
> cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,relatime,hugetlb)
> cgroup on /sys/fs/cgroup/pids type cgroup (rw,relatime,pids)
> cgroup on /sys/fs/cgroup/debug type cgroup (rw,relatime,debug)
> cgroups on /sys/fs/cgroup/unified type cgroup2 (rw,relatime)
>
>
> Thanks ,
> Ashish

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
