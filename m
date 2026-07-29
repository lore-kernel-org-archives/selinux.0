Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E68453A5F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336955; cv=none; b=KFXCMWb/MQSLrH7numMKgj+S7upqttAJihG6zwdQKWNUCfqx7/wjMsz6f4jCcIX7u9l2TeIhTiCb6e7erRs5cLCzecbgdWM2BVI8onW7ZbPNjxAytTga+FPRhUvhZWtVZ4Un+S6jK8xn1zoQD4I93pJjEbjXhFxCG/IbNn2Sbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336955; c=relaxed/simple;
	bh=/jDne0DJ5mbnxeiKPlQITec4XnYr8v8KEyfTR3pY3R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8vu1E9+9tINq7R5znJ16hUtB/YQFmKxJjT8JpXjYuYOGKVaXC/CcBhPgytUkBngdk17G5r1943iV4eEz6+z3t4GmDUYsDs5+Ltu+Q8Ejx5CA7kExTSt2ZBRbH/qa4kiGquOvHedqY13kL6xerag6VyotPD+GriULBuDOFUagDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I1rBGARB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VYpKOZ8O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ayJZHP9k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qqbHr+H7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I1rBGARB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VYpKOZ8O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ayJZHP9k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qqbHr+H7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29B317B89C;
	Wed, 29 Jul 2026 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785336948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wb79HNjBM9Ja9StHsSuAaDFNwpme22AHRjjnJkkhvE=;
	b=I1rBGARBptpgRnqQmfIIDXKrGEYM5DedfSwj9t5wbHqe7PwcvmRVMGdytmgZqv3tJxcx1t
	X1eRqyTwBdmxaiyYeatdF/jeFeeuqIfQMF/JE+jVdw8hpEK4fRn4itciVHeZLH5qKMkrC+
	+/lt2BM5VB/RSJdbzQVUhNOS0CxLo+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785336948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wb79HNjBM9Ja9StHsSuAaDFNwpme22AHRjjnJkkhvE=;
	b=VYpKOZ8OsnMXd/uujYC0NqnP+DiX5Dom5Wsuvy98DoAJha/It+t6anL9U9rpdTz4SM5Tka
	Fytv7e5wSVZpnTBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785336944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wb79HNjBM9Ja9StHsSuAaDFNwpme22AHRjjnJkkhvE=;
	b=ayJZHP9kxC+2RG86nvhxcNkGApPyOdMD8InujdikwJapFxaKmcLTTXBLBY25WMGAcFSM2f
	SFrBgtiUzjucWN7jmMNsPl+AYd8rL3Xfmcee5mko0dn7vQJ0KvmM41hg6hN8zO/ndfiw0U
	uEvjdDfdd146ZJgo8pHelstHNJzuF6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785336944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wb79HNjBM9Ja9StHsSuAaDFNwpme22AHRjjnJkkhvE=;
	b=qqbHr+H75TT6q+b2kYorGJJhiTIM9bQFRIY8SqUTCA3DY8CICyep7s5IB2vsNJt6B3BY+y
	RY0PDtQX5hA1OKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEA3779A1;
	Wed, 29 Jul 2026 14:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l7+DAXAUamqnUQAAD6G6ig
	(envelope-from <jsegitz@suse.de>); Wed, 29 Jul 2026 14:55:44 +0000
From: Johannes Segitz <jsegitz@suse.de>
To: selinux@vger.kernel.org
Cc: Johannes Segitz <jsegitz@suse.de>
Subject: [PATCH] mcstrans: harden systemd service file
Date: Wed, 29 Jul 2026 16:55:24 +0200
Message-ID: <20260729145524.3882905-1-jsegitz@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-2.99)[99.93%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,sysinit.target:url]

Start to harden the systemd services file with some of the
unproblematic options.

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 mcstrans/src/mcstrans.service | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
index fdcfb0d4..114c802f 100644
--- a/mcstrans/src/mcstrans.service
+++ b/mcstrans/src/mcstrans.service
@@ -7,6 +7,13 @@ Before=shutdown.target sysinit.target
 Conflicts=shutdown.target
 
 [Service]
+ProtectHostname=true
+ProtectClock=true
+ProtectKernelTunables=true
+ProtectKernelModules=true
+ProtectKernelLogs=true
+ProtectControlGroups=true
+RestrictRealtime=true
 ExecStart=/sbin/mcstransd -f
 RuntimeDirectory=setrans
 RuntimeDirectoryPreserve=true
-- 
2.55.0

