Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0133DEDF
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065311; cv=none; b=pnlZw8cb10nUfzMgXc1cnla9b7HoR2a+g+94qONeUmTVNqxw4xlfxCPnHk1X4qqGMefM1VuY9CT4Obtcn7zRkNHw2U3///bUhftdNRefBkjuBqbaggxmB04oYNGoYMNlCRaF5embrygSUKGYimTYofr22AlEBdUnlUY3scFldIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065311; c=relaxed/simple;
	bh=9MJGpa4J+wLK3naJia+2K2n9J7YgaFKUKi3Izh3CJjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZ1Hm5kcp2O10b8Q5cze3zJFbG8cjoP2pcRGp/tR72Jv2nfarrLpS1srj8OMYPlcM4YefYV5YzjE3ZKKWCVP5qProLbhpNgJ7v457MBn+041nhtNHg32E4mBvFWG7LKH8Re0OfqCXebatvfZA85zjzV1EV+1/5rP0sMq2wxJJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x8rInOSN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J97tskiM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x8rInOSN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J97tskiM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x8rInOSN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J97tskiM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x8rInOSN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J97tskiM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2157D66DC2;
	Fri, 29 May 2026 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780065308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6v2c2E+DUTqkwt9HU9D3lxlKU2u43MpgHH72uj2udPk=;
	b=x8rInOSN8Fb4aJCWWvZzhzDeyCXh9km3Yn1DBsjnq+ourPsBsaNRbwq8O5UUEbVNqJNNYl
	cJCRbG0G40MeovjMV0CQPtizlzbtgfZI9FlcZaQO3Xbnk9sETyz/uwJwd5lcNoYMPJomwY
	2vgxx9grLaAKkTCvmX4SO2EhTLoNzIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780065308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6v2c2E+DUTqkwt9HU9D3lxlKU2u43MpgHH72uj2udPk=;
	b=J97tskiMFYD3KM82kyZypUlcpR+1TTwzn9xuruEIyWuYlw2Z9wRLYMJjcub6yM96eqjxA4
	7+6VuuG7rFWZ1TDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x8rInOSN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J97tskiM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780065308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6v2c2E+DUTqkwt9HU9D3lxlKU2u43MpgHH72uj2udPk=;
	b=x8rInOSN8Fb4aJCWWvZzhzDeyCXh9km3Yn1DBsjnq+ourPsBsaNRbwq8O5UUEbVNqJNNYl
	cJCRbG0G40MeovjMV0CQPtizlzbtgfZI9FlcZaQO3Xbnk9sETyz/uwJwd5lcNoYMPJomwY
	2vgxx9grLaAKkTCvmX4SO2EhTLoNzIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780065308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6v2c2E+DUTqkwt9HU9D3lxlKU2u43MpgHH72uj2udPk=;
	b=J97tskiMFYD3KM82kyZypUlcpR+1TTwzn9xuruEIyWuYlw2Z9wRLYMJjcub6yM96eqjxA4
	7+6VuuG7rFWZ1TDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE1FA779A7;
	Fri, 29 May 2026 14:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3pb2OBukGWo2CAAAD6G6ig
	(envelope-from <cahu@suse.de>); Fri, 29 May 2026 14:35:07 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>,
	selinux@suse.de,
	fvogt@suse.de,
	lautrbach@redhat.com
Subject: [PATCH v2] libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (bsc#1266385)
Date: Fri, 29 May 2026 16:33:34 +0200
Message-ID: <20260529143424.180246-2-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2157D66DC2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

We encountered race conditions where the built order was:
1. libsemanage.a
2. python-3.13_semanage.so
3. libsemanage.so.*

That happened when make was called with `-j2`.

In this case, python-3.13_semanage.so tries to use libsemanage.a and
- on s390x: succeeds and builds an incorrect python-3.13_semanage.so
  (that one was found during product testing)
- on x86: fails (manually reproduced, never encountered IRL)
  Reproducer:
  ```
  cd selinux/libsemanage/src
  make clean
  make pywrap
  find . -wholename "*libsemanage.so*" -delete
  find . -wholename "*python*.so" -delete
  make python-3.13_semanage.so
  -> fails
  ```

Therefor hard-require LIBSO to be present before SWIGSO and
probably also SWIGRUBYSO.

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 libsemanage/src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f870dc68..782e4045 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -82,10 +82,10 @@ $(SWIGLOBJ): $(SWIGCOUT)
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(SWIGSO): $(SWIGLOBJ)
+$(SWIGSO): $(SWIGLOBJ) $(LIBSO)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(PYLIBS)
 
-$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ) $(LIBSO)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
-- 
2.54.0

