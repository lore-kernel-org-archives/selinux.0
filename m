Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E61A00D1
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334637; cv=none; b=iY/eQ8OJ00VI/OtZgFE5JkXq576JKikAM/NybYzI8K29AHfiWNi8nKjkUVyiVoq2DlzhacaZN1QtMtRrSbWFU2K7Kxd1vyo4Dx+zECzHmmJwKlYS5V96JvSug8hpxHFU4r6Jsz4bL1S6G/yjjUa6w/EObOMXK+n15Vsag8no5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334637; c=relaxed/simple;
	bh=BOPdcJiuEPcgtYZ3NOzt/A4/SNIg4wgXN1Vm9jE8Fuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3cyGGEAGuKnKfidXFxlYPaoSPl7M3N5JNJ58RV5Qv2UG+UYt3Lzllo4gobzVmGBNH8G7NXl9BO8rLZH0HgabO8SZ2VdeWa//Oq+1L/lxnzOm+1FrVHOXeGdR9CiYs/Sk2SEGRUgcZFFDCUYnov1MAJ2e2xad5yO3RvoH6hiHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=efnsnbtw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="efnsnbtw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334633;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAWpzf3I85PnY/2YCUidZkA5CsUaMlpsCcnjpGD5xFA=;
	b=efnsnbtwRBXDw2TNlk+DhLaz4oT+byeEYs52L/ujjSQkH+E1bmht3mIYPFpCWI5mT5tb6t
	RYNZ83Ig/7WRISKF1I3koJ5dtSuh0t7IQ+mQKgAi00e92KsffplLtitcQoQBLjA4BsVo1L
	FgqFY5HAK2OkyliawymrBEW0wPknpc1Zn7TH5IiDpbm/JpcR3iooaB+etqBOHWswfOWiLb
	Yd1fUYHWWn9WCQNoGdkEtDeetxkCQfzFxJ1+LnMJAtqp7TYW7p/b35ja5D2To315duby7d
	+ahFC0cap9z22vvwnnCkrwKo/1UqaZ1kA6hcKWrjd0AtfC39VRGJYiffFVNggg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 05/47] libsemanage: drop dead variable
Date: Mon, 11 Nov 2024 15:16:24 +0100
Message-ID: <20241111141706.38039-5-cgoettsche@seltendoof.de>
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

Reported by clang-analyzer:

    semanage_store.c:2206:9: warning: Although the value stored to 'retval' is used in the enclosing expression, the value is never actually read from 'retval' [deadcode.DeadStores]
                            if ((retval =
                                 ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 82c5a684..57295482 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2201,7 +2201,7 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out,
 int semanage_verify_modules(semanage_handle_t * sh,
 			    char **module_filenames, int num_modules)
 {
-	int i, retval;
+	int i;
 	semanage_conf_t *conf = sh->conf;
 	if (conf->mod_prog == NULL) {
 		return 0;
@@ -2210,8 +2210,7 @@ int semanage_verify_modules(semanage_handle_t * sh,
 		char *module = module_filenames[i];
 		external_prog_t *e;
 		for (e = conf->mod_prog; e != NULL; e = e->next) {
-			if ((retval =
-			     semanage_exec_prog(sh, e, module, "$<")) != 0) {
+			if (semanage_exec_prog(sh, e, module, "$<") != 0) {
 				return -1;
 			}
 		}
-- 
2.45.2

