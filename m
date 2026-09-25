Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165D41443A
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356738; cv=none; b=NooSorsTq55udIVhHbxVFEzAob7KZYimwqNfPPg48EKOEXetXBF8JJ3qGftAna441qDuYqEIdNTBi0DfwNTVPhJTTBnnqVBgZRUc4589gsmkxhr5/p2wBTxEuftmcb/47HWYhwSk8K0/CFvs/gtgazD7U17jiQ1YbKO/GBejV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356738; c=relaxed/simple;
	bh=etpd6S+4Kp+/PJqiI6M3mxDq9pZNOX1EWdjQX9fLw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj+6JbPFBnve6Vk01QLI4jwTG/WwnZbf+ZJ6010neuOxasiwz6ZamkAEmNC8QwyADx32vbJcPRlydFvNmYu8T0FnA+sskp6OPobdOS+Jf75uphQ0InCrtiIzM5pIWgYBraaheo2woSIteTPVTgUweLzSi2qgozn6yc64N3GiPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=m9isOwAz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="m9isOwAz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356711;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QWjS2mdqbmJOhDpwmo3JDPySFyVnZsTYeQVAZh0rJk=;
	b=m9isOwAzcm2lOVG/hI004NRBVC9ve2q2m/dOvuyBsKFD0U5lCNbfUnk6awgbFEDdbvOS8t
	NsERJBSCiy1StmDFgiYm3XHN0OSzudScqOyhXLu3JwVj+KhjzC8ZZxVp851yySv5dKH2WP
	92B81BhZP3qT1X0E1FOMIDzduzgk3e+LneixQMhNJPfXcKR2nBP7f07WkH1NL99QTVh5Dz
	0DGPVnavfMgu7f5PuyUPokSUBGQWimYYFZTASgimNcCDbRG+oorJaN87ZYC+07YO2MrnRa
	VR0z3KEtSa1CCVDXMHnDUgjir+xsG2Yupfd+a/t2qT/HhzG30PX+v4zKAFnHjQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 08/21] Makefile: use $(MAKE) to pass options
Date: Fri, 25 Sep 2026 19:17:40 +0200
Message-ID: <20260925171755.2029271-7-cgoettsche@seltendoof.de>
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

