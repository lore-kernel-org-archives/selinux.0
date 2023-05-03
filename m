Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB78C77B78
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 16:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjECQYp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECQYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 12:24:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1AA4EEB
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 09:24:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f139de8cefso3974150e87.0
        for <selinux@vger.kernel.org>; Wed, 03 May 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131080; x=1685723080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzl2WlAulSVGZbejoxeElJCiC/F7Rv8KkCnaGjE4Gd8=;
        b=P49B3GaEN+yq5Cc5Sug/ZrW2d/38Dv7r40Kjzg6ivvb+C/rvWQUkcdsi6TkyhFhKmQ
         V99SAaRb46KXZ7pdlAlDH+YZPt7fJaSNwuDMOk7t3+0zbaccytEB4R4TzXCDTkeGyi0t
         J2cizrP/Izh2bbMdWD4ICGsGEBsUEAId2zGOxBySKvnJZQyjkMBs3k7m/r+R6+ixrg3B
         qx+A5eDYPD7dxX2oJUy5d9eNh5Dx2WsRM44LtYEBNGy5pY3wrJNZq2a8ftGFRpXsdYHk
         ZwPbFYZZusI5yV0KYW8IA3+9tGi4HuC2s0ZkR5XIgsUkuGAfKR/1b0vhYs+q1jq9Lujx
         PrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131080; x=1685723080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yzl2WlAulSVGZbejoxeElJCiC/F7Rv8KkCnaGjE4Gd8=;
        b=IXS7ZQUJI4iBUfrmpzWqGHdzs76RdGeaTB3HJAUSz7SoQq9KCHWO6BEayJWXfAvkjE
         6bSHQZTM1gswMiZLb6r6kQBARiQ4uXY/8PXHI2qTYQaHAyh7KJXp87lyUhX3bemGeBXB
         0Nfe7HEpDVYTsLeEy7Kjy4atu1VHkDpWCjRoEcgnjmpp9Ogd14kLOSsykEBppAWO+nFX
         i3M0eVKqG6pW24zOpcCvzvG/NOsGu2LkPI6PBTV10r2QJPZJMjmmaQG5ZYf6WvC0ukHi
         iERtWY97Ljcp8a5a/543vZCU/AsQ3Oid4xfNxZO4m584JVlHuVBeDD/t6N3+B/Kr1BzV
         szFQ==
X-Gm-Message-State: AC+VfDzdrl3mzkRJc9TndtFCzvfQ9l8kF8hSrLXq6ZtC4w0D8IX3zzoQ
        0m+pn1jTpYfRdnUrG43MrmRjqNUqnRtCRTI4ziY/cfhD
X-Google-Smtp-Source: ACHHUZ6nmW6AB7dotePfn1Ekle89bt6MOinzmIw2lxZN9GB/U6fg6sASJD2Ecvj6OCmIbnk4te7IiabqcsQGkHZPdX8=
X-Received: by 2002:a2e:721a:0:b0:2a4:fada:edd1 with SMTP id
 n26-20020a2e721a000000b002a4fadaedd1mr84874ljc.16.1683131079682; Wed, 03 May
 2023 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230420162700.41974-1-cgzones@googlemail.com>
 <87h6t2n0wb.fsf@redhat.com> <87edo6myg9.fsf@redhat.com>
In-Reply-To: <87edo6myg9.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 3 May 2023 12:24:28 -0400
Message-ID: <CAP+JOzQ1L-BWjk390MhqEMgQSkpcsV53rBdQeG2kcac6=-6fcQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: set CFLAGS for pip installation
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 26, 2023 at 12:06=E2=80=AFPM Petr Lautrbach <plautrba@redhat.co=
m> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
> >
> >> Explicitly set CFLAGS for the pip install command, similar to calling
> >> setup.py, to ignore known compiler warnings treated as errors, e.g.:
> >>
> >>     selinuxswig_python_wrap.c:3593:19: error: 'sidget' is deprecated [=
-Werror,-Wdeprecated-declarations]
> >>                 result =3D (int)sidget(arg1);
> >>                               ^
> >>     selinuxswig_python_wrap.c:15024:1: error: no previous prototype fo=
r function 'PyInit__selinux' [-Werror,-Wmissing-prototypes]
> >>             SWIG_init(void) {
> >>             ^
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> >
> > It looks like a problem in build system - selinuxswig_python_wrap.o is
> > built twice, first time by
> >
> > pywrap: all selinuxswig_python_exception.i
> >       CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
> >
> >
> > clang -fdeclspec -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv =
-O3 -Wall -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self =
-Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-d=
ereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -W=
write-strings -fno-common -I/tmp/destdir/usr/include -I../include -D_GNU_SO=
URCE -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8 -Wno-erro=
r -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter -=
Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarat=
ions -Wno-deprecated-declarations -fPIC -I../include -I/opt/hostedtoolcache=
/Python/3.9.16/x64/include/python3.9 -c selinuxswig_python_wrap.c -o build/=
temp.linux-x86_64-3.9/selinuxswig_python_wrap.o
> >
> >
> > and second time by
> >
> > install-pywrap: pywrap
> >       $(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_A=
RGS) .
> >
> > clang -fdeclspec -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv =
-O3 -Wall -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self =
-Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-d=
ereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -W=
write-strings -fno-common -I/tmp/destdir/usr/include -I../include -D_GNU_SO=
URCE -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=3D8 -fPIC -I.=
./include -I/opt/hostedtoolcache/Python/3.9.16/x64/include/python3.9 -c sel=
inuxswig_python_wrap.c -o build/temp.linux-x86_64-cpython-39/selinuxswig_py=
thon_wrap.o
> >
> >
> > I'd expect that it's built only in pywrap target and install-pywrap
> > would just install it.
>
> So according to the internet, pip install does all setup.py operations
> [build_ext, build, install, ...] on it's own and therefore pywrap target
> with `setup.py build` seems to be useless.
>
> But your change is necessary.
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

>
>
>
> >
> >
> >> ---
> >> fixes GitHub CI, see https://github.com/SELinuxProject/selinux/pull/38=
8
> >> ---
> >>  libselinux/src/Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> >> index 36d57122..f9a1e5f5 100644
> >> --- a/libselinux/src/Makefile
> >> +++ b/libselinux/src/Makefile
> >> @@ -187,7 +187,7 @@ install: all
> >>      ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBD=
IR)/$(TARGET)
> >>
> >>  install-pywrap: pywrap
> >> -    $(PYTHON) -m pip install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_A=
RGS) .
> >> +    CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --pr=
efix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-i=
nstalled --no-deps` $(PYTHON_SETUP_ARGS) .
> >>      install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__i=
nit__.py
> >>      ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYC=
EXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> >>
> >> --
> >> 2.40.0
>
