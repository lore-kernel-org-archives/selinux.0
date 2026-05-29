Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB928B7DA
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059212; cv=none; b=m7A5O685Ri5kKtw8Eb0Y8xnxDh6fEgbW01rNAHXcb/DAMjM/YB+8s3cl9Jk3H3qTE9BXV0IotGUx2nWCaATwoEOOuArg83Q8dGSXq9K5xGbSNlSY5otAgpGtDybn2hiGXffByZ2ZKRtgwEgkD0+C5Qn1K+YlEy82DXlrx/2yQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059212; c=relaxed/simple;
	bh=DEwU6H1KmDjt7LLRTMk9l0y0299/5fNUWmw6kZqJmaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf0ZJoddBMXR6T040+x+aSOzoAPoNrnrLlo9X6xhPebMjM3sZdolS+TB9XPPj7q3JGjmHBB5TceHtREXT8L362aRButijcP+PPZ9DvEJliV5+vDZE4UH8heqyFTpjzWVbdVEvCTM2xo42tpcahizSNpt3CeA+XkTcax2YNwMpeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q9SdUhv+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BTdcWJ/P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qt96Kn+3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GLATuYG8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q9SdUhv+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BTdcWJ/P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qt96Kn+3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GLATuYG8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6302866FB4;
	Fri, 29 May 2026 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780059209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bpxgz95yItsTfg8VQCPGJc4k/BgR8g8EVrmJhyD4h/Q=;
	b=Q9SdUhv+TwLCfHOuji7leZgUVrtxtsqR9Dkj6qzvpokZo5Fzk1igAOU+QRIofK/gKB2jdC
	7EkKZyooSmrMnR7c0uqvxriFAEv522zXth+gGNqfsUs3y9Jb4jdzy0+11vOaWOSka8zOPa
	ov1hy9jbgBvmuPVq77vIKArf+65tcRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780059209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bpxgz95yItsTfg8VQCPGJc4k/BgR8g8EVrmJhyD4h/Q=;
	b=BTdcWJ/PGvkTnhfT9PgpWxFmIZBL3Yi2MEnPYmxGsfjBOUE4+2+vlWPEHeSFxmZVPHVOkZ
	6ybHUMKxJIXhhRDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qt96Kn+3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GLATuYG8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780059208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bpxgz95yItsTfg8VQCPGJc4k/BgR8g8EVrmJhyD4h/Q=;
	b=qt96Kn+3ALMXd7vobGk5r+9CzDaccjxqgVkfRdeTBTLmqBvXGcD7AT9iS7Hk1UQ4w7gWFE
	2Ilb4w5CA1dfWn/U64oqIAMngvmGGUFjiiIouyAYK+9vNyIekhba0w3HRdyGwQX2u8K0ow
	ri2QegCJc4aw+Bwa22wd6/sGx7pdgSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780059208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bpxgz95yItsTfg8VQCPGJc4k/BgR8g8EVrmJhyD4h/Q=;
	b=GLATuYG82bf01NL0NkObwrkJU60nAD86i+WlkqPMJl76q1VFpcAEx4rLHqqxmpyp9msCJG
	alqlqWUG7bZ+vQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FB97779A7;
	Fri, 29 May 2026 12:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/hkDkiMGWoYIgAAD6G6ig
	(envelope-from <cahu@suse.de>); Fri, 29 May 2026 12:53:28 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>,
	selinux@suse.de,
	fvogt@suse.com
Subject: [PATCH] libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (bsc#1266385)
Date: Fri, 29 May 2026 14:50:57 +0200
Message-ID: <20260529125126.159687-4-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6302866FB4
X-Spam-Flag: NO
X-Spam-Score: -2.33
X-Spam-Level: 
X-Spamd-Result: default: False [-2.33 / 50.00];
	BAYES_HAM(-2.32)[96.81%];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,13_semanage.so:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

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

