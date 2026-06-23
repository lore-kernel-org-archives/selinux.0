Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8F37C929
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222155; cv=none; b=dLRDWBfhQiCRhYpWSKGGHT9/CpNZvjeC/mDQGzCJhltp1s3Yyp4ZtQRWsvgx+DYreHhbSLUo3lD24ul6WCUUJO+qag3ChCNot1nEAB8WvBlqF4oPKTCDVnzFwr4Gom1HOvxnImw58Rc3RsNJQgGpvtGbAPlbsVcROLGxDvQ9xPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222155; c=relaxed/simple;
	bh=le2+Xdu+2c8u9b/38TyXKr5L7szWKZAfCsffNupl39U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecizslgF+17anJFTvSjrvCbqdJ9DZODxKVo3WyjVFGGpQklDrGE+aOycjY+YNnE6HT+sEemdVRQZeW57Vn7B2hBdn3gpnIfUCRrNRCWQ+J8VMBDb4FITMl0ArRj9atKSgGglN4w8Hqb4RC/2U4xt7avKYWeAqdJ55Iz/LNbIIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TInphNWo; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TInphNWo"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222151;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhcEjKPQuAyi/6QJV464Es1lsQD3CDngcaO2kZ+Mde8=;
	b=TInphNWoVESc04eTvyV9Nhr/9FgBDyEFbYoZXO/kRFEc5hijODw1uPDndopJfLNdEk+XG2
	u0Gqxujf4SK0li3nOD6Mn7ZjGiv0h7QmPegq6YQ4SXesUeR/kzG6Kbso3rbqCKpl6bi1FT
	0s6q81ucfIHjQ0YxYaw5vHJrEbG36DpMLOxlMLMy7KN9PCZmakS+dIkosEQ5+p9eJ1KD5F
	zyj69NflQii2hnGyQ1wJ0O5pBCDefuFAxV5j+3+uLKYF0fFh1uehp3XSIXQOFBP2LfobJp
	D4PSkZ4vOBy7MsliJ3AGxdW/My12pgd18mDvQNRVYK5RQ7zJdxPkqPmsy2Vp4w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 07/24] libselinux: free resources on avc_init_internal failure
Date: Tue, 23 Jun 2026 15:41:56 +0200
Message-ID: <20260623134215.98273-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

The single "out" label returned the error code without releasing what
had already been set up, so a failed security_getenforce() or
selinux_status_open() (and the earlier allocation failures) leaked the
audit buffer, the SID table, the freelist nodes and both locks. Replace
it with cascading cleanup labels that unwind only what was allocated.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index d6556bc9..ae988729 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -175,7 +175,7 @@ static int avc_init_internal(const char *prefix,
 	if (rc) {
 		avc_log(SELINUX_ERROR, "%s:  unable to initialize SID table\n",
 			avc_prefix);
-		goto out;
+		goto err_locks;
 	}
 
 	avc_audit_buf = (char *)avc_malloc(AVC_AUDIT_BUFSIZE);
@@ -183,7 +183,7 @@ static int avc_init_internal(const char *prefix,
 		avc_log(SELINUX_ERROR, "%s:  unable to allocate audit buffer\n",
 			avc_prefix);
 		rc = -1;
-		goto out;
+		goto err_sidtab;
 	}
 
 	for (i = 0; i < AVC_CACHE_MAXNODES; i++) {
@@ -205,7 +205,7 @@ static int avc_init_internal(const char *prefix,
 			avc_log(SELINUX_ERROR,
 				"%s:  could not determine enforcing mode: %m\n",
 				avc_prefix);
-			goto out;
+			goto err_audit_buf;
 		}
 		avc_enforcing = rc;
 	}
@@ -215,10 +215,24 @@ static int avc_init_internal(const char *prefix,
 		avc_log(SELINUX_ERROR,
 			"%s: could not open selinux status page: %d (%m)\n",
 			avc_prefix, errno);
-		goto out;
+		goto err_audit_buf;
 	}
 	avc_running = 1;
-out:
+	return rc;
+
+err_audit_buf:
+	while (avc_node_freelist) {
+		new = avc_node_freelist;
+		avc_node_freelist = new->next;
+		avc_free(new);
+	}
+	avc_free(avc_audit_buf);
+	avc_audit_buf = NULL;
+err_sidtab:
+	sidtab_destroy(&avc_sidtab);
+err_locks:
+	avc_free_lock(avc_lock);
+	avc_free_lock(avc_log_lock);
 	return rc;
 }
 
-- 
2.53.0

