Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063B1F3B8A
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872803; cv=none; b=q2niaKwFnZ+TZ6ae4CtgTXdltxmcdwQx7PjUQaMmU36QHMBvlaths0087fCou1dkkQNRlNkuO3nvSisvl4rocemsKKTcIftJIqId2WDATRzYIQX+PyxEFykLDEAvRdPQ60ENJSuFS5YKqayRq3H9wkE0MmNErPIhq7XpkFP/Ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872803; c=relaxed/simple;
	bh=3rAOtqlc2A/PQHXZRskmigmnfDN2eBbbw9qJ3iAJohE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1CF29ecvCb0P8OtS/EJLc9nlqt5a1JP5AxfmOrNAAX/0XFMl2K58XQ7P/ISyyLXAtyOvKtkv/HYI4ZxYhxwVAZyZ5NXHKNxkG+H9qdLvqj/EeaWQmc/MFhuNwku2ycdgsF4SE9tvSpmT+ordZLgFZaYiQfRsfz/GhoDIWIyvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkU06pDd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkU06pDd"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b4298d271fso2865696d6.3
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778872801; x=1779477601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fN0WHZSYgyHf4VKX0VL5GDyz/OhF/9Sm5wmAA26u6k=;
        b=TkU06pDdYeFFyR7/hhdY5MUmtYecU4uqaOd9F8zQbAokwEXjMWLhgf4Rm7y95D6sGJ
         8lAdlXWz9RrPhrnrc5VnxMdQWACttmT/yKgIqzrFpYILF+WYFYD3wF8vhc3/AkdKuZlK
         FcTHf2GVsQMHV1ub2Dxh+xa4GMva0tJvay7EtqRCTkKzLRRayuJ50BgTcMot0a8p0VYI
         8k28ShryFxxJrvKq3tFPOfO2VRNV2X379OgfzBWpakLrmnyjSdEL7U3sC6w+Vag9xJGC
         JujY44Kii+jXWcPG3m4rYR5FWhkGwytNOjWwDpu0SEjbSYcPw9HYbFCc/lVefzQl4DC6
         7LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872801; x=1779477601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fN0WHZSYgyHf4VKX0VL5GDyz/OhF/9Sm5wmAA26u6k=;
        b=dJtANBsYqslslNEGvwgB4QYWpm4bAU2ihQB2eSfYOzN7Dr14M52khcMjOecCUAwO7X
         5uk+ie/QC1NMaJMjQbXzxap8sDLEi9Z9VqM3nlX2N+D54Nmi4aBxOnKd0rbhzkFDnYlP
         XqjyRcGOP+N3cSqe99aj2/6um26/2HLGR35y4P8vwYkTS7Qe9CnPkWMnIJTCUICMI74s
         CkU1gCBe/24esYF1DW9p9EqQeKjxw7+VWYkrtTiFhmnjczSYrcI1SKKBG+DWfpMCLo9y
         5VLHGfexC3MkJX72L403tbpKyX980fNM+1mGoAAhavcTPFlgKO9fr7ujJg8QZekt4ueS
         c/rQ==
X-Gm-Message-State: AOJu0Yw77wHSYRc1xXfixS0QHBYBuXVu1XCjNWsXROy+YgrUMxzVe9BV
	d9oDvJ5hn3r8vqOREJFTvle5ldFVaKAFmSseQOGeoNY7uA8+NKQuEoIwCVw4wg==
X-Gm-Gg: Acq92OFLY5oQ4OeiDrWDVD6z9TmN3cE60qu6Q9Nqex14fTlTbxk9fO40aWfdiB1xdFr
	iWxefcmHmOMSvhAnmhVNMoZ94YO90Yz6N0L9DDoKHNy25fhU9UUx0bo6mpejsWGAgnPLwh0n7rI
	V/Fr7ux8td++Drl+Y1qmpADXxtHQmSES+yWYlBqVo9HoZ6uo3luhMcpXponCf1DJ8ELOj9rlLlp
	EFMwDM0Lw4mzC8y6wJ8adxLGsmp/lrYpd7SUocw42pAh9pwqogGEKnKzZeJbpD+i/QvH3J+12Or
	SolLgmhK0ZtyO5nm8FM27uYgSNzzM2r9d08cinCsOgDVFRVWJJikyBRqPpuYuGxP1+qakDB/Das
	XIowsZm81lSiWZHMGV0C1DIIZ4szQaqYZBYCUAhIbO7XObDNYPJS/OWxy74T/NI1FopRVxJgtYY
	PMCqGptMDkcA6t3S1B1mZc6S2CNG3R6t8jTUVH7/tnsB/grA1h1TVCl97LqSjAkx3L2Vye0K9fN
	ZaVNAmLOacxT64jDqUQpT5/lGGxH4rlnkZlFegpo8E3GVGeqQOn2gU=
X-Received: by 2002:a05:6214:3a83:b0:8c9:53bd:ec78 with SMTP id 6a1803df08f44-8ca0f627db8mr83819326d6.19.1778872800556;
        Fri, 15 May 2026 12:20:00 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c161928sm60815266d6.44.2026.05.15.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:20:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/sepolicy: update for modern python builds
Date: Fri, 15 May 2026 15:19:45 -0400
Message-ID: <20260515191945.34125-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup.py build is deprecated and no longer working on GitHub
CI runners.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolicy/Makefile       |  9 ++++-----
 python/sepolicy/pyproject.toml | 23 +++++++++++++++++++++++
 python/sepolicy/setup.py       | 21 ++-------------------
 3 files changed, 29 insertions(+), 24 deletions(-)
 create mode 100644 python/sepolicy/pyproject.toml

diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index ccb22fe7..51812980 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -14,11 +14,10 @@ BASHCOMPLETIONS=sepolicy-bash-completion.sh
 all: python-build
 
 python-build:
-	$(PYTHON) setup.py build
+	$(PYTHON) -m build --no-isolation --wheel .
 
 clean:
-	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#* sepolicy.egg-info/
+	-rm -rf build dist *.egg-info *~ \#* *pyc .#*
 
 sepolgen:
 	ln -sf sepolicy sepolgen
@@ -26,8 +25,8 @@ sepolgen:
 test:
 	@$(PYTHON) test_sepolicy.py -v
 
-install:
-	$(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+install: python-build
+	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject.toml
new file mode 100644
index 00000000..00a6f69a
--- /dev/null
+++ b/python/sepolicy/pyproject.toml
@@ -0,0 +1,23 @@
+[build-system]
+requires = ["setuptools>=61.0", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "sepolicy"
+version = "3.10"
+description = "SELinux Policy python bindings"
+authors = [
+  { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
+
+[project.scripts]
+sepolicy = "sepolicy:main"
+sepolgen = "sepolicy:main"
+
+[tool.setuptools]
+packages = ["sepolicy", "sepolicy.templates", "sepolicy.help"]
+
+[tool.setuptools.package-data]
+sepolicy = ["*.glade"]
+"sepolicy.help" = ["*.txt", "*.png"]
+
diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
index a57f1ff1..8999a841 100644
--- a/python/sepolicy/setup.py
+++ b/python/sepolicy/setup.py
@@ -1,22 +1,5 @@
 #!/usr/bin/python3
-
-# Author: Thomas Liu <tliu@redhat.com>
-# Author: Dan Walsh <dwalsh@redhat.com>
 from setuptools import setup
 
-setup(
-    name="sepolicy",
-    version="3.10",
-    description="Python SELinux Policy Analyses bindings",
-    author="Daniel Walsh",
-    author_email="dwalsh@redhat.com",
-    packages=[
-        "sepolicy",
-        "sepolicy.templates",
-        "sepolicy.help"
-    ],
-    package_data={
-        'sepolicy': ['*.glade'],
-        'sepolicy.help': ['*.txt', '*.png']
-    }
-)
+# Everything handled via pyproject.toml now
+setup()
-- 
2.54.0

