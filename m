Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8C198841
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533531; cv=none; b=UZza0DVxblmHRFnruKvKgo3EnvDLBF8P/HJURWcjes/iVC6WZopCaoOzOtZdqWXVfQ03ZbavaduLPtN42BxRqeoNUoRFOIqIGkYcvdsDdzxz58dTNIOjfnjCy+eLgSHIzLQgfs09cjtk1Ykrg0ZUVywOexsWcpg1KEXpshhZB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533531; c=relaxed/simple;
	bh=OCUkKxgu2xKrEbJTT/WDSZ/8T3gYlr+6cjiO97qrbUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVP/5YMJB+E9qcZf/Nk9/YVLZqoqWicIHovZ7YpvkvPF5wKcQxCEX6w4AZQUp5sljl6u7dBXqG7QISILcebDxHDLpw9MxndAYZKj5/Zlz7NKrjsmnxrMJKG7gzRHYrkRTRy0S3bWYSyuMHMEBxSeS9TacLfL0PaIE9WE/7bVgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qLM4vf/p; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qLM4vf/p"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdhqOqY2yQ+X0ABHh5r0rsyS+XmfHAggfrjOr0wkDy4=;
	b=qLM4vf/pQHxQvxpY3XCLUE8+HswsxxPoAkZqZnCCGkkHSIGzB0oAVHOZXlMHn1D3om2Qic
	h9KwuQAmu4dN64pguFOWQXjGLO8feMiF0TXhcvy4bAMbzlMCHu63JXGYt06hZbkvMTa998
	MFSGRKhuJOuq831IMwvDiCoeQPVvTOmzgrBF/gvs4bxOpybupKwnC7GOr17jWVl5124d7r
	HJLcP8NonjZ8t/YEGqimsu6bTdDed73PsFgDzaG3Nu26CUL4liD0tpXtsxyLPIbPmE2+Hl
	FtGSXQ1X3KMURtGwP3d+CyxOlWjcZDPHKAFLLgj0qby2ULzfzM/WcSLu4whvug==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 6/9] libsemanage: simplify file deletion
Date: Mon, 25 Nov 2024 12:18:37 +0100
Message-ID: <20241125111840.63845-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-1-cgoettsche@seltendoof.de>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
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

Instead of checking if a file to be deleted exists, just try to delete
it and ignore any error for it not existing in the first place.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 87c7627d..99cba7f7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2762,7 +2762,6 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 	int status = 0;
 	int ret = 0;
 	int type;
-	struct stat sb;
 
 	char path[PATH_MAX];
 	mode_t mask = umask(0077);
@@ -2863,13 +2862,11 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
-		if (stat(path, &sb) == 0) {
-			ret = unlink(path);
-			if (ret != 0) {
-				ERR(sh, "Error while removing cached CIL file %s.", path);
-				status = -3;
-				goto cleanup;
-			}
+		ret = unlink(path);
+		if (ret != 0 && errno != ENOENT) {
+			ERR(sh, "Error while removing cached CIL file %s.", path);
+			status = -3;
+			goto cleanup;
 		}
 	}
 
@@ -2966,13 +2963,10 @@ static int semanage_direct_remove_key(semanage_handle_t *sh,
 			goto cleanup;
 		}
 
-		struct stat sb;
-		if (stat(path, &sb) == 0) {
-			ret = unlink(path);
-			if (ret != 0) {
-				status = -1;
-				goto cleanup;
-			}
+		ret = unlink(path);
+		if (ret != 0 && errno != ENOENT) {
+			status = -1;
+			goto cleanup;
 		}
 	}
 	else {
-- 
2.45.2

