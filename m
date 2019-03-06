Return-Path: <SRS0=Zlcp=RJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23820C4360F
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1A7206DD
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QwPXtqZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfCFQUo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:20:44 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36435 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCFQUo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Mar 2019 11:20:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id x206so9379847lff.3
        for <selinux@vger.kernel.org>; Wed, 06 Mar 2019 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjz51UU6GXQYL+16XKU/iiGTsNEYSn0tEhxGlYS0vdE=;
        b=QwPXtqZXvCp9vswSrO4WW1Ty6hS97gqr/JXonLffEsta4mW0YmYrJcx7nNifVDbclu
         UZzBbIryPUYyPMSv8a617ZOo6uj0bBGhznSR+rYJxFL/w2j1IciZOuaPxG2c6LvU2YZM
         ty9AfQ6XRscNlwSRQi0eyEqwwlAKqiIj5tu95wMoSMD+uiKf/d/uPPqd5/GPmj/jfxJM
         SBiaDur4hC98cYgQYWYLd8ehOIkkqTErVKw3TRD5T/N1AFroiAmi0TDntfCRj0e1NLZ3
         RqSH+JJeajOKuoAAIMHvOrLg7KJGfld2Z9wtJCBUOc86fhsV/u+piQbANjqwdtNriMBt
         xawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjz51UU6GXQYL+16XKU/iiGTsNEYSn0tEhxGlYS0vdE=;
        b=s89ElXjW4ddfUWp1LbJk3BE6h2IKE9ZOk5MWOdpf6RzRYTEujrIfgvJFomoZZ/EwD7
         PO1mZgwwysMCSwUWNAtNuKWVjMleJiHHiJ1TcF/L53IFfdQKxiPxtMt7ZN+oF4wIJnGK
         oeyU+GadMCF/hFjjQ+Mu/uFNotwcpbbHLG9hGoALFLobTXAW11qAiPlryfUTq6tlj6RS
         SIb7/qWaIH+WSY1oXfN7hFcQqqNF/rmlCE69IqVkofl/7kjEq4YXVF00Rg97H/MjsEoM
         deKxnyeQaIQw+zoYXUhd87PcvubTTHTnLlibmC2WuOc7kGyHW1ESpcuQ1knnV0kKmnxv
         izyQ==
X-Gm-Message-State: APjAAAVbLths75PZhl9yqe7+X8IgcUzMp8T92PZsQfsg6RcBFPH79ElV
        A+NUuqnjLYtD2/PPWMCpHaahCtisN7fy/ZKZR+2f
X-Google-Smtp-Source: APXvYqxo1of1MchxnVzRpTaZj7cG9minfK+eA7RA0YF97+o5lPUADLNPFHqKXcz3ksOnjtgNDIZwlE12Vv7WJc7+bo0=
X-Received: by 2002:a19:7512:: with SMTP id y18mr4255061lfe.105.1551889240785;
 Wed, 06 Mar 2019 08:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20190222145718.5740-1-omosnace@redhat.com> <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
In-Reply-To: <CAFqZXNs28QAxHA3=vECuG17TQ-be0ywS=r9S48q_KNBYpzgJLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Mar 2019 11:20:29 -0500
Message-ID: <CAHC9VhShXZasD8d3nF4PwaL38gkq3hKDbvRivHX5_oHeBROFKQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Allow initializing the kernfs node's secctx based
 on its parent
To:     Ondrej Mosnacek <omosnace@redhat.com>
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

On Wed, Mar 6, 2019 at 10:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Feb 22, 2019 at 3:57 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> >
> > --
> > 2.20.1
>
> Ping about this series... Casey, are you OK with this new version?

We've got two weeks, well one and a half weeks, to decide as the
earliest I would merge this would be after the merge window closes :)

-- 
paul moore
www.paul-moore.com
