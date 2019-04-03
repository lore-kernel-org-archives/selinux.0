Return-Path: <SRS0=YsfU=SF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B312DC4360F
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 07:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A29320830
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 07:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDCHZ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:25:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37668 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHZ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Apr 2019 03:25:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so14558213otn.4
        for <selinux@vger.kernel.org>; Wed, 03 Apr 2019 00:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPv+/an/47YbZ5RiyzER+DNiKtKzXU8zipOU5FL1+Fg=;
        b=TDD6Sj9qgq1KDAyXTOAXaYLoTvAUzeDtY4voKIYM4ZPXvyqKWOZnYDq3s0Y2mMI1y/
         5vOemCIAj1o98U5mLq2zU/DHj1PwcsX7xZkofvT39UkGACb4IehdmnSRO7f0ghhCAl0H
         VP8+B7aZBOOzZi+Bmwi31zY1p0gV74JyxK06x7KM57CASGrqmf2EOuvoMH9RAeJ7LNIS
         N6zCapagirqQ8j8jG0g7n2BFniXzQTXL7z89N9Nj9O7xCcswyhTWcNrTc8rkUvnTNQYR
         j1eb9KO+WQKOh3cw3GbklMg0S/5I378kfFUXFUgoPijq5HSLJLUgHDVzx/mFDvHwgBas
         cUQg==
X-Gm-Message-State: APjAAAX1Yo0kS7trEMH2IMP+myoUucER5eArDSlCPoCzcLcJiZY7clv/
        22lhFNEgS+9o86MXVUMc7tG23YQ8yN4Lg1/z/hEKNA==
X-Google-Smtp-Source: APXvYqwUZoXSx5q3u+nLxdrS5nAV+lg1whntkUsCyyZ2xPwBNrOlKpxxtmbMwZBziyYyhR0xu9KXBiPxgGkaAAeRD2o=
X-Received: by 2002:a9d:27e9:: with SMTP id c96mr16417267otb.206.1554276357182;
 Wed, 03 Apr 2019 00:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190401103403.14130-1-omosnace@redhat.com>
 <CAHC9VhSpHHeXHd3winROvmto5RULQYnfQB30nO_FcQ35WLxFfA@mail.gmail.com> <CAHC9VhQX31rnFet-V4E24AktrW6d7OqsTPtDOOoeNxVrCXCTmQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQX31rnFet-V4E24AktrW6d7OqsTPtDOOoeNxVrCXCTmQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Apr 2019 09:25:46 +0200
Message-ID: <CAFqZXNt7yBF-4XiQ5AtgudjDj1sLLXQ=TSZphkqAAon9SVGbmw@mail.gmail.com>
Subject: Re: [PATCH v3] kernfs: fix xattr name handling in LSM helpers
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tejun Heo <tj@kernel.org>, lkp@01.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 3, 2019 at 3:24 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Apr 2, 2019 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Apr 1, 2019 at 6:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > The implementation of kernfs_security_xattr_*() helpers reuses the
> > > kernfs_node_xattr_*() functions, which take the suffix of the xattr name
> > > and extract full xattr name from it using xattr_full_name(). However,
> > > this function relies on the fact that the suffix passed to xattr
> > > handlers from VFS is always constructed from the full name by just
> > > incerementing the pointer. This doesn't necessarily hold for the callers
> > > of kernfs_security_xattr_*(), so their usage will easily lead to
> > > out-of-bounds access.
> > >
> > > Fix this by moving the xattr name reconstruction to the VFS xattr
> > > handlers and replacing the kernfs_security_xattr_*() helpers with more
> > > general kernfs_xattr_*() helpers that take full xattr name and allow
> > > accessing all kernfs node's xattrs.
> > >
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> > > Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > v3: simplify kernfs xattr helpers as per Paul's suggestion
> > > v2: just rebase to update diff context
> > >
> > >  fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
> > >  include/linux/kernfs.h   | 18 ++++++------
> > >  security/selinux/hooks.c |  9 +++---
> > >  3 files changed, 33 insertions(+), 56 deletions(-)
> >
> > This is better, thanks.  Merged into selinux/next.
>
> ... and I've just popped it off selinux/next.  It looks like you need
> to export the kernfs functions.
>
> ld: security/selinux/hooks.o: in function `selinux_kernfs_init_security':
> /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-5.1.
> 0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3397: undefined re
> ference to `kernfs_xattr_get'
> ld: /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-
> 5.1.0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3408: undefine
> d reference to `kernfs_xattr_get'
> ld: /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-
> 5.1.0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3441: undefine
> d reference to `kernfs_xattr_set'
> make: *** [Makefile:1033: vmlinux] Error 1

Hm, I *thought* I ran the build before posting... The problem is that
the function names in kernfs.h and inode.c didn't match.
EXPORT_SYMBOL_GPL() shouldn't be needed since both kernfs and SELinux
are always built-in and there seems to be an existing trend in kernfs
to not export functions unless necessary.

I should have a fixed patch ready soon.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
