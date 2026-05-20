Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E43C9EE6
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279196; cv=none; b=kklJP+nb4VfdCfT73mTODNetuqXPXzTMc0r5nPLlgIee/RBJRRfH4TJQgwExhS9RG5UPclXM+j2XvVppeq0a0jZMYMeBNUCR1tTPEMPqm8qD2SZy7BAM1k7s0PTua46il8RHGrnBDTk702Qr3RLXibPJCsNX7f9GfJ9e/KN1xtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279196; c=relaxed/simple;
	bh=4mcW/RUoV7jcjHeR41S9+qaOcklZH25nZI9958hzmyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrO46y/7Tv3lUF68Jbhoh0IQiZhmFi3e5AUNadgwBDks2kxJm+C5sKSUfHoD4SFbh19B4sPOEilL1rxEKmnmgy6/xlXYu/e4SwfQmnzjwR/ffox4g7PHlsoF2YCMXcouEPkMmEdOskG+E32DWDSqU78pyknyTpOznWzf+oB/iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=IEuKfLdB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="IEuKfLdB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1779279191;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bcyFFGLnAN+6vBwqf3FXb8mbWEOlQRUe4iKrMCbez0=;
	b=IEuKfLdBShgtgWhwTR0me/7nwJhASdnvZBNUJNyDwhjua9MkfpwAUDh2US6ny8ET+h71o1
	MiejXR8wnaghMyT4vzth8L8szDH5LV2Vm0BK4odQDmp6AR6nn/dtcBXp74mnAqrr+pD/4w
	hlHLiH1RfwppZmT9glOtc1V00MxQAZkM3ZcY+So9Rop3ScEX61S99LKMMlHuQUiYBjqrOL
	3MwX46U9I1w9i0wfXpgyFeIu66UqfKiSe1ENG2HoWczGawkQvN21tUCO6HWgzv+Bbfx5Kv
	VzH8kKkGE1fz9NKqlGWSLw+BlehNv+T4H3iEAW741bkneeg32DN1Ey2K2FttOw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/2] libselinux: improve restorecon progress locking
Date: Wed, 20 May 2026 14:10:51 +0200
Message-ID: <20260520121051.20863-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260520121051.20863-1-cgoettsche@seltendoof.de>
References: <20260520121051.20863-1-cgoettsche@seltendoof.de>
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

Use an atomic counter to avoid acquiring the synchronizing mutex for
each file.  Only acquire when actually writing to stdout.

Suggested-by: Copilot
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: extract fc_count reset into separate commit
---
 libselinux/src/selinux_restorecon.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8b6eba0c..b4d58b05 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -40,8 +40,6 @@
 #include "label_file.h"
 #include "sha1.h"
 
-#define STAR_COUNT 1024
-
 static struct selabel_handle *fc_sehandle = NULL;
 static bool selabel_no_digest;
 static char *rootpath = NULL;
@@ -734,19 +732,23 @@ static int restorecon_sb(int fd, const char *pathname, const struct stat *sb,
 	}
 
 	if (flags->progress) {
-		__pthread_mutex_lock(&progress_mutex);
-		fc_count++;
-		if (fc_count % STAR_COUNT == 0) {
+		const unsigned STAR_COUNT = 1024;
+		uint64_t fc_count_local;
+
+		fc_count_local = __atomic_add_fetch(&fc_count, 1, __ATOMIC_RELAXED);
+
+		if (fc_count_local % STAR_COUNT == 0) {
+			__pthread_mutex_lock(&progress_mutex);
 			if (flags->mass_relabel && efile_count > 0) {
-				float pc = (fc_count < efile_count) ? (100.0 *
-					     fc_count / efile_count) : 100;
+				float pc = (fc_count_local < efile_count) ? (100.0 *
+					     fc_count_local / efile_count) : 100;
 				fprintf(stdout, "\r%-.1f%%", (double)pc);
 			} else {
-				fprintf(stdout, "\r%" PRIu64 "k", fc_count / STAR_COUNT);
+				fprintf(stdout, "\r%" PRIu64 "k", fc_count_local / STAR_COUNT);
 			}
 			fflush(stdout);
+			__pthread_mutex_unlock(&progress_mutex);
 		}
-		__pthread_mutex_unlock(&progress_mutex);
 	}
 
 	if (flags->add_assoc) {
-- 
2.53.0

