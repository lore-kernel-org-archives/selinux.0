Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382718DB1F
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394403; cv=none; b=Q0ODp1drRn1YXriLLZsETmCUa73a0T+nVCqQ4upe1GqckhRvqmNLFM/vuA13jtVhun9+PjjMzpqd0bN1IUPgx2Dvvxxwrxpz0mzmPE220AG/Qt/hGy/aQ9bOrkJmdHbi3cawIlyVVjsN2DOGEO0RoA4Pkkbn1JPAORdak+NQhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394403; c=relaxed/simple;
	bh=/rGMgrXh41jdjWfvWQYOc53UFymojcSHHuVTjbgHMQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRsprocz5VngmneL4OQjTq/1MizG/Nb7Lmvtb8WvPuLiw6llKgMceJzjnEUa9WRvG9QljkCFnVgxlKoMcbC4em1YgdIiats4J5M846EvM0QEgsrVXZ52/B99S/lDnF9AqhHF/FbYSXQrBbG8W+gGQNM2S6Txc9H4skqp43p5jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i9rgsljY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dlb45ggH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i9rgsljY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dlb45ggH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i9rgsljY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dlb45ggH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i9rgsljY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dlb45ggH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC1D1689A6;
	Tue,  2 Jun 2026 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780394399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4C4fRdy1xIrmM0dx77haNrgdXeCvV9ATtAfOCs6UQA=;
	b=i9rgsljYV2Vct6uiw74B2LeZD2IhgSOEnTgRqqh1u9IBYu6vUjD/nkGEtdtrXCzt1dmG5w
	R/44YhJELY+5Cu3HW2zOocUTgUsV3Ln1FBb3NTMwVfHw02v1LDQ3+nUpaiE7+iqGnQ2gSc
	JBMpR/bEjBPbI8zRRlMzXjUQsnJkYOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780394399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4C4fRdy1xIrmM0dx77haNrgdXeCvV9ATtAfOCs6UQA=;
	b=Dlb45ggHUP7DHXAMwSDikc5hH1qlM0WINZEwo/0UrxRJN5vqeFMeBTTQTUm7hTkDmrKnGs
	NBglWHn7chk2FeCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780394399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4C4fRdy1xIrmM0dx77haNrgdXeCvV9ATtAfOCs6UQA=;
	b=i9rgsljYV2Vct6uiw74B2LeZD2IhgSOEnTgRqqh1u9IBYu6vUjD/nkGEtdtrXCzt1dmG5w
	R/44YhJELY+5Cu3HW2zOocUTgUsV3Ln1FBb3NTMwVfHw02v1LDQ3+nUpaiE7+iqGnQ2gSc
	JBMpR/bEjBPbI8zRRlMzXjUQsnJkYOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780394399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4C4fRdy1xIrmM0dx77haNrgdXeCvV9ATtAfOCs6UQA=;
	b=Dlb45ggHUP7DHXAMwSDikc5hH1qlM0WINZEwo/0UrxRJN5vqeFMeBTTQTUm7hTkDmrKnGs
	NBglWHn7chk2FeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AF0779A7;
	Tue,  2 Jun 2026 09:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r/G9Jp+pHmppbAAAD6G6ig
	(envelope-from <cahu@suse.de>); Tue, 02 Jun 2026 09:59:59 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>,
	stephen.smalley.work@gmail.com,
	lautrbach@redhat.com,
	fvogt@suse.com
Subject: [PATCH v4] libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (bsc#1266385)
Date: Tue,  2 Jun 2026 11:57:37 +0200
Message-ID: <20260602095844.115761-3-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,redhat.com,suse.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -1.30

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

For SWIGRUBYSO switch to using the first requisite only
($< instead of $^), as it should not include "all" and
$(SWIGRUBYLOBJ) evaluates to one item only.

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 libsemanage/src/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f870dc68..9199bd39 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -82,11 +82,11 @@ $(SWIGLOBJ): $(SWIGCOUT)
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(SWIGSO): $(SWIGLOBJ)
+$(SWIGSO): $(SWIGLOBJ) all
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(PYLIBS)
 
-$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^ -lsemanage $(RUBYLIBS)
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
-- 
2.54.0

