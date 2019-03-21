Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6059C10F00
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 08:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762A2218A2
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 08:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfCUI4z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:56:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44609 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCUI4y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 04:56:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id i21so4042049oib.11
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 01:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KEblbMUfoQ3UkEQc9QeTsPs2iYbAcDdF3kQ8khk51U=;
        b=qwj9/Dc9wxY8JPhnYPft8KazHm4vGkxkTi+c5IpY0IiJoVr/Wa421hJWyXZ41AtgiV
         +yH3qh4LQsd84jH2zEI5GKIG1hDbhmoUV67BhSdvOugU/OoOdS7LfwwuGJliIuFo/cRE
         XQseYc21Xp2141RASsJUiFaVw6Et6YZSb47L3YDcymRQmM05BGS344ydwg1rOqJ3VTWL
         SDnXZQfDw3iQaXhVjkcXHhqhb5CzQs9KDc2OztCqWyN7xI3nD1xbDUXT9esYSQMVo3fe
         9HsP443m3v38G+DAcmXk9mnnCcFWriFNtLR2CMLxCWQZOUe5+oroPkelwaBW8u4/to+U
         7/7Q==
X-Gm-Message-State: APjAAAVebdbFFHZc2L+Lcpc/THjR/Th0o4/EDrHC+d/SaPbq6VWB9pi1
        OYLeKko9gdX6OJIxQ66pzEPn0+nLlWWuxWN3zWAfSg==
X-Google-Smtp-Source: APXvYqwkSntAL/iGcTz3zyHjYjaZyfYaDF8GHjpTLaFATEWVw4eMbORQ76fLN/W6cfLV1DLSymdSpEQiW94cYNCJ/UE=
X-Received: by 2002:aca:b354:: with SMTP id c81mr1461719oif.26.1553158613654;
 Thu, 21 Mar 2019 01:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190222145718.5740-1-omosnace@redhat.com> <CAHC9VhT3pEAwYyHcv7KY4xAHJQKu4PN-NPxAkpcnuGCSwVHLtQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT3pEAwYyHcv7KY4xAHJQKu4PN-NPxAkpcnuGCSwVHLtQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Mar 2019 09:56:42 +0100
Message-ID: <CAFqZXNtjbYUcfWODC0Ygbbxa87VhVoHaMbpvFtKaNdp3HV-JvA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Allow initializing the kernfs node's secctx based
 on its parent
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 3:14 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 22, 2019 at 9:57 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > TL;DR:
> > This series adds a new security hook that allows to initialize the security
> > context of kernfs properly, taking into account the parent context (and
> > possibly other attributes). Kernfs nodes require special handling here, since
> > they are not bound to specific inodes/superblocks, but instead represent the
> > backing tree structure that is used to build the VFS tree when the kernfs
> > tree is mounted.
> >
> > Changes in v7:
> > - simplify the new security hook's interface
> >   - rather than trying to extract kernfs data into common structures, just
> >     pass the kernfs nodes themselves and add helper functions to
> >     <linux/kernfs.h> for accessing their security xattrs
> >   - in case other LSMs need more kernfs node attributes than the file mode
> >     (uid/gid/...), they can simply add new helpers to <linux/kernfs.h> as
> >     needed
> > - refactor "kernfs: use simple_xattrs for security attributes" to keep using
> >   a single common simple_xattrs structure
> >   - turns out having two separate simple_xattrs wouldn't work right (see
> >     the definition of simple_xattr_list() in fs/xattr.c)
> > - drop unnecessary initializations from inode_doinit_use_xattr()
> > - move the IOP_XATTR check out of inode_doinit_use_xattr()
> > - add two kernfs cleanup patches
> >   - these could be applied independently, but the rest of the patches depend on
> >     them, so I'd rather they stay bundled with the rest to avoid cross-tree
> >     conflicts
> >
> > v6: https://lore.kernel.org/selinux/20190214095015.16032-1-omosnace@redhat.com/T/
> > Changes in v6:
> > - remove copy-pasted duplicate macro definition
> >
> > v5: https://lore.kernel.org/selinux/20190205110638.30782-1-omosnace@redhat.com/T/
> > Changes in v5:
> > - fix misplaced semicolon detected by 0day robot
> >
> > v4: https://lore.kernel.org/selinux/20190205085915.5183-1-omosnace@redhat.com/T/
> > Changes in v4:
> > - reorder and rename hook arguments
> > - avoid allocating kernfs_iattrs unless needed
> >
> > v3: https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/T/
> > Changes in v3:
> > - rename the hook to "kernfs_init_security"
> > - change the hook interface to simply pass pointers to struct iattr and
> >   struct simple_xattrs of both the new node and its parent
> > - add full security xattr support to kernfs (and fixup SELinux behavior
> >   to handle it properly)
> >
> > v2: https://lore.kernel.org/selinux/20190109162830.8309-1-omosnace@redhat.com/T/
> > Changes in v2:
> > - add docstring for the new hook in union security_list_options
> > - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
> >   implemented
> >
> > v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
> >
> > The kernfs nodes initially do not store any security context and rely on
> > the LSM to assign some default context to inodes created over them. Kernfs
> > inodes, however, allow setting an explicit context via the *setxattr(2)
> > syscalls, in which case the context is stored inside the kernfs node's
> > internal structure.
> >
> > SELinux (and possibly other LSMs) initialize the context of newly created
> > FS objects based on the parent object's context (usually the child inherits
> > the parent's context, unless the policy dictates otherwise). This is done
> > by hooking the creation of the new inode corresponding to the newly created
> > file/directory via security_inode_init_security() (most filesystems always
> > create a fresh inode when a new FS object is created). However, kernfs nodes
> > can be created "behind the scenes" while the filesystem is not mounted
> > anywhere and thus no inodes can exist for them yet.
> >
> > Therefore, to allow maintaining similar behavior for kernfs nodes, a new
> > LSM hook is needed, which will allow initializing the kernfs node's
> > security context based on its own attributes and those of the parent's
> > node.
> >
> > The main motivation for this change is that the userspace users of cgroupfs
> > (which is built on kernfs) expect the usual security context inheritance
> > to work under SELinux (see [1] and [2]). This functionality is required for
> > better confinement of containers under SELinux.
> >
> > Patch 1/7 simplifies the kernfs_iattrs structure and patch 2/7 optimizes
> > kernfs to not allocate kernfs_iattrs when getting the value of an xattr.
> >
> > Patch 3/7 changes SELinux to fetch security context from extended
> > attributes on kernfs filesystems, falling back to genfs-defined context
> > if that fails. Without this patch the 4/7 would be a regression for
> > SELinux (due to the removal of ...notifysecctx() call.
> >
> > Patch 4/7 implements full security xattr support in kernfs using
> > simple_xattrs; patch 5/7 adds the new LSM hook; patch 6/7 implements the
> > new hook in SELinux; and patch 7/7 modifies kernfs to call the new hook
> > on new node creation.
> >
> > Testing:
> > - passed the reproducer from the commit message of the last patch
> > - passed SELinux testsuite on Fedora Rawhide (x86_64) when applied on top
> >   of current Rawhide kernel (5.0.0-0.rc7.git2.1) [3]
> >   - including the new proposed selinux-testsuite subtest [4] (adapted
> >     from the reproducer)
> >
> > [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
> > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
> > [3] https://koji.fedoraproject.org/koji/taskinfo?taskID=32963825
> > [4] https://github.com/SELinuxProject/selinux-testsuite/pull/48
> >
> > Ondrej Mosnacek (7):
> >   kernfs: clean up struct kernfs_iattrs
> >   kernfs: do not alloc iattrs in kernfs_xattr_get
> >   selinux: try security xattr after genfs for kernfs filesystems
> >   kernfs: use simple_xattrs for security attributes
> >   LSM: add new hook for kernfs node initialization
> >   selinux: implement the kernfs_init_security hook
> >   kernfs: initialize security of newly created nodes
> >
> >  fs/kernfs/dir.c                     |  28 ++--
> >  fs/kernfs/inode.c                   | 166 +++++++++------------
> >  fs/kernfs/kernfs-internal.h         |   8 +-
> >  fs/kernfs/symlink.c                 |   4 +-
> >  include/linux/kernfs.h              |  15 ++
> >  include/linux/lsm_hooks.h           |  13 ++
> >  include/linux/security.h            |   9 ++
> >  security/security.c                 |   6 +
> >  security/selinux/hooks.c            | 223 +++++++++++++++++++---------
> >  security/selinux/include/security.h |   1 +
> >  10 files changed, 290 insertions(+), 183 deletions(-)
>
> I just merged this patchset into selinux/next, thanks everyone.
>
> Ondrej, every patch in the patchset except for one required some
> amount of merge fixups, please take a look and make sure everything in
> the selinux/next branch still looks right to you.

Looks good to me, thanks!  I checked by rebasing the original branch
on v5.1-rc1 myself and then comparing my result with selinux/next.
The only difference was one extra empty line on my side, but that
doesn't bother me :)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
