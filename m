Return-Path: <SRS0=YsfU=SF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F04C4360F
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 01:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA22020830
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 01:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LHgrNOg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDCBYD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:24:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41660 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCBYD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Apr 2019 21:24:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so10411878lfr.8
        for <selinux@vger.kernel.org>; Tue, 02 Apr 2019 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7UZTXuj/NsmHiL5cYnMEAcsAlbZOqvzW93+/Z0pgqY=;
        b=LHgrNOg1OBr51kCAqlp/zzqb8/E4WZqBxlkUPmGYsmkxrr5dEETP6h3jvKKy299ZB4
         +IbVSbLegbxo68Mqs34yZfXy6VQSBTeeLjIVM4VCAJiFEzAnMDMbh1qVUWP8W0m3gWEA
         5pK7JVY7xOnBMCiTAnS+swwBL2HuhFUHzEjVzZMdXouxe8O9LpO50SsLc4VD9UZWB9FP
         0/yXzwu6d+of54EwlnhhO0XsAf/onhEkpqIdqpRK6wvicp8OTSWkTq9YVqgt5GAxC7Ek
         sGMk18xgBJhtcAPjAWz52qBRWRXySONmMd3yTfCtiWJ75pI1yfmeNH91DErUlkymojit
         wdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7UZTXuj/NsmHiL5cYnMEAcsAlbZOqvzW93+/Z0pgqY=;
        b=l3Sx+AOVZjWDwRl4BRMEkUoF4D3bDpvbVqOElGYlwrKLEMDTwrvVtsfh7jCzE6+Bj5
         cuto0kEuLQeUXUS5CgMdClTRjl/2eNzdOReTwSBPqht9NCLqsEriGCtGK5NyykcYllm4
         f4FMVVlpAsDnQ16VtQDMfQy6+2UyxdRsZxqTdwHJj0Z1oNDQrZbD9hJS+4A/ZyU4bOOQ
         IwpUXaBKw+Z0uNElDwLPQhKffWUFIWI8HqeNzr1rxnMAWNakos902zQ6HBJ8Fnt/cedh
         oPcQIt+PXRF3PtSyas1Z68UJw1akH/kxAOQCgYHVeN2GO4IIpKyW3IP4buMVY0um3c2U
         20Zg==
X-Gm-Message-State: APjAAAW1+pGhYlPuKI6C4531Y/SKluhl4aq89KT6vxUSDGSEbvjv28BD
        6wcWSq/m/8Wn1KGDs9tjeGAeNhBiCkNWI9CVAtjt
X-Google-Smtp-Source: APXvYqx7Ec0166IdDAr/E0Byluh3pm7gXkG5O34r3tESpR1DBHEwxJFL6EaC7BP/VITBJqMOgrEk9Rm540y1rPibThE=
X-Received: by 2002:ac2:43b7:: with SMTP id t23mr17873017lfl.85.1554254640909;
 Tue, 02 Apr 2019 18:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <20190401103403.14130-1-omosnace@redhat.com>
 <CAHC9VhSpHHeXHd3winROvmto5RULQYnfQB30nO_FcQ35WLxFfA@mail.gmail.com>
In-Reply-To: <CAHC9VhSpHHeXHd3winROvmto5RULQYnfQB30nO_FcQ35WLxFfA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Apr 2019 21:23:49 -0400
Message-ID: <CAHC9VhQX31rnFet-V4E24AktrW6d7OqsTPtDOOoeNxVrCXCTmQ@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Apr 1, 2019 at 6:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > The implementation of kernfs_security_xattr_*() helpers reuses the
> > kernfs_node_xattr_*() functions, which take the suffix of the xattr name
> > and extract full xattr name from it using xattr_full_name(). However,
> > this function relies on the fact that the suffix passed to xattr
> > handlers from VFS is always constructed from the full name by just
> > incerementing the pointer. This doesn't necessarily hold for the callers
> > of kernfs_security_xattr_*(), so their usage will easily lead to
> > out-of-bounds access.
> >
> > Fix this by moving the xattr name reconstruction to the VFS xattr
> > handlers and replacing the kernfs_security_xattr_*() helpers with more
> > general kernfs_xattr_*() helpers that take full xattr name and allow
> > accessing all kernfs node's xattrs.
> >
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> > Fixes: ec882da5cda9 ("selinux: implement the kernfs_init_security hook")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v3: simplify kernfs xattr helpers as per Paul's suggestion
> > v2: just rebase to update diff context
> >
> >  fs/kernfs/inode.c        | 62 ++++++++++++++--------------------------
> >  include/linux/kernfs.h   | 18 ++++++------
> >  security/selinux/hooks.c |  9 +++---
> >  3 files changed, 33 insertions(+), 56 deletions(-)
>
> This is better, thanks.  Merged into selinux/next.

... and I've just popped it off selinux/next.  It looks like you need
to export the kernfs functions.

ld: security/selinux/hooks.o: in function `selinux_kernfs_init_security':
/pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-5.1.
0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3397: undefined re
ference to `kernfs_xattr_get'
ld: /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-
5.1.0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3408: undefine
d reference to `kernfs_xattr_get'
ld: /pjob.data/scratch/t/server-build.lan-2100-uHT0/BUILD/kernel-5.0.fc31/linux-
5.1.0-0.rc3.git1.1.2.secnext.fc31.x86_64/security/selinux/hooks.c:3441: undefine
d reference to `kernfs_xattr_set'
make: *** [Makefile:1033: vmlinux] Error 1

-- 
paul moore
www.paul-moore.com
