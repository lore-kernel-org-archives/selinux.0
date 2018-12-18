Return-Path: <SRS0=zZcK=O3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45459C43387
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 15:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ECD21873
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 15:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLRPup (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:50:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41960 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLRPup (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Dec 2018 10:50:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so2297039oii.8
        for <selinux@vger.kernel.org>; Tue, 18 Dec 2018 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQLg+uf9UJ1yCrzzwVhXRkdFT84oybI6KCACwPXvFS4=;
        b=GPqi5nPlxj1O0xyfoaVwxfvUiCX5V1IHAn/ffIZDqxeYyx3l8JfQDFgnRP79KxtN3Q
         3j+tsV3gH23Oitob7Hd3Ge2VK5v+O2L8Jqc4/iM6jxvWI6hv5zxl3HXHS1odMBQmadLn
         vUw4frhV/rVznUzvnf/vhVMEjCarkaSW2BW813kwzLaGwtVh++TAO2XLEnLiDNgawKGQ
         MP9y/qeLCXQ7w2zGfV1RUyIEHvyQut3shVJfNgLZtG+1OxBOcWQzmIpI8KPUHOwg5iN3
         JTETaE2z3lOjgUoc0kO6Zd8XIeYBE5KZowrURWQYBz1gyhHYsJMBC0/qrm9ICjOfAgLJ
         cA5Q==
X-Gm-Message-State: AA+aEWb5ihMtkTlQKUyagP7WTK5f9/GBtu2D41zjSjwDcq23EoKXGQZA
        SfxqC82+44b8TteEzsF9pRY1Ktl0H5mfT0Qpg39QNg==
X-Google-Smtp-Source: AFSGD/WNDNmFJlX2N0LYIWaZ/bwCYUBedNINTMslr47CSv0uFEL+Xja0sddOA0V8wsnS6SrYoeH85u6lOdQPrZ/ovy8=
X-Received: by 2002:aca:50cf:: with SMTP id e198mr8497663oib.343.1545148244475;
 Tue, 18 Dec 2018 07:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20181213141739.8534-1-omosnace@redhat.com> <20181213141739.8534-4-omosnace@redhat.com>
 <a779b0e5-79d5-8a10-8372-488de5f8345f@tycho.nsa.gov>
In-Reply-To: <a779b0e5-79d5-8a10-8372-488de5f8345f@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Dec 2018 16:50:33 +0100
Message-ID: <CAFqZXNvVw0tfxYAphm-Yibhy5JoeP2SzvUb_QDRPnNtJRTCGcA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] selinux: do not override context on context mounts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 13, 2018 at 5:25 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/13/18 9:17 AM, Ondrej Mosnacek wrote:
> > Ignore all selinux_inode_notifysecctx() calls on mounts with the
> > SECURITY_FS_USE_MNTPOINT behavior.
> >
> > This fixes behavior of kernfs-based filesystems when mounted with the
> > 'context=' option. Before this patch, if a node's context had been
> > explicitly set to a non-default value and later the filesystem has been
> > remounted with the 'context=' option, then this node would show up as
> > having a different context.
> >
> > Steps to reproduce:
> >      # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> >      # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
> >      # ls -lZ /sys/fs/cgroup/unified
> >      total 0
> >      -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
> >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
> >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
> >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
> >      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
> >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
> >      # umount /sys/fs/cgroup/unified
> >      # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> >
> > Result before:
> >      # ls -lZ /sys/fs/cgroup/unified
> >      total 0
> >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
> >      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads
> >
> > Result after:
> >      # ls -lZ /sys/fs/cgroup/unified
> >      total 0
> >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
> >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
> >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/hooks.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index d6d29ec54eab..0ca5ed30afe1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6620,6 +6620,13 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
> >    */
> >   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
> >   {
> > +     struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> > +
> > +     /* Do not change context in SECURITY_FS_USE_MNTPOINT case */
> > +     if ((sbsec->flags & SE_SBINITIALIZED) &&
> > +         (sbsec->behavior == SECURITY_FS_USE_MNTPOINT))
> > +             return 0;
> > +
> >       return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> >   }
>
> Wondering if we ought to take this into selinux_inode_setsecurity() and
> return -EOPNOTSUPP in that case.  We already return -EOPNOTSUPP from
> selinux_inode_setxattr() if (!(sbsec->flags & SBLABEL_MNT)) and that
> should precede other calls to selinux_inode_setsecurity() IIRC.

Maybe, but see below. In selinux_inode_setsecurity() we should indeed
check for SBLABEL_MNT, but only if it is called directly as a hook
(but I'm not sure if it is worth it in this case, since as you say, a
prior selinux_inode_setxattr() failure should always prevent this hook
from being called). selinux_inode_notifysecctx() has a bit different
semantics, IMHO.

> Should we just be checking SBLABEL_MNT here instead?

I don't think so. IIUC, the purpose of selinux_inode_notifysecctx() is
to adjust the sid that has been assigned by selinux_d_instantiate() by
the label that is 'stored' for the particular node internally by the
filesystem. I would say the fact whether we want to use the stored
label depends on the sbsec->behavior value (BTW, shouldn't we also
return 0 in case of SECURITY_FS_USE_TASK? or even
SECURITY_FS_USE_TRANS?). I understand the SBLABEL_MNT flag more as an
indication of whether we want the user to allow setting the label
explicitly (and probably also implicitly via tsec->create_sid).

> And do we need to separately check SE_SBINITIALIZED?

I'm not sure, but other places in the code check that flag before
checking sbsec->behavior, so it seemed to me as the right thing to do.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
