Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A755C433DF
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309882070A
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp5HXM2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETJT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 05:19:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbgETJT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 05:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589966396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fM+ILU3P4ZAFjH+KtBRljT6DXWi/L7XjbXOGjjWAzEQ=;
        b=Lp5HXM2x0RQkqfBE7Ox5Ljw8Z0nfLi0vqs2nFF7CRjd/HRBeTR+5fBhLv37DkKOsSZBvqF
        f1m6S5XWLHC59h/1hjvl2n0flhtPgFXWeEsV3bdic0cGuBz8JT4KHP4yQ+YKiFpkxopVbI
        /HSD9u/utrNL2W8cvcn9APWSSJWWE10=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-SpmLKYj9NqyGq0FZ8YCNCQ-1; Wed, 20 May 2020 05:19:54 -0400
X-MC-Unique: SpmLKYj9NqyGq0FZ8YCNCQ-1
Received: by mail-oi1-f197.google.com with SMTP id j19so1133734oie.18
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 02:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fM+ILU3P4ZAFjH+KtBRljT6DXWi/L7XjbXOGjjWAzEQ=;
        b=IZLCbvnyLFf1RQ3gWl6qD9b5Vdtl3+CgiMrJ8ETDsKwIH0wnW16XC8QaA+2ZmiwhyT
         DAr3juARSJpW9CnqX3t3c6ckr7SWlGhNb7NWvaMcmik0XG/8LdZU7kIEyGpe0Yq3MLd1
         vmB6HheK5tRpH68ASrQRc+a5fB0vcWK/3sFcC9t6DS//a+cO0iGq1+poib9HURpfDDIQ
         yl+p+0jgwvO6wRXjs4h0VKLoT6AZAgNLF4voNHWGNPtElezVckaMeyOP6dMcvbHpb2NU
         1PWpccGRVbnjRVNUoHzGl3uthaquP3yfGb0R/O+OX8x2537GKBo7MbyNUe9rg7mF3j9U
         lUaA==
X-Gm-Message-State: AOAM532hmEZslMjAiqj+/7ArEkXvi5dKzA9+vzjq3pUKUCXWKXIAfe3w
        F07bFeLLxLRlhpliQGUoDJA3EW1KeAc0wnrpUfDtcgXI6OMYX4KXQ8sYcBghSfb7c5fcT7zFxfI
        mn91uxxxeEAgikhtLfaqi+sERpRx0dhuYDw==
X-Received: by 2002:aca:488c:: with SMTP id v134mr2594115oia.103.1589966393590;
        Wed, 20 May 2020 02:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbcqM7c6DRKCaffGqm8XKxXVHXLsrXF2393eEd25ntqP3rgf2QKJj/KjAkGsQJLLgixYfLxVZuhLFrX3S59vQ=
X-Received: by 2002:aca:488c:: with SMTP id v134mr2594107oia.103.1589966393376;
 Wed, 20 May 2020 02:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com> <20200515212132.24204-1-william.c.roberts@intel.com>
In-Reply-To: <20200515212132.24204-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 May 2020 11:19:42 +0200
Message-ID: <CAFqZXNsWE6DDZ-jvzTTm-f+4YL5hMhqQBPktxS+UpZvs9OcCAQ@mail.gmail.com>
Subject: Re: [PATCH v3] README: update kernel-devel package in dnf command
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 11:22 PM <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> The README.md file in the selinux-testsuite states that kernel-devel
> package is needed. However, for everything to work you need the
> kernel-devel package specific to your kernel version.
> Update the dnf command to include uname -r, so that a copy + paste
> of the dnf command, results in a system with dependencies filled
> for recent Fedora distro's like Fedora 32.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 1f7e5d92a100..1bec9fe85c91 100644
> --- a/README.md
> +++ b/README.md
> @@ -74,7 +74,7 @@ following command:
>                 attr \
>                 libbpf-devel \
>                 keyutils-libs-devel \
> -               kernel-devel \
> +               kernel-devel-$(uname -r) \
>                 quota \
>                 xfsprogs-devel \
>                 libuuid-devel
> --
> 2.17.1
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

