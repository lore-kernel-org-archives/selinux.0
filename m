Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDF4E8DF0
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611118; cv=none; b=IK1mcvg25g4TkTnYB/MeGMfZqGxyrOy4eqFUSDJk4WZxMnYT1lZnDeFX7r6qly1mkX2MhHrNbQomw4n7q5TumAefJkCaLOHbQFojHF18DDuBxqhkDDzfgGPHPaHQj5uDVEJxmD9TjO7fO/je73JstBNQJ8nhWVIk6zSxT3bDLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611118; c=relaxed/simple;
	bh=5U1JE9hxvbhXcZLPxTGXNlL0ISKh2HZq/1uxLU38C5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/P22Jm4KwfDBzHtzm4/C2Kk0rNy+/rbNRU9C2eehWJfPMuULaTBuXSWpxHXXEGHpzTmufArlxHLXiEbkSyke7cqNMcw4um8KJ45PpsxguJUBiXZedXHCtUYYaa7hfP93J32A6xXXkfMjgM8dxpzX7kHnxbEllyYKXBFZHHLpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BufeqC8C; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BufeqC8C"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611105;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Uj011AcSW1R8cpLv3PvgdsDIEP5zOaOJbSTLtJRVYE=;
	b=BufeqC8COoreKDxK9KTIyOn+IlmxXO5Vyelfo0z8G1gJg6OEPs4K1wi/2bufD+zO/2kLKz
	Oz/TdKtk0WgzZ/MOB6a3giMeDGp8LY3ZAYhxATXQTmwmkyb7+w9h7cq4yXO75o7Gyl/hGm
	1D5daZdSig+kZ3XP37zwH8LX4HNcecBOZrPduIaLPGG4wB0YDzRZhxvaZUisMi3SEag2L/
	JeDLEV4l1q8/XMPrNtuIBnyvx40EOx7zs4bqHx//pa3kOL73FiwZ9o25ggpPvljA6bmqsy
	h5vIGt2ntuUwujS0Dd1WaPTEJTV97U42vEvyBBMo8Bb1mJNf1ifdQjNtE8fNEQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 01/21] policy: allow io_uring allowed in the io_uring test domains
Date: Mon, 28 Sep 2026 17:57:53 +0200
Message-ID: <20260928155753.2259807-21-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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

Since Linux 6.15, io_uring_setup(2) is subject to the SELinux
io_uring allowed permission, checked on the calling domain against
itself (kernel commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks
for io_uring_setup()")).  Policies that define this permission, e.g.
Reference Policy since commit d4084b9fa ("Add new kernel security class
memfd_file and new kernel permissions"), do not grant it to the io_uring
test domains, which only get the minimal testsuite domain rules.

io_uring_queue_init_params() then fails with EACCES, so the positive
io_uring tests fail and the negative ones pass without ever reaching the
check they are meant to exercise:

  avc:  denied  { allowed } for  pid=3493 comm="iouring"
    scontext=unconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
    tcontext=unconfined_u:unconfined_r:test_io_uring_t:s0-s0:c0.c1023
    tclass=io_uring permissive=0

Grant the permission in the common io_uring test domain definition if
the policy defines it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policy/Makefile         | 3 +++
 policy/test_io_uring.te | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/policy/Makefile b/policy/Makefile
index bf1ea76..2d098ce 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -207,6 +207,9 @@ endif
 
 ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_io_uring.te
+ifeq ($(shell grep -q all_io_uring_perms.*allowed $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM += -Dio_uring_allowed_defined
+endif
 endif
 
 all: build
diff --git a/policy/test_io_uring.te b/policy/test_io_uring.te
index ad12846..4b8a1f7 100644
--- a/policy/test_io_uring.te
+++ b/policy/test_io_uring.te
@@ -36,6 +36,12 @@ testsuite_domain_type_minimal($1_t)
 #
 allow $1_t self:process fork;
 
+#
+# Allow io_uring_setup(2), which the kernel checks against the
+# io_uring allowed permission if the policy defines it.
+#
+ifdef(`io_uring_allowed_defined', `allow $1_t self:io_uring allowed;')
+
 #
 # Define a per-domain type for any io_uring anon inodes created
 # by this domain. We use per-domain types so we can distinguish
-- 
2.55.0

