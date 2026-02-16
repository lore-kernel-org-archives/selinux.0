Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74C311C2F
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258074; cv=none; b=r3tyoiLtzeeLE5v6BcxlCjQQEJHKv75OJIB6Zz4lozUrBDGRB0iJNxTggUxwao0WPnMW4S5ewnXMWC9YbtlzoXZ0srcwEcYNNJHlJkZCb+9+O4dO6q0t8RDNxIDuQfQTTqf2qz+juMOnTNHRJ88EayglRtqeNbNPRJJKvRfFhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258074; c=relaxed/simple;
	bh=W57d+TplG9y9OLY0P9qvNSgo0ghGojQ+6inw5FFCr5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Obi5HBzEOGJw7RdW/onEInQHBajhrFEajhohLffBObA/1RmkK28an0SiRlZZa+awalRyyCHXebygqb7323JO1WOo3GtceMv3rgN/epbJa54AKR5uQlCZ4/+qOePR4AJcXYDdfvWG2C8Y6GINeDgbrHdlEPpYILQQooyXKQSiNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJ1B8SMx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJ1B8SMx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJ1B8SMx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJ1B8SMx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C7815BF0A;
	Mon, 16 Feb 2026 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771258071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=duXbeqzL1JIv8E9hZNUNfvuZzIVBMr3x03+aZJD1DoI=;
	b=bJ1B8SMxWaG12sLkeY3XIgFD/r+gZ9PvK0Kiv+Kn42SxZceM1hvlZzZP7exFG2cSJNyvga
	iqKRbChj88o1MGHQg7m9nugaN3b6EiXnoKPr0N96p9OgcU4ABnhSq1tJwyyUmUJs3Cf0Ce
	2XdF6p1rD8HmHAQQ0QH/5IlT0YtEp1Q=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bJ1B8SMx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771258071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=duXbeqzL1JIv8E9hZNUNfvuZzIVBMr3x03+aZJD1DoI=;
	b=bJ1B8SMxWaG12sLkeY3XIgFD/r+gZ9PvK0Kiv+Kn42SxZceM1hvlZzZP7exFG2cSJNyvga
	iqKRbChj88o1MGHQg7m9nugaN3b6EiXnoKPr0N96p9OgcU4ABnhSq1tJwyyUmUJs3Cf0Ce
	2XdF6p1rD8HmHAQQ0QH/5IlT0YtEp1Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED21B3EA62;
	Mon, 16 Feb 2026 16:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ilr+EdVAk2m5EgAAD6G6ig
	(envelope-from <cathy.hu@suse.com>); Mon, 16 Feb 2026 16:07:48 +0000
From: Cathy Hu <cathy.hu@suse.com>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>
Subject: [PATCH] Disable build isolation for sepolicy python module
Date: Mon, 16 Feb 2026 17:07:34 +0100
Message-ID: <20260216160734.126597-1-cathy.hu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.89
X-Spamd-Result: default: False [-2.89 / 50.00];
	BAYES_HAM(-2.88)[99.49%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9C7815BF0A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

From: Cathy Hu <cahu@suse.de>

same justification as:
https://github.com/SELinuxProject/selinux/commit/17a9372391ad2c9bf0e440391d6fd13cb8cfdaf3

Used patch by Daniel Garcia <daniel.garcia@suse.com>:
https://build.opensuse.org/requests/1333291

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 python/sepolicy/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 1a26cfdc..ccb22fe7 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	$(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.52.0

