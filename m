Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46124195808
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533531; cv=none; b=OPN5rkZ1wgBywDou1sCjPyWr1nmpmfLPtzwwi80wsEpjWv5ExJbI9KIIdUHLd1qnt+RnzFKOuJROL53PINjqsqLKzqb7Hr+IxZQK4Y/eey7kYZn0rmvfQCy/jOK3BJ50pj4V4p4ohtPqy8o7aWEfjDtA0ZZxvGwJKGO8aXVqIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533531; c=relaxed/simple;
	bh=36WYOF0H4CMtHQtx6IaL8VqVlDcO/pQKsg9kLPerpeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4idTnks/b75WuS++VrtK0ZmWk6WDjmKy9w0o75Ep0NN9Kl2mvi7IUcQm4czqljUmYCiqkj2l43APXFLMMrhgWWru5ZG2sb2IPHIcRiBWPiZM4ayWfzW51XKApWVPBxkplNqvubC4aLwnVfzVTkWReTy0FSxFLpva6XkD7vXOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rJm4eRuZ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rJm4eRuZ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i30zIH1O4GFPwcYg0VAF4ZW1BbA30M2gT0zRaeJY7sI=;
	b=rJm4eRuZ1fQIERkOPos8bBe7xVC+VMuRXOAu6Qlk90aXzNtguLNxs7eYTgwRBPbVcnyeOX
	MhWd4/zJW51zYzFT1S+87J5sfPrDPlTDW7dVvRSgrM7pWlObI8gvHS+XFc5dhL9f+JoomI
	es/T9OlvznS36Fi9f23OAy4WRKd8sW2PtDU3uXMaIq/ZekP5Kim7G3fMrDRSsIr6eYDVAM
	g+gwB5TbM8nfunYVCrIXDYe0iWb/frBQPw8qDLuUVL6YBt9fKDE7agxghb1HGbEZC94Cr/
	QkW/oigYeq6fgPicZiT8y1l9c4JEk1pBZ+Os8r4Ch4T3f1PJvLtfETXWTY3B5g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 7/9] libsemanage: optimize policy by default
Date: Mon, 25 Nov 2024 12:18:38 +0100
Message-ID: <20241125111840.63845-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-1-cgoettsche@seltendoof.de>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
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

Fedora is setting optimize-policy to 1 by default, and there seem to be
no bugs related to policy optimizations so far.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/man/man5/semanage.conf.5 | 2 +-
 libsemanage/src/conf-parse.y         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 140cb8d9..6a1afc13 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -124,7 +124,7 @@ In order to compile the original HLL file into CIL, the same HLL file will need
 .TP
 .B optimize-policy
 When set to "true", the kernel policy will be optimized upon rebuilds.
-It can be set to either "true" or "false" and by default it is set to "false".
+It can be set to either "true" or "false" and by default it is set to "true".
 
 .TP
 .B multiple-decls
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index b2b84892..6cb8a598 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -396,7 +396,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->bzip_small = 0;
 	conf->ignore_module_cache = 0;
 	conf->remove_hll = 0;
-	conf->optimize_policy = 0;
+	conf->optimize_policy = 1;
 	conf->multiple_decls = 1;
 
 	conf->save_previous = 0;
-- 
2.45.2

