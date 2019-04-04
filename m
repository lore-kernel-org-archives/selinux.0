Return-Path: <SRS0=gAxo=SG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F2C4360F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9589A20855
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 13:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="INrOCB7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfDDNJi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:09:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39399 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDDNJi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 09:09:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so1736458lfb.6
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGDkV9SrrC2ybpSUvRskKPAujmJmaT6QBlGdMVv2xMo=;
        b=INrOCB7Wh/rs21dD8mGhFbGcIcS49KLkYByq6FqTwd6L4uxl+yTmZyQH86XR4CJ4JQ
         YnnYCK9NSJ0TZF6nkK8XtwoWcUamnall08cFu1UDMax65gxkcu1XaQdss2OxHw3D+h+I
         DRoNxmyeV9oHs+H8i5KLfpfileLECyB4BtIBy++/kBU5IrLuyZPBo3HSbHklO36w7Gug
         J1vpbfLp6KsUuPNIavVj9vDAD6LuxQchYWcgomCemm31A0PBfhjRLiqDklDnRNMdIEv7
         Z7MJLXi/TqGbQP72PKCTf6KKsPlBZiB5VhSGH2lWSUZ9kv9FtIr472zN5GbQyJc5w8dI
         5KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGDkV9SrrC2ybpSUvRskKPAujmJmaT6QBlGdMVv2xMo=;
        b=aHEjepN/0WFKmaTcXHyrNyzD5TjPLZ7C5yvNs15hVgZ5sfnlPNEPfQ/lwZ7IuYLCgJ
         Y3lGK09rJOhmXCFgnf04V3oBJZiJc8x2Szr6ZClE5o0lFD1uEhnV4LvDq74m8bEn3s2X
         27bULVfmiBu5pv6Hk388lBb7J23yWW305jFpWXtHxushTxsGtvJ9B+twdbGLTdHb6o4V
         p782OFf57GQ/LDxGd7RbW/Vu8hHry8CpxbSqpcyden/GuxlOgc2VQ7ajzjw5cW+sz6zK
         msqcn5eD+/pVclAM5bR45iwB5HynWXBrsmxjtFcY3tUliNeqrxBwMTWjN7rfTPt0CA0Q
         o5eA==
X-Gm-Message-State: APjAAAWhpeDEcwKGYe7KCCtAAVXSghL2D1M9D/mibbAKwSEK8Iou4kKm
        Jfbh0bFSj/uuXVodSW1e0704q4qKSHgKPluhWMc6
X-Google-Smtp-Source: APXvYqzrqG/VR2a9qJAcPf1wbcs8oxF+I8Fx4u5cqmRMTAFSB1cnODLvkt5schvmoRZ/LxkDOMM4Vqe638HfMSuh6vg=
X-Received: by 2002:ac2:5c5a:: with SMTP id s26mr3282970lfp.109.1554383375944;
 Thu, 04 Apr 2019 06:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190401103403.14130-1-omosnace@redhat.com>
 <CAHC9VhSpHHeXHd3winROvmto5RULQYnfQB30nO_FcQ35WLxFfA@mail.gmail.com>
 <CAHC9VhQX31rnFet-V4E24AktrW6d7OqsTPtDOOoeNxVrCXCTmQ@mail.gmail.com> <CAFqZXNt7yBF-4XiQ5AtgudjDj1sLLXQ=TSZphkqAAon9SVGbmw@mail.gmail.com>
In-Reply-To: <CAFqZXNt7yBF-4XiQ5AtgudjDj1sLLXQ=TSZphkqAAon9SVGbmw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Apr 2019 09:09:24 -0400
Message-ID: <CAHC9VhRjv4en3_G3zRSXi721udUmTWiq3zAvXyDUrQ_==THhLw@mail.gmail.com>
Subject: Re: [PATCH v3] kernfs: fix xattr name handling in LSM helpers
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 3, 2019 at 3:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Apr 3, 2019 at 3:24 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Apr 2, 2019 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Apr 1, 2019 at 6:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > The implementation of kernfs_security_xattr_*() helpers reuses the
> > > > kernfs_node_xattr_*() functions, which take the suffix of the xattr name
> > > > and extract full xattr name from it using xattr_full_name(). However,
> > > > this function relies on the fact that the suffix passed to xattr
> > > > handlers from VFS is always constructed from the full name by just
> > > > incerementing the pointer. This doesn't necessarily hold for the callers
> > > > of kernfs_security_xattr_*(), so their usage will easily lead to
> > > > out-of-bounds access.
> > > >
> > > > Fix this by moving the xattr name reconstruction to the VFS xattr
> > > > handlers and replacing the kernfs_security_xattr_*() helpers with more
> > > > general kernfs_xattr_*() helpers that take full xattr name and allow
> > > > accessing all kernfs node's xattrs.
> > > >
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> > > > Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >
> > > > v3: simplify kernfs xattr helpers as per Paul's suggestion
> > > > v2: just rebase to update diff context
> > > >
> > > >  fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
> > > >  include/linux/kernfs.h   | 18 ++++++------
> > > >  security/selinux/hooks.c |  9 +++---
> > > >  3 files changed, 33 insertions(+), 56 deletions(-)
> > >
> > > This is better, thanks.  Merged into selinux/next.
> >
> > ... and I've just popped it off selinux/next.  It looks like you need
> > to export the kernfs functions.
> >
> > ld: security/selinux/hooks.o: in function `selinux_kernfs_init_security':
> > /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-5.1.
> > 0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3397: undefined re
> > ference to `kernfs_xattr_get'
> > ld: /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-
> > 5.1.0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3408: undefine
> > d reference to `kernfs_xattr_get'
> > ld: /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-
> > 5.1.0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3441: undefine
> > d reference to `kernfs_xattr_set'
> > make: *** [Makefile:1033: vmlinux] Error 1
>
> Hm, I *thought* I ran the build before posting...

Spoiler alert: you didn't.  On my end I know I didn't build a full
kernel to test that your patch built, I just built the fs/kernfs and
security/selinux directories.  I should add a verification step to
help ensure stuff like this doesn't get through review, and you should
*ALWAYS* make sure you can build and boot a kernel with your patches
before submitting them; I don't care if you just changed the name of a
variable, build a new kernel and boot it.

> The problem is that
> the function names in kernfs.h and inode.c didn't match.
> EXPORT_SYMBOL_GPL() shouldn't be needed since both kernfs and SELinux
> are always built-in and there seems to be an existing trend in kernfs
> to not export functions unless necessary.

I didn't look that closely at the failure, I just yanked your patch
out of the tree.  Historically most failures like this are usually
caused by wrong/missing exports, so I just assumed that was the case.

-- 
paul moore
www.paul-moore.com
