Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A13B38B9
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221974; cv=none; b=mdWU60WN1UvgLHmew10ph1ZGTKO4O/6+/4QjJdxxqeIQXemuh82e6J7BGQZpFflOb+adARfwbrYkTAHmdcZPRce8euG+10DOzTr0SK1+pcS1ik9P9VOO9AiyirLw2AX3UIX0lttws2GfLMJzU7dPA1u/YKsnlSBdRaD+v/UIiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221974; c=relaxed/simple;
	bh=S4oFE1Xrx7jRvLIn8KpCYRuCgTWZuDrikroBu2i8fS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYhaZ49TXwl1nnLR0mCeR1OqFKoYqJvHdS92uZguNfpQEbdU/v4S3SEzOekRjOvMBypK00Z4AM4hygMwGXTbZmhLTAYOX+ntfIW5YD+CVeAZotmJ6sITDIYDpKiyQHGJx3MRfmmw0N/pFdNDL4o8/ABpVatVuJeBNv2+W7MuZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S5MuzA+I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+phddh+M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FcGt2eEh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=el1b+gqd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S5MuzA+I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+phddh+M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FcGt2eEh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="el1b+gqd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7B513E42;
	Tue, 28 Jul 2026 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785221967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h49wrWZrnTom3EFcEL5ainnjsCHpaUYKhiJxm4dcG6c=;
	b=S5MuzA+I2MYfaxQ3PHcoj3h3Z9278RZOQ60b8AH/RrUB/dP00zHOPx/BLXJuBW8lIAd4O4
	bHYFBs9PVcs9h8Hv1ca11ixe9qFsG/e4cQcu9g1+29qAftAamAR/mowV76TuY9uV2N6Ihk
	gAxMdAi42kqnjakzADvaRZ16dHGc5V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785221967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h49wrWZrnTom3EFcEL5ainnjsCHpaUYKhiJxm4dcG6c=;
	b=+phddh+Mvy6ICvABKOwedBOJFaue5D3kHeRF4pEoHFxMlyYKS65ArgTXOd1VzF/BU5/Y1E
	vWQCnQHPzNCzm3Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785221963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h49wrWZrnTom3EFcEL5ainnjsCHpaUYKhiJxm4dcG6c=;
	b=FcGt2eEhh9/nhOt/M8Gr0MKEpHG6/PZub+1E03/UjFlwLQ9SYamMkilDqxPj+bAV9Sqcx0
	IylNFh8H1xhDFtunNFGHtZFPOcqN11M7mUxoTubS1E1kqMbrHC3peJjDlSfbzXBteiWEg/
	LxUj89gqORX4eXGsnhYsdptzatUfYYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785221963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h49wrWZrnTom3EFcEL5ainnjsCHpaUYKhiJxm4dcG6c=;
	b=el1b+gqdqKqf/of0pDuh860JXNKGLydqWD+ViU1s+NDG1bJN8AW9aCR9F+tElPpHewYPYZ
	TUPU8ylQnn10z+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CDB4779B1;
	Tue, 28 Jul 2026 06:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eqMRIUtTaGqFWwAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Tue, 28 Jul 2026 06:59:23 +0000
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Cc: Johannes Segitz <jsegitz@suse.de>
Subject: [PATCH v4 1/2] selinux_restorecon: Do not exit on directory cycles
Date: Tue, 28 Jul 2026 08:59:16 +0200
Message-ID: <20260728065917.1343947-1-jsegitz@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

All other failures are handled gracefully. Directory cycles can e.g.
happen on BTRFS filesystems with subvolumes. Skip them and continue
instead of exiting

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/src/selinux_restorecon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 30f1b836..4233ba65 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1393,15 +1393,13 @@ static void *selinux_restorecon_thread(void *arg)
 		if (is_dir) {
 			if (descend && walk_is_cycle(state, ent_sb.st_dev,
 						     ent_sb.st_ino)) {
-				selinux_log(SELINUX_ERROR,
+				selinux_log(SELINUX_WARNING,
 					    "Directory cycle on %s.\n",
 					    ent_path);
 				close(ent_fd);
 				close(rd_fd);
-				errno = ELOOP;
-				state->error = -1;
-				state->abort = true;
-				goto finish;
+				prune_pathbuf(state);
+				continue;
 			}
 
 			if (state->sfsb.f_type == SYSFS_MAGIC &&
-- 
2.55.0

