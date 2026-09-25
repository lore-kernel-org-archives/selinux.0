Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18F415F31
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356735; cv=none; b=VmtZ4sLfHz74QTmW/O13kwgXcQqw4JZVxQe9EfgzwIGLVBgHRZm4MfJLpJSKWzSSAlnYGqfyVbgr0vVV0ZKo+Kvz6gW+1/TBnb1vn73XlTwnYt8geNWUXf4gwTZwz4lzAvDr3KXPJUNiSkPDVJyisI5ir19903L0qtUMIXx3LU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356735; c=relaxed/simple;
	bh=ry9teIAgvCwZWkzK0IrOGVZo4jvbVT+04sKUxFGqnwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E984Hb0GcOWAQtCAqJbyFopJINgNCGz4hYFNWBHauvdav5DbNXsbUvTh+vkF8z6KC7sPL9hqV+D6Am++JOiQX+HMJFD94wFZvl0Xc+Tls3AcBQTfvr+srDfIicu4kzO5gnkLZorc84yn3PygnT48faW1eXz1RkuGNvA9mW+1Fo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VcgF3QeG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VcgF3QeG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356713;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT/vmsxR8Iua2B0tZjNlQTL1dqNfg+cvZzgwrMfDyRM=;
	b=VcgF3QeGGvsXgQfEmDYvT50tLCG7wwwzO5EuDJd2Xx44Oev7ZvfA5AsR3EjVi2QgSUciol
	gfeYIPpAzJFG4Ps9uBt7zQcT1E/UoTMA7aUAQ7OfW8M+cX1NiHwdPdZSVkqCqcGnPLlVV2
	vQCV+2FHBBMwSreyX+DeQTbKmxQpvcYZmXCh5SpNcNWmCm3LucHofyTdUSg/CkeEgiV/Kb
	QT5ZmxmJoxiJ20Mi8MzM7NY2xyduK6wcjZ69EwDU1cpifCH31+T9gBPef+IwxegKcqVNi5
	NDZf6kLqACymhj51bWELJj+drF3RZ6NiR+UwnRxx+vFZppc6IX99q4NjTJZ7KQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 12/21] Makefile: add PHONY targets
Date: Fri, 25 Sep 2026 19:17:44 +0200
Message-ID: <20260925171755.2029271-11-cgoettsche@seltendoof.de>
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
index 2d098ce..012199a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -212,6 +212,8 @@ export M4PARAM += -Dio_uring_allowed_defined
 endif
 endif
 
+.PHONY: all build clean expand_check load unload
+
 all: build
 
 expand_check:
-- 
2.55.0

