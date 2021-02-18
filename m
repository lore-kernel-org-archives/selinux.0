Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE40C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD28C64EAD
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBRN7p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 08:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232048AbhBRLkb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 06:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613648341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8/f1KzD2KLpwCYV4QD0cj33joMCIH88vsXo7b+nZQE=;
        b=hdJ+ZeADp2r5XwkEA1tzZdYkw+vh0zBJqtuYXW3y00njZXHc/CFLA7HbAJCFr8Ixe4S/Ol
        ajKFuAEEOBxQXnHv9HcW0UWO6RG6NIrngNvQZRExx8w1XQuWiMfgTfex9hxRnqiz0fl1GW
        G9SbRvTraM7SPi+I1mBM4hyLb+Psxho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-QLevsGNzNVm16jWNb_aEmQ-1; Thu, 18 Feb 2021 06:27:00 -0500
X-MC-Unique: QLevsGNzNVm16jWNb_aEmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F03FB801996;
        Thu, 18 Feb 2021 11:26:58 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3551007617;
        Thu, 18 Feb 2021 11:26:57 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: rename gettid() to something which never
 conflicts with the libc
In-Reply-To: <20210216211328.3609-1-nicolas.iooss@m4x.org>
References: <20210216211328.3609-1-nicolas.iooss@m4x.org>
Date:   Thu, 18 Feb 2021 12:26:57 +0100
Message-ID: <87pn0xfwfy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> Musl recently added a wrapper for gettid() syscall. There is no way to
> detect this new version in a reliable way, so rename our gettid()
> wrapper to a non-conflicting name.
>
> Introduce a new function which, when using a libc known to provide a
> wrapper for gettid(), calls it, and which, otherwise, performs the
> syscall directly.
>
> Anyway this function is only used on systems where /proc/thread-self
> does not exist, which are therefore running Linux<3.17.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/282
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Tested on Fedora with musl-1.2.22 scratch build
https://koji.fedoraproject.org/koji/taskinfo?taskID=3D62214131 :

Before
^&^ musl-gcc -D_GNU_SOURCE -I../include procattr.c -c
procattr.c:38:14: error: static declaration of =E2=80=98gettid=E2=80=99 fol=
lows non-static declaration
   38 | static pid_t gettid(void)
      |              ^~~~~~
In file included from procattr.c:2:
/usr/x86_64-linux-musl/include/unistd.h:194:7: note: previous declaration o=
f =E2=80=98gettid=E2=80=99 with type =E2=80=98pid_t(void)=E2=80=99 {aka =E2=
=80=98int(void)=E2=80=99}
  194 | pid_t gettid(void);
      |       ^~~~~~


After
^&^ musl-gcc -D_GNU_SOURCE -I../include procattr.c -c


Seems to work. Thanks!

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 1aa67ac53f39..840570525f5f 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -25,21 +25,23 @@ static __thread char destructor_initialized;
>  /* Bionic and glibc >=3D 2.30 declare gettid() system call wrapper in un=
istd.h and
>   * has a definition for it */
>  #ifdef __BIONIC__
> -  #define OVERRIDE_GETTID 0
> +  #define HAVE_GETTID 1
>  #elif !defined(__GLIBC_PREREQ)
> -  #define OVERRIDE_GETTID 1
> +  #define HAVE_GETTID 0
>  #elif !__GLIBC_PREREQ(2,30)
> -  #define OVERRIDE_GETTID 1
> +  #define HAVE_GETTID 0
>  #else
> -  #define OVERRIDE_GETTID 0
> +  #define HAVE_GETTID 1
>  #endif
>=20=20
> -#if OVERRIDE_GETTID
> -static pid_t gettid(void)
> +static pid_t selinux_gettid(void)
>  {
> +#if HAVE_GETTID
> +	return gettid();
> +#else
>  	return syscall(__NR_gettid);
> -}
>  #endif
> +}
>=20=20
>  static void procattr_thread_destructor(void __attribute__((unused)) *unu=
sed)
>  {
> @@ -94,7 +96,7 @@ static int openattr(pid_t pid, const char *attr, int fl=
ags)
>  		if (fd >=3D 0 || errno !=3D ENOENT)
>  			goto out;
>  		free(path);
> -		tid =3D gettid();
> +		tid =3D selinux_gettid();
>  		rc =3D asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
>  	} else {
>  		errno =3D EINVAL;
> --=20
> 2.30.0

