Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36FBC54FD0
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA2D2076C
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wYqh2O4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgDWT3h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWT3h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 15:29:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAC1C09B042
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2020 12:29:35 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p16so5255880edm.10
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2020 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6vE4ioHzV7Y6Ky9DoM9ZdYgxjuY4aYBckOCV1pX7+I=;
        b=wYqh2O4hTLhQisqSjtahnlByC1SvPvchYQ595OOqCRaFLn0UAmSGy4wu/glpksSt0s
         HqsA1B4Qe6YfHU9bcBnk5GogwA9LcoWEkLtAFQz521Bo8/wuXZ3i8w4llmE0fkZE1HZv
         L5d91JYohRZ9+jHaBe0OhcvPcnK6NJf6siUVM4s0ubfs9yCq9CbYyMn3pNRLySVJLI1N
         mWJCRUFiS67sAEVrYC9tnD+pjV/ufcLlRkIrtabbkDKlIkZ2AgBvQMbeL0lMasDhpwyi
         xn+AHMaAtJlokDHii1DgSPk0psqKH3NUzjassKdkHTn/YWu3N3tgi8nj6oRBx/M0aFBa
         XfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6vE4ioHzV7Y6Ky9DoM9ZdYgxjuY4aYBckOCV1pX7+I=;
        b=tSF+46E4E8OjEv5k1gd5+d3cOcFObyQcaJob6mJwywaPqD9wBFOAXdmfjOaJzDDRLL
         fb5s6/i+HqKlJVywP90ZMSXHXFBk9WUH3VQtzJbC1pZGS5/JYk7cY1ZeLNKoXU0XIOwx
         5N5Wjm1dIoNLnGehzxAZ/oPCyq8+EhSxs2MWClHNRQNQvodcm1TLF1TRTA4VjrD8wIGl
         Oz89t6F4eAxY02aP4/H6Q2xxVZEN8loE7zQVC6RpjtRN24vdjdbTx5LD00d6AtShRoY4
         sApqNngcUyanTX/LMFpQQ5bkUNusKO5/p24lolNgfT6Ar7AEnp36aTlCn3RrGaH2wkfA
         3MAQ==
X-Gm-Message-State: AGi0PuaA2ENCOQadZyiQbeL+UT+G72kpeqA0Yub7z2ow0cRMxLObLgxv
        baB0joynY2l9u8BvVEi8srdeusPLoFYsxJP+qG6o
X-Google-Smtp-Source: APiQypLAZcjylY8ITxJfwZ5VOXpu01EJ4FjaFa33R42Ykh92z9ta1V0FEZ8OcnpHl2m2yx4qkFe9bhE3BtjEgYSRgK4=
X-Received: by 2002:aa7:c401:: with SMTP id j1mr4035506edq.31.1587670173876;
 Thu, 23 Apr 2020 12:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRe25+PkmjaM8GcFZzFgDM5F3S65rfR5LuCBkangOtjGw@mail.gmail.com>
 <20200423185449.223595-1-plautrba@redhat.com>
In-Reply-To: <20200423185449.223595-1-plautrba@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Apr 2020 15:29:22 -0400
Message-ID: <CAHC9VhQdgvihTJPLPAzZ7O0QPTtLehdGn18vs19+mOGTG_ev3g@mail.gmail.com>
Subject: Re: [PATCH v2] Convert README to README.md
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 23, 2020 at 2:55 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> It should make the document readable for github users.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/225
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> - Fixed indentation in yum command
>
>  README    | 25 -------------------------
>  README.md | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
>  delete mode 100644 README
>  create mode 100644 README.md

Thanks Petr.  For whatever it's worth, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/README b/README
> deleted file mode 100644
> index e4423ca23b58..000000000000
> --- a/README
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Please submit all bug reports and patches to selinux@vger.kernel.org.
> -Subscribe by sending "subscribe selinux" in the body of an email
> -to majordomo@vger.kernel.org.
> -
> -Build dependencies on Fedora:
> -yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
> -
> -To build and install everything under a private directory, run:
> -make DESTDIR=~/obj install install-pywrap
> -
> -To install as the default system libraries and binaries
> -(overwriting any previously installed ones - dangerous!),
> -on x86_64, run:
> -make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> -or on x86 (32-bit), run:
> -make install install-pywrap relabel
> -
> -This may render your system unusable if the upstream SELinux userspace
> -lacks library functions or other dependencies relied upon by your
> -distribution.  If it breaks, you get to keep both pieces.
> -
> -To install libsepol on macOS (mainly for policy analysis):
> -cd libsepol; make PREFIX=/usr/local install
> -
> -This requires GNU coreutils (brew install coreutils).
> diff --git a/README.md b/README.md
> new file mode 100644
> index 000000000000..974280f9d14f
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
> +    yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
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
