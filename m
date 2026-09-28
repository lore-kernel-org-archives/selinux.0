Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE24E77FF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611114; cv=none; b=RNFGyAN0lFmLwWwsJg7sDD6FXMzmEOghFuWJvxdnAq74p87a2WP88SYql1C9JZ7FnufOTGD8r6Xfyyugai8DsxnvkuCwLC7LkmjF+NW7XVCFI7tvfDjeuFV9i47K/0zyT+sAgYqLwezaziiYsNekMGEJ5To9SleddmVnqMJxX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611114; c=relaxed/simple;
	bh=etpd6S+4Kp+/PJqiI6M3mxDq9pZNOX1EWdjQX9fLw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsG0zgIJxXq/8zxB7tX9aJONUgCV47rJn1vrMQA1g3hWOEOP4ecWeCRipA3cFJq92aXvbOIi1d3ObaW0v3rswFsC6nBHrDgMkTH9oekWdxmisTQDjJbvKDvKbako/9EQTypsvy8DQFHXhjzjMXzQaaxl+X0vgB9SoujvIP1RZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=C1E12toE; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="C1E12toE"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611101;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QWjS2mdqbmJOhDpwmo3JDPySFyVnZsTYeQVAZh0rJk=;
	b=C1E12toESKHSYsgT3Wr/w7xU8I9SxRwygUrM5hG3TJ3814YSLrVQpirZmXdRY4bW8juPwe
	Vk4Bt2thFChtNJEj5BShiG22W1e4L7yszrioMvY9V74MC8tfdAmVNFwUK00vHC+ZdTqtuI
	RwpNWCujytzQK2+ddpmZ4ObQBapzWZa/1NZ/6T+51d/5pKUPKEUy8uKct8L6s0BBFRAkzx
	C7XFo3qcqjznIRu5dTHBQlaoKN9NKU55rCaqOmyeUtWTRKZL4WtO6Up2mCfo6Aeetbj7oa
	k4x9MlDtfLXNikZJHtF1T6FdxKbRSeA6hzgyU23HYqV7UVT+fkf4n70msGVVxA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 08/21] Makefile: use $(MAKE) to pass options
Date: Mon, 28 Sep 2026 17:57:39 +0200
Message-ID: <20260928155753.2259807-7-cgoettsche@seltendoof.de>
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

Pass make options, e.g. number of jobs, which allows to build multiple
test executables in a single sub-directory in parallel.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9081406..8d6227a 100644
--- a/Makefile
+++ b/Makefile
@@ -4,14 +4,12 @@ all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all ; done
 
 test:
-	make -C policy load
-	make -C tests test
-	make -C policy unload
+	$(MAKE) -C policy load
+	$(MAKE) -C tests test
+	$(MAKE) -C policy unload
 
 check-syntax:
 	@./tools/check-syntax
 
 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
-
-
-- 
2.55.0

