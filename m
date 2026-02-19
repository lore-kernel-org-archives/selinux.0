Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692231C567
	for <selinux@vger.kernel.org>; Thu, 19 Feb 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507628; cv=none; b=r8ZQuKEH9tnjfiSPmoeEocGSpmCY+rzRBrwFEbALjUDLd7EBcGUyoB/JqKRszuq11qswEhyxL+3T2WObhb2nsyxK07d7kFfGg6uHd6Wt0OIifneFJBbpc80CUEQRwf77ux/SSWKnjrP/AFnEXW5z4Qtz8NJEE0iUwqqd2ewOUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507628; c=relaxed/simple;
	bh=imb4dG4xRUZuikS98A8dHtqnEGZtNAl8a7CHdTGQ4ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOOdbmgHav1fjnKlf0LJ5pnt1rA5yUlfLWSUUSdc+/8zdc6EMofiNpEIpqXu8gVkrTsrwrcMEhHFASSV2qXknxMJRAbqHUI+4goTX6YLMTQOnS98LF52aCTRNVjUlPGVtDBgKhSAv59QApsIWK7/84UoQgc2+nkSYVrF1jBK7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dKugX4yh; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dKugX4yh"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1771507316;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UTjbXlchSTL4uaAwpku70hNsHnC+Fay2wvKcnAHLQd8=;
	b=dKugX4yhBxNP3ehAiDzfKIA8W6EzBYWZ8KXO/6TxNkjqJiZyo0ysRiTqqGk9m8D0jTCCW3
	0yJ2EHMdGmjagdHr4+j1pmwaMwUMn4EGDCAuTJNW70Wk3Jzt9YXByMhdyhqwBaogFPVPcV
	WjhazzqiHGg0b+elSKghgNdWYDnlzypF4KbzKRin5WHZM9c2g1eqJ4M4eIC/j4c8DQXuGD
	oIdasxBhEEPBjsU+aNvWm9xqh+CbsdCrgAWATBq1cLGej2mG7LTcF65QNysfPwJBdslKZF
	Mnllb3D4CwhHO6H4qI6+79wRcWujoVsPtLc7xMgioHWVEknRGBuN/xp5kFg3lA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] libselinux: improve restorecon progress locking
Date: Thu, 19 Feb 2026 14:21:51 +0100
Message-ID: <20260219132151.34299-1-cgoettsche@seltendoof.de>
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

Also reset the scanned file count at startup in case the calling process
calls selinux_restorecon(3) multiple times during its lifetime.

Suggested-by: Copilot
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: use GCC builtin __atomic_add_fetch() instead of C11 atomics for musl
support
---
 libselinux/src/selinux_restorecon.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8fadf4d2..ac9f6bc5 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -39,8 +39,6 @@
 #include "label_file.h"
 #include "sha1.h"
 
-#define STAR_COUNT 1024
-
 static struct selabel_handle *fc_sehandle = NULL;
 static bool selabel_no_digest;
 static char *rootpath = NULL;
@@ -694,19 +692,23 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
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
@@ -1118,6 +1120,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	int fts_flags, error;
 	struct dir_hash_node *current = NULL;
 
+	fc_count = 0;
+
 	if (state.flags.verbose && state.flags.progress)
 		state.flags.verbose = false;
 
-- 
2.51.0

