Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA513F9F4A
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105570; cv=none; b=VEUxo0Ffworxbz+FxHrlZj5i/6i/UNEd9vewzj8ym0LILLc8VpQL6nk32exOarziOjXTBehgho8au0ymVGCLlUcETcqeOXq36NocYyafwYxbPIjPpCUQWEzuppi057fUmvC4RQ+XpflB24k0tbsnwkNoSgv6+OxtjeN1ICMP1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105570; c=relaxed/simple;
	bh=R80opXPPCZewxApdMws88H4Smh5Sx1hio+9WVDER14Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3gFN5lQRaTXUHAIpRCaHlczh8dNfM0GCj5lvMWYOp1pVLMP+6MdIbD7iouNRisCvi1LqO3fXVJjrVH0aGgh9StW9jV78pA04XRtuwN7WQkNKUZUEh28iQnEi0cHZt4oabIU7uHSNDrQXYhlvMfMG9YOPM9n1PwPU+ek1N0mq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyp+R8uI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyp+R8uI"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5148cbdea08so19693681cf.2
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779105566; x=1779710366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtdzbgRbcCjiKPjtXXG5EptqrJymtd/l8k8E8tHuhyY=;
        b=oyp+R8uIj+gEzqpBP4rmc4oXTyQzQXiC30HGb22UdnIF584gcmBTcm8vI9wh8jZKfH
         9dj0j4eGxYBHtXjZL9n4JvI66xMbHvs+FZgq86tC6cKPZq3RRLb6yf7KUfYbFCSUwRJj
         qV0PmmxWNYdnGwcCYY0c9elz1CM1qm/+u10ibiGC6wWJb0jGiqJB6gISytSz7BBQF7dm
         GQOG07/Z3nHM9FbGZ8BP8SCCXbuFEyREAUyhvcAnoVP7h1BxyVjy4MPkMd5BYz82CnON
         Rok8IaGwQw5mRvGAHk75ahdQpfueD3vtII06TBvVzXq89+EKFYYmNjs+mPTeHPD634Ll
         XbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779105566; x=1779710366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtdzbgRbcCjiKPjtXXG5EptqrJymtd/l8k8E8tHuhyY=;
        b=TliPpY4RWhGTD/MgxAOLtEpeoRHfDh6sx63ZGGsKyuQJZYw1FAc6uFL4tvAsMcQuTR
         +uxF4SbSnE3zdftnknAZhXA7l49FIUm16MRsOp3qlSFKGM+8pXv1uSUt64OWeB7USS21
         IihVJkU+uY0JXGbDYZPC+nfsvlXrojUY/rO+LsPcSuWCBRb+p9uxaRt5NY2GPj4d6l1J
         kibU451210QTYRYmGudV9ZmF7qsYotv9K3I1xIl61wwoGI5/VDVE8CTkH6glGTHithAK
         NoJQsWWe6SAoyZKVC5WTLnQKta+g14Ak1TtoncgMBBzs1n4c6kITykBF78prLBEYA+Dh
         tFBQ==
X-Gm-Message-State: AOJu0YzXzZq2+SpnR8IBb4rPboPwF2dNgm+vr9Ojr8u+KKrtXf0e5IzX
	DDgeggznPve9M6iTm5kj42l2yb6PZ1m7Nrh3bEbemDqDPERuu/UomaouxfxTWQ==
X-Gm-Gg: Acq92OEJTlqPAzG5v7Rr1OAzZ7kKGaDzGn63bx/PuSGHACiqv1qbCoF+0wMwRigO0WP
	KuZSvXvMSeNXx/Zsu/QXJ8DZUW8eEp0lt6EHMTqMCBR/Bp4cA0X28YoRVkCH26qnaqZBiHYpzYK
	w0HclDhiYMLji82PDdqZ2uzUqqPy4KANUUeHw3GHCdKC+HWi91MG4LndjN7OmXqKYTi2aNif/nO
	RICpISfgSQz4O0Xywkfzf0uM3O1QsNC27LMnjsw6/SlTlLv5cGmBzUUO6nL179r7lrRSCXjORVq
	8cBjIevdnoTxb3AWArts3+vs19HldE53oJqLuS1c7h+A5JjGcA8x4spsC3Wh0p5t0luD6Rmwdfi
	+NF2V1BnkQIO7c9MnrrNmW+mIEZwQDjgzD/lx3zl4p43qVHKTMS2rHUb5jCljv+WYVQZKzZWpNg
	jV2Sk4RW2Zfrafemegf8xHGsetZWu4PpqO4x5z3/3RU7uJOktwBkuLQz7p4pn3t1m9XuHHsVWuR
	XZ3hXb4wsm+dd5GNFZdrtg2ypB+yVqdg2Cv47GNPFFNgJSR2cgfesg=
X-Received: by 2002:ac8:7c4e:0:b0:50e:5cea:a519 with SMTP id d75a77b69052e-5165a002a69mr212185861cf.12.1779105565834;
        Mon, 18 May 2026 04:59:25 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm129593391cf.13.2026.05.18.04.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:59:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/2] libselinux: update pywrap targets for modern python builds
Date: Mon, 18 May 2026 07:57:42 -0400
Message-ID: <20260518115742.352949-2-stephen.smalley.work@gmail.com>
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
v3 drops pyproject.toml since it is unused currently.
My earlier attempt to convert setup.py to pyproject.toml failed.
Therefore, just leaving setup.py intact but updating the Makefiles
to invoke the modern python build module.

 libselinux/src/.gitignore | 1 +
 libselinux/src/Makefile   | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

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
-- 
2.54.0

