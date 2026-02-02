Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCF366052
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042963; cv=none; b=U4AJboRf0Z33/1aDKdfl+pGOAXrIEEVWzd6A4Pxrolv+bbTKuNtEeEwEJrBjkQSEKqvpN/vMb8Hgd7VVABKKVMpRVoCN3mEmTdWwYCX4pb/W19R8JbLJH04JvOyPGQ/Mnc3BnisE2AGdNE2osWMhciNTAiFOkRop6E9VHpA7+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042963; c=relaxed/simple;
	bh=qWmui+lZNdA7/LpKSTNl3egUdcvyfpbQY+onHoOI2kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqkS5SUPTF/y6a+3orYAvAJh3kImK0K2t7168f3c6+9CEShXddXsjd9OeL0lXdkGbxlyxy/ZHGSHeA/ue/YilIlS2CvWYj6XqChWF5IREDg4jTNxHGrrP/do2YeONt0YeScB98yp7mLpDFiyqKuEQLmJMtuN3NLFxAc70xAFHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uAYnsHFw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uAYnsHFw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042960;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GaHPua2gNAluRjwF1KpWSbJ5t1cJiFA8xfjhiD4LlM=;
	b=uAYnsHFwKfu+NMU7zf6vdPaQAxQvDj5ANc9dY2tmQqo6r8g9YwKXLCK7s5aj8CrosBuhrX
	0JK1BRQMxg/0ZGeuZ2moYojX8mmePgKrkte68TH+U2OvPMV0+ze1J8wk+MS6T4J0bOXe3f
	1WhDEq+cgT2UK08UNZFgy4vBMoR25g1ClTgkPEH9N21SclFTh3bkS2jfpALRW1yBBa7S86
	OAP/hHFrWdkO2CzMm6Lj7FnDU4ZMwPrQStVRstyDiqx5kUhxLYThGaAtRZPFLTBL0olZ6o
	MUVoFrQmy9b0FirKgszDfrnvbrBjIaBSIEbbRJGSrj0436wxQWltTYHdArSa+g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] libselinux: improve restorecon progress locking
Date: Mon,  2 Feb 2026 15:35:53 +0100
Message-ID: <20260202143554.97209-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-1-cgoettsche@seltendoof.de>
References: <20260202143554.97209-1-cgoettsche@seltendoof.de>
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
 libselinux/src/selinux_restorecon.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index b1f6f672..a512a669 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -17,6 +17,7 @@
 #include <fts.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdatomic.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -39,8 +40,6 @@
 #include "label_file.h"
 #include "sha1.h"
 
-#define STAR_COUNT 1024
-
 static struct selabel_handle *fc_sehandle = NULL;
 static bool selabel_no_digest;
 static char *rootpath = NULL;
@@ -58,8 +57,8 @@ static bool ignore_mounts;
 static uint64_t exclude_non_seclabel_mounts(void);
 static int exclude_count = 0;
 static struct edir *exclude_lst = NULL;
-static uint64_t fc_count = 0;	/* Number of files processed so far */
-static uint64_t efile_count;	/* Estimated total number of files */
+static atomic_uint_fast64_t fc_count = 0;	/* Number of files processed so far */
+static uint64_t efile_count;			/* Estimated total number of files */
 static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 /* Store information on directories with xattr's. */
@@ -687,19 +686,24 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (flags->progress) {
-		__pthread_mutex_lock(&progress_mutex);
-		fc_count++;
-		if (fc_count % STAR_COUNT == 0) {
+		uint64_t fc_count_local;
+		const unsigned STAR_COUNT = 1024;
+
+		fc_count_local = atomic_fetch_add_explicit(&fc_count, 1, memory_order_relaxed);
+		fc_count_local++;
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
@@ -1111,6 +1115,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	int fts_flags, error;
 	struct dir_hash_node *current = NULL;
 
+	fc_count = 0;
+
 	if (state.flags.verbose && state.flags.progress)
 		state.flags.verbose = false;
 
-- 
2.51.0

