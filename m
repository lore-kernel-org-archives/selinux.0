Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730E8C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBDE20C56
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 17:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4Pb8bEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgE0RPw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 13:15:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729913AbgE0RPv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 13:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590599750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+DKhej2L3ExeFPiolt+EL9c2zVezXfTaOkoP50TcdQ=;
        b=Q4Pb8bEqPgKBXK/cnwBbyEoLoWiQa1QGBsHtXLPjMXPEAH5+/TLuW03myDhmrPGVTkCV0x
        OQ0ioep7ofvD3OEAZ1cSStBWmh1Idf/jwcdL0O8eYNzN67VvkxG8mgUAxn5N7npxg6dM7W
        fi7KKu2m6UxVLdWaBea/Y6MI92KwZG8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-ZNXAXZ-HOeOPX8hhJvqz2Q-1; Wed, 27 May 2020 13:15:36 -0400
X-MC-Unique: ZNXAXZ-HOeOPX8hhJvqz2Q-1
Received: by mail-ot1-f71.google.com with SMTP id k23so72183otp.16
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 10:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+DKhej2L3ExeFPiolt+EL9c2zVezXfTaOkoP50TcdQ=;
        b=jGhHXTXAwgxnABhobBi1DzZz7YR4lBO1FebM3I8c6yYHgaI2USSyi4I/SCcHx1taz6
         r6md0evwVBd4Iq1RHbRNTecA5bEXcHnyv4AlhjkCkfXZ80EBe1jAyTpOEynA415+athM
         QevR73QTV2z8efuBR1dq0btBQK9BQAWZzP+XjEvOuw7PFVGbKIg3eztLe76wp9byoAEN
         bLOOWHeHc8/aUHwMqO43y7y3psSxP8dGh+EhkZ0lMK3x7UzgGftBOdhG766qifRV39y2
         hsuQgiAX9h310dlnQPM51HnjECAT+Fgpt5WGgDp30DgsJF10zUtiQr27KggcEDsWBISs
         EZzg==
X-Gm-Message-State: AOAM530FSpCVTKMYSo2/LJNqM1440cbWKVbXazdpgilXITg4+v91uK7y
        IZNbrKSUDYDHAhWcKy14+W/7uuBCKY83Kba5+QhtDrVYG8y+xmoqzD7I00lRpth9pN9zgnnF9Rp
        27VhjSzElCV4yPAu9rVq81ZmjU7oNAdnKYg==
X-Received: by 2002:aca:230e:: with SMTP id e14mr3456963oie.127.1590599736012;
        Wed, 27 May 2020 10:15:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHx0Asb6FwJxt/Iunf4OBGfGj6u91q8CWKBPPQj/L5GZPTdm0oCnbT7rHNLjqLgjlMTBa+F8Wlq2cjj+Kj48E=
X-Received: by 2002:aca:230e:: with SMTP id e14mr3456950oie.127.1590599735713;
 Wed, 27 May 2020 10:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200527155610.156633-1-jlebon@redhat.com>
In-Reply-To: <20200527155610.156633-1-jlebon@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 May 2020 19:15:24 +0200
Message-ID: <CAFqZXNtf52p8OcyffJT30zf1ja3cVsTczSqeNoSm=j3=c0FXOA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 6:02 PM Jonathan Lebon <jlebon@redhat.com> wrote:
> This patch does for `getxattr` what 3e3e24b4204 did for `setxattr`; it
> allows querying the current SELinux label on disk before the policy is
> loaded.
>
> One of the motivations described in that commit message also drives this
> patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
> able to move the root filesystem for example, from xfs to ext4 on RAID,
> on first boot, at initrd time.[1]
>
> Because such an operation works at the filesystem level, we need to be
> able to read the SELinux labels first from the original root, and apply
> them to the files of the new root. Commit 3e3e24b4204 enabled the second
> part of this process; this patch enables the first part.
>
> [1] https://github.com/coreos/fedora-coreos-tracker/issues/94
>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
> ---
>  security/selinux/hooks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b7..67ee2cfc25b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3334,7 +3334,9 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>         char *context = NULL;
>         struct inode_security_struct *isec;
>
> -       if (strcmp(name, XATTR_SELINUX_SUFFIX))
> +       /* If we're not initialized yet, then we can't validate contexts,
> +        * so just let vfs_getxattr fall back to using the on-disk xattr. */
> +       if (strcmp(name, XATTR_SELINUX_SUFFIX) || !selinux_state.initialized)

Just two small notes:
1. We now have a helper for accessing selinux_state.initialized -
selinux_initialized() - to ensure proper memory access ordering.
Please use that instead of accessing it directly.
2. I'd suggest to make the new condition first in the || expression -
it is cheaper than strcmp() so it could save some cycles during early
boot.

Otherwise LGTM.

>                 return -EOPNOTSUPP;
>
>         /*
> --
> 2.25.4
>


--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

