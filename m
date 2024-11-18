Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4E1AA1F1
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942196; cv=none; b=YeaZJhzZFfMCZee+P/hN1p2E6+kuAis9rcGQdenQ1szT2d6HIleNWN4iSflQax0sQGeig9L2cxy3wOnLn32M2oL0khf5MrkxWuQINlrJE3FuNzTiV4Sf4IxWXoIYDlaEQypSU7b6UmTHTvcMNGwzd6BpaafofdqRBK/0y7Gipn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942196; c=relaxed/simple;
	bh=NS31cr+XCMW1l/BVFvCHs5GwAF5P1rbc5ecIMTkhG3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc01l+YeznkA+b00jwLc721OS7P6TEp/9OY58ydn5E0LbcsMAd2767zmrYbqjcyzGxbHpRZdQrukwmFK8RejDcU4z/DjXzaD+t+j/KmHSpHTS+nFEwnfaiyMxCADZjH1i8pyg0rhGnS2ElXdND6vBqzN74qPXtYKfxWz0e8EieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=YVfyh8DN; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="YVfyh8DN"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SytQII04nwCFARVvVaX0uxulCLDGBoMaUqNq51rHoiA=;
	b=YVfyh8DNHkKVnGlSGkYB938nrvEnIYT2zLXVpHfGFYQie4rb3plnHR5GUV8ofcNXTN+7/t
	vEnD0ozDBbij7PMnqR2MtPfLSb4MYIJ7VV9MvzWVf8MDua2olhMTG2cFo8ZGcuFjKL1Ivd
	eXaInOs6ipBnol61xK8KhgXvLmuqJQPxPTWfD66xJ8Wi1ngzGN3QuMwzPoRrBTlpR4ypVc
	gcx2i4xLd43tjd1TX3Q8b6DK4XC6yXPCfpY77bv4j8+ORcW9XRXBfeGJG5ctUWosnhBkbQ
	opTre3juUHV3swqskOHEmKNNqnJCGq6iS/YaWSH0Mh/PCYK/9QqPJtmrrwYe0Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 06/17] Makefile: add PHONY targets
Date: Mon, 18 Nov 2024 16:02:28 +0100
Message-ID: <20241118150256.135432-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
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
 Makefile        | 2 ++
 policy/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 8d6227a..fc58613 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,7 @@
 SUBDIRS = policy tests 
 
+.PHONY: all test check-syntax clean
+
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all ; done
 
diff --git a/policy/Makefile b/policy/Makefile
index 32d7ede..a525b0e 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -175,6 +175,8 @@ ifeq ($(shell grep -q user_namespace $(POLDEV)/include/support/all_perms.spt &&
 export M4PARAM += -Duser_namespace_defined
 endif
 
+.PHONY: all expand_check build load unload clean
+
 all: build
 
 expand_check:
-- 
2.45.2

