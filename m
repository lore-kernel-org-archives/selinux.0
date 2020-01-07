Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59158C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288FA20715
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 15:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WWYYht4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgAGP2d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:28:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37202 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgAGP2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 10:28:33 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so22646388ioc.4
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4U62kLnaN6ypDRsqSq3glKuBu1UuApYfzyFJNoJ/b80=;
        b=WWYYht4oDeloHX+pbOsVDSTPwOk36Lxx2Pe39LC5FEMKvxqspZjuLNkGsQQP9BmksA
         rQ4u1C143MHcNETy/qXj60nPcESIZfyPKlNk13UYbqleaS3U08Ti+zOafR8iuZlbjXxL
         FGMDJGFFOb2YT9FfQ+HzZrSwCsKQdHkvK3/6NESF+XzNB00WNVDa3UDXiEh/vJELTqLh
         hRGZXzuq2XGaMtpsKNs5i/tQ9juqyPFxvj9/dA0vhsIRMqm+RJ1lbNXHuWqwUgoGPnXM
         GYuGh2EfxzUcxy9otvS3+1C0WuWd5Yfi5RfH4q9fs1dmWn/bU1AHS/TeZeyXg1Blpn6j
         YuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4U62kLnaN6ypDRsqSq3glKuBu1UuApYfzyFJNoJ/b80=;
        b=dXh9nKYFHs9rB3057gf+6f8GvLH0F1gtfL23j89pLTgm4o3Zm0gTgMiWH/N//i4tef
         HryIf45PJmQBSYvQ9tICCZDxgIGQOvDseSBsmhzdll/IswJt2XxpeCNuG5+XO3adyeox
         L0944QSk1xGF9zH/aYWLn9g0AMwYX4IXJRkS1wZKO2YVhbH+znNoCdUP9PEOTOl5tWOO
         EzvKmVJZxa9F9Se9EtosI7b1Y2fZAweNy7HTOedsZ6ypte90Z5kBJbTnVKjO11J8aZh4
         2G62GKfTOcCtO9tUe31Q2ZtUl3FxmC0UyV8cUs1VaXB1EDt0ZnbM0apANOZIqR52Huh9
         OZjg==
X-Gm-Message-State: APjAAAUEZSTO6XLS9FOIqrsfCo14Xr706eF4VsOcDJ2Mar83eigsBe8U
        sLGS/HUoKQja0WxLlLNrZ1vYW4jDCmW6UPbvEI3rT10=
X-Google-Smtp-Source: APXvYqwcIYvMOPp+ZL82NrvpF5/O7/p3na/FShANxVDhjK/lg2BalF8X8Ww2N/ZHmOBFonkwR51Dq8P2CKaJyatCcZ8=
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr40354jao.65.1578410912923;
 Tue, 07 Jan 2020 07:28:32 -0800 (PST)
MIME-Version: 1.0
References: <157836784986.560897.13893922675143903084.stgit@chester> <43f27f76-f3ca-7ea2-7820-da56bb53fd0e@tycho.nsa.gov>
In-Reply-To: <43f27f76-f3ca-7ea2-7820-da56bb53fd0e@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jan 2020 10:28:22 -0500
Message-ID: <CAHC9VhRrCdrb0K-CzxRehDw85cMHM7SJWeWZQJtr64U8Y1THrQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: deprecate disabling SELinux and runtime
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 9:34 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/6/20 10:30 PM, Paul Moore wrote:
> > Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> > code was originally developed to make it easier for Linux
> > distributions to support architectures where adding parameters to the
> > kernel command line was difficult.  Unfortunately, supporting runtime
> > disable meant we had to make some security trade-offs when it came to
> > the LSM hooks, as documented in the Kconfig help text:
> >
> >    NOTE: selecting this option will disable the '__ro_after_init'
> >    kernel hardening feature for security hooks.   Please consider
> >    using the selinux=0 boot parameter instead of enabling this
> >    option.
> >
> > Fortunately it looks as if that the original motivation for the
> > runtime disable functionality is gone, and Fedora/RHEL appears to be
> > the only major distribution enabling this capability at build time
> > so we are now taking steps to remove it entirely from the kernel.
> > The first step is to mark the functionality as deprecated and print
> > an error when it is used (what this patch is doing).  As Fedora/RHEL
> > makes progress in transitioning the distribution away from runtime
> > disable, we will introduce follow-up patches over several kernel
> > releases which will block for increasing periods of time when the
> > runtime disable is used.  Finally we will remove the option entirely
> > once we believe all users have moved to the kernel cmdline approach.
> >
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> checkpatch.pl has two warnings on this patch, one about the new
> Documentation/ABI/obsolete/sysfs-selinux-disable file not being listed
> in MAINTAINERS (looks like others are) and one about the comment block
> style being wrong.

Fixed.

> Also not entirely sure if the file should be
> sysfs-selinux-disable or selinuxfs-disable; it gets mounted under sysfs
> but isn't part of it per se.  Otherwise, LGTM.

I wondered about that too, but decided the selinuxfs vs sysfs
distinction didn't matter much here as /sys/fs/selinux *looks* like
sysfs to admins/users (outside of the separate mount, but that is
typically handled by the distro's init system).

Anyway, it's merged into selinux/next now.

-- 
paul moore
www.paul-moore.com
