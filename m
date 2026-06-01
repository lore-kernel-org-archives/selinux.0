Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85D175A79
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323631; cv=none; b=nqklz9o2BqTD1ieSvp6Wk1L/qactGzvIZh0UehDI+LkP5FoRlvecjd9bN81mQPKcTpGgaQkgoYSZUC3WaZ9lYBZEzkLoL3m20XT6r7FOXZ5ZjfgBFGv0SiWrpbjWYdFMD9v79sOsnNMfa71f91o6gdeUnpgzyQW/ssp1qxrsbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323631; c=relaxed/simple;
	bh=7Xstpq/cbIxuFXvX7ziT8oJwZW/69LrS4gQY3+540uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdILMLOvoBrYnbjhkFr1MNnD9a/n/tl/lcLexCA9vLSxCfqlix8ea88P+si/HrPD0Ak0go4mkYm9nJbn2iP039oHjSQYi23SnRHowo6A4dLJim13QUqqwi314OfKMf+peCWKq/JfwKyG5sFmG8mtp7k/GoVZEgxlXR6WMPHNPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cz3b2L8b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9y/VCEtU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cz3b2L8b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9y/VCEtU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cz3b2L8b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9y/VCEtU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cz3b2L8b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9y/VCEtU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F28D67320;
	Mon,  1 Jun 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FAHwVV6BQRsja7TG6/G4Phat5Yt+0i4Fjw6uhBQ5U1M=;
	b=cz3b2L8blasuEK2mf908EisptfLsgWP4y1FM4I04c0rrUYj3tYOwhiPBdAMydWRi7UOjFp
	54mwg7aVJejbetoCoUan74X4NTdEbX6Dw7qqjlMylPkRQGD2eCU8d5I61jYZHTzLoECVP7
	joKPuwCTJZRTND+P4Il7BXnUONfAQDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FAHwVV6BQRsja7TG6/G4Phat5Yt+0i4Fjw6uhBQ5U1M=;
	b=9y/VCEtUQI/6ZlNUVjYjN+Bs657Q1cF5rT5oveJqsXAc+HZZQeDomGoX1Gmguutzf2KeGX
	+iugmDIP6hPStYCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cz3b2L8b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9y/VCEtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FAHwVV6BQRsja7TG6/G4Phat5Yt+0i4Fjw6uhBQ5U1M=;
	b=cz3b2L8blasuEK2mf908EisptfLsgWP4y1FM4I04c0rrUYj3tYOwhiPBdAMydWRi7UOjFp
	54mwg7aVJejbetoCoUan74X4NTdEbX6Dw7qqjlMylPkRQGD2eCU8d5I61jYZHTzLoECVP7
	joKPuwCTJZRTND+P4Il7BXnUONfAQDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FAHwVV6BQRsja7TG6/G4Phat5Yt+0i4Fjw6uhBQ5U1M=;
	b=9y/VCEtUQI/6ZlNUVjYjN+Bs657Q1cF5rT5oveJqsXAc+HZZQeDomGoX1Gmguutzf2KeGX
	+iugmDIP6hPStYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE2E7779A7;
	Mon,  1 Jun 2026 14:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hL5uJSuVHWoleAAAD6G6ig
	(envelope-from <cahu@suse.de>); Mon, 01 Jun 2026 14:20:27 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>,
	lautrbach@redhat.com,
	fvogt@suse.com
Subject: [PATCH v3] libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (bsc#1266385)
Date: Mon,  1 Jun 2026 16:17:07 +0200
Message-ID: <20260601141904.60859-3-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[13_semanage.so:url,suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3F28D67320
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

Therefor hard-require "all" when DISABLE_SHARED=n
so that LIBSO is present before SWIGSO and
probably also SWIGRUBYSO.

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 libsemanage/src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f870dc68..0241ef71 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -82,10 +82,10 @@ $(SWIGLOBJ): $(SWIGCOUT)
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(SWIGSO): $(SWIGLOBJ)
+$(SWIGSO): $(SWIGLOBJ) all
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(PYLIBS)
 
-$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
-- 
2.54.0

