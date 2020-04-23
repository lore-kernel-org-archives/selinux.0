Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4AFC55186
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3C620728
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rm1VDUYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgDWNsf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728576AbgDWNsf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 09:48:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB94FC08E934
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2020 06:48:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id re23so4748767ejb.4
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2020 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGxU80BpkPNTBJAGmis2cFVGswfYlw6284N083oVeIQ=;
        b=rm1VDUYM7kLJv2Mfg/j4aKs5oeZR1/vEwoSEaEzZgawn4d1WbQB9iI9Pd8D2tYEAae
         F7gNXDQ50rdRbUZxJwmFSCSf2bA/KU7BFQAkekXQOHWkarfn8h7hcVJQ+JXyqOMqKU9g
         GLGiiBGNTuGoeZ4W0qD76iUhKo8+LmE4xQ5czVBA6A+CLLyNYPmHu0Ck69JWIkH3N7e3
         FVfBhi1R/4ORH401wokIWK6sVGt4OcDT0nOZPWzK5VktBEI5KiZBfBL3ceKDxhVOEqVb
         GFZiEoKXAuKQPH3l4uiHQ7jK2smdWFm5s0/6yiAK5GcA/kaoUbLOb0DV8pY8suyeTerj
         02Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGxU80BpkPNTBJAGmis2cFVGswfYlw6284N083oVeIQ=;
        b=lIJuvwPYAsbpmkofPm1qD3M7gKR+JEhQ2ULKhnH1KYOhVDvUXyIE9+Lz9a2teGs8Dp
         n1KcARmeU4tDVWA+FeSqdpCtJoMHOVrJSgMHAdZy9p37vjLMu7Y36BGxo0qQb3W7EGnT
         RW7M2/thewkfl9mFH+U755a7AlA2w2PTFaPTYKay4ECuV0WM+Up+Wrh/3mULJPlfDQar
         hm3IRmb2bWUVU/ly3boIFOjUV0fQger8DGA1B74+c0XdylRvYPuuL40A0bZgeFomFRH4
         NT/23yDbk/EMcZuRDlUSIvUv3z3R2ewlnK2IGM9GK9XnqfMQ7Pqztboq7QumquGaZT0+
         YN9Q==
X-Gm-Message-State: AGi0PuZqpLL6CjAkAWuHB3etgVGmzMua9PVF5d53RudicDodOgmYMner
        mTn9K9Xa5Sb83Zxd/UCUS9YwHKTr706jJqChOHZ1
X-Google-Smtp-Source: APiQypLiibbpV4KLHK2Y3a4u/5sR1vJBnanjzDotJ/SrhG9OtlaMHvDv/Iip5TFgWJjZfvxbGhMvha4gbh8S8bORtPE=
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr2869465ejb.272.1587649712394;
 Thu, 23 Apr 2020 06:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200423132833.211294-1-plautrba@redhat.com>
In-Reply-To: <20200423132833.211294-1-plautrba@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Apr 2020 09:48:21 -0400
Message-ID: <CAHC9VhRe25+PkmjaM8GcFZzFgDM5F3S65rfR5LuCBkangOtjGw@mail.gmail.com>
Subject: Re: [PATCH] Convert README to README.md
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 23, 2020 at 9:29 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> It should make the document readable for github users.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/225
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  README    | 25 -------------------------
>  README.md | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
>  delete mode 100644 README
>  create mode 100644 README.md

...

> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,41 @@
> +SELinux Userspace
> +=================
> +
> +Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> +
> +Subscribe by sending "subscribe selinux" in the body of an email
> +to <majordomo@vger.kernel.org>.
> +
> +Installation
> +------------
> +
> +Build dependencies on Fedora:
> +
> +       yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config

Other than the different amount of white space on the line above
compared to the other command examples, it looks good to me - thanks
Petr.

> +
> +
> +To build and install everything under a private directory, run:
> +
> +    make DESTDIR=~/obj install install-pywrap
> +
> +To install as the default system libraries and binaries
> +(overwriting any previously installed ones - dangerous!),
> +on x86_64, run:
> +
> +    make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> +
> +or on x86 (32-bit), run:
> +
> +    make install install-pywrap relabel
> +
> +This may render your system unusable if the upstream SELinux userspace
> +lacks library functions or other dependencies relied upon by your
> +distribution.  If it breaks, you get to keep both pieces.
> +
> +To install libsepol on macOS (mainly for policy analysis):
> +
> +    cd libsepol; make PREFIX=/usr/local install
> +
> +This requires GNU coreutils:
> +
> +    brew install coreutils
> --
> 2.26.0
>


-- 
paul moore
www.paul-moore.com
