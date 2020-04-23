Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9957C55186
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 08:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13C7208E4
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 08:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrX6OVsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDWIZZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:25:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgDWIZY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 04:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587630321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AItTxPIBy/jCyTyuEH+Ps+XDg2uRUQYi74nyNPUSxrU=;
        b=WrX6OVsNTQ+REk+jM83kDFCswg7thmCd6HJIQ9uTDbGedbJFGZfBdtwt/WjSeWFOsw3F4n
        4KXCCKAdC1qe/lC6t3NY4SpIByQ7b6R3vVZil1oP+8wwsST0myqKXdyev+qfr4+RoyFqvz
        mn9fZVpKeL6zXwpNkOJ3B6dOQqceDtE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-FM6g-vIYNcul_JIKIQ6C5Q-1; Thu, 23 Apr 2020 04:25:18 -0400
X-MC-Unique: FM6g-vIYNcul_JIKIQ6C5Q-1
Received: by mail-ot1-f71.google.com with SMTP id k11so3309044otc.8
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2020 01:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AItTxPIBy/jCyTyuEH+Ps+XDg2uRUQYi74nyNPUSxrU=;
        b=LVnXKgWoQFxPqPErGYDRp0NzndLgUlhd06f+/l6yTzJu+bQvK7t/qvwXvwlb5TtLC2
         HuGtFCWjNzgkoqAqHpik8IQBvWxA5G0t/f7yl45tAv3lyqNYmViY5aBxPuqIsnPWoN0p
         djAjV7Kvz8KfG0ivLNAKRXsG1I1BO6B0Ej0n2+Gb1qjiJZ+D+eJvj0n/Z2yzGKEt+lWz
         QMYYrJATFltHy/716tmvDjupQFm2VmWJK2aPBztha20KrSBFNqEnrTj1p8rUtliyodc3
         GUadOvgzMwTaJrB+0krxz38fcdsb9oZ+scfohlnqSvbdIScu7Ws9PoSKVyw4DkvS/gFK
         iBIA==
X-Gm-Message-State: AGi0PuYS/bucOC4edIkpqTpuR20hRS/tSL6m8P69c87iESa4Y+KKSvBI
        J5pp6Q3vY6aqv0Mj0RoOpKlnmP3Zxy8a98RNlR3F4wgn64ZzlvimyXrPGOQgxea6sz+seiRFVVz
        mkllJdoUmysBMp9eiqu5Rg9toVNyMM+PzCg==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr2396561otb.367.1587630317292;
        Thu, 23 Apr 2020 01:25:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypIH//57xrps85hMQsMVVRUK63UZ26cuPeK4JlFc8pJ7ysmBZIY9Sp/mw9jpcqq/NonoI99xsmAP1vahwMi8Gxw=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr2396546otb.367.1587630316826;
 Thu, 23 Apr 2020 01:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <ebe1a7cc-6a42-0e2d-d704-23011ee2d1d3@gmail.com>
 <CAFqZXNsafaBpZ1x7f7xBYHbqFyPYx-9Tgy0pnCnNH6hY3CHW9A@mail.gmail.com> <CAEbUFv6bED87bk-bAyUoHkvRPxpP+vS0kzNUa88qZmeB=2O7YA@mail.gmail.com>
In-Reply-To: <CAEbUFv6bED87bk-bAyUoHkvRPxpP+vS0kzNUa88qZmeB=2O7YA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 23 Apr 2020 10:25:05 +0200
Message-ID: <CAFqZXNuyWmLZd+VOtW0jB=EXn3x1TUQSAnPTmUperaSi=Pzc0g@mail.gmail.com>
Subject: Re: ebitmap_node ate over 40GB of memory
To:     Bin <anole1949@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 23, 2020 at 9:50 AM Bin <anole1949@gmail.com> wrote:
> Dear Ondrej:
>
> I've added "slab_nomerge" in the kernel parameters, and after observation=
 for couple of days, I got this:
>
>
>  Active / Total Objects (% used)    : 83818306 / 84191607 (99.6%)
>  Active / Total Slabs (% used)      : 1336293 / 1336293 (100.0%)
>  Active / Total Caches (% used)     : 152 / 217 (70.0%)
>  Active / Total Size (% used)       : 5828768.08K / 5996848.72K (97.2%)
>  Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25K
>
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 80253888 80253888 100%    0.06K 1253967       64   5015868K iommu_iova

Well, that means the leak is caused by the "iommu_iova" kmem cache and
has nothing to with SELinux. I'd try luck on the iommu mailing list:
iommu@lists.linux-foundation.org

> 489472 489123  99%    0.03K   3824      128     15296K kmalloc-32
> 297444 271112  91%    0.19K   7082       42     56656K dentry
> 254400 252784  99%    0.06K   3975       64     15900K anon_vma_chain
> 222528  39255  17%    0.50K   6954       32    111264K kmalloc-512
> 202482 201814  99%    0.19K   4821       42     38568K vm_area_struct
> 200192 200192 100%    0.01K    391      512      1564K kmalloc-8
> 170528 169359  99%    0.25K   5329       32     42632K filp
> 158144 153508  97%    0.06K   2471       64      9884K kmalloc-64
> 149914 149365  99%    0.09K   3259       46     13036K anon_vma
> 146640 143123  97%    0.10K   3760       39     15040K buffer_head
> 130368  32791  25%    0.09K   3104       42     12416K kmalloc-96
> 129752 129752 100%    0.07K   2317       56      9268K Acpi-Operand
> 105468 105106  99%    0.04K   1034      102      4136K selinux_inode_secu=
rity
>  73080  73080 100%    0.13K   2436       30      9744K kernfs_node_cache
>  72360  70261  97%    0.59K   1340       54     42880K inode_cache
>  71040  71040 100%    0.12K   2220       32      8880K eventpoll_epi
>  68096  59262  87%    0.02K    266      256      1064K kmalloc-16
>  53652  53652 100%    0.04K    526      102      2104K pde_opener
>  50496  31654  62%    2.00K   3156       16    100992K kmalloc-2048
>  46242  46242 100%    0.19K   1101       42      8808K cred_jar
>  44496  43013  96%    0.66K    927       48     29664K proc_inode_cache
>  44352  44352 100%    0.06K    693       64      2772K task_delay_info
>  43516  43471  99%    0.69K    946       46     30272K sock_inode_cache
>  37856  27626  72%    1.00K   1183       32     37856K kmalloc-1024
>  36736  36736 100%    0.07K    656       56      2624K eventpoll_pwq
>  34076  31282  91%    0.57K   1217       28     19472K radix_tree_node
>  33660  30528  90%    1.05K   1122       30     35904K ext4_inode_cache
>  32760  30959  94%    0.19K    780       42      6240K kmalloc-192
>  32028  32028 100%    0.04K    314      102      1256K ext4_extent_status
>  30048  30048 100%    0.25K    939       32      7512K skbuff_head_cache
>  28736  28736 100%    0.06K    449       64      1796K fs_cache
>  24702  24702 100%    0.69K    537       46     17184K files_cache
>  23808  23808 100%    0.66K    496       48     15872K ovl_inode
>  23104  22945  99%    0.12K    722       32      2888K kmalloc-128
>  22724  21307  93%    0.69K    494       46     15808K shmem_inode_cache
>  21472  21472 100%    0.12K    671       32      2684K seq_file
>  19904  19904 100%    1.00K    622       32     19904K UNIX
>  17340  17340 100%    1.06K    578       30     18496K mm_struct
>  15980  15980 100%    0.02K     94      170       376K avtab_node
>  14070  14070 100%    1.06K    469       30     15008K signal_cache
>  13248  13248 100%    0.12K    414       32      1656K pid
>  12128  11777  97%    0.25K    379       32      3032K kmalloc-256
>  11008  11008 100%    0.02K     43      256       172K selinux_file_secur=
ity
>  10812  10812 100%    0.04K    106      102       424K Acpi-Namespace
>
> Is these info ring any bell for you?
>
> Ondrej Mosnacek <omosnace@redhat.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=889:44=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> On Wed, Apr 15, 2020 at 2:31 PM =E9=83=AD=E5=BD=AC <anole1949@gmail.com>=
 wrote:
>> > I'm running a batch of CoreOS boxes, the lsb_release is:
>> >
>> > ```
>> > # cat /etc/lsb-release
>> > DISTRIB_ID=3D"Container Linux by CoreOS"
>> > DISTRIB_RELEASE=3D2303.3.0
>> > DISTRIB_CODENAME=3D"Rhyolite"
>> > DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0 (Rhyolite)"
>> > ```
>> >
>> > ```
>> > # uname -a
>> > Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 201=
9
>> > x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Linu=
x
>> > ```
>> > Recently, I found my vms constently being killed due to OOM, and after
>> > digging into the problem, I finally realized that the kernel is leakin=
g
>> > memory.
>> >
>> > Here's my slabinfo:
>> >
>> > ```
>> > # slabtop --sort c -o
>> >   Active / Total Objects (% used)    : 739390584 / 740008326 (99.9%)
>> >   Active / Total Slabs (% used)      : 11594275 / 11594275 (100.0%)
>> >   Active / Total Caches (% used)     : 105 / 129 (81.4%)
>> >   Active / Total Size (% used)       : 47121380.33K / 47376581.93K (99=
.5%)
>> >   Minimum / Average / Maximum Object : 0.01K / 0.06K / 8.00K
>> >
>> >    OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>> > 734506368 734506368 100%    0.06K 11476662       64 45906648K ebitmap_=
node
>> [...]
>> > You can see that the `ebitmap_node` is over 40GB and still growing. Th=
e
>> > only thing I can do is rebooting the OS, but there are tens of them an=
d
>> > lots of workloads running on them, I can't just reboot whenever I want=
.
>> > So, I run out of options, any help?
>>
>> Pasting in relevant comments/questions from [1]:
>>
>> 2. Your kernel seems to be quite behind the current upstream and is
>> probably maintained by your distribution (seems to be derived from the
>> 4.19 stable branch). Can you reproduce the issue on a more recent
>> kernel (at least 5.5+)? If you can't or the recent kernel doesn't
>> exhibit the issue, then you should report this to your distribution.
>> 3. Was this working fine with some earlier kernel? If you can
>> determine the last working version, then it could help us identify the
>> cause and/or the fix.
>>
>> On top of that, I realized one more thing - the kernel merges the
>> caches for objects of the same size - so any cache with object size 64
>> bytes will be accounted under 'ebitmap_node' here. For example, on my
>> system there are several caches that all alias to the common 64-byte
>> cache:
>> # ls -l /sys/kernel/slab/ | grep -- '-> :0000064'
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 dmaengine-unmap-2 -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 ebitmap_node -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 fanotify_event -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 io -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 iommu_iova -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 jbd2_inode -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 ksm_rmap_item -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 ksm_stable_node -> :0000064
>> lrwxrwxrwx. 1 root root 0 apr 15 15:26 vmap_area -> :0000064
>>
>> On your kernel you might get a different list, but any of the caches
>> you get could be the culprit, ebitmap_node is just one of the
>> possibilities. You can disable this merging by adding "slab_nomerge"
>> to your kernel boot command-line. That will allow you to identify
>> which cache is really the source of the leak.
>>
>> [1] https://github.com/SELinuxProject/selinux/issues/220#issuecomment-61=
3944748
>>
>> --
>> Ondrej Mosnacek <omosnace at redhat dot com>
>> Software Engineer, Security Technologies
>> Red Hat, Inc.
>>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

