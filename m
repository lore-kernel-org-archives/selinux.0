Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4JVwAcj"
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98566B0
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 08:50:17 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-423e77aa09cso37771141cf.1
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708617; x=1702313417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz+UoYhaLS++OsH42BKY3voi9A9T41pSlNIlgtxfEtA=;
        b=b4JVwAcjAOKVicJU2PB8V9ZXTpiluuMSiMwFkizWR9KERZmn8XG8BFOcF2dEtbvxnh
         O9T6R27Lq05gsYbqk8bcrVwkGhI4zBFM8Sah0MR7IS8HpT8jy0tHyFd78YZAtpKKUgrs
         MiQON9GgaRu2Y3y2jQ6HBsicVIkQzQP63tlF4I1f9w6dZARZxQiIYfcjxckNjgQWu7PN
         vVPySaGaOGbBcFG8Q/VNPHcLU2ESmX1UGVeAJ3UCkJeofLTIVoL5RREP6Xbjn8fKscXb
         4Xhaiuad7XCi0yK8EE0x2wWC0MNfXMA5HfDl6yfC7ilcqU0n9lsYhOTkGzKbwcuZVKM8
         yYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708617; x=1702313417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz+UoYhaLS++OsH42BKY3voi9A9T41pSlNIlgtxfEtA=;
        b=UWDXGX7MCFys34DUImusuD6MqmPtA/3V3VmKFjjB2/4eXRIyflFD1l+PB9rmbZyYZE
         PPmGBPjbYwSZofbngNKvEGkAPj7Zp3QBxH8+HhtMkiFbbQ7geQeJljZfxNFMqI3RRcj8
         7NVfy+c51hdPgrygwVihuKNBcrRV9kRWUHjztBmK0YuyhU0vgfwkRqS9PRl49n9rD2yN
         /wt84jaiYwZiRfyOPPh6wOMAuvjD6FOZMv20OUcsYPZOoxzXazYvNeQkFeGPW1KiProi
         4Kh1SK0lnyWI+gmkWQ3wBdx/auusrPxWP8nm9W3gvzewLmwPfl3d00QttSZuqE7nDWbZ
         j7rw==
X-Gm-Message-State: AOJu0YxdImkL6Q5ALn8v4icwrQptbHgpISMT6muCjFBBlrX+RnPKrTgq
	kFX6/o42vvi/xiLB+9sFzvU=
X-Google-Smtp-Source: AGHT+IEpddpmFFaT6IlVPlKKM1Rq6Unh3K1UX8FX2L96lpv2EtTfa0s5bs8J0uDXrwComQgI7q+j0A==
X-Received: by 2002:a05:622a:56:b0:421:bcc0:d6c6 with SMTP id y22-20020a05622a005600b00421bcc0d6c6mr8351365qtw.28.1701708616590;
        Mon, 04 Dec 2023 08:50:16 -0800 (PST)
Received: from fed39-vm.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id hj2-20020a05622a620200b0042545901450sm2337900qtb.72.2023.12.04.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:50:16 -0800 (PST)
From: Cameron Williams <ckwilliams.work@gmail.com>
To: jwcart2@gmail.com
Cc: chungsheng@google.com,
	selinux@vger.kernel.org,
	Cameron Williams <ckwilliams.work@gmail.com>
Subject: [PATCH] [userspace] Add CPPFLAGS to Makefiles
Date: Mon,  4 Dec 2023 11:49:54 -0500
Message-ID: <20231204164954.3735-1-ckwilliams.work@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAP+JOzQvaZK8yYx==xjYwtpJwr6pUYnWLO+X=z2Ti_YgpQdPiQ@mail.gmail.com>
References: <CAP+JOzQvaZK8yYx==xjYwtpJwr6pUYnWLO+X=z2Ti_YgpQdPiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds CPPFLAGS to all of the Makefiles as suggested.

Signed-off-by: Cameron Williams <ckwilliams.work@gmail.com>
---
 checkpolicy/Makefile            | 10 +++++-----
 checkpolicy/test/Makefile       |  4 ++--
 libselinux/src/Makefile         | 14 +++++++-------
 libsemanage/src/Makefile        | 22 +++++++++++-----------
 libsepol/src/Makefile           | 10 +++++-----
 mcstrans/src/Makefile           |  2 +-
 mcstrans/utils/Makefile         |  2 +-
 policycoreutils/hll/pp/Makefile |  2 +-
 secilc/Makefile                 |  6 +++---
 9 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 281d15be..036ab905 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -30,19 +30,19 @@ all:  $(TARGETS)
 	$(MAKE) -C test
 
 checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 %.o: %.c 
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
 
 y.tab.o: y.tab.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -o $@ -c $<
 
 lex.yy.o: lex.yy.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -o $@ -c $<
 
 y.tab.c: policy_parse.y
 	$(YACC) -d policy_parse.y
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 8e5d16b3..7f2f431c 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -13,10 +13,10 @@ endif
 all: dispol dismod
 
 dispol: dispol.o $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 dismod: dismod.o $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 clean:
 	-rm -f dispol dismod *.o 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7aadb822..d3b981fc 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -148,22 +148,22 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
 pywrap: all selinuxswig_python_exception.i
-	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
 
 rubywrap: all $(SWIGRUBYSO)
 
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
-	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
@@ -173,10 +173,10 @@ selinuxswig_python_exception.i: exception.sh ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
 
 %.o:  %.c policy.h
-	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
 
 %.lo:  %.c policy.h
-	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 	$(SWIGRUBY) $<
@@ -191,7 +191,7 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 589e4a70..d5259967 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -74,23 +74,23 @@ pywrap: all $(SWIGSO)
 rubywrap: all $(SWIGRUBYSO)
 
 $(SWIGLOBJ): $(SWIGCOUT)
-	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
-	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsemanage $(PYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsemanage $(PYLIBS)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
@@ -108,22 +108,22 @@ conf-parse.c: conf-parse.y
 conf-parse.h: conf-parse.c
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 
 %.lo:  %.c
-	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 conf-parse.o:  conf-parse.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -c -o $@ $<
 
 conf-parse.lo:  conf-parse.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
 
 conf-scan.o:  conf-scan.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -c -o $@ $<
 
 conf-scan.lo:  conf-scan.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGCOUT): $(SWIGIF)
 	$(SWIG) $<
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 13410c67..d80a941f 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -53,7 +53,7 @@ $(LIBA):  $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS) $(LIBMAP)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
@@ -68,10 +68,10 @@ endif
 
 ifneq ($(DISABLE_CIL),y)
 $(CILDIR)/src/cil_lexer.o: $(CILDIR)/src/cil_lexer.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -c -o $@ $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -c -o $@ $<
 
 $(CILDIR)/src/cil_lexer.lo: $(CILDIR)/src/cil_lexer.c
-	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(filter-out -Werror, $(CPPFLAGS) $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
 
 $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
 	$(LEX) -o $@ $<
@@ -79,10 +79,10 @@ $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
 endif
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -c -o $@ $<
 
 %.lo:  %.c
-	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 install: all
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index ef518625..89dbac16 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -23,7 +23,7 @@ $(PROG): $(PROG_OBJS) $(LIBSEPOLA)
 	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap $(PCRE_LDLIBS) $(LDLIBS_LIBSEPOLA)
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -fPIE -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -fPIE -c -o $@ $<
 
 install: all
 	test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(SBINDIR)
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index a48f4e72..eec714f1 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -20,7 +20,7 @@ untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
 	$(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSEPOLA)
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
 
 install: all
 	-mkdir -p $(DESTDIR)$(SBINDIR)
diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index fc8d3c4a..3c9b0efc 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -15,7 +15,7 @@ pp: $(PP_OBJS)
 	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 %.o: %.c
-	$(CC) $(CFLAGS) -c -o $@ $^
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $^
 
 install: all
 	-mkdir -p $(DESTDIR)$(HLLDIR)
diff --git a/secilc/Makefile b/secilc/Makefile
index 94be0481..ef7bc8cd 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -31,7 +31,7 @@ override LDLIBS += -lsepol
 all: $(SECILC) $(SECIL2CONF) $(SECIL2TREE) man
 
 $(SECILC): $(SECILC_OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 test: $(SECILC)
 	./$(SECILC) test/policy.cil
@@ -40,10 +40,10 @@ test: $(SECILC)
 	$(DIFF) test/opt-expected.cil opt-actual.cil
 
 $(SECIL2CONF): $(SECIL2CONF_OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 $(SECIL2TREE): $(SECIL2TREE_OBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE) $(SECIL2TREE_MANPAGE)
 

base-commit: 0f5a8dd3ac8226264dc01df6bd0eca8ae7443db6
-- 
2.43.0

