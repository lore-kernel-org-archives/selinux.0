Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EE390235
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781454212; cv=none; b=a9jv9iKKuW6UIPLxqdMNjnWv6Z0jSQYygPgy1xyqdELan/6knd/M/s9RWAmujHKUBiHMLUQhBnnGsmAb3JDOnNFcWboXjUzWuU+h83l0O8DhGRGA4bzR1zqjRfDeS//4T+WIC+k0L3Un84b121sYUPL2J+pxjhxchee+ZRbtRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781454212; c=relaxed/simple;
	bh=vPrs+yi5FEWfiXsztfs1v6d68ZoC4+5IkWKLvfZqSWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+92WflbY0PrRVQYgAmn84MiUtgp9/c3VEgMT22LxtN9eFufpdhB0yceQYgVYsdoaA0VfxmWVzk3bZo0MC+bm9vuPUMUnIaWR7kSktNdDK5E/mHutkY8gGtzHywT+bX6eg/x9aNgvmMx16/nRTrYOiogli2mHMd38PrjWApKThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=NKh/cAjW; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="NKh/cAjW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ko7wVVzqnZ+03V544yPkv3u8MLVtgO45LznEmDhjQK4=; b=NKh/cAjW4NtKCFxTP9XrMPS2pD
	/oIm+ZjJKwITwk90ukMUrNphq8DzVZvqfDwjH9E7MkjHXVOWJP7o4526AqYDTYLY++49xyAXwe/7i
	SrfR8w4xz3APZpTdDp5zhRRQNwiooIeWKD2MHmi2zdgkdCcvDElfWkGLH65WxVbKsVtD1cVCpgEMh
	Y4ExoZ5sj3DzuzYnzNirErATMvliyyefSZDLK67ZuxUga2HKfKD2Iqmh2pIIzfbECqXdHVioPzzze
	pULjJCZHATRWbE+befUJSE/yZ3RTAWbDx7dnc3u5gRsL8YKPrxsjFuFYLLr3cJuCSAFYvbgrJJ9yC
	lPF+Ah9g==;
Received: from [87.95.76.183] (port=4369 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYncN-00000008iZ6-474c;
	Sun, 14 Jun 2026 19:23:28 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] policycoreutils: use bool instead of int
Date: Sun, 14 Jun 2026 19:23:23 +0300
Message-ID: <20260614162323.18730-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 policycoreutils/newrole/newrole.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 19271c2a..8f75706e 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -55,6 +55,7 @@
 #error NAMESPACE_PRIV needs the USE_PAM option
 #endif
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h> /* for malloc(), realloc(), free() */
 #include <pwd.h> /* for getpwuid() */
@@ -390,11 +391,11 @@ static int authenticate_via_shadow_passwd(const char *uname)
 
 /**
  * This function checks to see if the shell is known in /etc/shells.
- * If so, it returns 1. On error or illegal shell, it returns 0.
+ * If so, it returns true. On error or illegal shell, it returns false.
  */
-static int verify_shell(const char *shell_name)
+static bool verify_shell(const char *shell_name)
 {
-	int found = 0;
+	bool found = false;
 	const char *buf;
 
 	if (!(shell_name && shell_name[0]))
@@ -407,7 +408,7 @@ static int verify_shell(const char *shell_name)
 
 		/* check the shell skipping newline char */
 		if (!strcmp(shell_name, buf)) {
-			found = 1;
+			found = true;
 			break;
 		}
 	}
@@ -457,7 +458,7 @@ static int extract_pw_data(struct passwd *pw_copy)
 		goto out_free;
 	}
 
-	if (verify_shell(pw->pw_shell) == 0) {
+	if (!verify_shell(pw->pw_shell)) {
 		fprintf(stderr, _("Error!  Shell is not valid.\n"));
 		goto out_free;
 	}
-- 
2.54.0

