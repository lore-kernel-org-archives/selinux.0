Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EDC433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 08:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9296A207DA
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 08:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqULDWu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgFCIXe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:23:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgFCIXe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 04:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591172612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n48ObUJ4XB5tQgqMf9W5l2G/DrT8oH0Vsx+85GbzLZY=;
        b=JqULDWu34o+F/SqNwxmxUoG5WK6z2lS5ZoczqKSWJRaZqZx46EGKu44bgFloAzaiO+E4w5
        bmM3t/x7dCaiIX1IPhvbYWYuDmclrwZq7xat3TZHXQ2ZA9gmMEdJstabJYemR39FgV963E
        dbnyLglWzVLNMA9l5CFXZaHz/370qoY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-WkhxGXTsMiuBgJ1hrf_gHA-1; Wed, 03 Jun 2020 04:23:30 -0400
X-MC-Unique: WkhxGXTsMiuBgJ1hrf_gHA-1
Received: by mail-oi1-f197.google.com with SMTP id s185so1063457oia.23
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 01:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n48ObUJ4XB5tQgqMf9W5l2G/DrT8oH0Vsx+85GbzLZY=;
        b=pc9G84X/NyPgW4vR1RrOS63NCxgCUcTWAE0lUAW5z6JF6MQWXwQNfuHTirsV+m4W7F
         tt1Z0DDTy2Co/60Zreow2bgSCSTppFI8E26ZtGP7cnV1r4TLJy+88MvbsspYpY/py92Z
         yJQNOKSJIl6bOZJqn7vitZ5ek2vBhVu93bAcr2KH6yzkSVzRITSHIGYcB3NXr6Zh8xiG
         UVzMG++bTh6qDCFBsqEUfbtXMPlxd24HHwF5B8JGOucb7aolu6hTlIHWxHndM+ocGwwr
         Db21pqFe0dUR7VJfo25kD0bJCcUAi7XWthx2c6t5hdjzIWjl/2y/Z1TwQkTNt2bcrmrn
         3sig==
X-Gm-Message-State: AOAM530ONElVtPt7W/EgPVYRG1zA1j19ovwOFLpBaKRlpHi++eHqCXib
        o4eySEOjKxFXrN8XnofBYCzb1BikdaVYDW45OxvlNZY5rCg5Wf6uUN61yZlqDO8cC+lYpv+LN2D
        aW6FPiY5yGh14NUGjwGz2yMGUC8IZnZBnxA==
X-Received: by 2002:aca:230e:: with SMTP id e14mr5522513oie.127.1591172608851;
        Wed, 03 Jun 2020 01:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+Uf26Qv+MI7Jo2EWgwAroSzxV+bxK9hSMuykjCYSReOmpGcJetFMnx24g9R36TAJclRyqO9vqUAx0djx3gzg=
X-Received: by 2002:aca:230e:: with SMTP id e14mr5522510oie.127.1591172608594;
 Wed, 03 Jun 2020 01:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200602174220.10210-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200602174220.10210-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Jun 2020 10:23:17 +0200
Message-ID: <CAFqZXNuaqfko_PSzdw8Nwp4hEfYKmQY0ycTopuDwDPK1b2pzeg@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy/test_overlayfs.te: allow mounter to
 create whiteouts
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 7:42 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> This is required to pass the tests for kernels that include
> commit a3c751a50fe6 ("vfs: allow unprivileged whiteout creation"),
> which changed vfs_mknod() to permit whiteout creation without
> requiring CAP_MKNOD and then switched vfs_whiteout() to use vfs_mknod()
> rather than calling i_op->mknod() directly, which was originally done
> to avoid such checking.  However, vfs_mknod() still calls the LSM hook
> and therefore applies SELinux checks on whiteout creation.  Since
> vfs_whiteout() now calls vfs_mknod(), SELinux :chr_file create permission
> is now required for such whiteout creation by overlayfs.  Skipping the LSM
> hook call or SELinux check entirely seems unsafe since we otherwise would
> never check whether the process was allowed to create a file in that label;
> even though the whiteout device cannot be read/written, it can be used as
> a channel wrt its existence and attributes.
>
> See the discussion in:
> https://lore.kernel.org/linux-fsdevel/20200409212859.GH28467@miu.piliscsaba.redhat.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  policy/test_overlayfs.te | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this looks good and fixes the failure for me.

>
> diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> index b29621e..c844b82 100644
> --- a/policy/test_overlayfs.te
> +++ b/policy/test_overlayfs.te
> @@ -88,7 +88,7 @@ manage_dirs_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_o
>  #
>  # Needed to remove a transition file

Just please also update this comment ("...to create and remove..." or similar).

>  #
> -allow test_overlay_mounter_t test_overlay_mounter_files_t:chr_file { getattr rename unlink };
> +allow test_overlay_mounter_t test_overlay_mounter_files_t:chr_file { create getattr rename unlink };
>  allow test_overlay_mounter_t test_overlay_files_rwx_t:chr_file { manage_chr_file_perms rename unlink };
>
>  #
> --
> 2.23.3
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

