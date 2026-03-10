Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EF39DBE8
	for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156890; cv=none; b=mdqi8ptRyuIxoZFBV2v9KnSp1ACI/BXf/ZpXYj96LcE3VnB94e5cLn0a8fS5BT9I2cmDex1UO1Iknx0kDiyh4SjMWlhNWYbiNnld2vorRtD1ju7frxvLx9gGfysUfaIPjg6V7pkhii8Y6mI9wRQKksJ9HaoePyNG9GV2QeJML5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156890; c=relaxed/simple;
	bh=FGKAljskP/aLuIhdsS+cysRAPbNAuK3ViYcAdPqbwGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHFFY/akQd3RM8ba/4IS8A4Z9u2H28W99He76JatPyvevG8Ed0QDnxzznFw+ppillq9duSP7IjOBiyv6DLVKUsbquu6d8intT/AUY5ThxJSjXAxJzN+3cYxJPEH/aL+kzyLFEMt+d9wNgcmDvii/3MLJfBGN+EBCQebPMAhPdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rCSuR8yw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qRQX0C04; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rCSuR8yw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qRQX0C04; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rCSuR8yw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qRQX0C04";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rCSuR8yw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qRQX0C04"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31EF94D1FA;
	Tue, 10 Mar 2026 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773156886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=miOjxUS6cS6Yb5LpxWl2pXtpXf0UUMvt+ec6IGl7C6E=;
	b=rCSuR8ywBP0kXoBsqM3S/zH5gUHfu4COw8puCb9/N0rlRUu09XJ/c8HXye75+hsVHuDwWc
	bVyH8lf5mzoyLAL0xVbu3vm89X1qb7BUkGPbNb54fEgPkSIFKr+sEPqbODQBGMVQQshXr8
	CVJHuNE3ZV8yRZLfLDgE5bqtF4PaAmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773156886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=miOjxUS6cS6Yb5LpxWl2pXtpXf0UUMvt+ec6IGl7C6E=;
	b=qRQX0C04r8/qyJ2E+zLrxlxoWqN3HHQGSI74sascwHcZLL657ZIQsCn0y4IS/mhFT5DlKe
	r4u+UemLGYrf4hCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rCSuR8yw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qRQX0C04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773156886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=miOjxUS6cS6Yb5LpxWl2pXtpXf0UUMvt+ec6IGl7C6E=;
	b=rCSuR8ywBP0kXoBsqM3S/zH5gUHfu4COw8puCb9/N0rlRUu09XJ/c8HXye75+hsVHuDwWc
	bVyH8lf5mzoyLAL0xVbu3vm89X1qb7BUkGPbNb54fEgPkSIFKr+sEPqbODQBGMVQQshXr8
	CVJHuNE3ZV8yRZLfLDgE5bqtF4PaAmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773156886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=miOjxUS6cS6Yb5LpxWl2pXtpXf0UUMvt+ec6IGl7C6E=;
	b=qRQX0C04r8/qyJ2E+zLrxlxoWqN3HHQGSI74sascwHcZLL657ZIQsCn0y4IS/mhFT5DlKe
	r4u+UemLGYrf4hCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F8563F517;
	Tue, 10 Mar 2026 15:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o6SyBhY6sGnyXAAAD6G6ig
	(envelope-from <cahu@suse.de>); Tue, 10 Mar 2026 15:34:46 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>
Subject: [PATCH] restorecon: Only log error on readonly fs (bsc#1257996)
Date: Tue, 10 Mar 2026 16:32:51 +0100
Message-ID: <20260310153249.2077092-3-cahu@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31EF94D1FA

Signed-off-by: Cathy Hu <cahu@suse.de>
---
RFC Patch for the issue described in thread "Question regarding restorecon and btrfs read-only snapshots"

 libselinux/src/selinux_restorecon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8fadf4d2..e8545e27 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -774,10 +774,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		if (!flags->nochange) {
 			if (lsetfilecon(pathname, newcon) < 0) {
 				/* Ignore files removed during relabeling if ignore_noent is set */
-				if (flags->ignore_noent && errno == ENOENT)
+				if (flags->ignore_noent && errno == ENOENT) {
 					goto out;
-				else
+				} else if (errno == EROFS) {
+					selinux_log(SELINUX_INFO, "Read only filesystem, relabel not possible: %s\n", pathname);
+					goto out;
+				} else {
 					goto err;
+				}
 			}
 
 			updated = true;
-- 
2.53.0

