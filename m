Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2469C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8023106
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 14:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAFO4h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbhAFO4h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 09:56:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70AC06134D
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 06:55:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w5so2652564wrm.11
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mzknK6bwcXQdhZ3YeaPrbrlnHBksxW9tWP6MlbNQUg=;
        b=APwxD8AcTs2eHvj4Eo/r5hugOOoRkfdSpINqOHYfVcS4c5BJvG1LTLQ3y7QBzBzLmI
         R7dMBosdN/O+QF8FZfrxHV6TkyvCkQG4lS+Ak5A8Pel94ccxjttS1zTSKW9H8BPmTyWf
         0b/NFE8S42Tp6/DScgKwLR8DYLybaU+OiRDfBkDEMkbQEf396nChyOaUHvMlf/B2ELhh
         sr/VocngMkPRDMKEPrLICyoCl7YK2rnSWv9MiXqGejW1a2aIlnyDGeR72Hoytyhi8GAd
         X4vX45vEJNtKLFpx8+tWWMxhNVmoem3ywhWN8eSauIUo/TjzFHM+dqTFl2UcKL7UNl7t
         4eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mzknK6bwcXQdhZ3YeaPrbrlnHBksxW9tWP6MlbNQUg=;
        b=tmUfL9P5i9J1RHGgncKCKKMocDdKHjBeeUX46mbVsbg4zgfvatfNE1qlURNZ3444zd
         9EPw/EitixPNSxOoAhXUIWaDT/1/nl/Zu0zygrwPC2N2oL/CBVFqprmVpjIbasa0dAXt
         IbrsUEA8mZTbQ+SB0Pg94ty0KY4DNKzLd9TBb1tqfHsgilr7n7rFKggttqnTy90Y6H8s
         0RDDIthRCXq48A7PxlrWMuaPzPxCICHtfPtJnI2n8aZPFTVOeuZsFC61THUUgAwayHhN
         gPzwLTVNNZhe5eBMzImsiIa+XgO95OWqO3KHfePZ86HV54hM+3mOTUGkZ6aEWGZLXgSV
         8NjQ==
X-Gm-Message-State: AOAM5336fOd1zeZveyLM71u3B6zZUdj435msGUcPEgCz96iJlftcfUrv
        kEj7LlTNTBSr5Du+NJ1IQ6gSy+oDmH6Bduk6saJ4WQ==
X-Google-Smtp-Source: ABdhPJyxjz3la8lEGbDFhLO969nTLCDycJFsCcsh+y+OGO4uJoAtyP0hHg24EXuFjgy+Go87p/1wkeYjkt7UgdlPzQc=
X-Received: by 2002:adf:84c1:: with SMTP id 59mr4806637wrg.409.1609944955314;
 Wed, 06 Jan 2021 06:55:55 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl> <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
 <ypjlv9cc50hj.fsf@defensec.nl> <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
 <ypjla6tmgoka.fsf@defensec.nl> <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
 <ypjl5z4agmt4.fsf@defensec.nl>
In-Reply-To: <ypjl5z4agmt4.fsf@defensec.nl>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Wed, 6 Jan 2021 20:25:44 +0530
Message-ID: <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dominick ,
Thanks for your valuable time and inputs .

As a background w.r.t ROOTFS :
a) We had an custom SDK which is a basic makefile based SDK .

b) The rootfs was RAMFS based .
     For selinux we switched from RAMFS to TEMPFS

c) It was not having SELINUX , so we added refpolicy & selinux-userland
     Expectation was we will get working selinux context & policy.
     I have the policy but the context is being the same for each file
and folder .

d)  The setup is being evaluated for tempfs ( INITRAMFS-as -TEMPFS +
SELINUX ) w.r.t output of mount command :
~ # mount
rootfs on / type rootfs (rw,seclabel,size=253620k,nr_inodes=63405)
sysfs on /sys type sysfs (rw,seclabel,relatime)
selinuxfs on /sys/fs/selinux type selinuxfs (rw,nosuid,noexec,relatime)
nodev on /dev type devtmpfs
(rw,seclabel,relatime,size=253620k,nr_inodes=63405,mode=755)
none on /proc type proc (rw,relatime)
none on /dev/shm type tmpfs (rw,seclabel,relatime)
none on /dev/pts type devpts (rw,seclabel,relatime,mode=600,ptmxmode=000)
none on /sys/kernel/debug type debugfs (rw,seclabel,relatime)
none on /mnth type hugetlbfs (rw,seclabel,relatime)
cgroup on /sys/fs/cgroup type tmpfs (rw,seclabel,relatime,mode=755)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,relatime,cpuset)
cgroup on /sys/fs/cgroup/cpu type cgroup (rw,relatime,cpu)
cgroup on /sys/fs/cgroup/cpuacct type cgroup (rw,relatime,cpuacct)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,relatime,blkio)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,relatime,memory)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,relatime,devices)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,relatime,freezer)
cgroup on /sys/fs/cgroup/net_cls type cgroup (rw,relatime,net_cls)
cgroup on /sys/fs/cgroup/net_prio type cgroup (rw,relatime,net_prio)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,relatime,hugetlb)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,relatime,pids)
cgroup on /sys/fs/cgroup/debug type cgroup (rw,relatime,debug)
cgroups on /sys/fs/cgroup/unified type cgroup2 (rw,relatime)


Thanks ,
Ashish
