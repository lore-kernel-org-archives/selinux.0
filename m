Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E13C0C
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041453; cv=none; b=QKfvS8THHDQnQHVU3GPvNEPmZ821K9Kvk6yCnHSZR7ONN8HpissHbYakaKUYaP7dlb15YeAXlrxkWycZxO/XxObpT07zH6x0GQS2oho0zeqBFmzupBy9z5dxvU5tWOVoHi/YshAnx4RJwHBy8yUGtsdl+LhIqAY1D/xiA9jO/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041453; c=relaxed/simple;
	bh=b1Poq+37feb+IZ0SgzJAj70yRx8a6Myx8LzK71/FtNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WbKslAWOBc9O606QXMUs3LPnIJbme08Wil4PgIrEhKtGz6AD1B9A0l0UHFkknIsuoZevuic/CNIIbymEQwH2sjoLZaSNoJEw3YJ9Rn+Mg9st6Zj3SMK7O23rd8RrsmU+jLTV0wxOvCKO+CY50kwQF74sHbPk2j7JxmnoFOG7Ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=T78Jiqsm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="T78Jiqsm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770041447;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=If1xYP2BZia5cKcNiJVP5Av82FvMdDEQ/xQ6Q2cTVUc=;
	b=T78Jiqsmft2jaiqmThHryXbAcs0cq3aQLk7m7dnB/+KSpxv37nyC0RWAM62RxGGvOtdd41
	Ql4RFpt3stEUMUG9AVa3jlbgeGwbdPh205/x5vGMMHa/Xdk4IJPpZ7XSNs7szWQ+IsgHri
	GzDqdwiIwfSxV4a+72Yfl8FShYHibm4bDtRMdVK/GhskexIDYTWkWF2z41h6hSPjkNMR1F
	/0JI7c8gLcw2LvOFa+EmXkPAzsYLqkP4Dmn1Qy1O4TPYvoVPIPv9DGjS9f4/56zK8gPVvg
	twqZRQRzCIkUVZ3sMN+cMNxrRMVadsp5Ds85yO02r1TYJLP8g40DUMNoDzw1aw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Helmut Grohne <helmut@subdivi.de>
Subject: [PATCH 2/2] tree-wide: build shared libraries with -fPIC
Date: Mon,  2 Feb 2026 15:10:42 +0100
Message-ID: <20260202141043.85962-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

When using LTO code can be generated at the linking stage.  Unless
passing -fPIC, this code is not position-independent as is required for
shared libraries.  This happens to work on most architectures but x32 by
chance.

Suggested-by: Helmut Grohne <helmut@subdivi.de>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile  | 4 ++--
 libsemanage/src/Makefile | 6 +++---
 libsepol/src/Makefile    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index a9bfe069..04f5b68a 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -161,14 +161,14 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lselinux $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 8e025112..f870dc68 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -83,17 +83,17 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsemanage $(PYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(PYLIBS)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ -L../../libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index bb2b7f5e..c222a8fd 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -58,7 +58,7 @@ $(LIBA):  $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS) $(LIBMAP)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(LOBJS) -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $(LOBJS) -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
2.51.0

