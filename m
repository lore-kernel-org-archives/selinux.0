Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76926C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 11:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4508E217D7
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 11:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLSLoq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:44:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34540 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeLSLoq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 06:44:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so956384oie.1
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 03:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmr3tFGVz9P8zFWOY+RG7avRKNUeaYXR0nY/g0LPvJ8=;
        b=pPPnOBMzb8rRaA+ER8rGqwgnRSjSkr/DoAOJ/WvL+xXOyxS938u2IFTHQGj0/kzf6i
         X1JIWD/blrET3/KvO+2dW9/EZv1VzsF/IFb4guLXZPTmQTzB3hwQC6bWYdLzu/bWkS+H
         mC34JCKwXYlgd3WAQ62Ig6nF8fbIhvFqo7LKKbP45Z9nUdmM4PGjZKPMeLTfrCVL0i+n
         DjRKcOE6JlKkIuMs8Uj527cL6NmuqD0bnu+Y0UQ2kUmA0WJCwTQBbnu6jDK2qD6ivkiM
         ZrTHOCXjQcv77AH9CG49kHXBrhgQK7nN7pA1kPlkfupa9PRMOQ/nV7PfIdaqWxlGZbHy
         7CAQ==
X-Gm-Message-State: AA+aEWaHhaY/LPASg9qlO7BCPM9+P10LpSTQqanUM8pMo8dH2Co/mdTY
        pdIZVhkYFkexdQ49cy0LffSMj2qkZjkzWBdQS4Zc3g==
X-Google-Smtp-Source: AFSGD/VQ0WAq4BLCyMYyZia0OxceVp92IYumLHYwpjtVkXgHcQMl5z8uzVv22mcToiy0bHWs94ar5cORSqitWw7R8OE=
X-Received: by 2002:a54:440d:: with SMTP id k13mr947143oiw.263.1545219885405;
 Wed, 19 Dec 2018 03:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20181213141739.8534-1-omosnace@redhat.com> <20181213141739.8534-4-omosnace@redhat.com>
 <a779b0e5-79d5-8a10-8372-488de5f8345f@tycho.nsa.gov> <CAFqZXNvVw0tfxYAphm-Yibhy5JoeP2SzvUb_QDRPnNtJRTCGcA@mail.gmail.com>
 <d6324b07-3a40-01c3-78a9-45032d9c107f@tycho.nsa.gov>
In-Reply-To: <d6324b07-3a40-01c3-78a9-45032d9c107f@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Dec 2018 12:44:34 +0100
Message-ID: <CAFqZXNvNCaAP=a=ugUBUn0B3q6PdxO9CzHCmuTE=2kvmxQF9LQ@mail.gmail.com>
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

On Tue, Dec 18, 2018 at 8:19 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/18/18 10:50 AM, Ondrej Mosnacek wrote:
> > On Thu, Dec 13, 2018 at 5:25 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/13/18 9:17 AM, Ondrej Mosnacek wrote:
> >>> Ignore all selinux_inode_notifysecctx() calls on mounts with the
> >>> SECURITY_FS_USE_MNTPOINT behavior.
> >>>
> >>> This fixes behavior of kernfs-based filesystems when mounted with the
> >>> 'context=' option. Before this patch, if a node's context had been
> >>> explicitly set to a non-default value and later the filesystem has been
> >>> remounted with the 'context=' option, then this node would show up as
> >>> having a different context.
> >>>
> >>> Steps to reproduce:
> >>>       # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> >>>       # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
> >>>       # ls -lZ /sys/fs/cgroup/unified
> >>>       total 0
> >>>       -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
> >>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
> >>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
> >>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
> >>>       -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> >>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
> >>>       -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
> >>>       # umount /sys/fs/cgroup/unified
> >>>       # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> >>>
> >>> Result before:
> >>>       # ls -lZ /sys/fs/cgroup/unified
> >>>       total 0
> >>>       -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
> >>>       -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads
> >>>
> >>> Result after:
> >>>       # ls -lZ /sys/fs/cgroup/unified
> >>>       total 0
> >>>       -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
> >>>       -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
> >>>       -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads
> >>>
> >>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >>> ---
> >>>    security/selinux/hooks.c | 7 +++++++
> >>>    1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>> index d6d29ec54eab..0ca5ed30afe1 100644
> >>> --- a/security/selinux/hooks.c
> >>> +++ b/security/selinux/hooks.c
> >>> @@ -6620,6 +6620,13 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
> >>>     */
> >>>    static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
> >>>    {
> >>> +     struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> >>> +
> >>> +     /* Do not change context in SECURITY_FS_USE_MNTPOINT case */
> >>> +     if ((sbsec->flags & SE_SBINITIALIZED) &&
> >>> +         (sbsec->behavior == SECURITY_FS_USE_MNTPOINT))
> >>> +             return 0;
> >>> +
> >>>        return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> >>>    }
> >>
> >> Wondering if we ought to take this into selinux_inode_setsecurity() and
> >> return -EOPNOTSUPP in that case.  We already return -EOPNOTSUPP from
> >> selinux_inode_setxattr() if (!(sbsec->flags & SBLABEL_MNT)) and that
> >> should precede other calls to selinux_inode_setsecurity() IIRC.
> >
> > Maybe, but see below. In selinux_inode_setsecurity() we should indeed
> > check for SBLABEL_MNT, but only if it is called directly as a hook
> > (but I'm not sure if it is worth it in this case, since as you say, a
> > prior selinux_inode_setxattr() failure should always prevent this hook
> > from being called). selinux_inode_notifysecctx() has a bit different
> > semantics, IMHO.
> >
> >> Should we just be checking SBLABEL_MNT here instead?
> >
> > I don't think so. IIUC, the purpose of selinux_inode_notifysecctx() is
> > to adjust the sid that has been assigned by selinux_d_instantiate() by
> > the label that is 'stored' for the particular node internally by the
> > filesystem. I would say the fact whether we want to use the stored
> > label depends on the sbsec->behavior value (BTW, shouldn't we also
> > return 0 in case of SECURITY_FS_USE_TASK? or even
> > SECURITY_FS_USE_TRANS?). I understand the SBLABEL_MNT flag more as an
> > indication of whether we want the user to allow setting the label
> > explicitly (and probably also implicitly via tsec->create_sid).
>
> selinux_inode_notifysecctx() provides the filesystem with a way to push
> a label for an inode to the security module as opposed to having the
> security module pull it via __vfs_getxattr.  The latter doesn't work
> well for NFSv4.2 security labeling nor for sysfs, albeit for different
> reasons.
>
> SBLABEL_MNT is not so much whether we want to allow the user to do it
> but rather whether the filesystem and policy make it safe to do so.  It
> is set mostly based on the ->behavior with exceptions for the
> whitelisted filesystem types.  The same flag is checked in
> selinux_inode_init_security(), where we are returning a label for a
> newly created file.
>
> Not sure we want to create two different ways of determining whether the
> filesystem supports labeling.
>

All right, I think we can say that any filesystem that does not
support labeling should never call security_inode_notifysecctx(). So
in this case "!(sbsec->flags & SBLABEL_MNT)" should be equivalent to
"sbsec->behavior == SECURITY_FS_USE_MNTPOINT". Considering that, I
don't have any strong arguments against checking SBLABEL_MNT instead
of behavior, so I'll change it to that in v2.

> >
> >> And do we need to separately check SE_SBINITIALIZED?
> >
> > I'm not sure, but other places in the code check that flag before
> > checking sbsec->behavior, so it seemed to me as the right thing to do.
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Associate Software Engineer, Security Technologies
> > Red Hat, Inc.
> >

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
