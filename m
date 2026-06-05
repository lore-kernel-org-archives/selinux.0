Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377A34751F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680147; cv=none; b=nsl47q3Lc8SL5RG+4s002yKVpGpiin7XR91BDidbLyVrNCkPcfoiHYJy3X0DlxarxKtQnsxRA+ShpWYavayX9yT9Z6Lys65TypAH9oKH+Q49Mmn+UvePrl7/kkpVgl790mEX9CIZTzCj8Ort2H58Y1C0KgzM8CqATQCfUd9UHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680147; c=relaxed/simple;
	bh=NFqGPLN+zWppPDDX9MClF57JMKUgOa4Mla+G6+kW4cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCw6tMEci5haSA1qvqLc7aoZ0k4ZHFWOPTbE8xyGvPCWX/K1bNKH/yW967p5uhuimJK+EMiExb4wSYWyRhStafGKYTwpciNPn3m0Udp7SpTfwKavlN9fPQWZFbXVty2Dbmd5oS6ahvnBkzeQCwJ55fmGH6JtxVqCyLT/rQJcVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=PAwf+EPT; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="PAwf+EPT"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680144;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ba/+IYbTYMmwMdR4qCWjX/47YwlMBQ77S/3AGTfQLFQ=;
	b=PAwf+EPTTjmYcjC/XHAeO+8Zra3imR0+6U8V2n++qUTkXtOE0fsTa5lwLW9G4EJvqALKAN
	9cuwDXEuPXKPHNnODoPxFgdMwFuLbn6yOG4NTgxYlDi9Nk+l5a+6eO++wqLnNStSRQkV2a
	BeWdI9OU+75ZaVf/Yxks1ubA1ZN8NNbMqjMKRkOUPtjW2S5HWvKLsDtMUFAUjoisFSHhpu
	mZTMiHiLeROvaHYukISBPR/IAwZfiDcg2tmGLVFQjvyo1kxngjsf7rZP5XXpwb1IT+IrdB
	MUkPDAUd1AwPfG8vJBEAyQ3yLqj/B/ZepCSLPzfxUr0Thv7S8MMiG72awhdetg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 06/11] restorecond: declare local variables static
Date: Fri,  5 Jun 2026 19:22:01 +0200
Message-ID: <20260605172207.222382-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

Variables that are only used inside a translation unit can be declared
static.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 restorecond/restore.c | 2 +-
 restorecond/watch.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/restorecond/restore.c b/restorecond/restore.c
index c8437f4e..622de773 100644
--- a/restorecond/restore.c
+++ b/restorecond/restore.c
@@ -10,7 +10,7 @@
 #endif
 
 char **exclude_list;
-int exclude_count;
+static int exclude_count;
 
 void restore_init(struct restore_opts *opts)
 {
diff --git a/restorecond/watch.c b/restorecond/watch.c
index 41497f49..8e1c36fe 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -40,7 +40,7 @@ struct watchList {
 	char *dir;
 	struct stringsList *files;
 };
-struct watchList *firstDir = NULL;
+static struct watchList *firstDir = NULL;
 
 int watch_list_isempty(void)
 {
-- 
2.53.0

