Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDE37C903
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222153; cv=none; b=akeefccLpQ9tsqVTJ9sY8bmWCChUL8sbPWR+T9B6oMV6fHUPmv4/uphRF3+yxnPHT0bdRQkkie1ze6q8zt/4VFgaOLZLcK/T11JYKKMFNcCXXV8xUf9V6tOGJOZcAY1amgDYbFG+YVjL6t9aX2CnVDvwC6UHbHKHTtCEJdyjoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222153; c=relaxed/simple;
	bh=F198Lozrn2qWoBZySAOzQw3hVKn2H/13ad70nAeVpas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9or8mdMZ7Q5/psUBvoUfkYmEt90obu9qMLJY8kGCGpm9i1hjHeqzsjrfve08ZM7WHodv7cn+0fMrWFAkSxwBf7tUeejeF/AwHx1KRxuul+UXW/eKmMUqlSV6e6nDnj6JE4c6PKtqlTanbuYoGWN+rMuaeI1I8GzdvY/CLdV+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Adufc5CH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Adufc5CH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222149;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Lxa5kUvGLxyZi4jRljHOGw0wvNzXsBc4w5dRo72S5tk=;
	b=Adufc5CHuwJuxiOconv0SaLi4+uTLJhuIdxOMYJUJYq35U1F/x97GVSCbS7DwjnAAmC82z
	PDB39CK6KOa6D/JnaFBcqsvsg7A4gMQHQ6bkfwjjfkSGLDoUQwoLH1BPoYHKzt4SN04Y8d
	cJENUY/vdlazb3MqmlbOZidWeSaQU2exI+QkOoGaBQeOANEHO6jVPiH98K73WYTZaw1R7N
	mXiZj+KLfJHkXXdEh7qVlGQkikM9BChJGLJegW5CtOah9Ne07DbUQfln3ANzoauaTbfKtE
	+cBVL7BKmOC6l3+psESRe387D3ZtJyZM+kJbBgNGx5dWAQzSsiGhN669aJrRNA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 02/24] libselinux/utils: fix matchpathcon usage
Date: Tue, 23 Jun 2026 15:41:51 +0200
Message-ID: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

Add the supported -q flag to matchpathcon's usage string.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/matchpathcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index d8b9216c..ebf3c94d 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -13,7 +13,7 @@
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...\n",
+		"usage:  %s [-V] [-q] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...\n",
 		progname);
 	exit(1);
 }
-- 
2.53.0

