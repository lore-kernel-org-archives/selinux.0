Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E36C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B372311F
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 15:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAFPVn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 10:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAFPVn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 10:21:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8119FC06134C
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 07:21:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q18so2794921wrn.1
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnwmAxQF06ZbTXJKtGyJCaV03DELPkjZfOi/i3jCw1s=;
        b=NjxVaikFoeyAnHMCtluzoxCxyDEFVBiVBwp4bUavAO6Q4pNvTscLDSM3dQVMJoSTGp
         NinxEwB45uVkd3VBu75wSA0+iUdPXrgUVogLSJ1NimxGLyd3bJpxkUe3ED8Me9A4Wof3
         W7meq3/4FGxdGBjk2tUYOvkAoOAn/dGEJB5GzU9oVQz0Xmn/qu0JTLxkWAvTKe7vhGy7
         hn6KC5teUPFzolZK5WCDhh2j3HxCfcd5Yaidy4omQRKFSrFlkd46LlxttC1KHFosqnzj
         kaM0ZTGBAo0ginnHzPPXlL94fmJdgJxznDL+IdHMan1oLOLU23MHqXIX8VkOhHAMbxzW
         tuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnwmAxQF06ZbTXJKtGyJCaV03DELPkjZfOi/i3jCw1s=;
        b=uLjgFUqpepNcHBFnA5Dll2dJ4ru4zPkB7l8FupO2qwJjB4rJMB3JEgEOgiVhmfrbRb
         BUzg0KvDJzxNaVUQnWKXTwEeSB+PHy12dshNXDCyf+S5KdYVC59rUZBMJOEXFpdG7qDS
         NGfx2Akyl3QsjdCv25yjRK55LdbMAsT1lAo3/WIFuuh6CoKzPQpOGpPxLLrIxhwBWm4B
         N9isMpV42/VvoD+c9WCYgBeJWOsRln1vtf6piY1FAUQH0Fd8hdaTzT9G/QTaUp74cCFn
         ySUwp720G4THyH527j8zZWROFLK9hrly+1GvoHSfbqjBQ1cIhNuM3qrKeAFnAN6DK44R
         LL4A==
X-Gm-Message-State: AOAM530PAatqJFNoC8RP+BBXCI1MrcDrCLS21llZj8QaAbU8HGReHZYt
        UX7lAsSd6T31c9fAOHpEJ+oBDA1evwqVvvM518th1JK3G6Y5bQ==
X-Google-Smtp-Source: ABdhPJx/opnQgHhWqRNEUAhiD9dehmfVIRj+gbcgXmaPAWc8QeCyq6txkmOREEkBdjrkdm8CGwAJnEfQhNw0i3VWGts=
X-Received: by 2002:adf:df08:: with SMTP id y8mr4688817wrl.278.1609946461196;
 Wed, 06 Jan 2021 07:21:01 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
 <ypjlzh1o523g.fsf@defensec.nl> <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
 <ypjlv9cc50hj.fsf@defensec.nl> <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
 <ypjla6tmgoka.fsf@defensec.nl> <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
 <ypjl5z4agmt4.fsf@defensec.nl> <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
 <ypjlsg7ef6nh.fsf@defensec.nl>
In-Reply-To: <ypjlsg7ef6nh.fsf@defensec.nl>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Wed, 6 Jan 2021 20:50:50 +0530
Message-ID: <CAP2Ojcg5d=i0FKM0f1DTqtT2N3ftKEEqJq4=zdZr4m22xn4zjA@mail.gmail.com>
Subject: Re: Selinux context type is same for root & normal user both
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Dominick ,

Will look at the re-labelling as you suggested.
Is there any doc / blog / implementation etc to understand the
sequence and commands to do this.
To understand this step in a better way.

We are working with such a setup freshly so any inputs / guidance will
be helpful.

Thanks for your time & inputs for this long thread .

Thanks ,
Ashish










On Wed, Jan 6, 2021 at 8:34 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ashish Mishra <ashishm@mvista.com> writes:
>
> > Hi Dominick ,
> > Thanks for your valuable time and inputs .
> >
> > As a background w.r.t ROOTFS :
> > a) We had an custom SDK which is a basic makefile based SDK .
> >
> > b) The rootfs was RAMFS based .
> >      For selinux we switched from RAMFS to TEMPFS
> >
> > c) It was not having SELINUX , so we added refpolicy & selinux-userland
> >      Expectation was we will get working selinux context & policy.
> >      I have the policy but the context is being the same for each file
> > and folder .
>
> You also have to address labeling. If your filesystem is ram-based
> (volatile) then I
> suspect you will have to address labeling at runtime (ie run
> setfiles/restorecon to label the filesystem). The point is that
> your filesystem is currently not labeled according to the reference
> policy.
>
> >
> > d)  The setup is being evaluated for tempfs ( INITRAMFS-as -TEMPFS +
> > SELINUX ) w.r.t output of mount command :
> > ~ # mount
> > rootfs on / type rootfs (rw,seclabel,size=253620k,nr_inodes=63405)
> > sysfs on /sys type sysfs (rw,seclabel,relatime)
> > selinuxfs on /sys/fs/selinux type selinuxfs (rw,nosuid,noexec,relatime)
> > nodev on /dev type devtmpfs
> > (rw,seclabel,relatime,size=253620k,nr_inodes=63405,mode=755)
> > none on /proc type proc (rw,relatime)
> > none on /dev/shm type tmpfs (rw,seclabel,relatime)
> > none on /dev/pts type devpts (rw,seclabel,relatime,mode=600,ptmxmode=000)
> > none on /sys/kernel/debug type debugfs (rw,seclabel,relatime)
> > none on /mnth type hugetlbfs (rw,seclabel,relatime)
> > cgroup on /sys/fs/cgroup type tmpfs (rw,seclabel,relatime,mode=755)
> > cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,relatime,cpuset)
> > cgroup on /sys/fs/cgroup/cpu type cgroup (rw,relatime,cpu)
> > cgroup on /sys/fs/cgroup/cpuacct type cgroup (rw,relatime,cpuacct)
> > cgroup on /sys/fs/cgroup/blkio type cgroup (rw,relatime,blkio)
> > cgroup on /sys/fs/cgroup/memory type cgroup (rw,relatime,memory)
> > cgroup on /sys/fs/cgroup/devices type cgroup (rw,relatime,devices)
> > cgroup on /sys/fs/cgroup/freezer type cgroup (rw,relatime,freezer)
> > cgroup on /sys/fs/cgroup/net_cls type cgroup (rw,relatime,net_cls)
> > cgroup on /sys/fs/cgroup/net_prio type cgroup (rw,relatime,net_prio)
> > cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,relatime,hugetlb)
> > cgroup on /sys/fs/cgroup/pids type cgroup (rw,relatime,pids)
> > cgroup on /sys/fs/cgroup/debug type cgroup (rw,relatime,debug)
> > cgroups on /sys/fs/cgroup/unified type cgroup2 (rw,relatime)
> >
> >
> > Thanks ,
> > Ashish
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
