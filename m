Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262E6C433EF
	for <selinux@archiver.kernel.org>; Thu, 17 Feb 2022 14:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiBQOBb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Feb 2022 09:01:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbiBQOBY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Feb 2022 09:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C04D2B0B05
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645106468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oS5lTlySzHKOm7gXSjwQBX8iWtIs04U4QG1DJTChIAE=;
        b=Q0wO/PgZ3i8SIDSe5j7QM5XHxMyetHOQe06fgvHcf0vv3gJOr8LBGa5y9veXPi9NArkM5/
        HoWzdSqs2YSmxVut+OXPNlsNzz5YDa7zU107HYZekfhzx6ZOE4Xk6tVxgLV2z6BupKGBel
        tCpT8gsf35FTl4BlB7YLcBpcqIGg1LQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-liDeAP3LOx64csg7hL1kNw-1; Thu, 17 Feb 2022 09:01:06 -0500
X-MC-Unique: liDeAP3LOx64csg7hL1kNw-1
Received: by mail-ua1-f71.google.com with SMTP id n1-20020ab07481000000b0033bd83da484so2119508uap.20
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 06:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS5lTlySzHKOm7gXSjwQBX8iWtIs04U4QG1DJTChIAE=;
        b=GWzrrsAw3S6Vbb0HqoPyCVLHX50Xj486cCmBKzGH8sqmXxtS8TWTBj5W5XV1XWsUnA
         /DUkxVtApwhGYdty1LgJ9B+fKZbn0ImrhWpYxcPmUIwivF8IAxJT9jpLGLDP6C0f2bks
         riH7+Srq9nvK86B112Qi5dav9j/3PFWReA+XbjUWEKph0I5lfbMPT876zs8ix5FaSUa7
         sdR2LFbkCrAoH+Q/wQJNE/e6PkeU6e5xC/LvSoerpyA7mMwVR2zXDG8RzUFSHBXq5hCS
         4El+Iq28P4v0USk/snN9SS7DVi7/jkETHk+nPsvo701DZwmfVer30+uh7q5/L4MJPcYj
         xkDw==
X-Gm-Message-State: AOAM530zpPeeVT8aJALNeM+eMVHCgLlEOeQPH982Nc4tLg/n4ZLQf4XY
        RgKqgfo3UTpm8iF2lTTRJAVTLE/FMzC3hEpFMfo94RKcP4X3+u5hxWBlhJ/gAfxdnkJ/CrJ6idY
        gCCI1RSNlGIiKU0BNklS6v/hdYCb44jQsHg==
X-Received: by 2002:ab0:35da:0:b0:33c:8950:436 with SMTP id x26-20020ab035da000000b0033c89500436mr976819uat.131.1645106465559;
        Thu, 17 Feb 2022 06:01:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtLb90+3B1dIYmDBOQzwq48PApWkcXrScDaondjorqJKm53GODaJnDdxA3A4vxPc5/gGJjQKGXIO6HivmSvC0=
X-Received: by 2002:a0d:f105:0:b0:2d1:1f59:80fc with SMTP id
 a5-20020a0df105000000b002d11f5980fcmr2600164ywf.77.1645106416296; Thu, 17 Feb
 2022 06:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20220216174909.333355-1-plautrba@redhat.com>
In-Reply-To: <20220216174909.333355-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 17 Feb 2022 15:00:05 +0100
Message-ID: <CAFqZXNtBmoVppmhgrxfzuZrQ+oksWeSHH_x7ZgG4Wa6VO05Dsw@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/fixfiles: Use parallel relabeling
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 16, 2022 at 6:49 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> Commit 93902fc8340f ("setfiles/restorecon: support parallel relabeling")
> implemented support for parallel relabeling in setfiles. This is
> available for fixfiles now.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  policycoreutils/scripts/fixfiles   | 33 +++++++++++++++++-------------
>  policycoreutils/scripts/fixfiles.8 | 17 +++++++++------
>  2 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 6fb12e0451a9..33db1d3bfb61 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
[...]
> @@ -330,7 +331,8 @@ case "$1" in
>         > /.autorelabel || exit $?
>         [ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
>         [ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
> -       [ -z "$BIND_MOUNT_FILESYSTEMS" ] || echo "-M" >> /.autorelabel
> +       [ -z "$BIND_MOUNT_FILESYSTEMS" ] || echo "-M " >> /.autorelabel

I believe you need -n here? Although the line above also doesn't have
it... I guess the contents get the whitespace squashed in the end
anyway? Still, would be nice to clean up all these lines to use a
consistent pattern. I'd prefer:

echo -n "$SOMETHING "
(or in case of the variable containing an argument:)
echo -n "-X $XXX "

> +       [ -z "$THREADS" ] || echo -n "$THREADS " >> /.autorelabel
>         # Force full relabel if SELinux is not enabled
>         selinuxenabled || echo -F > /.autorelabel
>         echo "System will relabel on next boot"
[...]

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

