Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2738E8B8
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875924; cv=none; b=PlM70WHnT49zl0w3ah4WMvLdp+L8o/1NHGOvVXlT/6rwxtlQq6giD986rFdAop4aeZLsWCv4nz//MFHrwWOGK/KVaRZhAJl23YK5QCrakJCeApxoYPuCZWIL2s0GK0v+8P2JkNZtjjVUodvAsFXacKsBasW+2m7TeU5VIBimdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875924; c=relaxed/simple;
	bh=FeF52JJjiwHXPZy9iCtLVquMeFiBLoCTpg2jE/ssRK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVh7ZCmAGv2010Z01PmOUfD7Yx8Lr2RZ/dCSKHoOEQtSFKU9376yCeFnI0E5LBOpt9/TY5IVf8ieCol1+Iw+w3npj1oNQxwN9OxZP0ZlQcjutYFqcfj4aLjqjnPOqmNuRRT5Z/tdpbzdFBS4iFUC7hY2XtmM3Rer6x0x6aM9QFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvvEsijo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvvEsijo"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ca12973e15so3057536d6.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778875922; x=1779480722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlMxiOAt7d9nDV+hGoiAzNyDn6YNigLGIM8TzYUhzSQ=;
        b=SvvEsijoL2iC2ttraHi4Hcff/CxYwIg/f90ThCgNB5qqzGTlyt48/vHHhC/ZYWtZy7
         Zda2GzJaZjtXk9Lws87cMSzmRON1X7PHzU5AocYsLhvoFSY2gYLVnYaDe+BU32h7/E4D
         wNbN1oZY3w9W4mKaETumIKbQa+XHjuLqfB8aRrrH5gVVBVcw1PpmbMifWTwmOlV7zw+E
         X2JnZVlbwt5Y79RB7nOK2lPWqzwzdl1iQ2gJymMGVXEYxb1mvbNzEnAwXpsrJ8Ajw5Gb
         lB75MwF7ESawixR5mi5cqG7QMJhb6SSZ+ISlbXCwfbC0jDETbZXnCTOptMChbXbpy05k
         tHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875922; x=1779480722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlMxiOAt7d9nDV+hGoiAzNyDn6YNigLGIM8TzYUhzSQ=;
        b=Rhj7C9I6h+TAyXsyCh0wwUJW17HIQUBuRey++avl2zGOATGAI2AUEQVxMqn+oMNr0Y
         V3HLs5d0jvVWu/Fm7gxcRjoXRmTxvWySUxBFjC2NB6PBM4Khit2HEev/tVPw2EUq5sDW
         1VPSIa1oa23XoZ6M0RmL8b5oxNnFa1ESMJGWIv+3AiCF4StyGimihmK2F0cx0O+lw680
         LKIVbxsFV7wRxBFHR5VuXI7LkU0WqQNOLcoGCqYsNUS22EvYQrRmdicibr72BEDeAOaf
         RV7HQWATCr6my2vuFINOOCm26yqTcsvBs4SJ5DHwyYjLmADZxFtHMzpvm6RmlGwPsATt
         oHcQ==
X-Gm-Message-State: AOJu0Yyq8HoJlOJwKDKu00OJmBTeJj8MPnuwDcqdO5T1Cptje7Q2aIiY
	9LgDtUUpBhBz61Bpp0sE8HW0I27w8zcpXFRoVtexMIiuKaM1ibKNpQ+qt/TdwA==
X-Gm-Gg: Acq92OESu9u1HEXHZWvgfYesH2qv5j8K5F+JE9t72K2T0XUdqrPQp+wmzBtFugkn4/j
	A2BkWmGKJjEMK3+ysaPqu8fZ8zmE7n+pNnIVxHWVORSpkdp3YhggOCgl36S1jWRXqDedcBogKaO
	HJ+0TA21/LXMWl43oadb4Crkwkbhe6hFzFSsO2FGNXx7Zyck2u9kVJd498/8Repz4P7MocyW9EZ
	6qAcWDC4crPmYTvYP4sXMsIOdSisTR0BIAuWFv+lpEN9ZjDTtx5EJsz85W3OYGPsbPCSaphMD4x
	7EdWLJmy7EyZthws4hLsvZyT5NgUxBwLJ9kD/x6ECtGS3u1DqpFo8qZa8/dnylCV624UqD5DBie
	+MfbvAfkDEv7UWHUdSpRm+pdyWR53jU3mkexJIfARdVD8DA13Kn2ITSwL8M5062YLI6ecK+cTk7
	AwqOvmw9571H5OBbkL93eP2OiV8iuHXaFY/dHNvcf8lxaaefZmK/IufkmBcFA4wSd5e5UMlx7lS
	J0rkhOnpIXk6/F6rt0jghLgpvVNZz7Vv9thqqfmGKVO3vuLGkzKG1c=
X-Received: by 2002:a05:6214:5a05:b0:8b1:f784:7ec8 with SMTP id 6a1803df08f44-8ca0f6fcd58mr103836426d6.47.1778875922212;
        Fri, 15 May 2026 13:12:02 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca1188c2c3sm32200826d6.5.2026.05.15.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:12:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] libselinux: update pywrap targets for modern python builds
Date: Fri, 15 May 2026 16:09:52 -0400
Message-ID: <20260515200952.35857-2-stephen.smalley.work@gmail.com>
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
v2 finally passes the GitHub build tests for me in combination with
the libsemanage tests fix.

 libselinux/src/.gitignore     |  1 +
 libselinux/src/Makefile       |  8 ++++----
 libselinux/src/pyproject.toml | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 libselinux/src/pyproject.toml

diff --git a/libselinux/src/.gitignore b/libselinux/src/.gitignore
index 94400e81..5413ccf0 100644
--- a/libselinux/src/.gitignore
+++ b/libselinux/src/.gitignore
@@ -2,3 +2,4 @@ selinux.py
 selinuxswig_python_wrap.c
 selinuxswig_ruby_wrap.c
 selinux.egg-info/
+dist/
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 6fce9fa5..c62ad1ed 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -151,7 +151,8 @@ all: $(LIBSO)
 endif
 
 pywrap: all selinuxswig_python_exception.i
-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
+	$(PYTHON) -m pip install build wheel
+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m build --no-isolation --wheel .
 
 rubywrap: all $(SWIGRUBYSO)
 
@@ -196,7 +197,7 @@ ifneq ($(DISABLE_SHARED),y)
 endif
 
 install-pywrap: pywrap
-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
 	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 
@@ -209,8 +210,7 @@ relabel:
 
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
-	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#* selinux.egg-info/
+	-rm -rf build dist *.egg-info *~ \#* *pyc .#*
 
 clean-rubywrap:
 	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.toml
new file mode 100644
index 00000000..74dbbc34
--- /dev/null
+++ b/libselinux/src/pyproject.toml
@@ -0,0 +1,11 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "selinux"
+version = "3.10"
+description = "SELinux python 3 bindings"
+authors = [
+  { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
-- 
2.54.0

