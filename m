Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025413195F0
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781461442; cv=none; b=dfDnTPn2eFhCIrDDJVBYAniQJf/zGLp7vKqxzneRpMmk3WuaI2W+n/LuN8ymojON78rj3AlELkYdar5ufj4Ly34tLaot7I88msMUCTWHoMcRj0J7IjnKM6d/SmcSHm7++ZNxOs9jOUCH9g0cYqyBQS1gu8qBQ6zSR6CB5inFHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781461442; c=relaxed/simple;
	bh=PEXMdJfhhNjU5oJluzVM0WCQn/E0PIrZtuHdd7m9YIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/BnBZ93+T6fwtplVsUOMGLbF4P2ObxDV+uOSoWsFnKaNs+5xrqyw81c5WjrOPz/TeAdFxzZuKvi0kKTv2MGVDToSEh4vhjWc7b0ZmYg5Vgg6pRC+cKD/xoC3ak00W7YzZ3yGfGJKRJ9fT+r1lwZjMssVHeZ2qhJUpBwmvz4qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=ZQJhQqyN; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="ZQJhQqyN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNuIPOac30u5EOjqiYvVvwCYc259z4ZD3mQJ4TdOCsg=; b=ZQJhQqyNrAYkQgBhOqqLMCKYbY
	7rqcwZexlsBCuP9M04X9wP4pT3uuLd5C+CJPMtZPWJjK8a6ZN6ugM01ScmDrYoy27wG0gfAtCwvHu
	gMmr2uWcbWy8CA3xDIx+Ad1xJgukXEyFGiLkzJhvdhQ17evOAC2InOh9d53VoIVIwBzAcFfjSCBSF
	1r/Dea8sr2iqaeg40rHpjkk0sN1oWbyo6lpKuf05WrqYNtEm1tjIwUPLSIWE+i4MazmUureAKbyyR
	l6nRejufoY6+EEBicrD5fGB5KU5QRPSVhs/qydBvnn5db5xUyggqR61CUzSWVtgcPE+ITFq0EM++G
	R7xnkWTw==;
Received: from [87.95.76.183] (port=4449 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYpUy-0000000930F-3unr;
	Sun, 14 Jun 2026 21:23:57 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] sandbox: use bool instead of int
Date: Sun, 14 Jun 2026 21:23:53 +0300
Message-ID: <20260614182353.59521-1-kalevi@kolttonen.fi>
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
 sandbox/seunshare.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 58baa7ff..3fa42f9a 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -241,15 +241,15 @@ static int pin_dir(const char *dir, struct stat *st_out)
 
 /**
  * This function checks to see if the shell is known in /etc/shells.
- * If so, it returns 0. On error or illegal shell, it returns -1.
+ * If so, it returns true. On error or illegal shell, it returns false.
  */
-static int verify_shell(const char *shell_name)
+static bool verify_shell(const char *shell_name)
 {
-	int rc = -1;
+	bool found = false;
 	const char *buf;
 
 	if (!(shell_name && shell_name[0]))
-		return rc;
+		return found;
 
 	while ((buf = getusershell()) != NULL) {
 		/* ignore comments */
@@ -258,12 +258,12 @@ static int verify_shell(const char *shell_name)
 
 		/* check the shell skipping newline char */
 		if (!strcmp(shell_name, buf)) {
-			rc = 0;
+			found = true;
 			break;
 		}
 	}
 	endusershell();
-	return rc;
+	return found;
 }
 
 /**
@@ -802,7 +802,7 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	if (verify_shell(pwd->pw_shell) < 0) {
+	if (!verify_shell(pwd->pw_shell)) {
 		fprintf(stderr, _("Error: User shell is not valid\n"));
 		return -1;
 	}
-- 
2.54.0

