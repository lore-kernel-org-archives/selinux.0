Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j30ecf9q"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01ADC
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 12:58:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso14261561fa.1
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 12:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701896313; x=1702501113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn9LINbEJC5BKSt0dCHKFqm4WvGdN153L7m511sgQjw=;
        b=j30ecf9qwUdtZwpNCbXTVtXDzf54aew6rnBWB7qCbI6jL4Gj+C3AE1ZwCjQAKiV5hY
         74aUahz5swZOIGzIA6VmmUM1xilWVrTGHbocvSeDbYqQ/me6Z74/mIN6ZqpCH/2C5mXK
         7VdFiMD3z+qpeaz+MqbRPeYtzRIyeQyZCXvJrDcqyVb80pLWUde3Bb4buDrSD1qSN7cj
         h5sI0xNE9IMUa+VQNTIbJK8hWVmhqgXYkEtE4a0NtFDFhglCc1nyyRvw6wt4e16AkZjX
         U5R7fapPEzUMPy8DNqVibWx5QQtJtTwngpKtA25ZsWfeaKlr6Y7U925wEOYHUantu8CQ
         aSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896313; x=1702501113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn9LINbEJC5BKSt0dCHKFqm4WvGdN153L7m511sgQjw=;
        b=vlBBnBg2Pdmz90VrHsT3aBoQIRyIqFRGbulIp2D+qlZbh45SRaWnfVmRi8VDrTpzdV
         2/iRzgviI2gdBbm4CaVugBsp8t8mC1INT/YeRqIMZLTJz2SSuHqchY3yGUEYKisF3p4+
         jzHjJ9kUKn+e3wVCZpIA4ps9opYwYv1uViBJ8RN/pyjA4qjHtU8rPir7lrOTNqgjLskP
         4oLGIj7mD6XZlaG/LZwoHLe6WEbOMhf9kX/MXhuP3e4GIZYybsGIb6+ApzKLLdBUOXxK
         Va4JVQQHLHoJN3JOBNVwYWwOAVAdfRQCIp4bUvLqAiBetVi4EzCvHhwYqFBTtJ5niBJG
         ui2g==
X-Gm-Message-State: AOJu0YyZDwfesEZc5VkXvI27BPE2GME0sJvm+hXG5U1/yerB9wOCBerK
	K+U7R2tDv0Ui5ucz3ePdYhqqd9RCj1ckz+NdzYk=
X-Google-Smtp-Source: AGHT+IEuFZXHIa3pkCf0EfpgvKZRShG0RC8cgWQBZm4bYwGHnUhOr58qHJ7av8LffuxGKTrf48SFAqKzp+06w1vlq9o=
X-Received: by 2002:a05:6512:688:b0:50b:fcd3:95d1 with SMTP id
 t8-20020a056512068800b0050bfcd395d1mr1105659lfe.19.1701896312526; Wed, 06 Dec
 2023 12:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzQvaZK8yYx==xjYwtpJwr6pUYnWLO+X=z2Ti_YgpQdPiQ@mail.gmail.com>
 <20231204164954.3735-1-ckwilliams.work@gmail.com> <CAP+JOzTqmB10o7WZfE-OET85ih2a3eisU35fHpyWh3w-uTqT5Q@mail.gmail.com>
In-Reply-To: <CAP+JOzTqmB10o7WZfE-OET85ih2a3eisU35fHpyWh3w-uTqT5Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 6 Dec 2023 15:58:21 -0500
Message-ID: <CAP+JOzTwBTjMsfbRXFALehhSPs7PYQb50roxrxvDRBq+J2rLRw@mail.gmail.com>
Subject: Re: [PATCH] [userspace] Add CPPFLAGS to Makefiles
To: Cameron Williams <ckwilliams.work@gmail.com>
Cc: chungsheng@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:08=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Dec 4, 2023 at 11:50=E2=80=AFAM Cameron Williams
> <ckwilliams.work@gmail.com> wrote:
> >
> > This patch adds CPPFLAGS to all of the Makefiles as suggested.
> >
> > Signed-off-by: Cameron Williams <ckwilliams.work@gmail.com>
>
> I thought initially that you left out some directories, but for some
> reason sometimes the CPPFLAGS come after the CFLAGS. Not sure why, but
> everything has them.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

>
> > ---
> >  checkpolicy/Makefile            | 10 +++++-----
> >  checkpolicy/test/Makefile       |  4 ++--
> >  libselinux/src/Makefile         | 14 +++++++-------
> >  libsemanage/src/Makefile        | 22 +++++++++++-----------
> >  libsepol/src/Makefile           | 10 +++++-----
> >  mcstrans/src/Makefile           |  2 +-
> >  mcstrans/utils/Makefile         |  2 +-
> >  policycoreutils/hll/pp/Makefile |  2 +-
> >  secilc/Makefile                 |  6 +++---
> >  9 files changed, 36 insertions(+), 36 deletions(-)
> >
> > diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> > index 281d15be..036ab905 100644
> > --- a/checkpolicy/Makefile
> > +++ b/checkpolicy/Makefile
> > @@ -30,19 +30,19 @@ all:  $(TARGETS)
> >         $(MAKE) -C test
> >
> >  checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
> > -       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEP=
OLA)
> >
> >  checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
> > -       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEP=
OLA)
> >
> >  %.o: %.c
> > -       $(CC) $(CFLAGS) -o $@ -c $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
> >
> >  y.tab.o: y.tab.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -o $@ -c $<
> >
> >  lex.yy.o: lex.yy.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -o $@ -c $<
> >
> >  y.tab.c: policy_parse.y
> >         $(YACC) -d policy_parse.y
> > diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
> > index 8e5d16b3..7f2f431c 100644
> > --- a/checkpolicy/test/Makefile
> > +++ b/checkpolicy/test/Makefile
> > @@ -13,10 +13,10 @@ endif
> >  all: dispol dismod
> >
> >  dispol: dispol.o $(LIBSEPOLA)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEP=
OLA)
> >
> >  dismod: dismod.o $(LIBSEPOLA)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEP=
OLA)
> >
> >  clean:
> >         -rm -f dispol dismod *.o
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 7aadb822..d3b981fc 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -148,22 +148,22 @@ SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) =
-outdir ./ $(DISABLE_FLAGS)
> >  all: $(LIBA) $(LIBSO) $(LIBPC)
> >
> >  pywrap: all selinuxswig_python_exception.i
> > -       CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ex=
t
> > +       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup=
.py build_ext
> >
> >  rubywrap: all $(SWIGRUBYSO)
> >
> >  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
> > -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o =
$@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DS=
HARED -c -o $@ $<
> >
> >  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUB=
YLIBS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -ls=
elinux $(RUBYLIBS)
> >
> >  $(LIBA): $(OBJS)
> >         $(AR) rcs $@ $^
> >         $(RANLIB) $@
> >
> >  $(LIBSO): $(LOBJS)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) $(FT=
S_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_=
LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > @@ -173,10 +173,10 @@ selinuxswig_python_exception.i: exception.sh ../i=
nclude/selinux/selinux.h
> >         bash -e exception.sh > $@ || (rm -f $@ ; false)
> >
> >  %.o:  %.c policy.h
> > -       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> >
> >  %.lo:  %.c policy.h
> > -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> >
> >  $(SWIGRUBYCOUT): $(SWIGRUBYIF)
> >         $(SWIGRUBY) $<
> > @@ -191,7 +191,7 @@ install: all
> >         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LI=
BDIR)/$(TARGET)
> >
> >  install-pywrap: pywrap
> > -       CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --=
prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore=
-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> > +       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pi=
p install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTD=
IR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> >         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/_=
_init__.py
> >         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(P=
YCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index 589e4a70..d5259967 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -74,23 +74,23 @@ pywrap: all $(SWIGSO)
> >  rubywrap: all $(SWIGRUBYSO)
> >
> >  $(SWIGLOBJ): $(SWIGCOUT)
> > -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARED -c -o $@=
 $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHA=
RED -c -o $@ $<
> >
> >  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
> > -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o =
$@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DS=
HARED -c -o $@ $<
> >
> >  $(SWIGSO): $(SWIGLOBJ)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsemanage $(PY=
LIBS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -ls=
emanage $(PYLIBS)
> >
> >  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RU=
BYLIBS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -ls=
emanage $(RUBYLIBS)
> >
> >  $(LIBA): $(OBJS)
> >         $(AR) rcs $@ $^
> >         $(RANLIB) $@
> >
> >  $(LIBSO): $(LOBJS)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -ls=
elinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.map,-z,def=
s
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol=
 -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanag=
e.map,-z,defs
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > @@ -108,22 +108,22 @@ conf-parse.c: conf-parse.y
> >  conf-parse.h: conf-parse.c
> >
> >  %.o:  %.c
> > -       $(CC) $(CFLAGS) -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> >
> >  %.lo:  %.c
> > -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> >
> >  conf-parse.o:  conf-parse.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -c -o $@ $<
> >
> >  conf-parse.lo:  conf-parse.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ =
$<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHAR=
ED -c -o $@ $<
> >
> >  conf-scan.o:  conf-scan.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -c -o $@ $<
> >
> >  conf-scan.lo:  conf-scan.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ =
$<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHAR=
ED -c -o $@ $<
> >
> >  $(SWIGCOUT): $(SWIGIF)
> >         $(SWIG) $<
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index 13410c67..d80a941f 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -53,7 +53,7 @@ $(LIBA):  $(OBJS)
> >         $(RANLIB) $@
> >
> >  $(LIBSO): $(LOBJS) $(LIBMAP)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,$(LD_SONA=
ME_FLAGS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -=
Wl,$(LD_SONAME_FLAGS)
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > @@ -68,10 +68,10 @@ endif
> >
> >  ifneq ($(DISABLE_CIL),y)
> >  $(CILDIR)/src/cil_lexer.o: $(CILDIR)/src/cil_lexer.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -c -o $@ $<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -c -o =
$@ $<
> >
> >  $(CILDIR)/src/cil_lexer.lo: $(CILDIR)/src/cil_lexer.c
> > -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ =
$<
> > +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHAR=
ED -c -o $@ $<
> >
> >  $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
> >         $(LEX) -o $@ $<
> > @@ -79,10 +79,10 @@ $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.=
l
> >  endif
> >
> >  %.o:  %.c
> > -       $(CC) $(CFLAGS) -fPIC -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c -o $@ $<
> >
> >  %.lo:  %.c
> > -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> >
> >  install: all
> >         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LI=
BDIR)
> > diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> > index ef518625..89dbac16 100644
> > --- a/mcstrans/src/Makefile
> > +++ b/mcstrans/src/Makefile
> > @@ -23,7 +23,7 @@ $(PROG): $(PROG_OBJS) $(LIBSEPOLA)
> >         $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap $(PCRE_LDLIBS) $=
(LDLIBS_LIBSEPOLA)
> >
> >  %.o:  %.c
> > -       $(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BIT=
S=3D64 -fPIE -c -o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FIL=
E_OFFSET_BITS=3D64 -fPIE -c -o $@ $<
> >
> >  install: all
> >         test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(S=
BINDIR)
> > diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> > index a48f4e72..eec714f1 100644
> > --- a/mcstrans/utils/Makefile
> > +++ b/mcstrans/utils/Makefile
> > @@ -20,7 +20,7 @@ untranscon: untranscon.o ../src/mcstrans.o ../src/mls=
_level.o $(LIBSEPOLA)
> >         $(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIB=
SEPOLA)
> >
> >  %.o:  %.c
> > -       $(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c =
-o $@ $<
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../s=
rc -fPIE -c -o $@ $<
> >
> >  install: all
> >         -mkdir -p $(DESTDIR)$(SBINDIR)
> > diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/M=
akefile
> > index fc8d3c4a..3c9b0efc 100644
> > --- a/policycoreutils/hll/pp/Makefile
> > +++ b/policycoreutils/hll/pp/Makefile
> > @@ -15,7 +15,7 @@ pp: $(PP_OBJS)
> >         $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >
> >  %.o: %.c
> > -       $(CC) $(CFLAGS) -c -o $@ $^
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $^
> >
> >  install: all
> >         -mkdir -p $(DESTDIR)$(HLLDIR)
> > diff --git a/secilc/Makefile b/secilc/Makefile
> > index 94be0481..ef7bc8cd 100644
> > --- a/secilc/Makefile
> > +++ b/secilc/Makefile
> > @@ -31,7 +31,7 @@ override LDLIBS +=3D -lsepol
> >  all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
> >
> >  $(SECILC): $(SECILC_OBJS)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >
> >  test: $(SECILC)
> >         ./$(SECILC) test/policy.cil
> > @@ -40,10 +40,10 @@ test: $(SECILC)
> >         $(DIFF) test/opt-expected.cil opt-actual.cil
> >
> >  $(SECIL2CONF): $(SECIL2CONF_OBJS)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >
> >  $(SECIL2TREE): $(SECIL2TREE_OBJS)
> > -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >
> >  man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
> >
> >
> > base-commit: 0f5a8dd3ac8226264dc01df6bd0eca8ae7443db6
> > --
> > 2.43.0
> >
