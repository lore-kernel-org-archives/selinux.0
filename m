Return-Path: <SRS0=awya=N7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC158C32788
	for <selinux@archiver.kernel.org>; Tue, 20 Nov 2018 22:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F229020C01
	for <selinux@archiver.kernel.org>; Tue, 20 Nov 2018 22:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YGqZbjee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F229020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeKUIk7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:40:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37829 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeKUIk7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 03:40:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so3045989lja.4
        for <selinux@vger.kernel.org>; Tue, 20 Nov 2018 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRzeFzzL6dK5j6uV5/XqI7IY4ZxEBsqvs82kASdQPCI=;
        b=YGqZbjee9+xhfVTuWAtljazBqstwFtlRCwqVb6V0yN4htzYcYrEppyEtpzKpUuZrDX
         JpLwZMUaNIiMtYBmf7LMT8AocND6SyM+Q/WIiMippMhaHlM8YgjE0MKx/vPYeOB1Ece3
         5vLkk7mkrtOlBW8brMpGZXm9XH3FfLySIO+sSfaMJMwyL/6CvUUP4ZjVmqmoYdiMtq3k
         YWahFKziYUfiAM02NNOwHJsy83keq0PdpWle5n+PPlHz0q2tyVPLLQ0Z4AkhELwnXb6I
         g1Fx7rSe2hyii2ALOxi2QWuvo/rHhWDUmxtOmD1UMQgljl+V4SQqw8DrcqQYgzL3aXTC
         u42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRzeFzzL6dK5j6uV5/XqI7IY4ZxEBsqvs82kASdQPCI=;
        b=twRXEo5OT0Ooo+bkWkJ3zqrvKnNAGp4tq1iTMFyQRcXMnw/8yIGK40XsxOKQf4EJtd
         oV4srm5Tmq7vFo1HCIsoDtkvZ/EdfQm3GH4PAqw+SqgihOAJwcg7OaAn06ZSeFVgW8/o
         EvFrC8cvOkmmri0+xZJhdd4q2Q9rm1DmfQqYlHmichEkBrF1t1R5HLG8DyQ0xgqVoBU/
         /2TgWVXOPDc0BstrS26YMK6F0xKwsiBq/ktnhTeYwW9Lzk8JB/TuvA+NmSyJqcbcrNOQ
         gKA4TsK+A0JMgEi4P0HPagDI9SuJUFDb+haQJoPkQk9bxEqzevw981sku01WubbhMZL5
         uVlw==
X-Gm-Message-State: AA+aEWbBtbzvKYn/ZbfyRwb+NzVdFX8NcVZ+s759cYiONvJvO6Elv5ns
        VHTqe+szOr5T1ETuMUFTy+nuNBT4rHW7OUxG/D3J
X-Google-Smtp-Source: AFSGD/Wps+3Xuq/ADwoHYGoluIhzOg4x/AZg0eU0Nqm7zLWcwU7z7aSMPYX4ASeg4g3PVToXVSpDKQXg410PsQBJsjQ=
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr2513649ljh.174.1542751777181;
 Tue, 20 Nov 2018 14:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20181116131202.26513-1-omosnace@redhat.com>
In-Reply-To: <20181116131202.26513-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Nov 2018 17:09:25 -0500
Message-ID: <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
Subject: Re: [PATCH] selinux: always allow mounting submounts
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, ebiederm@xmission.com,
        trond.myklebust@primarydata.com, seth.forshee@canonical.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 16, 2018 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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

I think this all sounds reasonable, but please verify this with an
upstream kernel.  Upstream our focus is on the upstream kernel
(surprise!), downstream RHEL is your responsibility, not ours :)

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

-- 
paul moore
www.paul-moore.com
