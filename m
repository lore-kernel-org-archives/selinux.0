Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533763E2AB3
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871681; cv=none; b=iW++h2N4OMnZiVjLBywzC+H2r1ZXSwAAejqoz93Nnb4mOy1277KmSsVk3GpxBIVNdAHNRVB+upOFYAED4i65kOdGcDy9z50d9QBST2aktm6KJ1dmrmir52LmF0gla7+6aZWFp0wJJNq1zLswbG0il56+6x1JrWmo2KhBezKYTL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871681; c=relaxed/simple;
	bh=H/YcqGYA3uf56myxgytYgT9HA8jpgqIADXb95tZB4lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9PK2ekePAfclxtsbPgaPR125n9E+YF6nk0EVtan7VgWSVARRHxX5xI+JpsKa38sc5HEKyED+Q2FIp6LmFFKY0JyWUxiYnQxcISSRWPpXnNBx3W2lp+69IDEvXxR1GT94hqYevXKEdLPowtz3h/rFvHn1y8pM2qZUisyEk+j8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tma4Laob; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tma4Laob"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6ab4476eso2529381cf.2
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778871679; x=1779476479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2AIyELwqoFUx6jQRfo3ouH2maaUee3mFPyFkQerErXA=;
        b=Tma4LaobIL9CMGFJZtIgMFd/VhNg/mzg7MhJef2/FXx6T3Lq2afcfcc9Jom7KGoszN
         Pb4VD2AYDpUl2pjgtb+Gr+RppABHxFlf8fh3yoSQuLqHwDd91VyoBFM1EpYzLWhW/O8e
         d5mozZ/FMzeCURM7j308G+YNKze1XcdYYtSofKU9dWWbrclpKzAKokTb18DKHT14aTL9
         WAvWREsbYv9nzfeBH+4z55v7g/FHaBACv7qhCa5aOGKLpd9+c7NKYGJn+5ahm/Y7Ugss
         ayLDOftrHWNiQ/DfPk1URLKQVB6ExTGVMfwJeLzsCYH2QkljvmINaZTDqmcQhrI6z7dS
         u2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871679; x=1779476479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AIyELwqoFUx6jQRfo3ouH2maaUee3mFPyFkQerErXA=;
        b=nAHBib4CFP4GOXLJaBgcCXdeQXZFUZ1Z5fkNVCp/g6hOQnWYRbkOIzmLDQE5WCn+l5
         RIlQ28EJbPw5rNGNFPkSBKXk0I2uP4dE8/dYvFBI4UsdF1BQeenQDqK2GeBUOPgX6sO9
         jmtYyyW/2MweOnItevyjk5OgEIcGJH6FMwxsikWgsMKS8xXtHjx33T6VfyfiGiY1GGIq
         9N7eLIJOjNn58hWTc5zeGVhSIW+7I4hylQVydLIdz/kqTLtYFNXZWAn1KuyZzG4COVzo
         ZNRN1eYivkLIBezp/Am3qvQGoVyX2th4Jg3b++q6c5Vsrf2leL5c2PrKr6RA9Q9068m0
         UX0w==
X-Gm-Message-State: AOJu0Yw9dMB/LojCY44I9cybpNlveYgAO5KY+c6fXfDjlqxjXLy4KIO+
	9Nru1vO0fE9NOUU4gCVrAdRBMxgm4E1Qq5V2wbxBMbEsFq4pfQi0z9zwKleJig==
X-Gm-Gg: Acq92OF4NbbUdu98hWbUr5FIPnrbsGFQQw/TTk2p/PZXPnOjxl6lXEoihiey0Ad/kwh
	0awcEt5tQGduwrSSe8CeXVRlsVwezfacAcQNaCcM0256AKo2CSPLGT4NHec1h+cg3qXjFrg295G
	Cwc4YuEjjBnY8TPwUyINrezXSgsnjBbhOt92lDXrA6kWJjvaOMvptzVxpY9EBR3PWatn338qgZu
	w2BFMPpQGPDc0/bG6oSxu6Q3qyAGNr7v4Pa9INuUkG5j9uzuJwJWNvPXJKL0wb4W8Xd8Ud14QhR
	QLSP20vflD3bFb8ZXezmHb5h8WFelzly1l0w1PIg6iuGcHfx//IvxKcOulI+hlwtvFd1OZ1gGP7
	fI7L6DJYgrJgCd2+mxVWAh3e7fXHPPHi5L+IeFM4KmI6hbs2BJv63h8EynwtrNDpnNtv7AH48Rr
	TIHbXyMMfFg2Zubo4J8BUf/SuxQ3QPhw7H1Bud0+plV1327PETsMeeWQmBNJS7vtOrnEIVa7FHY
	KiSQUfd/2lO2NHkb5UZtpm0KwYDVVv35/nhxrtkN93kmlzUlrKZCqY=
X-Received: by 2002:ac8:5d89:0:b0:516:4f8e:3004 with SMTP id d75a77b69052e-51659fd9682mr76552041cf.11.1778871669378;
        Fri, 15 May 2026 12:01:09 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm53922651cf.9.2026.05.15.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:01:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: update pywrap targets for modern python builds
Date: Fri, 15 May 2026 15:00:44 -0400
Message-ID: <20260515190044.33915-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup.py build is deprecated and no longer working on GitHub CI
runners.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/Makefile       |  7 +++----
 libselinux/src/pyproject.toml | 11 +++++++++++
 libselinux/src/setup.py       | 35 +++++++++++++++--------------------
 3 files changed, 29 insertions(+), 24 deletions(-)
 create mode 100644 libselinux/src/pyproject.toml

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 6fce9fa5..52b2c621 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -151,7 +151,7 @@ all: $(LIBSO)
 endif
 
 pywrap: all selinuxswig_python_exception.i
-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m build --no-isolation --wheel .
 
 rubywrap: all $(SWIGRUBYSO)
 
@@ -196,7 +196,7 @@ ifneq ($(DISABLE_SHARED),y)
 endif
 
 install-pywrap: pywrap
-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
@@ -209,8 +209,7 @@ relabel:
 
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
-	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#* selinux.egg-info/
+	-rm -rf build dist *.egg-info *~ \#* *pyc .#*
 
 clean-rubywrap:
 	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.toml
new file mode 100644
index 00000000..17d31f5b
--- /dev/null
+++ b/libselinux/src/pyproject.toml
@@ -0,0 +1,11 @@
+[build-system]
+requires = ["setuptools>=61.0", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "selinux"
+version = "3.10"
+description = "SELinux python 3 bindings"
+authors = [
+  { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
index 679ea43f..f66f444b 100644
--- a/libselinux/src/setup.py
+++ b/libselinux/src/setup.py
@@ -2,23 +2,18 @@
 
 from setuptools import Extension, setup
 
-setup(
-    name="selinux",
-    version="3.10",
-    description="SELinux python 3 bindings",
-    author="SELinux Project",
-    author_email="selinux@vger.kernel.org",
-    ext_modules=[
-        Extension('selinux._selinux',
-                  sources=['selinuxswig_python.i'],
-                  include_dirs=['../include'],
-                  library_dirs=['.'],
-                  libraries=['selinux']),
-        Extension('selinux.audit2why',
-                  sources=['audit2why.c'],
-                  include_dirs=['../include'],
-                  library_dirs=['.'],
-                  libraries=['selinux'],
-                  extra_link_args=['-l:libsepol.a', '-Wl,--version-script=audit2why.map'])
-    ],
-)
+ext_modules=[
+    Extension('selinux._selinux',
+              sources=['selinuxswig_python.i'],
+              include_dirs=['../include'],
+              library_dirs=['.'],
+              libraries=['selinux']),
+    Extension('selinux.audit2why',
+              sources=['audit2why.c'],
+              include_dirs=['../include'],
+              library_dirs=['.'],
+              libraries=['selinux'],
+              extra_link_args=['-l:libsepol.a', '-Wl,--version-script=audit2why.map']),
+]
+
+setup(ext_modules=ext_modules)
-- 
2.54.0

