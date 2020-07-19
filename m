Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C84C433DF
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F765208B3
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 17:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGSRPw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:15:52 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:60397 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRPw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 13:15:52 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9351656128D
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 19:15:48 +0200 (CEST)
Received: by mail-oo1-f43.google.com with SMTP id p26so2748465oos.7
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 10:15:48 -0700 (PDT)
X-Gm-Message-State: AOAM531sbvh/LUpyGjRfWzNM2+nkTpHg7EWzStSH2aZZI8KE3oXiHcvC
        mUKkC6X1ISVefYSUM90/ZFdOBx6H7rO76a/IhMY=
X-Google-Smtp-Source: ABdhPJwsQQWh7ZR2YHR7a2pMcaqH1ScFPsnO203eSVsYi7o5S9yBlFJiQEnRMuLMruPMwCKEI6qkc++DhKiCLD8aV4k=
X-Received: by 2002:a4a:ea83:: with SMTP id r3mr16446960ooh.22.1595178947544;
 Sun, 19 Jul 2020 10:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <8ebd6f4ab80e8b73ce3b4ff4e146c39b2123cec3.camel@flyn.org>
In-Reply-To: <8ebd6f4ab80e8b73ce3b4ff4e146c39b2123cec3.camel@flyn.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 19 Jul 2020 19:15:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kQwdwmG0t3=iS4L77vQOYRfTUHcTTR8g1awpkZzy3uFA@mail.gmail.com>
Message-ID: <CAJfZ7=kQwdwmG0t3=iS4L77vQOYRfTUHcTTR8g1awpkZzy3uFA@mail.gmail.com>
Subject: Re: [PATCH] selinux: make use of variables when defining libdir and includedir
To:     "W. Michael Petullo" <mike@flyn.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 19 19:15:49 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 16, 2020 at 10:39 PM W. Michael Petullo <mike@flyn.org> wrote:
>
> Pkg-config definitions commonly make use of ${exec_prefix} and
> ${prefix} when defining libdir and includedir, respectively. OpenWrt,
> for example, relies on this when it adjusts things for cross
> compiling.
>
> Signed-off-by: W. Michael Petullo <mike@flyn.org>
> ---
>  libselinux/src/libselinux.pc.in | 4 ++--
>  libsepol/src/libsepol.pc.in     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/libselinux.pc.in
> b/libselinux/src/libselinux.pc.in
> index 7c66b1fa..d9d58125 100644
> --- a/libselinux/src/libselinux.pc.in
> +++ b/libselinux/src/libselinux.pc.in
> @@ -1,7 +1,7 @@
>  prefix=@prefix@
>  exec_prefix=${prefix}
> -libdir=@libdir@
> -includedir=@includedir@
> +libdir=${exec_prefix}/lib
> +includedir=${prefix}/include
>
>  Name: libselinux
>  Description: SELinux utility library
> diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
> index f807fec6..cf2411e4 100644
> --- a/libsepol/src/libsepol.pc.in
> +++ b/libsepol/src/libsepol.pc.in
> @@ -1,7 +1,7 @@
>  prefix=@prefix@
>  exec_prefix=${prefix}
> -libdir=@libdir@
> -includedir=@includedir@
> +libdir=${exec_prefix}/lib
> +includedir=${prefix}/include
>
>  Name: libsepol
>  Description: SELinux policy library
> --
> 2.26.2

Hello,
I am wondering whether this could break some distributions that use
another path for their lib directory. For example on Fedora 31,
/usr/lib64/pkgconfig/libselinux.pc contains:

prefix=/usr
exec_prefix=${prefix}
libdir=/usr/lib64
includedir=/usr/include

Looking at other libraries, here is what I see for example for libpcre2-posix:

* In Debian 10, /usr/lib/x86_64-linux-gnu/pkgconfig/libpcre2-posix.pc
contains libdir=${prefix}/lib/x86_64-linux-gnu
* In Arch Linux, /usr/lib/pkgconfig/libpcre2-posix.pc contains
libdir=${exec_prefix}/lib (and exec_prefix=${prefix})
* In Fedora 31, /usr/lib64/pkgconfig/libpcre2-posix.pc contains
libdir=/usr/lib64
* Upstream, https://vcs.pcre.org/pcre2/code/tags/pcre2-10.35/libpcre2-posix.pc.in?view=markup
contains libdir=@libdir@ and @libdir@ is replaced using
AC_CONFIG_FILES(libpcre2-posix.pc) in configure.ac.

libsepol and libselinux use Makefile variables instead of autoconf, to
generate the .pc files from the .pc.in files. I can work on a way to
make the file contain ${exec_prefix}/lib when LIBDIR is $(PREFIX)/lib
in Makefile, but before doing so I would like to have more information
about your use-case. Do you encounter issues while building libsepol
and libselinux themselves, or when linking other projects using
"$(pkgconf --libs libselinux)"? Could you share a simple example that
reproduces your issue?

About the includedir part, this is quite different as it seems all
distributions agree on the location of header files. It makes sense to
drop the INCLUDEDIR variable from the Makefile and use
includedir=${prefix}/include, as your patch does.

Thanks,
Nicolas

