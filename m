Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CADC3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655642469D
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZzGlhgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgB1Ner (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:34:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45813 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgB1Neq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 08:34:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so2515790otp.12
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nTCNv5VMw0pmNnCE5WDrQOIa2MhRe8isZgJwIZB0Tw=;
        b=MZzGlhgHVQyknk+ZsQKEqWZN2ianOe9NmoAFjf7qQMCO/ZOCJ2zS7ki6LNMePN1LNd
         gOEtmzET9XwmxNFlNNYkDCta9jbGJz54TMedMvbkUZRvP1iyAF358yLeazjR8OyzP08m
         lY+KUFa3KECIM0tjJA+jx+mRtb7JazwUrW0IN2BdhjDJykZCxYv5STinFacLx7zOsYTx
         av9HDw8yrYXqBPODFOxEw/hve8J61SVMrBr4RkfIJ6Ucx40bUfGKew6f1iacnt5QvchT
         a4ETp+CN3Jj802ormrWRkSmLVazmKhw7pNXqVkbajqs6URWiV5uSGIkliRR2ySq/7JSk
         vt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nTCNv5VMw0pmNnCE5WDrQOIa2MhRe8isZgJwIZB0Tw=;
        b=SMrOjp0ZTsqb+qNSu4GCd/Zq5b4kWVNV/NHU3pX426jBos5tVJfK6YAwVWwFe5EZYx
         iV08BGb1EkYAikb2i9KpKXf6TQ+RFv0SlqiYB8NLgCn5y1PZ/glempCfm7iED0mSC+6p
         nfe1y5pUh7fq/0i1UHV0+/YhgoKwpW/KF/3/yDhEoP1xsoh47WWatydk6nxDeFC4VKRL
         7zQvlaYXIQUskuFvQXI+8DD2Rjesc5CJhIdgyUgpf7GRj/BR0mFwaDmoDT9YJ8ZSTRkW
         D0cl+t3dcnAcYr628w0PT0PKwiH2ObMjomSzyJa6IkN8q5By0eiaUOJsfo7iK9kfGrMb
         8kaQ==
X-Gm-Message-State: APjAAAXYW8iqFfhYDKwdHmLMWQGk8PVkFiBUm28XzjdNKCpHaSjBkSAg
        otZKGE52tyTFgp+4/IsqRmc4NgF1pxMc0pJOSaE=
X-Google-Smtp-Source: APXvYqwSr02/kk3ovfRzBUgyirbGehAO9lBL8HUZXQLmR9AzE5V8kgWPIu3t9j9huw6zd4BVSh/0MJ7X2t0rewo1z+o=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr3387123otl.162.1582896886044;
 Fri, 28 Feb 2020 05:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20200227230129.31166-1-william.c.roberts@intel.com> <20200227230129.31166-4-william.c.roberts@intel.com>
In-Reply-To: <20200227230129.31166-4-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 08:36:02 -0500
Message-ID: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile: add linker script to minimize exports
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 6:01 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> Add a linker script that exports only what was previosly exported by
> libselinux.
>
> This was checked by generating an old export map (from master):
> nm --defined-only -g ./src/libselinux.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
>
> Then creating a new one for this library after this patch is applied:
> nm --defined-only -g ./src/libselinux.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
>
> And diffing them:
> diff old.map new.map
>
> Fixes: #179
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/src/Makefile       |   2 +-
>  libselinux/src/libselinux.map | 249 ++++++++++++++++++++++++++++++++++
>  2 files changed, 250 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/src/libselinux.map
>

> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> new file mode 100644
> index 000000000000..823abeee9a36
> --- /dev/null
> +++ b/libselinux/src/libselinux.map
> @@ -0,0 +1,249 @@
> +{
> +  global:

Our other map files (for libsepol and libsemanage) have a versioned
symbolic name before the {, ala
LIBSELINUX_1.0 {

> +    dir_xattr_list;

I doubt this was intentionally made public and certainly isn't
declared in the public headers.  Can we hide it?

> +    map_class;
> +    map_decision;
> +    map_perm;

Ditto for these three.

> +    myprintf_compat;

And again.

> +    unmap_class;
> +    unmap_perm;

Likewise.
