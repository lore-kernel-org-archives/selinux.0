Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049DD4E7800
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611110; cv=none; b=hpT8xMg0litxmZrknFw9izxSd/gtoxyb+cOUeki6l0/TOGefeOabR9hoHLE2qLsj8r0Cq45kaCLBWLxfBPRgHz9pE0IT2RSkghCK89wsnhkfcucqYj7kGXVjJGV0k1D8dxS93+ib49fmyT+4X1f1aHKHU1Qkw7NRqaN146Oz3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611110; c=relaxed/simple;
	bh=wO6VZZf11y3UEREWBLybkS1b53Fb9qjG6f3hiYR9Z14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPFwL7CCGS3PZtsxZgMWZzGmuZkt8+Kgk+gKYv5fJ8tE7+hGsYy9jvqoBfAXcmfY90kPTrUmqMM9d3+UkKBCI0q9hWmt2QHHyJT03STNAfbVy/AplLfX6ENc1uafu9EyMz+TiDDSIQnbGGIOcvWop8v8nfuiPWWS8aja+A9dRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tPWslyA5; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tPWslyA5"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611100;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWguEuC75eBVVSHmKPAvkIaBgYP979Pc9TV0yGSbdFA=;
	b=tPWslyA5YsFzj1vvqpDUNhY7arqW6gh1rrpDMA+/W2M8uRZWlaEbxRFFwXpp4tIFN1Br2o
	36cYzVnCT6guQAoBRBsLEfyc2VwnYaKeuKA7EOKBRdZiCfMD2EQwP32uRVm2ojKB/DGJRK
	yOuhHoPpUNN6Jata3P7Sw/riiDp8YnHM0SC+nw+4YjfFVTW53XtmMAFr/KbOzT9B/4hG7B
	xajHwapix7+ibRir7qO3mJX9buQL4w6ZKPoXgnv6nu9Gi0Wiyrb+Am9vDfPxe1rCHBuI7O
	MB5GkQoCocSjiW+qrFZ+oGbuviyeAqBaq0yB2o64BSk/cMbBxNXEVeTPoCyfiw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 04/21] tests: skip module_load tests without a kernel build directory
Date: Mon, 28 Sep 2026 17:57:35 +0200
Message-ID: <20260928155753.2259807-3-cgoettsche@seltendoof.de>
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

