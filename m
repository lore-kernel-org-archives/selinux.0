Return-Path: <SRS0=oFG+=N6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5294DC43441
	for <selinux@archiver.kernel.org>; Mon, 19 Nov 2018 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F2220823
	for <selinux@archiver.kernel.org>; Mon, 19 Nov 2018 13:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeKSXjS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:39:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34350 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeKSXjR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Nov 2018 18:39:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so6883526oig.1
        for <selinux@vger.kernel.org>; Mon, 19 Nov 2018 05:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQGYQdixr1f/2aLtsRloTikQv/J3TLNwj3qLutVGKSM=;
        b=joz517npJuWfo//sXM90hvAlxFnVFplGTY6aR4geDjqQ7ooFJCESDYXVOun5lJKD70
         mJODc2lmZGPH3r1GVGVq3j9ObxPj6TOwuUuqkRy/hQjMRwBIYWx8tVAdGsRUQ2SlX387
         /Fmi65C+uagtN5z1T4uQIDplvKtclne8+VFK0JURMjCi6+axQ9WXRBVxtjGroVuPCHoh
         GVH9EHDg24GYqD+v3ns9W7ZQCU8AQKK01N3CT/L1DvVL9xst3d6jjJpQyx0seRDIzQCm
         OyahmwCYyRj1hYSVgYto5/GEUJh3fb6Ru+gXEW2nQiM4Tr5EcG1WCajkj0sBMt73I3up
         Z7ag==
X-Gm-Message-State: AA+aEWYqcgK+kMe5oc6jkMU0fiZXwdAX/gxdHEHHzfPH+1JQmbRrlroT
        XfCMy4UIma1+a9BNY5QP1vOPcNAzsAsrZ+aKtenA0A==
X-Google-Smtp-Source: AJdET5e7WQLK8xBGDHWFbpXeeoeeE6R5dcf37MzWXnuw4+BXhZGD401ktWUIyXSEJoBM222Vi6Ymjezl2ElaQ8m4CJk=
X-Received: by 2002:aca:3645:: with SMTP id d66-v6mr7463200oia.234.1542633341249;
 Mon, 19 Nov 2018 05:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20181116131202.26513-1-omosnace@redhat.com>
In-Reply-To: <20181116131202.26513-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 19 Nov 2018 14:15:30 +0100
Message-ID: <CAFqZXNts569Dqqs2A7wODwomo94XADnkOwf9+aXbSYO=oogJ-w@mail.gmail.com>
Subject: Re: [PATCH] selinux: always allow mounting submounts
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 16, 2018 at 2:12 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> If a superblock has the MS_SUBMOUNT flag set, we should always allow
> mounting it. These mounts are done automatically by the kernel either as
> part of mounting some parent mount (e.g. debugfs always mounts tracefs
> under "tracing" for compatibility) or they are mounted automatically as
> needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
> automounts are either an implicit consequence of the parent mount (which
> is already checked) or they can happen during regular accesses (where it
> doesn't make sense to check against the current task's context), the
> mount permission check should be skipped for them.
>
> Without this patch, attempts to access contents of an automounted
> directory can cause unexpected SELinux denials.
>
> In the current kernel tree, the MS_SUBMOUNT flag is set only via
> vfs_submount(), which is called only from the following places:
>  - AFS, when automounting special "symlinks" referencing other cells
>  - CIFS, when automounting "referrals"
>  - NFS, when automounting subtrees
>  - debugfs, when automounting tracefs
>
> In all cases the submounts are meant to be transparent to the user and
> it makes sense that if mounting the master is allowed, then so should be
> the automounts. Note that CAP_SYS_ADMIN capability checking is already
> skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
>  - sget_userns() in fs/super.c:
>         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
>             !(type->fs_flags & FS_USERNS_MOUNT) &&
>             !capable(CAP_SYS_ADMIN))
>                 return ERR_PTR(-EPERM);
>  - sget() in fs/super.c:
>         /* Ensure the requestor has permissions over the target filesystem */
>         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
>                 return ERR_PTR(-EPERM);
>
> Verified internally on patched RHEL 7.6 with a reproducer using
> NFS+httpd and selinux-tesuite.

FYI, I have now submitted a pull request that adds a test for this bug
to the selinux-testsuite:

https://github.com/SELinuxProject/selinux-testsuite/pull/43

>
> Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce683259357..7ce012d9ec51 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2934,7 +2934,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
>                 return rc;
>
>         /* Allow all mounts performed by the kernel */
> -       if (flags & MS_KERNMOUNT)
> +       if (flags & (MS_KERNMOUNT | MS_SUBMOUNT))
>                 return 0;
>
>         ad.type = LSM_AUDIT_DATA_DENTRY;
> --
> 2.17.2
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
