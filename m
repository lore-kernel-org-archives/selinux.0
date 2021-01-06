Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825ACC433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2507923100
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 14:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFOly (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFOly (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 09:41:54 -0500
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C61DC06134C
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 06:41:14 -0800 (PST)
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id F06B52A0065;
        Wed,  6 Jan 2021 15:41:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl F06B52A0065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1609944072;
        bh=quYUTIaVJmRvJOReGrpulMZ8trD+TWUpwV05McfTdnM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TMIHB5042s/EpvYYxuOCQnZsCmlekT75ZzNnbzHRZqC86WGsQsl6V2jZuw42C+dwR
         Lmx8THjAEvfSgakcpNjux2VyNBTkYuXdq9zv+jVgmY3pf7yX0m0rrlgEXIrgl6THxd
         EnadNCvupa9GZBoqqreE3xd6GXhTt3hiI6cOgYuU=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Selinux context type is same for root & normal user both
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
        <ypjlzh1o523g.fsf@defensec.nl>
        <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
        <ypjlv9cc50hj.fsf@defensec.nl>
        <CAP2OjciUpv0BKDTeRV=ahJ3f2d98RzXXMEAdbtk=HSCpXdxGuA@mail.gmail.com>
Date:   Wed, 06 Jan 2021 15:41:08 +0100
In-Reply-To: <CAP2OjciUpv0BKDTeRV=ahJ3f2d98RzXXMEAdbtk=HSCpXdxGuA@mail.gmail.com>
        (Ashish Mishra's message of "Wed, 6 Jan 2021 19:57:10 +0530")
Message-ID: <ypjl1reygmbf.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Dominick ,
>
> 1) Thanks for pointers .
>      I will look at the suggestion for login programs.
>
> 2) The major discrepancy which i am observing is all the folder and files across
>      filesystem have same context "system_u:object_r:root_t"
>      Like /etc ,  /var , /bin , /root etc all folders & files have
> this same context .
>      Attached is the context log for the folder.

Can you also enclose the output of the `mount` command? It might help to
give us an idea of your filesystem requirements


>
> Any feedback / pointer on point-2 will be helpful .
> I will evaluate the point-1 as suggested .
>
> Thanks for sharing valuable info.
> Ashish
>
> home # ps -Z
>   PID CONTEXT                          STAT COMMAND
>     1 system_u:system_r:kernel_t       S    init
>     2 system_u:system_r:kernel_t       SW   [kthreadd]
>     3 system_u:system_r:kernel_t       SW   [ksoftirqd/0]
>     4 system_u:system_r:kernel_t       SW   [kworker/0:0]
>     5 system_u:system_r:kernel_t       SW<  [kworker/0:0H]
>     6 system_u:system_r:kernel_t       SW   [kworker/u8:0]
>     7 system_u:system_r:kernel_t       SW   [rcu_sched]
>     8 system_u:system_r:kernel_t       SW   [rcu_bh]
>     9 system_u:system_r:kernel_t       SW   [migration/0]
>    10 system_u:system_r:kernel_t       SW<  [lru-add-drain]
>    11 system_u:system_r:kernel_t       SW   [cpuhp/0]
>    12 system_u:system_r:kernel_t       SW   [kdevtmpfs]
>    13 system_u:system_r:kernel_t       SW<  [netns]
>    14 system_u:system_r:kernel_t       SW   [oom_reaper]
>    15 system_u:system_r:kernel_t       SW   [kworker/u8:1]
>   124 system_u:system_r:kernel_t       SW<  [writeback]
>   126 system_u:system_r:kernel_t       SW   [kcompactd0]
>   127 system_u:system_r:kernel_t       SW<  [bioset]
>   129 system_u:system_r:kernel_t       SW<  [kblockd]
>   151 system_u:system_r:kernel_t       SW   [kworker/0:1]
>   167 system_u:system_r:kernel_t       SW   [kswapd0]
>   168 system_u:system_r:kernel_t       SW<  [vmstat]
>   787 system_u:system_r:kernel_t       SW<  [ipv6_addrconf]
>   798 system_u:system_r:kernel_t       S    syslogd
>   805 system_u:system_r:kernel_t       S<   auditd
>   808 system_u:system_r:kernel_t       SW   [kauditd]
>   859 system_u:system_r:kernel_t       R    /bin/sm_manager
>   861 system_u:system_r:kernel_t       S    /bin/sh
>   880 system_u:system_r:kernel_t       R    ps -Z
> /home # 
> /home # 
> /home # 
> /home # ls
> test      testfile
> /home # cd  
> ~ # ls
> bin      etc      lib      lxc      proc     share    usr
> dev      home     lib64    mnt      root     sys      var
> drivers  init     linuxrc  mnth     sbin     tmp
> ~ # cd /etc/
> /etc # ls
> audisp         gshadow        mtab           selinux        udhcpd.conf
> audit          host.conf      pam.d          sestatus.conf  xattr.conf
> default        hosts          passwd         shadow
> environment    inittab        protocols      subgid
> fstab          libaudit.conf  rc.d           subuid
> group          lxc            security       sysconfig
> /etc # cd 
> ~ # ls
> bin      etc      lib      lxc      proc     share    usr
> dev      home     lib64    mnt      root     sys      var
> drivers  init     linuxrc  mnth     sbin     tmp
> ~ # 
> ~ # 
> ~ # ls -alZ bin/
> drwxr-xr-x    2 root     root     system_u:object_r:root_t              1620 Jan  4 23:29 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 arch -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ash -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t           1267040 Jan  4 23:29 bash
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t           1593984 Jan  4 23:29 busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 cat -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t              7664 Jan  4 23:29 cav_sh
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chattr -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chgrp -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chmod -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chown -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 cp -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 cttyhack -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 date -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 dd -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t               200 Jan  4 23:29 delete_smapp.sh
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 df -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 dmesg -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 echo -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 egrep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 false -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fatattr -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fdflush -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fgrep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fsync -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 getopt -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 grep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 gunzip -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 gzip -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ionice -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 iostat -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 kill -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 link -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 linux32 -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 linux64 -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ln -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 login -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ls -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t              7736 Jan  4 23:29 lsmod
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t            128952 Jan  4 23:29 lspci
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mkdir -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mknod -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mktemp -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 more -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mount -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mountpoint -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mv -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 nice -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 nuke -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 pidof -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 pipe_progress -> /bin/busybox
> ~ # ls -alZ etc
> drwxr-xr-x   11 root     root     system_u:object_r:root_t               560 Jan  6 12:37 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> drwxr-xr-x    3 root     root     system_u:object_r:root_t               100 Jan  4 23:07 audisp
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                80 Jan  4 23:07 audit
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:17 default
> -rw-r--r--    1 root     root     system_u:object_r:root_t                97 Jan  4 23:17 environment
> -rw-r--r--    1 root     root     system_u:object_r:root_t               330 Jan  4 23:09 fstab
> -rw-r--r--    1 root     root     system_u:object_r:root_t                21 Jan  4 23:09 group
> -rw-r--r--    1 root     root     system_u:object_r:root_t                 9 Jan  4 23:09 gshadow
> -rw-r--r--    1 root     root     system_u:object_r:root_t                17 Jan  4 23:09 host.conf
> -rw-r--r--    1 root     root     system_u:object_r:root_t                20 Jan  4 23:09 hosts
> -rw-r--r--    1 root     root     system_u:object_r:root_t                55 Jan  4 23:09 inittab
> -rw-r-----    1 root     root     system_u:object_r:root_t               191 Jan  4 23:07 libaudit.conf
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:17 lxc
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mtab -> /proc/mounts
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                40 Jan  4 23:08 pam.d
> -rw-r--r--    1 root     root     system_u:object_r:root_t                70 Jan  4 23:09 passwd
> -rw-r--r--    1 root     root     system_u:object_r:root_t              6108 Jan  4 23:09 protocols
> drwxr-xr-x    3 root     root     system_u:object_r:root_t                60 Jan  4 23:07 rc.d
> drwxr-xr-x    4 root     root     system_u:object_r:root_t               260 Jan  4 23:18 security
> drwxr-xr-x    3 root     root     system_u:object_r:root_t               100 Jan  4 23:29 selinux
> -rw-r--r--    1 root     root     system_u:object_r:root_t               216 Jan  4 23:08 sestatus.conf
> -rw-r--r--    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 shadow
> -rw-r--r--    1 root     root     system_u:object_r:root_t                19 Jan  6 12:37 subgid
> -rw-r--r--    1 root     root     system_u:object_r:root_t                19 Jan  6 12:37 subuid
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:07 sysconfig
> -rw-r--r--    1 root     root     system_u:object_r:root_t              3048 Jan  4 23:09 udhcpd.conf
> -rw-r--r--    1 root     root     system_u:object_r:root_t               642 Jan  4 23:13 xattr.conf
> ~ # ls
> bin      etc      lib      lxc      proc     share    usr
> dev      home     lib64    mnt      root     sys      var
> drivers  init     linuxrc  mnth     sbin     tmp
> ~ # ^C
> ~ # ls -alZ bin
> drwxr-xr-x    2 root     root     system_u:object_r:root_t              1620 Jan  4 23:29 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 arch -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ash -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t           1267040 Jan  4 23:29 bash
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t           1593984 Jan  4 23:29 busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 cat -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t              7664 Jan  4 23:29 cav_sh
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chattr -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chgrp -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chmod -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 chown -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 cp -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 cttyhack -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 date -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 dd -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t               200 Jan  4 23:29 delete_smapp.sh
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 df -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 dmesg -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 echo -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 egrep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 false -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fatattr -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fdflush -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fgrep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 fsync -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 getopt -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 grep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 gunzip -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 gzip -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ionice -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 iostat -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 kill -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 link -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 linux32 -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 linux64 -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ln -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 login -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ls -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t              7736 Jan  4 23:29 lsmod
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t            128952 Jan  4 23:29 lspci
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mkdir -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mknod -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mktemp -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 more -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mount -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mountpoint -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mv -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 nice -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 nuke -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 pidof -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 pipe_progress -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t             13397 Jan  4 23:29 pow_test
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 printenv -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 ps -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 pwd -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 resume -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 rev -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 rm -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 rmdir -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 sed -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t             61160 Jan  4 23:29 setpci
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 setpriv -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 sh -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 sleep -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t            298279 Jan  4 23:29 sm_manager
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t               781 Jan  4 23:29 smapp_manage.sh
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 stat -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 stty -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 su -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 sync -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 tar -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 touch -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 true -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 umount -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 uname -> /bin/busybox
> -rwxr-xr-x    1 root     root     system_u:object_r:root_t              1340 Jan  4 23:29 upgrade_smapp.sh
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 usleep -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 vi -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 watch -> /bin/busybox
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 zcat -> /bin/busybox
> ~ # ls -alZ etc
> drwxr-xr-x   11 root     root     system_u:object_r:root_t               560 Jan  6 12:37 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> drwxr-xr-x    3 root     root     system_u:object_r:root_t               100 Jan  4 23:07 audisp
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                80 Jan  4 23:07 audit
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:17 default
> -rw-r--r--    1 root     root     system_u:object_r:root_t                97 Jan  4 23:17 environment
> -rw-r--r--    1 root     root     system_u:object_r:root_t               330 Jan  4 23:09 fstab
> -rw-r--r--    1 root     root     system_u:object_r:root_t                21 Jan  4 23:09 group
> -rw-r--r--    1 root     root     system_u:object_r:root_t                 9 Jan  4 23:09 gshadow
> -rw-r--r--    1 root     root     system_u:object_r:root_t                17 Jan  4 23:09 host.conf
> -rw-r--r--    1 root     root     system_u:object_r:root_t                20 Jan  4 23:09 hosts
> -rw-r--r--    1 root     root     system_u:object_r:root_t                55 Jan  4 23:09 inittab
> -rw-r-----    1 root     root     system_u:object_r:root_t               191 Jan  4 23:07 libaudit.conf
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:17 lxc
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 mtab -> /proc/mounts
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                40 Jan  4 23:08 pam.d
> -rw-r--r--    1 root     root     system_u:object_r:root_t                70 Jan  4 23:09 passwd
> -rw-r--r--    1 root     root     system_u:object_r:root_t              6108 Jan  4 23:09 protocols
> drwxr-xr-x    3 root     root     system_u:object_r:root_t                60 Jan  4 23:07 rc.d
> drwxr-xr-x    4 root     root     system_u:object_r:root_t               260 Jan  4 23:18 security
> drwxr-xr-x    3 root     root     system_u:object_r:root_t               100 Jan  4 23:29 selinux
> -rw-r--r--    1 root     root     system_u:object_r:root_t               216 Jan  4 23:08 sestatus.conf
> -rw-r--r--    1 root     root     system_u:object_r:root_t                12 Jan  4 23:09 shadow
> -rw-r--r--    1 root     root     system_u:object_r:root_t                19 Jan  6 12:37 subgid
> -rw-r--r--    1 root     root     system_u:object_r:root_t                19 Jan  6 12:37 subuid
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:07 sysconfig
> -rw-r--r--    1 root     root     system_u:object_r:root_t              3048 Jan  4 23:09 udhcpd.conf
> -rw-r--r--    1 root     root     system_u:object_r:root_t               642 Jan  4 23:13 xattr.conf
> ~ # ls -alZ lib
> drwxr-xr-x    3 root     root     system_u:object_r:root_t                60 Jan  4 23:07 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> drwxr-xr-x    3 root     root     system_u:object_r:root_t                60 Jan  4 23:07 modules
> ~ # ls -alZ li
> lib/     lib64/   linuxrc
> ~ # ls -alZ li
> lib/     lib64/   linuxrc
> ~ # ls -alZ li64
> ls: li64: No such file or directory
> ~ # ls -alZ lib64
> drwxr-xr-x    3 root     root     system_u:object_r:root_t              1320 Jan  4 23:29 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            210624 Jan  4 23:29 ld-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                10 Jan  4 23:29 ld.so.1 -> ld-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             67824 Jan  4 23:29 libBrokenLocale-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                23 Jan  4 23:29 libBrokenLocale.so.1 -> libBrokenLocale-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             71182 Jan  4 23:29 libSegFault.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             68768 Jan  4 23:29 libanl-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                14 Jan  4 23:29 libanl.so.1 -> libanl-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                16 Jan  4 23:29 libasan.so.0 -> libasan.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            215896 Jan  4 23:29 libasan.so.0.0.0
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                18 Jan  4 23:29 libatomic.so.1 -> libatomic.so.1.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             35056 Jan  4 23:29 libatomic.so.1.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t           1946544 Jan  4 23:29 libc-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:29 libc.so.6 -> libc-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            200408 Jan  4 23:29 libcidn-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                15 Jan  4 23:29 libcidn.so.1 -> libcidn-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             69416 Jan  4 23:29 libcrypt-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                16 Jan  4 23:29 libcrypt.so.1 -> libcrypt-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             68920 Jan  4 23:29 libdl-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                13 Jan  4 23:29 libdl.so.2 -> libdl-2.16.so
> -r--r--r--    1 root     root     system_u:object_r:root_t            161643 Jan  4 23:29 libgcc_s.so.1
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                16 Jan  4 23:29 libgomp.so.1 -> libgomp.so.1.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             87728 Jan  4 23:29 libgomp.so.1.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t           1006288 Jan  4 23:29 libm-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                12 Jan  4 23:29 libm.so.6 -> libm-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             73221 Jan  4 23:29 libmemusage.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                19 Jan  4 23:29 libmudflap.so.0 -> libmudflap.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            209120 Jan  4 23:29 libmudflap.so.0.0.0
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                21 Jan  4 23:29 libmudflapth.so.0 -> libmudflapth.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            209592 Jan  4 23:29 libmudflapth.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            140688 Jan  4 23:29 libnsl-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                14 Jan  4 23:29 libnsl.so.1 -> libnsl-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             70352 Jan  4 23:29 libnss_compat-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                21 Jan  4 23:29 libnss_compat.so.2 -> libnss_compat-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             71056 Jan  4 23:29 libnss_db-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                17 Jan  4 23:29 libnss_db.so.2 -> libnss_db-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             68520 Jan  4 23:29 libnss_dns-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                18 Jan  4 23:29 libnss_dns.so.2 -> libnss_dns-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             72024 Jan  4 23:29 libnss_files-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                20 Jan  4 23:29 libnss_files.so.2 -> libnss_files-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             69248 Jan  4 23:29 libnss_hesiod-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                21 Jan  4 23:29 libnss_hesiod.so.2 -> libnss_hesiod-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             70800 Jan  4 23:29 libnss_nis-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                18 Jan  4 23:29 libnss_nis.so.2 -> libnss_nis-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             71040 Jan  4 23:29 libnss_nisplus-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                22 Jan  4 23:29 libnss_nisplus.so.2 -> libnss_nisplus-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             70402 Jan  4 23:29 libpcprofile.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            143640 Jan  4 23:29 libpthread-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                18 Jan  4 23:29 libpthread.so.0 -> libpthread-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            138480 Jan  4 23:29 libresolv-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                17 Jan  4 23:29 libresolv.so.2 -> libresolv-2.16.so
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             71296 Jan  4 23:29 librt-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                13 Jan  4 23:29 librt.so.1 -> librt-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                15 Jan  4 23:29 libssp.so.0 -> libssp.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             11488 Jan  4 23:29 libssp.so.0.0.0
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                19 Jan  4 23:29 libstdc++.so.6 -> libstdc++.so.6.0.17
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t           1198520 Jan  4 23:29 libstdc++.so.6.0.17
> -rw-r--r--    1 root     root     system_u:object_r:root_t              2436 Jan  4 23:29 libstdc++.so.6.0.17-gdb.py
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             70256 Jan  4 23:29 libthread_db-1.0.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                19 Jan  4 23:29 libthread_db.so.1 -> libthread_db-1.0.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                17 Jan  4 23:29 libubsan.so.0 -> libubsan.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t            606176 Jan  4 23:29 libubsan.so.0.0.0
> -r-xr-xr-x    1 root     root     system_u:object_r:root_t             68344 Jan  4 23:29 libutil-2.16.so
> lrwxrwxrwx    1 root     root     system_u:object_r:root_t                15 Jan  4 23:29 libutil.so.1 -> libutil-2.16.so
> drwxr-xr-x    2 root     root     system_u:object_r:root_t              1440 Jan  4 23:29 octeon2
> ~ # ls -alZ drivers
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                60 Jan  4 23:29 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> -rw-r--r--    1 root     root     system_u:object_r:root_t             14558 Jan  4 23:29 pow_drv.ko
> ~ # 
> ~ # 
> ~ # ls -alZ tmp
> drwxr-xr-x    2 root     root     system_u:object_r:root_t                40 Jan  4 23:09 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> ~ # 
> ~ # 
> ~ # 
> ~ # ls /
> bin      etc      lib      lxc      proc     share    usr
> dev      home     lib64    mnt      root     sys      var
> drivers  init     linuxrc  mnth     sbin     tmp
> ~ # ls -alZ var/
> drwxr-xr-x    6 root     root     system_u:object_r:root_t               120 Jan  6 12:37 .
> drwxr-xr-x   20 root     root     system_u:object_r:root_t               460 Jan  6 12:38 ..
> drwxr-xr-x    3 root     root     system_u:object_r:root_t                60 Jan  4 23:17 cache
> drwxr-xr-x    4 root     root     system_u:object_r:root_t                80 Jan  4 23:17 lib
> drwxr-xr-x    3 root     root     system_u:object_r:root_t                80 Jan  6 12:37 log
> drwxr-xr-x    4 root     root     system_u:object_r:root_t               140 Jan  6 12:37 run
> ~ # 
>  CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.6.2  | VT102 |      Offline                                                                  
>
>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
