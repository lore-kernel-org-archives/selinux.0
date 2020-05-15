Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB4C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5329206D4
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 21:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GQsi7+zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEOVGx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEOVGx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 17:06:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D6C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:06:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o10so3365499ejn.10
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGvb0I1puwTEwUCX3TvMQGY6YjH5EaGSdcdasSKXqn0=;
        b=GQsi7+zff5rQ3iw5QyW/ZIVaxXX4EdZAv85rNaravKHJ8PP9GEKZwdJQI+YcZ2BCX/
         iEWaL+wguCOoGe7wD50ljZfiBmDF5hZ5DwgAxq/TYeA0deG0OWI6AFncw2HEfV1muq2N
         aSsSF2dJKQYMCLuMzNJ+mmm9C74EWk7irQyKEpUSFOl5RlWKg1VD72DnsxWvkiBkv+Uz
         aXl9Ds7XljCfBRDHR35DIb2TzltBnGXMIG0ROkPcZQ7W2AnYEnNlk5lCQtAJZFDjlsQa
         Nq6GTsnZjQsnx3+iDdVcRAAPcWCVnSvCi+a+PQcNgn2X/ScPUc/2GY8apVjDWUBuBBWS
         ubyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGvb0I1puwTEwUCX3TvMQGY6YjH5EaGSdcdasSKXqn0=;
        b=Bak6DgkM5tcDXmblWg7su0jJotKnx1NhTjo0wusKpC28/vQ4HS+uekIG0NGR9Jomyv
         aBrNDy9quhCE5Di4bHsW3Ck5RpOH120jaryVipc7VF7T+GVIB1ZxT++z71hh4QuhguTf
         mf9B4JkuZ5BiYddRRnjE8XENW/HNAwSkR7O8cLMV7ahfMeRlsEwzwneip6wLASutfJPp
         Y7SpQEIhm9yMHdwAiau2T/+4JE3gp2qscEGVwxEj1es1kKkOhWXJT/gcxqxmCOAZv7OZ
         13EiTgDL1iPLJuqLPhGxhTlCa2cCG+DUjU6RSrkc6MG9/nYPwGgLzyGQZaXo+UovIFRu
         eprA==
X-Gm-Message-State: AOAM533pUpwpxlmLhsBY2oWhmM12e++Mhg5+6iqpSfKzIG3KumaglsjE
        wPQaySRFm/tUPGT6PyTSkKhoR28kaRc8NQHzth4Z
X-Google-Smtp-Source: ABdhPJxRe0yw4ChIiMM6bAAZsAskA0JPaZaV5ewvqtIQGafDV8zei47GQ7iX+AcMRqXzwLPEb030wQ6SwXZTECso5HM=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr4541753ejf.308.1589576810297;
 Fri, 15 May 2020 14:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com> <20200515210154.23408-1-william.c.roberts@intel.com>
In-Reply-To: <20200515210154.23408-1-william.c.roberts@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 May 2020 17:06:38 -0400
Message-ID: <CAHC9VhSmRjeeujGCxscNuRg_805ObqAM26qyg6SAzNjUxLOxNw@mail.gmail.com>
Subject: Re: [PATCH v2] README: update kernel-devel package in dnf command
To:     william.c.roberts@intel.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 5:02 PM <william.c.roberts@intel.com> wrote:
>
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
> index 1f7e5d92a100..4d5d6d22203a 100644
> --- a/README.md
> +++ b/README.md
> @@ -74,7 +74,7 @@ following command:
>                 attr \
>                 libbpf-devel \
>                 keyutils-libs-devel \
> -               kernel-devel \
> +               kernel-devel-$(uname -r)

I \
think \
you \
forgot \
the \
trailing \
slash \

>                 quota \
>                 xfsprogs-devel \
>                 libuuid-devel
> --
> 2.17.1

-- 
paul moore
www.paul-moore.com
