Return-Path: <SRS0=Plie=RK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B84C10F03
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE1420675
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 09:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfCGJBR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:01:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43608 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCGJBQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Mar 2019 04:01:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so13409358ota.10
        for <selinux@vger.kernel.org>; Thu, 07 Mar 2019 01:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/94IVKlMPad+e5UwWHBeP+CHK+Rz/ElLhDY65en7LY=;
        b=cN+hFNHlJij+8gGWImmOJnuUvMvut0rF+aYS+k/L0ns+JxLpzKDjIibm0r2uQZS4bn
         CKZzF7ZnDdmSmFutKICq0r3uhxoHidBplTMhpRQ/OD1BqjUIp7tDKHfYL3k2PTZEjnek
         RM8y/ODnDa6QDHyCrFWjgSvcG9Sh81krzdf26yiJ7xfwnDAjEGtKh9kOsTqmFUlK/VTL
         eIk9lmYiJ7dwxUy0VbvHXfmsSXCByvZPbPugszuWyAOtBAKdSVabUDJN/gJ7aopYRkL0
         BnWAauzXILEvACpa+jbDREPFMGsx2nlhLvrwMZB9t7Ls+82C5C4MeIPQS4aPYtGSlgiX
         c7nA==
X-Gm-Message-State: APjAAAVLIoXpbG2bUao3uY8tZwibaeWT/M4M0Ejca2McQWi+KfyzDqka
        qfAU+SlDFhIFfgoPT25T5SduAMJ1rVvhH/lYcT4k3A==
X-Google-Smtp-Source: APXvYqy2MXlW02f1kKABz3aeMOJSoItuHnn4SC0kYe9zNARkR216OI3gnqi3pcg1D/daU9Ma24J8IFRRIh+uMKGd+us=
X-Received: by 2002:a9d:6553:: with SMTP id q19mr6913398otl.21.1551949275533;
 Thu, 07 Mar 2019 01:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20190222145718.5740-1-omosnace@redhat.com> <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
 <7f92ac61-c72b-ab31-c757-c2ac1bcf7b08@schaufler-ca.com>
In-Reply-To: <7f92ac61-c72b-ab31-c757-c2ac1bcf7b08@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Mar 2019 10:01:04 +0100
Message-ID: <CAFqZXNtVhwsYa-6eBq8BJV5kZznK8do075kOZJ8TSz4BnnN6_A@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Allow initializing the kernfs node's secctx based
 on its parent
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 6, 2019 at 7:04 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/6/2019 7:54 AM, Ondrej Mosnacek wrote:
> > On Fri, Feb 22, 2019 at 3:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> TL;DR:
> >> This series adds a new security hook that allows to initialize the security
> >> context of kernfs properly, taking into account the parent context (and
> >> possibly other attributes). Kernfs nodes require special handling here, since
> >> they are not bound to specific inodes/superblocks, but instead represent the
> >> backing tree structure that is used to build the VFS tree when the kernfs
> >> tree is mounted.
> >>
> >> Changes in v7:
> >> - simplify the new security hook's interface
> >>    - rather than trying to extract kernfs data into common structures, just
> >>      pass the kernfs nodes themselves and add helper functions to
> >>      <linux/kernfs.h> for accessing their security xattrs
> >>    - in case other LSMs need more kernfs node attributes than the file mode
> >>      (uid/gid/...), they can simply add new helpers to <linux/kernfs.h> as
> >>      needed
> >> - refactor "kernfs: use simple_xattrs for security attributes" to keep using
> >>    a single common simple_xattrs structure
> >>    - turns out having two separate simple_xattrs wouldn't work right (see
> >>      the definition of simple_xattr_list() in fs/xattr.c)
> >> - drop unnecessary initializations from inode_doinit_use_xattr()
> >> - move the IOP_XATTR check out of inode_doinit_use_xattr()
> >> - add two kernfs cleanup patches
> >>    - these could be applied independently, but the rest of the patches depend on
> >>      them, so I'd rather they stay bundled with the rest to avoid cross-tree
> >>      conflicts
> >>
> >> v6: https://lore.kernel.org/selinux/20190214095015.16032-1-omosnace@redhat.com/T/
> >> Changes in v6:
> >> - remove copy-pasted duplicate macro definition
> >>
> >> v5: https://lore.kernel.org/selinux/20190205110638.30782-1-omosnace@redhat.com/T/
> >> Changes in v5:
> >> - fix misplaced semicolon detected by 0day robot
> >>
> >> v4: https://lore.kernel.org/selinux/20190205085915.5183-1-omosnace@redhat.com/T/
> >> Changes in v4:
> >> - reorder and rename hook arguments
> >> - avoid allocating kernfs_iattrs unless needed
> >>
> >> v3: https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/T/
> >> Changes in v3:
> >> - rename the hook to "kernfs_init_security"
> >> - change the hook interface to simply pass pointers to struct iattr and
> >>    struct simple_xattrs of both the new node and its parent
> >> - add full security xattr support to kernfs (and fixup SELinux behavior
> >>    to handle it properly)
> >>
> >> v2: https://lore.kernel.org/selinux/20190109162830.8309-1-omosnace@redhat.com/T/
> >> Changes in v2:
> >> - add docstring for the new hook in union security_list_options
> >> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
> >>    implemented
> >>
> >> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
> >>
> >> The kernfs nodes initially do not store any security context and rely on
> >> the LSM to assign some default context to inodes created over them. Kernfs
> >> inodes, however, allow setting an explicit context via the *setxattr(2)
> >> syscalls, in which case the context is stored inside the kernfs node's
> >> internal structure.
> >>
> >> SELinux (and possibly other LSMs) initialize the context of newly created
> >> FS objects based on the parent object's context (usually the child inherits
> >> the parent's context, unless the policy dictates otherwise). This is done
> >> by hooking the creation of the new inode corresponding to the newly created
> >> file/directory via security_inode_init_security() (most filesystems always
> >> create a fresh inode when a new FS object is created). However, kernfs nodes
> >> can be created "behind the scenes" while the filesystem is not mounted
> >> anywhere and thus no inodes can exist for them yet.
> >>
> >> Therefore, to allow maintaining similar behavior for kernfs nodes, a new
> >> LSM hook is needed, which will allow initializing the kernfs node's
> >> security context based on its own attributes and those of the parent's
> >> node.
> >>
> >> The main motivation for this change is that the userspace users of cgroupfs
> >> (which is built on kernfs) expect the usual security context inheritance
> >> to work under SELinux (see [1] and [2]). This functionality is required for
> >> better confinement of containers under SELinux.
> >>
> >> Patch 1/7 simplifies the kernfs_iattrs structure and patch 2/7 optimizes
> >> kernfs to not allocate kernfs_iattrs when getting the value of an xattr.
> >>
> >> Patch 3/7 changes SELinux to fetch security context from extended
> >> attributes on kernfs filesystems, falling back to genfs-defined context
> >> if that fails. Without this patch the 4/7 would be a regression for
> >> SELinux (due to the removal of ...notifysecctx() call.
> >>
> >> Patch 4/7 implements full security xattr support in kernfs using
> >> simple_xattrs; patch 5/7 adds the new LSM hook; patch 6/7 implements the
> >> new hook in SELinux; and patch 7/7 modifies kernfs to call the new hook
> >> on new node creation.
> >>
> >> Testing:
> >> - passed the reproducer from the commit message of the last patch
> >> - passed SELinux testsuite on Fedora Rawhide (x86_64) when applied on top
> >>    of current Rawhide kernel (5.0.0-0.rc7.git2.1) [3]
> >>    - including the new proposed selinux-testsuite subtest [4] (adapted
> >>      from the reproducer)
> >>
> >> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
> >> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
> >> [3] https://koji.fedoraproject.org/koji/taskinfo?taskID=32963825
> >> [4] https://github.com/SELinuxProject/selinux-testsuite/pull/48
> >>
> >> Ondrej Mosnacek (7):
> >>    kernfs: clean up struct kernfs_iattrs
> >>    kernfs: do not alloc iattrs in kernfs_xattr_get
> >>    selinux: try security xattr after genfs for kernfs filesystems
> >>    kernfs: use simple_xattrs for security attributes
> >>    LSM: add new hook for kernfs node initialization
> >>    selinux: implement the kernfs_init_security hook
> >>    kernfs: initialize security of newly created nodes
> >>
> >>   fs/kernfs/dir.c                     |  28 ++--
> >>   fs/kernfs/inode.c                   | 166 +++++++++------------
> >>   fs/kernfs/kernfs-internal.h         |   8 +-
> >>   fs/kernfs/symlink.c                 |   4 +-
> >>   include/linux/kernfs.h              |  15 ++
> >>   include/linux/lsm_hooks.h           |  13 ++
> >>   include/linux/security.h            |   9 ++
> >>   security/security.c                 |   6 +
> >>   security/selinux/hooks.c            | 223 +++++++++++++++++++---------
> >>   security/selinux/include/security.h |   1 +
> >>   10 files changed, 290 insertions(+), 183 deletions(-)
> >>
> >> --
> >> 2.20.1
> > Ping about this series... Casey, are you OK with this new version?
>
> I'm still not wildly enthusiastic about it, but I can't
> offer a better solution right now. You can add my
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
