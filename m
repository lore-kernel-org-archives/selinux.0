Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5757241695
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946820; cv=none; b=XXzDwG+fUKZjL6g1T9iqIFzMGoXy40/O8+fm6vMiE3YWS0bGLF1p36YSncTodWjlU4Wluv0OHhNMNPq/Yma/zgIEZj//TAUZjQnTEHZCpBB4PP+sQM+s47GLSvaq9IWBdx/y2LvKoYSu+0IqVO8cjzpTJJSAxsPNUFDsaHCI4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946820; c=relaxed/simple;
	bh=48doFwpjJXZ5ReL9IxgUXtgg5QQEBKxewr6FwUOpxdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y0uYCfhJx5H8vtOkJccbn6UqSgOBU7viyXllK0uXoHGkKLuVyorcXuJgJZBJQ3hEYt0lrR5I0GpObNk6vbrN3S8sfFg5GNOj4RL7ACYsKCtnoIoV+RyDTMFITDQrIHjoJLwpM7FthwTdoRukQm+lQ4QtSiZI/4yzSu3Dno2XwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=EwSTbuWW; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="EwSTbuWW"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736946815;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qyx8cDinf4yn9RtHdGDtH8Ho7N63LupWZsVSXMKYXH8=;
	b=EwSTbuWWWL2oapSkUmQuik+vHSR6/n/M4hz363rLEOigqLlbpz4Hd7dZpMPVe7voZqJMeN
	w2ecd+XxZLyckt9fDtyshSNBGsLqSIawupd2BLfzxMQCQW8FRVCU1Ih0mG8PnAgy+zAFtG
	Z7/uAKZ+qe2wdOsqdnle0ikYbxvqy+3CH0y++Wo8GL7aJLZJyDQ7nSjDtY5bcOVvyVK1fj
	7KtPmbFlIVqMKumG3FlZy6TgDksdfLbuflYvM2de2CNrIho/ZaFPC4huvdE1T+7mDG9yTp
	WaqV0c7EbnSBClNITIOnod24IO7yzBlrQKUZKFvqESOnFN3sIVp+n8DeHTlIjg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/5] checkpolicy: check identifier before copying
Date: Wed, 15 Jan 2025 14:13:25 +0100
Message-ID: <20250115131329.132477-1-cgoettsche@seltendoof.de>
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

Avoid calling strdup(3) with a NULL pointer, which can happen with an
invalid policy context, e.g.:

    class C
    sid S
    class C { P }
    ;
    user U roles j;
    sid S s:l:q:q:q

Fixes: 6f2b689f ("checkpolicy: Fix MLS users in optional blocks")
Reported-by: oss-fuzz (issue 390004173)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 2f811b67..96a481f7 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4437,6 +4437,7 @@ static int parse_semantic_categories(char *id, level_datum_t * levdatum __attrib
 
 int define_user(void)
 {
+	const char *username;
 	char *id;
 	user_datum_t *usrdatum, *usr_global;
 	level_datum_t *levdatum;
@@ -4463,7 +4464,13 @@ int define_user(void)
 		return 0;
 	}
 
-	id = strdup(queue_head(id_queue));
+	username = queue_head(id_queue);
+	if (!username) {
+		yyerror("no user name");
+		return -1;
+	}
+
+	id = strdup(username);
 
 	if ((usrdatum = declare_user()) == NULL) {
 		free(id);
-- 
2.47.1

