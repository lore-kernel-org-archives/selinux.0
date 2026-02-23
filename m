Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB11ACEDE
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838445; cv=none; b=JEhIB2Zo156APdhtFuDS1s7i/H6vlzsfltVEMqaua9Q5S5bDw+uGFZCqxG++aA4+vE3EejClnybQwLILy+zrZ8VodJp5oWw9fw44DerFU8BaUQ7Obb+jyvOlkcyw3g3jI14u8xWvgKCPOdPQJnuy6lyY3AcKzjm4kALB2b36EgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838445; c=relaxed/simple;
	bh=zH+Pqx4RWP+fKRl42HgpSUvnwqXUWlFTJmhYQI0bpTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhLfxaA4jXelr0Gl7PT/5JDDj9xNQx9GA513LEIv3TxqT9m1OyRljB4frc2pKZzGBoyvKKtbP2XuBQhVojQniiiS2tvK1s/MwfsB2G/wYZkRp9TFJqLbuby0cCVj+cqohz45GH++0gpNJZOWNri9nbUYwgHvddxrNI5apK9ap+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kk6Ksmit; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+VFCyyhK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tSZJ+6xf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sqRwo2sA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kk6Ksmit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+VFCyyhK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tSZJ+6xf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sqRwo2sA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08DAA3EBBE;
	Mon, 23 Feb 2026 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771838442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R67+vwAiB++Jc3mjaOXFU78ZXi+cGp8msaxg9mafaNA=;
	b=Kk6Ksmitj4Jx9UqyL5UUaiK94TSuWHs9aoVPQU0WLByZRrkTLy0JcLsaintgXb5GaGfSTu
	RP3q3GqA2vGvg54XgrWG96EAUHnCfpmUjgHsXZP5vRFheUbieT2sEgXr/Uy4T4q5bx2eD0
	mgCfDJ1EAHWJU3ov9ye0MJaL8SGbrnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771838442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R67+vwAiB++Jc3mjaOXFU78ZXi+cGp8msaxg9mafaNA=;
	b=+VFCyyhKCfIy70BENBhinBVOXrjkmDKlBLonyIncMo1TpKO5rOyH71jCX+TPwI+HS2fBMl
	DBsRoLQUK6OgVhCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tSZJ+6xf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sqRwo2sA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771838440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R67+vwAiB++Jc3mjaOXFU78ZXi+cGp8msaxg9mafaNA=;
	b=tSZJ+6xfadqWyd4lc5MoskOZ55OjalxGmimFEo6iyqUVw4yHzFJy4IuUH4pJhzXNAB1b7V
	OJpGH1E0nTjNhQ8Th95vZpEA66ofafn+Awce+eQaaZTb1YUIP2UAH84lWmU3sND0rp8xup
	oS9oO2RuzfGskT/COHHeLHY76bc4HlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771838440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R67+vwAiB++Jc3mjaOXFU78ZXi+cGp8msaxg9mafaNA=;
	b=sqRwo2sABJV05Y0yR8J2A6rYBUGSV+vyETWhLPFSfVOp0vGT1a8rI1zcn+M8XD/LMezJV/
	vy3h5I7YD5728dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFAD83EA68;
	Mon, 23 Feb 2026 09:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 25d9MecbnGkzGwAAD6G6ig
	(envelope-from <cahu@suse.de>); Mon, 23 Feb 2026 09:20:39 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>
Subject: [PATCH] README: add SLES and openSUSE as distros
Date: Mon, 23 Feb 2026 10:19:48 +0100
Message-ID: <20260223091948.100473-1-cahu@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,opensuse.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,fedoraproject.org:url,readme.md:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.de:mid,suse.de:dkim,suse.de:email,repology.org:url,readme.md:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yoctoproject.org:url,fedoraproject.org:url]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 08DAA3EBBE

SLES and openSUSE are shipping the userspace toolchain

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index c272ce89..288ccca0 100644
--- a/README.md
+++ b/README.md
@@ -31,6 +31,7 @@ SELinux libraries and tools are packaged in several Linux distributions:
 * Debian and Ubuntu (https://packages.debian.org/sid/policycoreutils)
 * Gentoo (https://packages.gentoo.org/packages/sys-apps/policycoreutils)
 * RHEL and Fedora (https://src.fedoraproject.org/rpms/policycoreutils)
+* SLES and openSUSE (https://src.opensuse.org/pool/policycoreutils)
 * Yocto Project (http://git.yoctoproject.org/cgit/cgit.cgi/meta-selinux/tree/recipes-security/selinux)
 * and many more (https://repology.org/project/policycoreutils/versions)
 
-- 
2.53.0

