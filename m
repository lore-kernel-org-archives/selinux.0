Return-Path: <SRS0=dLD2=QS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB6C282CE
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5C1218D8
	for <selinux@archiver.kernel.org>; Mon, 11 Feb 2019 12:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfBKMIC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:08:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43660 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBKMIB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Feb 2019 07:08:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so2429108ota.10
        for <selinux@vger.kernel.org>; Mon, 11 Feb 2019 04:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hzHmTmOkkAlt/nXQx+HVZVynDSulg9pldKwmaE3AuM=;
        b=TvQNcarMxByieeOdmkBXfDSG9YAEaEkcSDLbujgBeYtbC4QWRyGKmI2751F9x5Y2I4
         UgxmqRXkiUmlEPOkx8fsjLxQqPfCICqGP+n0BmvlkpxoljnN7dkondeXLiOAs6WXi6rX
         vNRsMVaONBIWgwc6OExpJh/u29GxO+uRy0aXzoeAQUGm03uvlzQ9bpQpd0iRg+bTjnLH
         jku5lP0pFTm+JuS7UUmtvjtF/IepGmlalNQTaQKsv3Em+yF4hNYqpikf4Yi6Zbjk5drx
         ObNEUBa4TfAWBd1D0iiQsfjt/lQ6g6r3EkWzy3kZvc2dc/9kiUAoFmK2X9nkZxQR0xTx
         5mKw==
X-Gm-Message-State: AHQUAua1TNEQWmEyEeNd8SxTaLQ48wAhYmPSkbHvMt09TVKIIy78z/Qd
        kv1pPuIStC+Wme6ILWv8Tdx8W8O/aCISt7mfuB4MUVIw
X-Google-Smtp-Source: AHgI3IarB52ugU25VIY97/ZUicIxIlfxkImAvDC7T5rQHotYHYw3cyYtzE+QezSwQZ2YR6KGc+VbQUivPfL/PAmF1Ng=
X-Received: by 2002:a9d:1790:: with SMTP id j16mr12533961otj.52.1549886880235;
 Mon, 11 Feb 2019 04:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20190205110638.30782-1-omosnace@redhat.com>
In-Reply-To: <20190205110638.30782-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 Feb 2019 13:07:49 +0100
Message-ID: <CAFqZXNuW-ZAQ5Be2b+R4WRr33JCpJXK8OZ0Qv8uD8Pxcwk7Biw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Allow initializing the kernfs node's secctx based
 on its parent
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 5, 2019 at 12:06 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Changes in v5:
> - fix misplaced semicolon detected by 0day robot
>
> v4: https://lore.kernel.org/selinux/20190205085915.5183-1-omosnace@redhat.com/T/
> Changes in v4:
> - reorder and rename hook arguments
> - avoid allocating kernfs_iattrs unless needed
>
> v3: https://lore.kernel.org/selinux/20190130114150.27807-1-omosnace@redhat.com/T/
> Changes in v3:
> - rename the hook to "kernfs_init_security"
> - change the hook interface to simply pass pointers to struct iattr and
>   struct simple_xattrs of both the new node and its parent
> - add full security xattr support to kernfs (and fixup SELinux behavior
>   to handle it properly)
>
> v2: https://lore.kernel.org/selinux/20190109162830.8309-1-omosnace@redhat.com/T/
> Changes in v2:
> - add docstring for the new hook in union security_list_options
> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>   implemented
>
> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>
> TL;DR:
> This series adds a new security hook that allows to initialize the security
> context of kernfs properly, taking into account the parent context (and
> possibly other attributes). Kernfs nodes require special handling here, since
> they are not bound to specific inodes/superblocks, but instead represent the
> backing tree structure that is used to build the VFS tree when the kernfs
> tree is mounted.
>
> The kernfs nodes initially do not store any security context and rely on
> the LSM to assign some default context to inodes created over them. Kernfs
> inodes, however, allow setting an explicit context via the *setxattr(2)
> syscalls, in which case the context is stored inside the kernfs node's
> internal structure.
>
> SELinux (and possibly other LSMs) initialize the context of newly created
> FS objects based on the parent object's context (usually the child inherits
> the parent's context, unless the policy dictates otherwise). This is done
> by hooking the creation of the new inode corresponding to the newly created
> file/directory via security_inode_init_security() (most filesystems always
> create a fresh inode when a new FS object is created). However, kernfs nodes
> can be created "behind the scenes" while the filesystem is not mounted
> anywhere and thus no inodes can exist for them yet.
>
> Therefore, to allow maintaining similar behavior for kernfs nodes, a new
> LSM hook is needed, which will allow initializing the kernfs node's
> security context based on its own attributes and those of the parent's
> node.
>
> The main motivation for this change is that the userspace users of cgroupfs
> (which is built on kernfs) expect the usual security context inheritance
> to work under SELinux (see [1] and [2]). This functionality is required for
> better confinement of containers under SELinux.
>
> Patch 1/5 changes SELinux to fetch security context from extended
> attributes on kernfs filesystems, falling back to genfs-defined context
> if that fails. Without this patch the 2/5 would be a regression for
> SELinux (due to the removal of ...notifysecctx() call.
>
> Patch 2/5 implements full security xattr support in kernfs using
> simple_xattrs; patch 3/5 adds the new LSM hook; patch 4/5 implements the
> new hook in SELinux; and patch 5/5 modifies kernfs to call the new hook
> on new node creation.
>
> Testing:
> - passed the reproducer from the commit message of the last patch
> - passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
>   current Rawhide kernel (5.0.0-0.rc5.git0.1) [3]
>   - including the new proposed selinux-testsuite subtest [4] (adapted
>     from the reproducer)
>
> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
> [3] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/854148/
> [4] https://github.com/SELinuxProject/selinux-testsuite/pull/48
>
> Ondrej Mosnacek (5):
>   selinux: try security xattr after genfs for kernfs filesystems
>   kernfs: use simple_xattrs for security attributes
>   LSM: add new hook for kernfs node initialization
>   selinux: implement the kernfs_init_security hook
>   kernfs: initialize security of newly created nodes
>
>  fs/kernfs/dir.c                     |  64 +++++++-
>  fs/kernfs/inode.c                   | 125 +++++++---------
>  fs/kernfs/kernfs-internal.h         |   7 +-
>  include/linux/lsm_hooks.h           |  22 +++
>  include/linux/security.h            |  14 ++
>  include/linux/xattr.h               |  15 ++
>  security/security.c                 |  10 ++
>  security/selinux/hooks.c            | 221 +++++++++++++++++++---------
>  security/selinux/include/security.h |   1 +
>  9 files changed, 328 insertions(+), 151 deletions(-)
>
> --
> 2.20.1

Are there any further comments/objections to this patchset (other than
the duplicate include in patch #1)? I'd like to accumulate changes (if
any are needed) before posting v6.

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
