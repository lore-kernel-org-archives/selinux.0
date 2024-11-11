Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F51A073F
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=T+eh/iDM5xSC74mMmb5CFXRGcylf7/l3Nm/w09euK4GNojEYlgRrukGI7l88cWgcr6q8Uo1kC6rthcxKlpBZwUOBSDVDyOFG6qn/tE+Q5ULs4LgPTOR6saGGxwDDA1KkNzFyIId6REBjXpE/xS8SCnPcvDwztR9/5rt6yoXrwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=RcIq0lH04/oh7lll7PFZKiM06kjROEW4eS1nLWwhCmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdvpkmURklfC8AhXtBo5ZplChLfMxcL3bhTp3SLsNubYmQPTm+bfWo7SxebdbJuMVIiuAfVXlUsl51RU/zt+hhgbD7bOgJFhsVeb9koczpbIr5m7kL6dDlPfJdSPyM6uO5yMh0tHf2xNdRLEbiI02UCQryGCYhXozq+pWmSN+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HpoChdG4; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HpoChdG4"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p76SP1HW9r3xchycI0IfrEVrF+BxcE4KDvSV9oxdi5o=;
	b=HpoChdG4srF8wPqFRPamdQYk5IxQc3BTpTXTAxKVgus3lwHc4lAuUsgZZnt/R2y0jUTq1p
	eTUQ+Kw7E7wn8Phwmo13n3xc3lJTgb3bw7aqC+0iCftY6hzlPh5s72rFKcahtXUGDWWGB6
	Oet394blnIhXeGXLzIrWcAEmQvAFen//WrJMYl/D9L7Hba5/3e2wjZJAZKVh7w78og+8oV
	RncaU/FSq5BJ9ntbDk+549uqCIkp+kyDGr4AppGrY8SzYA3Axtolf9cV7bcDJmjD9TTxtj
	n6yjhF5uKUgfRSlnJlPal7LftB1nBPMOf6u0205nXxUI4mZWU+mISK9BZGMTeg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 28/47] libsemanage: simplify loop exit
Date: Mon, 11 Nov 2024 15:16:47 +0100
Message-ID: <20241111141706.38039-28-cgoettsche@seltendoof.de>
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

Simplify the loop condition and make the loop exit more explicit to
avoid static analyzers reporting a potential uninitialized variable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index cb5bc149..c84ca43b 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -738,13 +738,14 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 		goto out;
 	}
 	umask(mask);
-	while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
+	while ((amount_read = read(in, buf, sizeof(buf))) > 0) {
 		if (write_full(out, buf, amount_read) == -1) {
 			if (errno)
 				errsv = errno;
 			else
 				errsv = EIO;
 			retval = -1;
+			break;
 		}
 	}
 	if (amount_read < 0) {
-- 
2.45.2

