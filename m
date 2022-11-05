Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5946BC43217
	for <selinux@archiver.kernel.org>; Sat,  5 Nov 2022 04:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKEEjL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Nov 2022 00:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEEjL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Nov 2022 00:39:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F1317E8
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 21:39:09 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13c569e5ff5so7592215fac.6
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVhCjTiXsm0XAmH+YRM1X339ickLF/GL0sKIvePwac0=;
        b=FCSnsB+Ncbn05GHt62BXuzIBr4rsH97IiQeiye272VEDnNBybqlEYM6y/waq3nV71X
         KaiiJRqUZTcnkEtCXHhVXzAmNgTVDOFb0BYeit0BPiJhk79dMcjE/vceD3btbG/nkPML
         Sm3DZk4p55e3hOTDWHNnf21GfDhgAx0bVHpoV0VyYDI1lXMoPQT8hyTC9bHRPciw8JpY
         eZ3sDpBvLCFakfNbS83WC96gEQjxzBIVJj5pWpvD6FPndHyIGhQPp6LOCChKqMqdnq/j
         QMd8VSRtjkvDQKWcnjd0BXbzYUlGxA6LG1Sxr6sSwrBkaa0Rl3aJHijXxEDFqV3gIa+K
         d1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVhCjTiXsm0XAmH+YRM1X339ickLF/GL0sKIvePwac0=;
        b=tL5m1VjeyrQcIoiKngqge2yzsRYgmqBa07CppHQOHieiCsUeXErsJytjqgfq7v/xrE
         F5IliyhTvaCHUahqQQPy+KwE/1SLGFDQ77YTeL9kf4NrddeeN5FLh698/xbxHA+Ww+f3
         YQA6HjoUyUs2b4fEalxQY2B//hMx7xVscNthiEGixPGKIZvPsZF7fg2WqLym4BVrX6ng
         tkiF3kPkdev9JzOqvloxZTByfmEs3+SAL4ms3tQPgcdvP1N/7auQVsc2yztPOO4uWzWP
         8tTzslU0qvDIIZ+Qw58GmB7ydAL98DJ+HSDkYxc0tH/ii0/R0R1/j5wjylbJo41XPxKr
         YIpw==
X-Gm-Message-State: ACrzQf3o6F5HCJBC9K08Wm73nAuj0P+w9Db+YoQcz8jHzd4z4gIOBqvY
        pqMbkIucVu+toccsyUS8z+v+L65kqB79jE7epFcQZUdeQeIR
X-Google-Smtp-Source: AMsMyM4w7eiFkYBhePubE/PyYhcqGdnaotz0NDTczdH13Aq1WqMXxNy3Sb/YZHqSax4NIV/jSYcVfTpPs875XiKcH8E=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr23511755oap.172.1667623149267; Fri, 04
 Nov 2022 21:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221103151205.702826-1-omosnace@redhat.com>
In-Reply-To: <20221103151205.702826-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 00:38:57 -0400
Message-ID: <CAHC9VhS460B4Jpk8kqmhTBZv_dMuysNb9yH=6hB4-+Oc35UkAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: don't audit the capability check in simple_xattr_list()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 3, 2022 at 11:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The check being unconditional may lead to unwanted denials reported by
> LSMs when a process has the capability granted by DAC, but denied by an
> LSM. In the case of SELinux such denials are a problem, since they can't
> be effectively filtered out via the policy and when not silenced, they
> produce noise that may hide a true problem or an attack.
>
> Checking for the capability only if any trusted xattr is actually
> present wouldn't really address the issue, since calling listxattr(2) on
> such node on its own doesn't indicate an explicit attempt to see the
> trusted xattrs. Additionally, it could potentially leak the presence of
> trusted xattrs to an unprivileged user if they can check for the denials
> (e.g. through dmesg).
>
> Therefore, it's best (and simplest) to keep the check unconditional and
> instead use ns_capable_noaudit() that will silence any associated LSM
> denials.
>
> Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
> Reported-by: Martin Pitt <mpitt@redhat.com>
> Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v1 -> v2: switch to simpler and better solution as suggested by Christian
>
> v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/
>
>  fs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

VFS folks, this should really go through a vfs tree, but if nobody
wants to pick it up *and* there are no objections to the change, I can
take this via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
