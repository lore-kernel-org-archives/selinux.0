Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABA4E9C09
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611114; cv=none; b=madDDYlIHla72DGX585sFAr1h7wXjpecoMilYgm1mdkIZ+1xFWyR7VQMDmZGsrVpe6BZHodkkWDUobnq9iueaGmAazSMop56EqvjO+/doklGnV3gzXLoesMunbQiJB/VKSL+CqTAmvboksdzf04qQmnLxsqyIwW5UNeDUwWBAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611114; c=relaxed/simple;
	bh=K4mC6iSZXenoqcWDMXVlj0dBSgP+5bwRIDpjyt2PkWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGDbJqXHb5TEe9RrW4zfTh04R08IAspJK9iD9cRbFxIfCHT3T/Ovn0kJ/s0tBvfppJEKfyvoWv8YEtOucquTdesieHZwM7D2yewNITVJDLU7BHY+D1RJpR7ZtP0dpnT06R164lkI6UiSE2gXxJ8xiWtqhb5onBODe3nxqKxkOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=s7z+3xYH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="s7z+3xYH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611102;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmTkzfxsruxDsaM1vuGf0/6b+TR1QmAwjlDSC301ISE=;
	b=s7z+3xYHWaaxIqTu2sPcXJVmWKIjf+2rI9QxHUnmkqgWGbJU30aOzghy+ROVPDchzG7sPC
	qylsy884BmpFF5KQqSTBo+D61upB23gtY6bO/jBGVqkrmHHlOgeyuu1h7vXSfPz6Iwkkj/
	ZK9f2sT3Mq6j0Z7pGgJJQVFGDFC8WfL3NBllQpNzNVuNyTsVR/Lqo9qpdly67YinqnoALj
	tEQe8aNtBjRRhI4BnWFcc7Ko0yj3fK+P2gkxinWhC81ygFm7LrevmEMkEnb2HdF5yjcF40
	vPyk+HCHDUNRwyMVL13Icv/VIg+rq+D9HTwZXFM5ZWhXad7J4hHwhCwDY9MDjA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 12/21] Makefile: add PHONY targets
Date: Mon, 28 Sep 2026 17:57:43 +0200
Message-ID: <20260928155753.2259807-11-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
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

