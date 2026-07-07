Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AF420895
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426866; cv=none; b=DJIegB+iplvwe/w/xPznDbja2ov5YGmY9kMlD/A4GWR/ss0Uy5ifgvTa5GVKQtM3wslEtyv+quNHnxkQfq2vhFtB4MdIQ32QgzQsaIq4+CM/4XY7CjFRuMC9T6GYPuJmVQxzda+grL1Eh8e/WnKFCih69TJ8Ec6uMbCzoJ2sKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426866; c=relaxed/simple;
	bh=QnV5yZYnLytAFm5SYjD+2fE+vU9TegDRlvy3XIJAMVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhzfLLScTLMcE5qvhQjnkEqifzntAl5cPFQX1QYBqhV5UzoYvDM7RtwHCLXvZT6iV/AZRjaZvxcYkryXP06Jn382YXkEQjBfTcpA1cQFyo8+QCgCXyUBtg13y836lFmR7W819YOH4iRtdowsYPCCtskFFV/QIyj9L9QtsCfjN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ekQeuOVc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yf2vqoxv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ekQeuOVc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yf2vqoxv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ekQeuOVc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yf2vqoxv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ekQeuOVc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yf2vqoxv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6399974115;
	Tue,  7 Jul 2026 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783426863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k6Nyj9+2xlshIxw7edBXHhh0LWezhmvU4F9PgweeVOU=;
	b=ekQeuOVcdNWedT7hUqBOt+hen0zm1TEZ2dK+R9U4wEAFUz68B2n0411pYMR/eBLgXRz6RO
	JtvHv19uVshZ5dfuKjvmQ5wlja33zasR4gNxV4y8XfWPr9P3KPKt2slntcMKQyFmPH/oYS
	FSZj/K67R7TqNy6bOM+ZCqUdyElJTFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783426863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k6Nyj9+2xlshIxw7edBXHhh0LWezhmvU4F9PgweeVOU=;
	b=yf2vqoxvJeJwEKBYl1xqv9aGlrGTH/lYOdwbeIiyPUc/olApEpfjX830j8CCoAhevIupzB
	6fMtYJcV7gIHhzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783426863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k6Nyj9+2xlshIxw7edBXHhh0LWezhmvU4F9PgweeVOU=;
	b=ekQeuOVcdNWedT7hUqBOt+hen0zm1TEZ2dK+R9U4wEAFUz68B2n0411pYMR/eBLgXRz6RO
	JtvHv19uVshZ5dfuKjvmQ5wlja33zasR4gNxV4y8XfWPr9P3KPKt2slntcMKQyFmPH/oYS
	FSZj/K67R7TqNy6bOM+ZCqUdyElJTFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783426863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k6Nyj9+2xlshIxw7edBXHhh0LWezhmvU4F9PgweeVOU=;
	b=yf2vqoxvJeJwEKBYl1xqv9aGlrGTH/lYOdwbeIiyPUc/olApEpfjX830j8CCoAhevIupzB
	6fMtYJcV7gIHhzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A76779AE;
	Tue,  7 Jul 2026 12:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AQgcFC/vTGrJaQAAD6G6ig
	(envelope-from <cahu@suse.de>); Tue, 07 Jul 2026 12:21:03 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>,
	selinux@suse.de
Subject: [PATCH] Fix double-free in secilcheck
Date: Tue,  7 Jul 2026 14:19:34 +0200
Message-ID: <20260707121931.1175225-4-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

If the file size of the cil file is zero, fclose was called twice.

Fixes:
```
localhost:~ # touch ~/.empty.cil
localhost:~ # secilcheck  /etc/selinux/targeted/policy/policy.35 ./empty.cil
free(): double free detected in tcache 2
Aborted                    (core dumped) secilcheck /etc/selinux/targeted/policy/policy.35 ./empty.cil
```

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 secilc/secilcheck.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
index ee141bc0..b7c32bc6 100644
--- a/secilc/secilcheck.c
+++ b/secilc/secilcheck.c
@@ -155,7 +155,6 @@ static int add_cil_file(const char *filename, struct cil_db *cdb)
 	file_size = filedata.st_size;
 
 	if (!file_size) {
-		fclose(file);
 		rc = 0;
 		goto exit;
 	}
-- 
2.54.0

