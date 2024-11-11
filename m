Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8861A0BC5
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334649; cv=none; b=PGVziP03/MAkR0VXRPRj4v9lWddpLI3DJzsg/AOX4cF3BBl2AEwx92s8BHgVoU9WhcKTT386AhutHEvhX5HFBCdEYiIsI7OXdeHe2thJdkcYHKwwPFz4ggUBaJjR8yK50CtGSO1Kse6PZMgy6vhfwWEgD5jHBoycJXIhQ8g+6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334649; c=relaxed/simple;
	bh=/Dh1leDHEVHyp6q17kdlvhUV80PCWSmPRvNlgnVZdtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgLV98uoREK3MCgibxXmvfrkDNlXboM237nVJSCrn0bfYo3iFVzFhJ4bKp4SBILAw2Q3iMk5eaOkNMsEyjajLsbmNQKkh/6JHVWPM7KRed5SLCd4JzbF89C+Y85dnWy7VdPgAbqW43YKyJ055zwuJGRD5OA/nw0wQlkVIOST/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=FiPpzEcy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="FiPpzEcy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334640;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYk4joFJW3ReicczbIQFVSseJYMsqWheTn/zNr7qYBo=;
	b=FiPpzEcyG1eWXjWrYcyycviHSvfQ1MzZodn1cl4+HyVdg0Bod75446wvHjHpjxpdwf39dH
	XGNIDJNv0J96cW27c7n+68Fhw7DK5mwgoQdWezxS2IYrnpxgL2jF9JNJ9IcathpPOnXooH
	ZqvL9SDebhNI2IgxBDkd7DUf6nKEofofs8PPnkOkOaE1/DgtZk/uVq1cjqLJwOHaxLtXKN
	2zRvBMCYyZVf30e/4D/7BO0IW/dMkO3ElqZCYhIe41oDAcCVGG54KKxlxxbuN+BtvKtrJC
	W5SxP0BLZ/WQEnvFga5olOIGS54+0/+w1QnPQ2jha8NiQ5ItAUI54W05bZ1liQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 43/47] libsemanage: optimize policy by default
Date: Mon, 11 Nov 2024 15:17:02 +0100
Message-ID: <20241111141706.38039-43-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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
index e6e8e27a..7ac45c96 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -124,7 +124,7 @@ In order to compile the original HLL file into CIL, the same HLL file will need
 .TP
 .B optimize-policy
 When set to "true", the kernel policy will be optimized upon rebuilds.
-It can be set to either "true" or "false" and by default it is set to "false".
+It can be set to either "true" or "false" and by default it is set to "true".
 
 .SH "SEE ALSO"
 .TP
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 83aa3402..43179b9d 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -384,7 +384,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->bzip_small = 0;
 	conf->ignore_module_cache = 0;
 	conf->remove_hll = 0;
-	conf->optimize_policy = 0;
+	conf->optimize_policy = 1;
 
 	conf->save_previous = 0;
 	conf->save_linked = 0;
-- 
2.45.2

