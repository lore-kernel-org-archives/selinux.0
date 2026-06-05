Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5302156CA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668146; cv=none; b=QpLX6xajs33k/+zuXROxxzVqoTdk4zC6WCaeacAZKTqcA98vD+PvBdugyEiuBBw1yyULWU4tdje5YMb01nikPeSJKM5ThC5GmSwAk/sDbeBl+luKDAHn+zy+yh6BTiAbGd4ZEC3nWXEcjzjIkZygicfN6vKB+ztcWiAH4dmtrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668146; c=relaxed/simple;
	bh=kMfPFS7s7jYiIa3W18oE4ZA8Jw+PxjHnahHmuIJdtTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEXy06LtAxQvdBC30X+8NPgqjRhi1cdmzWT79TxgaHeA6/slvHXRS8NarEv/IWKkwwB5UTvjOcg4D5en/jrf8Luo2g7hf+IvUqgBWYNbyabD4jSKz5DCBBITlOfJRR30vySjIT+U/7zh+ajH4vjGh99CqF44VzYlcxKaZPa77UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=D183Rt9R; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="D183Rt9R"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780668143;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXO/RayGINp05D/pkbtcOmYqAjXLP6ve+O5DEiqIuqo=;
	b=D183Rt9RC6LKP8bKOD5tvGB0iwYNrUbNrfd+ujvJs+pZdh6gQ64uMBGr6pjS0HMd7wEJXE
	E809ipr7wEpsvLt79GSMSHsWiArhMjJe1cnu/GUJDXZOgb1YDBGAyheBbJiSUCf8qTyeQh
	MMZNj9/fayGSTOlE4Srot+iBG3QD4Ai3f4mpMDnRxRR5CKNAkBjFDMuyGDja58b9y+VP2j
	mSREU9kH2uhlYKoui9kUhafhGCZuiiBZwKBj2zKiNcXm5iTzNAYyDDpN1IwfW+349Ag/5p
	3NJzHMpCmCnG7AzxNYnzFEgdha1RyyTSaEWlAiNjteYrvV2xEKvFS1PgfzScng==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] libselinux: avoid out-of-bounds read on empty failsafe_context line
Date: Fri,  5 Jun 2026 16:02:01 +0200
Message-ID: <20260605140203.76848-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-1-cgoettsche@seltendoof.de>
References: <20260605140203.76848-1-cgoettsche@seltendoof.de>
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

get_failsafe_context() computed plen = strlen(ptr) from the first line
of the failsafe context file and then dereferenced buf[plen - 1] to
strip a trailing newline.  If that line started with a NUL byte, plen
is 0 and buf[plen - 1] indexes buf[(size_t)-1], a wild read.

The file is root-owned so this is a robustness issue rather than a
privilege boundary, but the guard is trivial: only inspect the last
byte when the line is non-empty.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/get_context_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index dcdef5d8..bad93fa1 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -307,7 +307,7 @@ static int get_failsafe_context(const char *user, char **newcon)
 	if (!ptr)
 		return -1;
 	plen = strlen(ptr);
-	if (buf[plen - 1] == '\n')
+	if (plen && buf[plen - 1] == '\n')
 		buf[plen - 1] = 0;
 
 	nlen = strlen(user) + 1 + plen + 1;
-- 
2.53.0

