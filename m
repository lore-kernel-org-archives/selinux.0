Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2241A072A
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334647; cv=none; b=PUBoKWRN6zqSk087kPdUeRxs2hrJGHzwTCOQ+nNBmDctFUxuJWa89JAiTUzLMR56unbH9qisaI+VerNaevf+ucW0f2OhHrG7lo95yxqL19hcGKPB2nvz8BFh+wkLfSXiTOuxcmjGOEi9I5okeFThBBO89o9SGhbrykzPpn0/nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334647; c=relaxed/simple;
	bh=tyr0jGzMXgry1xlE2Y8+wVlz4+AS/fdk+FMT9UutWvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRQkM5D5YsvFManfoWPxW4uhTpXrFtjq4Y3HoQ/i9H8/t0TbmaTkm2Vmjtx6wa3aYrGV0WnMtu4GlfAb6Zhpmuzecb+Mpkz4Q5iD/fKuc4Azrl+QuckPuvkFZly1jIfY8Oi/LhMr8Zek2pmccO7dfZMSHC13M0zR8mn4qjiwhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CV1dZ7cl; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CV1dZ7cl"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334640;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaCHPYdCnicSEkwgNsh0Ck31jbuOQL6fkUIjXnPI6zg=;
	b=CV1dZ7clfLNEZAQU55mLlUpLP9reaPKqmJ5soulq2kN9WZuWI81W6e47kwdqb10YZcKgqA
	Z1caBMVEdSlet9YxgrC3X5h1wOWv23Xxykd3EuimPTGw7RJPKZotQv2HiytDouT9Fn5Hho
	JSLQpvsGPzF4kLbiGGOUOEEa1hm8LjJW/PUmCESFRVrRWrj2+jzABtQ+UNmjdP15N7ov/3
	z33pFznW8qQkzoyHAt63/F3TwmNEncepUNPpUd2vC7ByzKHmB0qehZsZKDf/HBOFjF7h6o
	8P6EALclZ4v/CeX42E/py6aPs194O9aYt5L5SBC94zBi1DS7MGROfMWrcJf0yw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 42/47] libsemanage: simplify file deletion
Date: Mon, 11 Nov 2024 15:17:01 +0100
Message-ID: <20241111141706.38039-42-cgoettsche@seltendoof.de>
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

Instead of checking if a file to be deleted exists, just try to delete
it and ignore any error for it not existing in the first place.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e4ca5f26..2a3cdee9 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2761,7 +2761,6 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 	int status = 0;
 	int ret = 0;
 	int type;
-	struct stat sb;
 
 	char path[PATH_MAX];
 	mode_t mask = umask(0077);
@@ -2862,13 +2861,11 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
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
 
@@ -2965,13 +2962,10 @@ static int semanage_direct_remove_key(semanage_handle_t *sh,
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

