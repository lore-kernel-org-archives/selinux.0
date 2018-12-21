Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B29C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037C5217D9
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 21:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLUVuA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:50:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45422 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLUVuA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 16:50:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id y1so5942376oie.12
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 13:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/EjH6ZeLFMMzQu/Svx4m5bAFp7HI9QXQhfpkWIc5t4=;
        b=qwrr2MbYxaC9T39H5iONpnMxHImFUYb+ef3taPfH8tdWXHjwDeeEorPzcWNxwVM7Wm
         vzywF2h/6+8rFSGaPN0ojSZXxCGZYQT44n+g96IZvTmPv+wzYFUsbnYjMSeuR9sihwse
         wy7P13H+fK+RKsYWNhDIjJfeQNZ0cPm3n0/BJWhKG501HF9PixAjPKMxu9ED8kNwDlGh
         Lxl8xnLH+TZzc11+z2Kr6C3PmqXAM0CAyq3mP4m/l9XysoDqYNio9pfaDrmpstKcl7Qi
         G3hQKyLAYdCJpwGhVdbCMr0PEzc13nGw0ayS8Xi0RWWpxsio7HIlHJjoqQwNA0+NI6/G
         zJZg==
X-Gm-Message-State: AA+aEWbz1//Ot8wDRsrMIqHV9mbjfwQNOKI6KVHjqu6lHhFLyi6+LQet
        2ZGxbbMYnsJeIjzEL2k36gOB88TudTMMKHRMffCEf3a9
X-Google-Smtp-Source: AFSGD/UhHE9wy4AQUc0KkST/LFFPNsgqQ4wEFhlc8/aTKtoqrbJKqGqFZn6V5OBnFBQlZ1hDJh5o3TLYEBmYDzdPJR4=
X-Received: by 2002:a05:6808:493:: with SMTP id z19mr2608814oid.234.1545428999253;
 Fri, 21 Dec 2018 13:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20181221201853.24015-1-omosnace@redhat.com> <20181221201853.24015-3-omosnace@redhat.com>
 <b9fbfb5c-fc8f-fe02-13b1-998a00b1a7f5@tycho.nsa.gov>
In-Reply-To: <b9fbfb5c-fc8f-fe02-13b1-998a00b1a7f5@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 21 Dec 2018 22:49:48 +0100
Message-ID: <CAFqZXNsWVRZKEj5K_WMO7kPbigXDOkG8T6GYyYHq5oi3kR8U7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: do not override context on context mounts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 21, 2018 at 9:45 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/21/18 3:18 PM, Ondrej Mosnacek wrote:
> > Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
> > flag unset. This is achived by returning -EOPNOTSUPP for this case in
> > selinux_inode_setsecurtity() (because that function should not be called
> > in such case anyway) and translating this error to 0 in
> > selinux_inode_notifysecctx().
> >
> > This fixes behavior of kernfs-based filesystems when mounted with the
> > 'context=' option. Before this patch, if a node's context had been
> > explicitly set to a non-default value and later the filesystem has been
> > remounted with the 'context=' option, then this node would show up as
> > having the manually-set context and not the mount-specified one.
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
>
> The patch looks good to me but I am a little puzzled by the cgroup2
> behavior here.  I would have expected that unmounting would have killed
> the superblock and thus discarded the previously set label.  I guess
> something else is keeping it alive?

It is because the context set via setxattr is stored inside the kernfs
node and the kernfs tree is preserved across mounts/unmounts. It
actually behaves sort of like a normal filesystem backed by a block
device, just the "device" is represented by an in-memory kernfs tree
which is discarded at poweroff.

>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks!

>
> > ---
> >   security/selinux/hooks.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index b4759bebeddc..fcf4af1e5157 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3477,12 +3477,16 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
> >                                    const void *value, size_t size, int flags)
> >   {
> >       struct inode_security_struct *isec = inode_security_novalidate(inode);
> > +     struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> >       u32 newsid;
> >       int rc;
> >
> >       if (strcmp(name, XATTR_SELINUX_SUFFIX))
> >               return -EOPNOTSUPP;
> >
> > +     if (!(sbsec->flags & SBLABEL_MNT))
> > +             return -EOPNOTSUPP;
> > +
> >       if (!value || !size)
> >               return -EACCES;
> >
> > @@ -6625,7 +6629,10 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
> >    */
> >   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
> >   {
> > -     return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> > +     int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
> > +                                        ctx, ctxlen, 0);
> > +     /* Do not return error when suppressing label (SBLABEL_MNT not set). */
> > +     return rc == -EOPNOTSUPP ? 0 : rc;
> >   }
> >
> >   /*
> >

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
