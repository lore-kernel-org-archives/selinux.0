Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2C201278
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042963; cv=none; b=UFZ/CbEYOqSR2JVdU0yhDPY0Z1YI0e+Z5D51N+I4O4sgtA7KW49J5H7IjfWi9z5FZm/yIkpGqtrrKBcsIlCbhjN3x5h1ub6irncoAMaJdp1lx6Y9uNa0YlnFI9zt4pM+QlEJbxc8ixqQGAiYXxMOdvs20E5YbUb1AuGP5NbJ7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042963; c=relaxed/simple;
	bh=j1DieyvdNa46/7GyKZVgqileeVGKFrosd5QiC3G9ZAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hLgo1f99HADAx4Do8YTxw7fFW1RwBu/PKG2t4eNGgcLQM74SocDc4LDjvmzG6kVT6ZnHHfcLpS5Lb1xedaH+XkLjiGAuKvPQIcuCNZMMpLu8RjxPZ6gs9tGGtkljgeYg5b1oHbNh5qafHhBcKJmzq/n35yC1FrQAvtam1SpB/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=E9t7yAkz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="E9t7yAkz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042959;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BI2UgCSCPD+spkvciWBXj1Xxrvh0j001nSy2UeFfXtM=;
	b=E9t7yAkz94SaZRtouPcXJF8FA3MV1UtFRGWa3Bg/1uNQXDu5tKa64ksKJyLRxo1gdohZMN
	9FFs4NRKLhZ/3PqSZvGLbrVyQpUT7BDjGn0LFYMJmhkD1rFl8YjJfE4MR4fPw0v17xW9+K
	BksxhKCyAVD1SvwHSUeyX5trxjqM6q7M1xqXgBdI6sz8vw7Bxo8XA/ILo6X5oXhbLdRGEe
	T2T+DtYkZ1OmZsYzJt3PPq5N7QRReS1VjrkyMJuf3wK4SuZ6OraL7fwjYWjd/Y5SYmIuVT
	9BQJhr22exqkczoFMHRTh7/GMS+sRaeyRP+SwllIYG3/RFZ/GoEe8fd8NuZxKg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/4] libselinux: support non-pthread build
Date: Mon,  2 Feb 2026 15:35:51 +0100
Message-ID: <20260202143554.97209-1-cgoettsche@seltendoof.de>
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

Consistently use libselinux-internal __pthread wrappers to re-
instantiate support for non-pthread builds.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 34927126..b1f6f672 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -905,7 +905,7 @@ static void *selinux_restorecon_thread(void *arg)
 	bool first = false;
 
 	if (state->parallel)
-		pthread_mutex_lock(&state->mutex);
+		__pthread_mutex_lock(&state->mutex);
 
 	if (state->ftsent_first) {
 		ftsent = state->ftsent_first;
@@ -1011,14 +1011,14 @@ loop_body:
 
 			ent_st = *ftsent->fts_statp;
 			if (state->parallel)
-				pthread_mutex_unlock(&state->mutex);
+				__pthread_mutex_unlock(&state->mutex);
 
 			bool updated = false;
 			error = restorecon_sb(ent_path, &ent_st, &state->flags,
 					      first, &updated);
 
 			if (state->parallel) {
-				pthread_mutex_lock(&state->mutex);
+				__pthread_mutex_lock(&state->mutex);
 				if (state->abort)
 					goto unlock;
 			}
@@ -1046,7 +1046,7 @@ finish:
 		state->saved_errno = errno;
 unlock:
 	if (state->parallel)
-		pthread_mutex_unlock(&state->mutex);
+		__pthread_mutex_unlock(&state->mutex);
 	return NULL;
 }
 
@@ -1279,7 +1279,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		pthread_t self = pthread_self();
 		pthread_t *threads = NULL;
 
-		pthread_mutex_init(&state.mutex, NULL);
+		__pthread_mutex_init(&state.mutex, NULL);
 
 		threads = calloc(nthreads - 1, sizeof(*threads));
 		if (!threads)
@@ -1316,7 +1316,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		}
 		free(threads);
 
-		pthread_mutex_destroy(&state.mutex);
+		__pthread_mutex_destroy(&state.mutex);
 	}
 
 	error = state.error;
-- 
2.51.0

