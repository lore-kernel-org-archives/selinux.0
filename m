Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10EC77B78
	for <selinux@archiver.kernel.org>; Wed, 26 Apr 2023 15:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbjDZPCC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjDZPCB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Apr 2023 11:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0876BE
        for <selinux@vger.kernel.org>; Wed, 26 Apr 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682521275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDAVY+qHDUeK8XaODziQiX3dlHYEGJl2mvqD42jL3hE=;
        b=aKIZQhzhkIs7qi6g2Wy0byJlhdZPEPj3LFoafwSUtt36cHPb5aTRSOsmscXAJiA0omk4Zt
        2nhYMrI9KnoaHkBDpI90HLXEnEKdQHFCuHIuchd0b0t1J8j+UJLGObHao67gDfvKcNTnWc
        aY6ZVN2l/cs3r/TBuROaNJ+4AAE6xiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-ROKAjGxsNDidzQV7c4sK2Q-1; Wed, 26 Apr 2023 11:01:11 -0400
X-MC-Unique: ROKAjGxsNDidzQV7c4sK2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F42C87B2A5;
        Wed, 26 Apr 2023 15:01:09 +0000 (UTC)
Received: from localhost (unknown [10.45.225.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296EF1121315;
        Wed, 26 Apr 2023 15:01:09 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: set CFLAGS for pip installation
In-Reply-To: <20230420162700.41974-1-cgzones@googlemail.com>
References: <20230420162700.41974-1-cgzones@googlemail.com>
Date:   Wed, 26 Apr 2023 17:01:08 +0200
Message-ID: <87h6t2n0wb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Explicitly set CFLAGS for the pip install command, similar to calling
> setup.py, to ignore known compiler warnings treated as errors, e.g.:
>
>     selinuxswig_python_wrap.c:3593:19: error: 'sidget' is deprecated [-We=
rror,-Wdeprecated-declarations]
>                 result =3D (int)sidget(arg1);
>                               ^
>     selinuxswig_python_wrap.c:15024:1: error: no previous prototype for f=
unction 'PyInit__selinux' [-Werror,-Wmissing-prototypes]
>             SWIG_init(void) {
>             ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


It looks like a problem in build system - selinuxswig_python_wrap.o is
built twice, first time by

pywrap: all selinuxswig_python_exception.i
	CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext


clang -fdeclspec -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O3 =
-Wall -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -Wmi=
ssing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-deref=
erence -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrit=
e-strings -fno-common -I/tmp/destdir/usr/include -I../include -D_GNU_SOURCE=
 -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8 -Wno-error -W=
no-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-=
shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations=
 -Wno-deprecated-declarations -fPIC -I../include -I/opt/hostedtoolcache/Pyt=
hon/3.9.16/x64/include/python3.9 -c selinuxswig_python_wrap.c -o build/temp=
.linux-x86_64-3.9/selinuxswig_python_wrap.o


and second time by

install-pywrap: pywrap
	$(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && ech=
o --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .

clang -fdeclspec -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O3 =
-Wall -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -Wmi=
ssing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-deref=
erence -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrit=
e-strings -fno-common -I/tmp/destdir/usr/include -I../include -D_GNU_SOURCE=
 -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8 -fPIC -I../in=
clude -I/opt/hostedtoolcache/Python/3.9.16/x64/include/python3.9 -c selinux=
swig_python_wrap.c -o build/temp.linux-x86_64-cpython-39/selinuxswig_python=
_wrap.o


I'd expect that it's built only in pywrap target and install-pywrap
would just install it.

There's a difference in the output dir - build/temp.linux-x86_64-3.9 vs bui=
ld/temp.linux-x86_64-cpython-39




> ---
> fixes GitHub CI, see https://github.com/SELinuxProject/selinux/pull/388
> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 36d57122..f9a1e5f5 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -187,7 +187,7 @@ install: all
>  	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(=
TARGET)
>=20=20
>  install-pywrap: pywrap
> -	$(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && =
echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> +	CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=
=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-insta=
lled --no-deps` $(PYTHON_SETUP_ARGS) .
>  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.=
py
>  	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $=
(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>=20=20
> --=20
> 2.40.0

