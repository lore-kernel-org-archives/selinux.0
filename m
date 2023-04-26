Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4EC77B78
	for <selinux@archiver.kernel.org>; Wed, 26 Apr 2023 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjDZPyy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbjDZPyu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Apr 2023 11:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777C65BC
        for <selinux@vger.kernel.org>; Wed, 26 Apr 2023 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682524441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOwcjKUlSIrPQM3pkwc5J9Nr9D+zkUMTCHjfBo47nCk=;
        b=HgcDeoljbl4TdVie/biRHumlNtb+IO2WL8nrKQOm6+nMB5pVzcA9404RI/aC2zWPs6zMZ8
        EH+qm9XjvVgh5Z0yI5jch7GqDQRQ2KtwbGPkFWN7hd/v0KrF7o3OTdfNffgeyHZzpS/HCM
        j8Gd0gg5+uubZ2TKUMRkULS7htXQzUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-KEIS7aotP9aQAz82r11Ddg-1; Wed, 26 Apr 2023 11:53:59 -0400
X-MC-Unique: KEIS7aotP9aQAz82r11Ddg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3FEC1C0950B;
        Wed, 26 Apr 2023 15:53:58 +0000 (UTC)
Received: from localhost (unknown [10.45.225.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B39E41121314;
        Wed, 26 Apr 2023 15:53:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: set CFLAGS for pip installation
In-Reply-To: <87h6t2n0wb.fsf@redhat.com>
References: <20230420162700.41974-1-cgzones@googlemail.com>
 <87h6t2n0wb.fsf@redhat.com>
Date:   Wed, 26 Apr 2023 17:53:58 +0200
Message-ID: <87edo6myg9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> Explicitly set CFLAGS for the pip install command, similar to calling
>> setup.py, to ignore known compiler warnings treated as errors, e.g.:
>>
>>     selinuxswig_python_wrap.c:3593:19: error: 'sidget' is deprecated [-W=
error,-Wdeprecated-declarations]
>>                 result =3D (int)sidget(arg1);
>>                               ^
>>     selinuxswig_python_wrap.c:15024:1: error: no previous prototype for =
function 'PyInit__selinux' [-Werror,-Wmissing-prototypes]
>>             SWIG_init(void) {
>>             ^
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
>
> It looks like a problem in build system - selinuxswig_python_wrap.o is
> built twice, first time by
>
> pywrap: all selinuxswig_python_exception.i
> 	CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
>
>
> clang -fdeclspec -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O=
3 -Wall -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -W=
missing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-der=
eference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwr=
ite-strings -fno-common -I/tmp/destdir/usr/include -I../include -D_GNU_SOUR=
CE -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8 -Wno-error =
-Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter -Wn=
o-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declaratio=
ns -Wno-deprecated-declarations -fPIC -I../include -I/opt/hostedtoolcache/P=
ython/3.9.16/x64/include/python3.9 -c selinuxswig_python_wrap.c -o build/te=
mp.linux-x86_64-3.9/selinuxswig_python_wrap.o
>
>
> and second time by
>
> install-pywrap: pywrap
> 	$(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && e=
cho --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>
> clang -fdeclspec -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O=
3 -Wall -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -W=
missing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-der=
eference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwr=
ite-strings -fno-common -I/tmp/destdir/usr/include -I../include -D_GNU_SOUR=
CE -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8 -fPIC -I../=
include -I/opt/hostedtoolcache/Python/3.9.16/x64/include/python3.9 -c selin=
uxswig_python_wrap.c -o build/temp.linux-x86_64-cpython-39/selinuxswig_pyth=
on_wrap.o
>
>
> I'd expect that it's built only in pywrap target and install-pywrap
> would just install it.

So according to the internet, pip install does all setup.py operations
[build_ext, build, install, ...] on it's own and therefore pywrap target
with `setup.py build` seems to be useless.

But your change is necessary.

Acked-by: Petr Lautrbach <lautrbach@redhat.com>




>
>
>> ---
>> fixes GitHub CI, see https://github.com/SELinuxProject/selinux/pull/388
>> ---
>>  libselinux/src/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index 36d57122..f9a1e5f5 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile
>> @@ -187,7 +187,7 @@ install: all
>>  	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$=
(TARGET)
>>=20=20
>>  install-pywrap: pywrap
>> -	$(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" &&=
 echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>> +	CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=
=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-insta=
lled --no-deps` $(PYTHON_SETUP_ARGS) .
>>  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__=
.py
>>  	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) =
$(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>>=20=20
>> --=20
>> 2.40.0

