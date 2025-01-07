Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BF1F0E43
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257586; cv=none; b=e1UOXyao3tTl4A5xeHg8fi4G8HEEPG7ZAqIP3Qk0+/iUJ5lk/Gjp+9xfcn7DuSTArLIeHrE2gv51XkZUx4uv/QcIUiL9PUAF5rq3XnuHP7dRHHaTXgnOHnCqSOGEjN6kTVBfJJUfZPDuvY1ma2PTNySqwDV/jizfoDZubTx9cfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257586; c=relaxed/simple;
	bh=rw5R5oU0qT2z/xmksjtb1BTirnP+nUPvfpX9Er6B0YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi9QUPXHXevBNpZnSIiQSAsGN6O/vHOxNPviOURoU5YqxTJBZfwRpGCIU6swDn+z9cC1LdiLrhOpUI7O0SEZ8cbVCvFBDvCkZodo50YwDcZKH5U4O4Z2ENn5zdG0+2Y6dQCmqcGfgNNis4BRFdFpWNlTJOUC8CdtRD6nchDtByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tVcPwNdv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tVcPwNdv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257573;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi/235JYB91dcyL49hlDzmgO/JK3puf4HGqKcrKnWRQ=;
	b=tVcPwNdvU3U8+rh0cWrVT8T3tWZRDWML0PyybPM5h7NMdXj0Vtvx8Cq0CXV3VXfdNiy3rJ
	U0R6/+IbkX8Ci9+rJ6QCV2KzzZWip9jhVjyajKENflzWY1oY26H72p7Ml36YLE8ZWTkvM0
	DJkeQp0s1Wglci1riN+gOXb2szsKBK+R80dHGPsTtmFd7sTo9or7VnZJ/qq92y4w0o3R/O
	0IMcr1HGLsszZuk55RZvH1U9tXTzqIuN3exdg9F0pghy4FHNp372GRUxFYWqOZva86EkyA
	YP+aU0MJrQmn+PPoNHMv2vx1YwApxlyyskhySyEvp9Ju7dzKfsYU3AgmLLI1nA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 06/17] Makefile: add PHONY targets
Date: Tue,  7 Jan 2025 14:45:54 +0100
Message-ID: <20250107134606.37260-6-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: order targets alphabetically
---
 Makefile        | 2 ++
 policy/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 8d6227a..ecde287 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,7 @@
 SUBDIRS = policy tests 
 
+.PHONY: all check-syntax clean test
+
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all ; done
 
diff --git a/policy/Makefile b/policy/Makefile
index 46e51f3..2896aee 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -180,6 +180,8 @@ ifeq ($(shell [ $(POL_VERS) -ge 34 -a $(MAX_KERNEL_POLICY) -ge 34 ] && echo true
 TARGETS += test_ioctl_cond_xperms.te
 endif
 
+.PHONY: all build clean expand_check load unload
+
 all: build
 
 expand_check:
-- 
2.47.1

