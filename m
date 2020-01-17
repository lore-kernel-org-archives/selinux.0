Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C062C33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA8120748
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClHAFWnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgAQUgH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:36:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34656 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727519AbgAQUgG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 15:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579293365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrlbfNkvOsQb/qxuxirV0cuFWKz04KkEXfXrkHWueVU=;
        b=ClHAFWnX2VXQqZqFbsXv06iAtRcC/XdMgU8pw1Lme8aLm9LF2FIHPs6lP7vdk6RV9qnH0X
        AZEDWnHNVrUzrbir0LH5li2AqokgmXsDpvVRykwOhwj3ZfSEECMlnVR+6NzG9OMIRqxID7
        BpWLbKX1C74jLNXuckdE1BU1s0f745Q=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-vPXkX4KENdmuubQXhqisvQ-1; Fri, 17 Jan 2020 15:36:02 -0500
X-MC-Unique: vPXkX4KENdmuubQXhqisvQ-1
Received: by mail-ot1-f72.google.com with SMTP id e22so13948318otj.13
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 12:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrlbfNkvOsQb/qxuxirV0cuFWKz04KkEXfXrkHWueVU=;
        b=Que3WqRSiMXUJ7+OZKEiK3BGT4SdkxfxXumE1eZUARwTIJEP2mGsoBtlc2xe8b9baU
         FOOGPUBnnSqr+pa5WnOdLfk2FGmxkrO2ZDAWvLrmlGQuHN6ESQwwe99kuIUwKhv1y5FV
         FsKjBTXCOuzdJexgaOo1yqE3gIBluAXpJxUxcsiXuXqiO5OoVfOB2qntIz0P0TxTt4QT
         zEDdWsuslL9c5MRE6mR91lIDEWUB694A4pLT7ksNi+m1qRaB9UXlvCQjJ+j3a8tDzUU6
         HNqkr+a6wUhn1JkLYrsFqBf3rACKMYYNNmkNZVK46lvhPsUp0WbUpZPcD2nZy/PxLLFY
         oOtw==
X-Gm-Message-State: APjAAAU+kX1GNMOVeo0aJ1rijpmNyxOrGANZ/9HQ0j2bTTSNuVjvyEva
        L9HPY+H2CLYNEa48AZ2Parx0okmXWBSBfaQLoES4olq4pHAAPD56IGBGDhvSg/WuT6nId/6EY86
        QZLucSRusvVH7ecFqIa2yP84bXRn8jEu1VQ==
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr4942776oib.26.1579293361929;
        Fri, 17 Jan 2020 12:36:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeMMQxtoygV21ZIGQqECj8REeLLvcdiYaqiUCAZqWkDJUqQkI+jNUBuQBRXXLwVSg0Myq/vQPTSoljgdFgLJE=
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr4942766oib.26.1579293361702;
 Fri, 17 Jan 2020 12:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20200117202407.12344-1-sds@tycho.nsa.gov>
In-Reply-To: <20200117202407.12344-1-sds@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Jan 2020 21:35:51 +0100
Message-ID: <CAFqZXNsL==nPNCk+H916_Xw_Wnnb9w2=9cbTHVyGhtiY8d5yDQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 9:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> introduced a new move_mount(2) system call and a corresponding new LSM
> security_move_mount hook but did not implement this hook for any existing
> LSM.  This creates a regression for SELinux with respect to consistent
> checking of mounts; the existing selinux_mount hook checks mounton
> permission to the mount point path.  Provide a SELinux hook
> implementation for move_mount that applies this same check for
> consistency.  In the future we may wish to add a new move_mount
> filesystem permission and check as well, but this addresses
> the immediate regression.
>
> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks reasonable.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
> v2 drops the RFC prefix, changes the subject to make it more evident that
> this is a regression fix, and drops the TBD comment from the hook.
>
>  security/selinux/hooks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f9224866d60a..b35b5c6ad8be 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2724,6 +2724,14 @@ static int selinux_mount(const char *dev_name,
>                 return path_has_perm(cred, path, FILE__MOUNTON);
>  }
>
> +static int selinux_move_mount(const struct path *from_path,
> +                             const struct path *to_path)
> +{
> +       const struct cred *cred = current_cred();
> +
> +       return path_has_perm(cred, to_path, FILE__MOUNTON);
> +}
> +
>  static int selinux_umount(struct vfsmount *mnt, int flags)
>  {
>         const struct cred *cred = current_cred();
> @@ -6913,6 +6921,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>         LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
>
> +       LSM_HOOK_INIT(move_mount, selinux_move_mount),
> +
>         LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
>         LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
>
> --
> 2.24.1
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

