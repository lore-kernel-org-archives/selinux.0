Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F913F5BE6
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356727; cv=none; b=r7UOYqUsXN9iXxg2mOX88bE7s550Ij+LA6iWyDKGZRmcJD0Qvrr3d0WYUoaJzuiM8jQ7R0+8PZkhV8kRG6Hb3ZNjdha3/N+S/WarAZsHpq+EVBPFESdxoC17wnaKqMJ8Ha+Wlq8t/jlxs8S5EFfiVxTKH/4fAZvfvHCxTOyfqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356727; c=relaxed/simple;
	bh=wO6VZZf11y3UEREWBLybkS1b53Fb9qjG6f3hiYR9Z14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceTZDZ6yb6giz8+p8JwbBfYs1AUZywXUi3TkC/bZ29UvR7URK4Flui5dQZEZnvTI9MOSR1/cVatG+AHV7ql9wnfTnYpv+9tSkVoRhZoyb6OyyXXfzb2iYyAcohpm6/FiUDjYGMkMYqIoBdEwfJb5iBngDnKkmllmgxuM907eMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=px9U3Nn7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="px9U3Nn7"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356710;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWguEuC75eBVVSHmKPAvkIaBgYP979Pc9TV0yGSbdFA=;
	b=px9U3Nn78vO4rP8iKWM5JGqh6hil4GfL+P1V4AOm3PpiZBdfAOvDKTopm5FjkcPISaTXKC
	xm2/yc17NF/tOSFoUcsv/02lyOX5mMg17sQ+hW0QcXFGaCE4ll1kOCqM+WzIXnaakJ7njD
	gII/eAdA6LBDg3xY18X35oE22pqZIzUkwYaZ50JdCoCHD5UZkXFUt7qpYaBGG1GuYnPc1X
	B4llvuAuvYPFaC9bW8qxicSfUitHwaJGpGXrcC186QTt2/I47wKBHUEyaLEZQNIyMGTF1Q
	chvX6P8anvfK4tiIm4/8XuAkI9mvfAq8PpPzvYC1UD42J22E9E9CHfwc8WavRg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 04/21] tests: skip module_load tests without a kernel build directory
Date: Fri, 25 Sep 2026 19:17:36 +0200
Message-ID: <20260925171755.2029271-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

The module_load tests build kernel modules against
/lib/modules/$(uname -r)/build.  If the headers for the running kernel
are not installed, e.g. when testing a custom kernel, the build fails
and aborts the whole testsuite.

Skip the tests with a warning in that case, like other tests are skipped
if their requirements are not met.  Check for the Makefile within the
build directory, since distributions may ship the build symlink with the
kernel image and only install its target with the kernel headers.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 084c788..d1edd4d 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -102,7 +102,11 @@ endif
 
 ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
+ifneq ($(wildcard /lib/modules/$(shell uname -r)/build/Makefile),)
 SUBDIRS+=module_load
+else
+$(warning Skipping module_load tests: /lib/modules/$(shell uname -r)/build not found)
+endif
 endif
 endif
 
-- 
2.55.0

