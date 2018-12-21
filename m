Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DE2C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 22:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C221920
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 22:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="G4Idl8qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeLUW7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:59:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35506 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbeLUW7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 17:59:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so6102777ljb.2
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whrN79uoa5KtUaYUXcKPhf+KyURiOD65NjT0RIp03Hg=;
        b=G4Idl8qhP5/OglWiCj/FDKteRGVgPZ8MiE8CE7NlDhNi8624Joe3dLzo7J7gJ9ZcH7
         cIb6rSou7AJpikvr5ho8gvodK1B6t/+HP+rhfljQMbTfsconLITaRW0vB00WaAqjDAT9
         T0IWVh+uMGciva+HAcYvWH+y/GRzoLnGYlB+X2Fip+LAgQHCHweZOMgFZaQ85l1NsuqK
         gqv22Oe2SHrmzUBoit74PWo/3HKvT/r6uN1112xyWqJBWmK3dXFpyqjbMQWDru5WC+Il
         fGljrHnALEj+aH0S00urPL902E8Ck1YMrUnT1XmPtjlwrHyvcsct9+T9fAxQ4x5SDux1
         ibvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whrN79uoa5KtUaYUXcKPhf+KyURiOD65NjT0RIp03Hg=;
        b=K6tAoA1AnRq2cqdidqPxusAo7ap2U91SjWAtSKDPZ2sD62sceGbQTZiKDe8vgFeePo
         MNeEVmDTmLX4WZCdsLx9WY2W8ajZH1fBSHGTeUyenMMi8omxPOPBFFBefgoLAwlN0jPC
         oDOQl2n7JBot9aIH4OSZPbiu4fAPaJEwwm/JCBGkCdq2UMaxW9vHCg3Ch8YSfhNVOdNW
         2h5mkVjFgXszOeQeWsax5PMsFVdogYaULe1SvXZrgmmynzJzEQ7uC+ECTagcXqhxF7im
         UCpHz9LSqZjFkxM1tpTVM9X2M+CywQJLPcjtsYuO3+ESTtuh0EKbWYHChuN2oeS/7dEh
         E0YQ==
X-Gm-Message-State: AJcUukeoX3XPohQwSO/bum/1wW+K4dA48AfBmNpD2X+7CiQMAKs+g6Nr
        jlmWrpGERLzzj+TsaPp4Hoe5NMNrfrRltg/BBwm78NQbJA==
X-Google-Smtp-Source: ALg8bN67kwWk/cUSqNqIJ6eX+zA5T4w2w9QCuMPhr6kQhmGnS31ZRCu+dR2UZOUAux8XYtrIa9zJke8yW3olB7PL4J8=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr2658509ljh.42.1545433158344;
 Fri, 21 Dec 2018 14:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20181221201853.24015-1-omosnace@redhat.com> <20181221201853.24015-3-omosnace@redhat.com>
 <b9fbfb5c-fc8f-fe02-13b1-998a00b1a7f5@tycho.nsa.gov> <CAFqZXNsWVRZKEj5K_WMO7kPbigXDOkG8T6GYyYHq5oi3kR8U7Q@mail.gmail.com>
In-Reply-To: <CAFqZXNsWVRZKEj5K_WMO7kPbigXDOkG8T6GYyYHq5oi3kR8U7Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Dec 2018 17:59:07 -0500
Message-ID: <CAHC9VhSQV73yvGeQmyLNYnt-S0LZvnHW15NkpKA05uGuowKxSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: do not override context on context mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 21, 2018 at 4:49 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Dec 21, 2018 at 9:45 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 12/21/18 3:18 PM, Ondrej Mosnacek wrote:
> > > Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
> > > flag unset. This is achived by returning -EOPNOTSUPP for this case in
> > > selinux_inode_setsecurtity() (because that function should not be called
> > > in such case anyway) and translating this error to 0 in
> > > selinux_inode_notifysecctx().
> > >
> > > This fixes behavior of kernfs-based filesystems when mounted with the
> > > 'context=' option. Before this patch, if a node's context had been
> > > explicitly set to a non-default value and later the filesystem has been
> > > remounted with the 'context=' option, then this node would show up as
> > > having the manually-set context and not the mount-specified one.
> > >
> > > Steps to reproduce:
> > >      # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> > >      # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
> > >      # ls -lZ /sys/fs/cgroup/unified
> > >      total 0
> > >      -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
> > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
> > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
> > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
> > >      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
> > >      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
> > >      # umount /sys/fs/cgroup/unified
> > >      # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> > >
> > > Result before:
> > >      # ls -lZ /sys/fs/cgroup/unified
> > >      total 0
> > >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
> > >      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads
> > >
> > > Result after:
> > >      # ls -lZ /sys/fs/cgroup/unified
> > >      total 0
> > >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
> > >      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
> > >      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > The patch looks good to me but I am a little puzzled by the cgroup2
> > behavior here.  I would have expected that unmounting would have killed
> > the superblock and thus discarded the previously set label.  I guess
> > something else is keeping it alive?
>
> It is because the context set via setxattr is stored inside the kernfs
> node and the kernfs tree is preserved across mounts/unmounts. It
> actually behaves sort of like a normal filesystem backed by a block
> device, just the "device" is represented by an in-memory kernfs tree
> which is discarded at poweroff.

That makes sense.

I'll take a closer look at these once we're past the upcoming merge
window, but they look okay after a quick glance.

> > Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Thanks!
>
> >
> > > ---
> > >   security/selinux/hooks.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index b4759bebeddc..fcf4af1e5157 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3477,12 +3477,16 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
> > >                                    const void *value, size_t size, int flags)
> > >   {
> > >       struct inode_security_struct *isec = inode_security_novalidate(inode);
> > > +     struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> > >       u32 newsid;
> > >       int rc;
> > >
> > >       if (strcmp(name, XATTR_SELINUX_SUFFIX))
> > >               return -EOPNOTSUPP;
> > >
> > > +     if (!(sbsec->flags & SBLABEL_MNT))
> > > +             return -EOPNOTSUPP;
> > > +
> > >       if (!value || !size)
> > >               return -EACCES;
> > >
> > > @@ -6625,7 +6629,10 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
> > >    */
> > >   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
> > >   {
> > > -     return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> > > +     int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
> > > +                                        ctx, ctxlen, 0);
> > > +     /* Do not return error when suppressing label (SBLABEL_MNT not set). */
> > > +     return rc == -EOPNOTSUPP ? 0 : rc;
> > >   }
> > >
> > >   /*
> > >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
paul moore
www.paul-moore.com
