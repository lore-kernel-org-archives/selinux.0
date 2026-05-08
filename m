Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D528B4E1
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242432; cv=none; b=VNbKGA5JJ0tv86zuc2SsiHJigowNgiGu3Mm3J6NQulLck3wqMNdhzgHeiOvKyM+TQPHPUAnGtgyYXnfKP+xjsb9yaMda09wgEB3dInRXo6dOiKuXXy7+fiNU8GrggJ1Z9vNJi9ablnH0q73wggDoc41WUfcYsll2LWbZZrxmKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242432; c=relaxed/simple;
	bh=IlZBA7kOfb5F56P/8EWH5v05ctcznr5jOHw3pnCLriM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnV1LVy7x5tklOCwNRZ+eTRSKtuvvRkWIFXr5PwEvNR7sJaJqpLPKYzjGJ7PKnYyZZh7zZdGWhHGXFscE+zRJKeelH0l+305spgZQo0hWTUgN6in9mjs3+OjFhH63vnZk+QnVoHjM1DF85mL6A9ctRZPMKJNRcXMw87GzErXs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=j7b3FjiD; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="j7b3FjiD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s4Qz0zN/NnGXv7BrZIUKLxf2WiBCf2q0I5zz1dfHuEg=; b=j7b3FjiD6uw+ZRWTx0hlVUFYzi
	wvwvfScgtCcYNGUa1kaSO57P5D2RbZnzvQ/xF3OlR/CGvXTpmkhaOtSTx02o8/8maEI/bPOEBZwUT
	SJG+W4ATQvDY0APLltfoRekpbLeeNjBqgvZ3t1XdGv2fDWscAKwiP0SJqYPanfbyXzDxmmOkzryFD
	LB2JC/aoHLbs2VC8x1cbOfWdlkHZS1BZy9a5Akt/8o69HCut/f/5E3WvipLyGhxx5od56uX35ejcY
	Y0zNP3aSwrsCnPNSWmjK1rDlb7YrEersZKVQGvL/BZmh6Yqf+OK73m+Kp9eV6RKzUcFNy5zW9nwHG
	ukhRBHPg==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11426 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLK5T-0000000BmhC-1kxL;
	Fri, 08 May 2026 15:13:47 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 2/4] checkpolicy: remove unneeded tests before free() calls
Date: Fri,  8 May 2026 15:13:25 +0300
Message-ID: <20260508121327.91410-3-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508121327.91410-1-kalevi@kolttonen.fi>
References: <20260508121327.91410-1-kalevi@kolttonen.fi>
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

ISO C guarantees that free(NULL) is always safe to do so
remove unneeded tests before free() calls.

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 checkpolicy/policy_define.c | 48 +++++++++++++------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d1511a1a..4f775111 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -381,10 +381,8 @@ int define_initial_sid(void)
 	return 0;
 
       bad:
-	if (id)
-		free(id);
-	if (newc)
-		free(newc);
+	free(id);
+	free(newc);
 	return -1;
 }
 
@@ -632,17 +630,13 @@ int define_common_perms(void)
 	return 0;
 
       bad:
-	if (id)
-		free(id);
-	if (comdatum)
-		free(comdatum);
+	free(id);
+	free(comdatum);
 	return -1;
 
       bad_perm:
-	if (perm)
-		free(perm);
-	if (perdatum)
-		free(perdatum);
+	free(perm);
+	free(perdatum);
 	return -1;
 }
 
@@ -759,10 +753,8 @@ int define_av_perms(int inherits)
 	return 0;
 
       bad:
-	if (id)
-		free(id);
-	if (perdatum)
-		free(perdatum);
+	free(id);
+	free(perdatum);
 	return -1;
 }
 
@@ -892,10 +884,8 @@ int define_sens(void)
 	return 0;
 
       bad:
-	if (id)
-		free(id);
-	if (level)
-		free(level);
+	free(id);
+	free(level);
 	if (datum) {
 		level_datum_destroy(datum);
 		free(datum);
@@ -903,8 +893,7 @@ int define_sens(void)
 	return -1;
 
       bad_alias:
-	if (id)
-		free(id);
+	free(id);
 	if (aliasdatum) {
 		level_datum_destroy(aliasdatum);
 		free(aliasdatum);
@@ -1076,8 +1065,7 @@ int define_category(void)
 	return 0;
 
       bad:
-	if (id)
-		free(id);
+	free(id);
 	if (datum) {
 		cat_datum_destroy(datum);
 		free(datum);
@@ -1085,8 +1073,7 @@ int define_category(void)
 	return -1;
 
       bad_alias:
-	if (id)
-		free(id);
+	free(id);
 	if (aliasdatum) {
 		cat_datum_destroy(aliasdatum);
 		free(aliasdatum);
@@ -6129,13 +6116,10 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 	free(type);
 	return 0;
       fail:
-	if (type)
-		free(type);
+	free(type);
 	context_destroy(&newc->context[0]);
-	if (fstype)
-		free(fstype);
-	if (newc->u.name)
-		free(newc->u.name);
+	free(fstype);
+	free(newc->u.name);
 	free(newc);
 	return -1;
 }
-- 
2.54.0

