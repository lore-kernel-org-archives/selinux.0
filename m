Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyKzk4EQ"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65351C3
	for <selinux@vger.kernel.org>; Tue,  5 Dec 2023 08:08:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf82f4409so2230853e87.0
        for <selinux@vger.kernel.org>; Tue, 05 Dec 2023 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701792495; x=1702397295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyfaYU3ux3ZDQB8ybKdw8OU9nez6ixPILW7/AzNGkAI=;
        b=gyKzk4EQsBSKT8kOQ9uqn2SLjtqVXhlZzBYK8TwOOQ8FSAu+XwWQGVglxd/Mpd0FYm
         2puDyoSNIA7XHMziVi1W68soIbsiVirrUxLa9sjjW8i7yBmjoeK1nCG2v/5J1YbZG2X1
         hlXAf65hgMx60eofCqW7M+CbFYjaZ+duApXvABzIwD7B5SiJrvk0yljt3Z1Vmh/MeaLT
         Yke0gguMfqVTaDUKUxAkbrmF1I7tjo0QebdGNM8URz1EiuFFRTc4l94yRdKOqVPOq2Ob
         JpR6G7mTJWdmZeLcVgLqN2t7YG8FEVgjtbCJ3vXn/yqP5bbe5pr17UPJ/vi2//2/LRzs
         oSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792495; x=1702397295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyfaYU3ux3ZDQB8ybKdw8OU9nez6ixPILW7/AzNGkAI=;
        b=s0zHhqOb+/11tvjoBN0LOqOy22v7fR7QxNfLcPIwLuOfl5nUUkLbhfNro6re6cRzXd
         yGEz8OINGu//bGTY0f8nhAkL9IMhd6VqSN5/NXDT/lsk74kogIfoXMMjg90oOdZWEq+Y
         SdW0XPWEcYnvA83rGbmXw4gZflW/uCdv1kgbSYJwmo2aSZQjdNIX0i7WyDkb9uToGAJP
         64noMrjFXrPDMmQq6dI/rccHVTPSO2wXfG4cKyAMSyjrOoIdYNTMlWfyjgcRhC+WB28e
         ecq6NXFzjdFtximCdPnHMmVnQcCnH8VH10kEM3L2aYFSF4aAbITgKk+PGD6q82KBxN9u
         JXSw==
X-Gm-Message-State: AOJu0Yza/QmZ5wCHLVDsQrsNVrUYd8vz9XNlAIOvbaeC37UWYN7Rs4Hp
	odFMKZOij/r7m6+h+d9dcl5QxV+A330emIkaYbw=
X-Google-Smtp-Source: AGHT+IH5lksq42qNGKyRsHN5Onzr7s4ckXUoh1BTTzBx6dIQizmbXqIwRUWplly00mdEJ1ZMDPQhSTiOemSg9IyDGss=
X-Received: by 2002:a05:6512:2c8f:b0:50b:cafc:bd70 with SMTP id
 dw15-20020a0565122c8f00b0050bcafcbd70mr1207886lfb.0.1701792495151; Tue, 05
 Dec 2023 08:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzQvaZK8yYx==xjYwtpJwr6pUYnWLO+X=z2Ti_YgpQdPiQ@mail.gmail.com>
 <20231204164954.3735-1-ckwilliams.work@gmail.com>
In-Reply-To: <20231204164954.3735-1-ckwilliams.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 5 Dec 2023 11:08:03 -0500
Message-ID: <CAP+JOzTqmB10o7WZfE-OET85ih2a3eisU35fHpyWh3w-uTqT5Q@mail.gmail.com>
Subject: Re: [PATCH] [userspace] Add CPPFLAGS to Makefiles
To: Cameron Williams <ckwilliams.work@gmail.com>
Cc: chungsheng@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:50=E2=80=AFAM Cameron Williams
<ckwilliams.work@gmail.com> wrote:
>
> This patch adds CPPFLAGS to all of the Makefiles as suggested.
>
> Signed-off-by: Cameron Williams <ckwilliams.work@gmail.com>

I thought initially that you left out some directories, but for some
reason sometimes the CPPFLAGS come after the CFLAGS. Not sure why, but
everything has them.

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  checkpolicy/Makefile            | 10 +++++-----
>  checkpolicy/test/Makefile       |  4 ++--
>  libselinux/src/Makefile         | 14 +++++++-------
>  libsemanage/src/Makefile        | 22 +++++++++++-----------
>  libsepol/src/Makefile           | 10 +++++-----
>  mcstrans/src/Makefile           |  2 +-
>  mcstrans/utils/Makefile         |  2 +-
>  policycoreutils/hll/pp/Makefile |  2 +-
>  secilc/Makefile                 |  6 +++---
>  9 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index 281d15be..036ab905 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -30,19 +30,19 @@ all:  $(TARGETS)
>         $(MAKE) -C test
>
>  checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
> -       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOL=
A)
>
>  checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
> -       $(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOL=
A)
>
>  %.o: %.c
> -       $(CC) $(CFLAGS) -o $@ -c $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
>
>  y.tab.o: y.tab.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -o $@ -c $<
>
>  lex.yy.o: lex.yy.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -o $@ -c $<
>
>  y.tab.c: policy_parse.y
>         $(YACC) -d policy_parse.y
> diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
> index 8e5d16b3..7f2f431c 100644
> --- a/checkpolicy/test/Makefile
> +++ b/checkpolicy/test/Makefile
> @@ -13,10 +13,10 @@ endif
>  all: dispol dismod
>
>  dispol: dispol.o $(LIBSEPOLA)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOL=
A)
>
>  dismod: dismod.o $(LIBSEPOLA)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOL=
A)
>
>  clean:
>         -rm -f dispol dismod *.o
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 7aadb822..d3b981fc 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -148,22 +148,22 @@ SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -o=
utdir ./ $(DISABLE_FLAGS)
>  all: $(LIBA) $(LIBSO) $(LIBPC)
>
>  pywrap: all selinuxswig_python_exception.i
> -       CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
> +       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.p=
y build_ext
>
>  rubywrap: all $(SWIGRUBYSO)
>
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
> -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@=
 $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHA=
RED -c -o $@ $<
>
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYL=
IBS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsel=
inux $(RUBYLIBS)
>
>  $(LIBA): $(OBJS)
>         $(AR) rcs $@ $^
>         $(RANLIB) $@
>
>  $(LIBSO): $(LOBJS)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_=
LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LD=
LIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> @@ -173,10 +173,10 @@ selinuxswig_python_exception.i: exception.sh ../inc=
lude/selinux/selinux.h
>         bash -e exception.sh > $@ || (rm -f $@ ; false)
>
>  %.o:  %.c policy.h
> -       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>
>  %.lo:  %.c policy.h
> -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>
>  $(SWIGRUBYCOUT): $(SWIGRUBYIF)
>         $(SWIGRUBY) $<
> @@ -191,7 +191,7 @@ install: all
>         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBD=
IR)/$(TARGET)
>
>  install-pywrap: pywrap
> -       CFLAGS=3D"$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --pr=
efix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-i=
nstalled --no-deps` $(PYTHON_SETUP_ARGS) .
> +       CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip =
install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR=
) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__i=
nit__.py
>         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYC=
EXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 589e4a70..d5259967 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -74,23 +74,23 @@ pywrap: all $(SWIGSO)
>  rubywrap: all $(SWIGRUBYSO)
>
>  $(SWIGLOBJ): $(SWIGCOUT)
> -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARED -c -o $@ $=
<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARE=
D -c -o $@ $<
>
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
> -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@=
 $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHA=
RED -c -o $@ $<
>
>  $(SWIGSO): $(SWIGLOBJ)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsemanage $(PYLI=
BS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsem=
anage $(PYLIBS)
>
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBY=
LIBS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsem=
anage $(RUBYLIBS)
>
>  $(LIBA): $(OBJS)
>         $(AR) rcs $@ $^
>         $(RANLIB) $@
>
>  $(LIBSO): $(LOBJS)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lsel=
inux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.map,-z,defs
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -=
laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.=
map,-z,defs
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> @@ -108,22 +108,22 @@ conf-parse.c: conf-parse.y
>  conf-parse.h: conf-parse.c
>
>  %.o:  %.c
> -       $(CC) $(CFLAGS) -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
>
>  %.lo:  %.c
> -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>
>  conf-parse.o:  conf-parse.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -c -o $@ $<
>
>  conf-parse.lo:  conf-parse.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHARED=
 -c -o $@ $<
>
>  conf-scan.o:  conf-scan.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -c -o $@ $<
>
>  conf-scan.lo:  conf-scan.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHARED=
 -c -o $@ $<
>
>  $(SWIGCOUT): $(SWIGIF)
>         $(SWIG) $<
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 13410c67..d80a941f 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -53,7 +53,7 @@ $(LIBA):  $(OBJS)
>         $(RANLIB) $@
>
>  $(LIBSO): $(LOBJS) $(LIBMAP)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,$(LD_SONAME=
_FLAGS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl=
,$(LD_SONAME_FLAGS)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> @@ -68,10 +68,10 @@ endif
>
>  ifneq ($(DISABLE_CIL),y)
>  $(CILDIR)/src/cil_lexer.o: $(CILDIR)/src/cil_lexer.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -c -o $@ $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -c -o $@=
 $<
>
>  $(CILDIR)/src/cil_lexer.lo: $(CILDIR)/src/cil_lexer.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHARED=
 -c -o $@ $<
>
>  $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
>         $(LEX) -o $@ $<
> @@ -79,10 +79,10 @@ $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
>  endif
>
>  %.o:  %.c
> -       $(CC) $(CFLAGS) -fPIC -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c -o $@ $<
>
>  %.lo:  %.c
> -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBD=
IR)
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index ef518625..89dbac16 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -23,7 +23,7 @@ $(PROG): $(PROG_OBJS) $(LIBSEPOLA)
>         $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap $(PCRE_LDLIBS) $(L=
DLIBS_LIBSEPOLA)
>
>  %.o:  %.c
> -       $(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -fPIE -c -o $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_=
OFFSET_BITS=3D64 -fPIE -c -o $@ $<
>
>  install: all
>         test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(SBI=
NDIR)
> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> index a48f4e72..eec714f1 100644
> --- a/mcstrans/utils/Makefile
> +++ b/mcstrans/utils/Makefile
> @@ -20,7 +20,7 @@ untranscon: untranscon.o ../src/mcstrans.o ../src/mls_l=
evel.o $(LIBSEPOLA)
>         $(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSE=
POLA)
>
>  %.o:  %.c
> -       $(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o=
 $@ $<
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src=
 -fPIE -c -o $@ $<
>
>  install: all
>         -mkdir -p $(DESTDIR)$(SBINDIR)
> diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Mak=
efile
> index fc8d3c4a..3c9b0efc 100644
> --- a/policycoreutils/hll/pp/Makefile
> +++ b/policycoreutils/hll/pp/Makefile
> @@ -15,7 +15,7 @@ pp: $(PP_OBJS)
>         $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
>  %.o: %.c
> -       $(CC) $(CFLAGS) -c -o $@ $^
> +       $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $^
>
>  install: all
>         -mkdir -p $(DESTDIR)$(HLLDIR)
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 94be0481..ef7bc8cd 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -31,7 +31,7 @@ override LDLIBS +=3D -lsepol
>  all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
>
>  $(SECILC): $(SECILC_OBJS)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
>  test: $(SECILC)
>         ./$(SECILC) test/policy.cil
> @@ -40,10 +40,10 @@ test: $(SECILC)
>         $(DIFF) test/opt-expected.cil opt-actual.cil
>
>  $(SECIL2CONF): $(SECIL2CONF_OBJS)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
>  $(SECIL2TREE): $(SECIL2TREE_OBJS)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
>  man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
>
>
> base-commit: 0f5a8dd3ac8226264dc01df6bd0eca8ae7443db6
> --
> 2.43.0
>
