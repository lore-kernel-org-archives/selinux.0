Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF023176EE
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156511; cv=none; b=AYkPdmrAoGGbAgJwITIQgrEuWNdhDFYTKsl9RZCoeUnKsp9p6zaqV1wuxv/oUWahxGppRTF/m2xcCq8Gicghn56hCDd9Rb9DKS4u0UeDkV3v7EAxJtPQa4ad9C5x/GC/jgiClng0JwDvh3+hn1KGsgHpe8p7IHyPqFM8qdHUaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156511; c=relaxed/simple;
	bh=tCWJ+vfrA0l2mVJ8a4TgSHYtcuSjL6hi0v0nv2aKDPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCF2vrtL1XzZgW6WJsNmGt7inzGKC7F/zJOz51CkgrFB7WAdSp8+ZPn9WCbrh0tfIptFtyCw4MgSgtNQWSzGktNFUDnXr7XwK+4ec1PmF4D0Owc/vxth+nz3oJeTA90gVqSCCZi5igmb0U2XNNukPM5gzlLp4aRoT+8qwkCVp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9+3zCXD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x4kJSiTu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Im5qq9zy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nry8haaa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9+3zCXD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x4kJSiTu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Im5qq9zy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nry8haaa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 405E07DB69;
	Mon, 27 Jul 2026 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785156503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YfJvErFnAJ1GpOmRhl88YyLW+JWExLrIfIt95v65TxY=;
	b=h9+3zCXDmmfCfeOmG7SkmmSVwDMGYyqw/0LeVZDVKgW9qYCx8PxrC21PxQgUv8wb22YX7T
	qL3HxXl4A6SFczViZYh+4wwybmrypxdTLOP/VLiknUPnDmSX/q4h+CQEO3uW7+GV14IWYU
	ksMUo/4Rwul9NNzSwScyw5Qc+p68jyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785156503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YfJvErFnAJ1GpOmRhl88YyLW+JWExLrIfIt95v65TxY=;
	b=x4kJSiTuwL1lA3oz3L1sxhEuPlYmI4i3EiV19oRYQD4+kveQxe1Wqf1LfmOzG4PJvbPWOw
	Ulae4fSyZXxqA0Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785156499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YfJvErFnAJ1GpOmRhl88YyLW+JWExLrIfIt95v65TxY=;
	b=Im5qq9zyqkfFWg63BhI7lPq5sqgUPYELO0FGdTA7p1oqiVqnvCT2LGiq8KU+s+YNdAfWr4
	dwGgTedTPYPsg43HSBOnaz4hg4rh+2UMQ/vg3xl2CpzPzFepBAC7jRIyGb7cklW2cvPzAR
	hHMtYiaoxqLSvg6G6PIOVXZZQ7n9WdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785156499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YfJvErFnAJ1GpOmRhl88YyLW+JWExLrIfIt95v65TxY=;
	b=nry8haaady6/ridTgkVxU90Q49ZS7eoOSAl7B+1o6aM4X9NYqDBuhn0FPD6Qcxxsf25Q5u
	iX6gQZtu5GLu+2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26B9F779B9;
	Mon, 27 Jul 2026 12:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4OggCJNTZ2qJYgAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Mon, 27 Jul 2026 12:48:19 +0000
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Cc: Johannes Segitz <jsegitz@suse.de>
Subject: [PATCH v3] selinux_restorecon: Do not exit on directory cycles
Date: Mon, 27 Jul 2026 14:47:57 +0200
Message-ID: <20260727124757.787026-1-jsegitz@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

All other failures are handled gracefully. Directory cycles can e.g.
happen on BTRFS filesystems with subvolumes. Skip them and continue
instead of exiting

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/src/selinux_restorecon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 30f1b836..fdefc92c 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1393,15 +1393,14 @@ static void *selinux_restorecon_thread(void *arg)
 		if (is_dir) {
 			if (descend && walk_is_cycle(state, ent_sb.st_dev,
 						     ent_sb.st_ino)) {
-				selinux_log(SELINUX_ERROR,
+				selinux_log(SELINUX_WARNING,
 					    "Directory cycle on %s.\n",
 					    ent_path);
 				close(ent_fd);
-				close(rd_fd);
-				errno = ELOOP;
-				state->error = -1;
-				state->abort = true;
-				goto finish;
+				if (rd_fd >= 0)
+					close(rd_fd);
+				prune_pathbuf(state);
+				continue;
 			}
 
 			if (state->sfsb.f_type == SYSFS_MAGIC &&
-- 
2.55.0

