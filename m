Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8CC43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 02:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519F72084C
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 02:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2LcgSVTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfAKCeq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:34:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39696 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKCeq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 21:34:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so9770901lfh.6
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 18:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSigiPOTtiFq+l6QpXcEvhVwRglea99czYd8rRN2BN0=;
        b=2LcgSVToWe1XW8yQPU2p2MQYJEHo1uFRClT+ukqeiNdDV0kkEj+pF1uOgoz5jqtDFR
         5FIBJ249VNrksbisUfjGaA5Twc4XqTeL1HER+rFwExredaxlsdrCaRMw9KAL4m2UPuiR
         ZqW0vpN9MagDBK+zkJhOeRDci4kNS+Pl9OnSD4sc8tWktK+7ETM7wURScH32DQA3zQq7
         EWGP9H5iTcjhsyeZlb9np9xLa9Uaidm7tjll9mC21GEY6N31dx144s4i9VZo3gyuV2YL
         kRRNKvgpVpNGD/jFT7+1lZHiV01+9NfqBc/JIejBShMbLvlOr7u8oPP/u11NUCaW6Feo
         8Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSigiPOTtiFq+l6QpXcEvhVwRglea99czYd8rRN2BN0=;
        b=IafIVkLUo3SIFc7SSZrnoMQiE7WJpabzYtshHBqEoOsi1zcQnwbN7PJ7EqgOZjKFG4
         7yRdQvumf+LSvRdRAXbxbvYtWOAM9u+W1RmOvkHSQVllhpMi0hdDwPyUrGnr2sumaE4z
         uEFAuUy7RCMQlu3clSuKsx9Uvg1YkHkZ5itSSErxLeprDHYmbEAux9EA4KXif2mWe7PB
         o+RFldie4AruUTRXXUCUOQc8ZRr21434r2Tcp2jDqnFlY+Q0NwJ/u95dT2FwD04laKpw
         6gtWULKeZ1kraI6aBVolv9MEE4EGkkbTnYHW/nBNnMjA9tjMHX65PAjHnh503CGM6ryb
         Fr8A==
X-Gm-Message-State: AJcUukcqxYUKdx8I2/2vWin2RkVE2lj+pjVTLfjVg/uGCrm2aAKnIhIq
        gY0+5l+OSatmm6+3MK/wetn2pmEzJIEZxG+wy/Wo
X-Google-Smtp-Source: ALg8bN4L+U0Wrw0LbuusPDYeZZ6Q59gKyOddxtIklQbkfafy6the5u2ucgrLaSP1Pq3xiFGKTZj9AgS3FNknXwWuMgQ=
X-Received: by 2002:a19:e601:: with SMTP id d1mr7442623lfh.71.1547173723823;
 Thu, 10 Jan 2019 18:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20181221201853.24015-1-omosnace@redhat.com> <20181221201853.24015-3-omosnace@redhat.com>
 <b9fbfb5c-fc8f-fe02-13b1-998a00b1a7f5@tycho.nsa.gov> <CAFqZXNsWVRZKEj5K_WMO7kPbigXDOkG8T6GYyYHq5oi3kR8U7Q@mail.gmail.com>
 <CAHC9VhSQV73yvGeQmyLNYnt-S0LZvnHW15NkpKA05uGuowKxSg@mail.gmail.com>
In-Reply-To: <CAHC9VhSQV73yvGeQmyLNYnt-S0LZvnHW15NkpKA05uGuowKxSg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 21:28:32 -0500
Message-ID: <CAHC9VhQMQeFMnW=YKpUhh8Z5hSD2dx6F4iEqe_aLMFJ9tkzKSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: do not override context on context mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 21, 2018 at 5:59 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Dec 21, 2018 at 4:49 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Dec 21, 2018 at 9:45 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 12/21/18 3:18 PM, Ondrej Mosnacek wrote:
> > > > Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
> > > > flag unset. This is achived by returning -EOPNOTSUPP for this case in
> > > > selinux_inode_setsecurtity() (because that function should not be called
> > > > in such case anyway) and translating this error to 0 in
> > > > selinux_inode_notifysecctx().
> > > >
> > > > This fixes behavior of kernfs-based filesystems when mounted with the
> > > > 'context=' option. Before this patch, if a node's context had been
> > > > explicitly set to a non-default value and later the filesystem has been
> > > > remounted with the 'context=' option, then this node would show up as
> > > > having the manually-set context and not the mount-specified one.
> > > >
> > > > Steps to reproduce:
> > > >      # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> > > >      # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
> > > >      # ls -lZ /sys/fs/cgroup/unified
> > > >      total 0
> > > >      -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
> > > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
> > > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
> > > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
> > > >      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> > > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
> > > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
> > > >      # umount /sys/fs/cgroup/unified
> > > >      # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> > > >
> > > > Result before:
> > > >      # ls -lZ /sys/fs/cgroup/unified
> > > >      total 0
> > > >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
> > > >      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads
> > > >
> > > > Result after:
> > > >      # ls -lZ /sys/fs/cgroup/unified
> > > >      total 0
> > > >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
> > > >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
> > > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > The patch looks good to me but I am a little puzzled by the cgroup2
> > > behavior here.  I would have expected that unmounting would have killed
> > > the superblock and thus discarded the previously set label.  I guess
> > > something else is keeping it alive?
> >
> > It is because the context set via setxattr is stored inside the kernfs
> > node and the kernfs tree is preserved across mounts/unmounts. It
> > actually behaves sort of like a normal filesystem backed by a block
> > device, just the "device" is represented by an in-memory kernfs tree
> > which is discarded at poweroff.
>
> That makes sense.
>
> I'll take a closer look at these once we're past the upcoming merge
> window, but they look okay after a quick glance.

Still looked fine to me, merged both 1/2 and 2/2 into selinux/next.
Thanks Ondrej.

-- 
paul moore
www.paul-moore.com
