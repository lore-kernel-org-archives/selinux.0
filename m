Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3719F113
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334640; cv=none; b=TTF9ZlriqUBKOlxGn6+5L0Mk86rPVLH2otYJL/eUwUQu3A4NABReQVq/XT21663B6vpfgfbVSnpCkpZpfh2ADxQT2/fYsxgNmZDcdtYM9u6YbQCaDiH2SWS7XhRUoCFU2I9eHUNtkFmO4caJg85Lgbwco6WfB2rw0qgSJGzjj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334640; c=relaxed/simple;
	bh=u65SspZ9dlDGHOuo+pxrh/Gtaq0XL3CSP8/xV+ceuiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1GfyMu+sBoNKGNSlaCIdL8LSWI/KQfWAju5LtbcnXsjPksLU1/3ybppuolAv9nGiwtx0T/Zs9h964E9pLm+KdA4bBGfprRVnYNnO619it5Y1ZU9wvXu6ljPJ7aPhcPm9Lf2he8tHwGXoZ8x4myS5HG03onr4kvT9aEVLW7wNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=D7o/vXDw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="D7o/vXDw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334634;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S30nL3g6+5cD4/G2Aa3/tEF2FB5Xy/D6M99N65p6sGk=;
	b=D7o/vXDwn3hqPwmulxnhkshv3EpaKGAS2+73RuuSkQcE2mj+bVaM8SrWcZQN9snuPTUPBG
	+hvQF9FhFcoP5U9CzRmfxeB5tRWcilZ7P+2GMwSqZykpl6ahhWdxxPVnl5ga2sBfPsV41X
	uLc3+E5HPP9Xq23AIYAK4GKj4kjVGSjZjNbFbVPlVChjimiHaX45EAh6WfZmVBYo1buvyf
	BS+TOJKHai7VCzIDje21AZdVW+TiR3qv2m3TdCHLgECcVh2TkzzaF4eIpZlffDDAnxSKYK
	8n/GNtqXL4eMPI1X18wWhA6ui6Hsbo5IumXRG7FtP9loyLA20k41GBJ8CoxJ7g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 11/47] libsemanage: check memory allocations
Date: Mon, 11 Nov 2024 15:16:30 +0100
Message-ID: <20241111141706.38039-11-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/conf-parse.y | 6 ++++++
 libsemanage/src/handle.c     | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 9e58345a..9c806fdd 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -369,6 +369,12 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->save_previous = 0;
 	conf->save_linked = 0;
 
+	if (!conf->store_path ||
+	    !conf->store_root_path ||
+	    !conf->compiler_directory_path) {
+		return -1;
+	}
+
 	if ((conf->load_policy =
 	     calloc(1, sizeof(*(current_conf->load_policy)))) == NULL) {
 		return -1;
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index d5baa614..f048f6d7 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -45,6 +45,8 @@ int semanage_set_root(const char *root)
 {
 	free(private_semanage_root);
 	private_semanage_root = strdup(root);
+	if (!private_semanage_root)
+		return -1;
 	return 0;
 }
 
-- 
2.45.2

