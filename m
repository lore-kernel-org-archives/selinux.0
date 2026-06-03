Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54346AF3E
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488588; cv=none; b=pQGeZtVvPVCwj1Vq0OTlq9xyq3CUdinqpdr4VNHuKRrCSbSUiezVdVRgv+cJJj4lI3aygCliZqS/ZR26o8MooqDNxDC1vE5omHlWbOa2MmMGEglvf/n4yLat1Ne4YnpSsDw0pxhnNBZmWVi62okNPtomZt7ICurGRWgPHjIxSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488588; c=relaxed/simple;
	bh=bVrK5eyNS1CaFGYvz3nCzvR1VQk0XXf0DtBTWEnKUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEMo1Qg92cYxc4E2Sfid4WRoMpSuyygiDts1B6cDnPn8iH5D9tB+I56REt5eb+lMTOzsiWjYzc4yR2bguXWJefAtkaiaB463lJ7bettMlb+pC9X+mtQJmsn2r2po9DkJW9d3SS4jAUXFNitRB4ViZqJ6AXoemmyHUIYjPQUsnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zotKGqqp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/vuH4SHo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGpE9P+W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Ja3MoLc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zotKGqqp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/vuH4SHo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGpE9P+W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Ja3MoLc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75FE967581;
	Wed,  3 Jun 2026 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780488585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YA0yPD57SDvaYKclO3yYmSLVFdJh40dJcrZKfTAMOOU=;
	b=zotKGqqp3mC8l9e7mQmiAKofTFu81+qetDkgVdVjZgfZAh9H15NGLcbPc8IQmdgvXlTm1r
	5JWn3Ungs1RYnqXT1goftuusp+zpuniFbTAEPGSBvl0kJeJmr5il6F2XaqPhD1T1eV4FWg
	zmdEkw5vBuojHEMSdZmDoMxdIkz4mqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780488585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YA0yPD57SDvaYKclO3yYmSLVFdJh40dJcrZKfTAMOOU=;
	b=/vuH4SHofSBru8DzwEpeFvKlrNWDQ8Rn6eF3UpnsxWrAhjw/IteDXffDJoICeHgW6jin2A
	XRUVavWPQ9x2S0Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vGpE9P+W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/Ja3MoLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780488584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YA0yPD57SDvaYKclO3yYmSLVFdJh40dJcrZKfTAMOOU=;
	b=vGpE9P+WXhM+4UTOJemn5GNkykT7OdGuRE6+rQBlfY9JowdU3s0sBRLRvawbWiGBhmeSCa
	5kM6V/1LreQplTgPhkYw+zMjBFh4l3PCnjEDqN6kPaJ5yX+/EaLKKk7yhzzok9o1Tb6kJb
	sBSFybubPg4XXDuTPFk54wkA0ODEYDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780488584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YA0yPD57SDvaYKclO3yYmSLVFdJh40dJcrZKfTAMOOU=;
	b=/Ja3MoLcjIKXMcaVYw1p+QrAhmKT2U4x2zN2paD2qIo145ZsjB/FDu1D3VWRnyfhhXP1bB
	phmIizQcTPub6NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6022B779A7;
	Wed,  3 Jun 2026 12:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GeYrFogZIGrmdQAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 03 Jun 2026 12:09:44 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>,
	fvogt@suse.com
Subject: [PATCH] libsemanage: avoid "all" as requirement for SWIGSO/SWIGRUBYSO (bsc#1266385)
Date: Wed,  3 Jun 2026 14:07:48 +0200
Message-ID: <20260603120805.251365-3-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 75FE967581
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Commit 49131e5 "libsemanage: Require LIBSO before SWIGSO and SWIGRUBYSO (bsc#1266385)"
introduced a regression by requiring "all" in SWIGSO and SWIGRUBYSO.
Listing "all" will cause the targets to rebuild every time because
of .PHONY = all.

Explicitly spell out the requirements depending if DISABLE_SHARED
is "y" or not.

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 libsemanage/src/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 9199bd39..63c1499c 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -70,6 +70,11 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 all: $(LIBA) $(LIBPC)
 ifneq ($(DISABLE_SHARED),y)
 all: $(LIBSO)
+$(SWIGSO): $(LIBSO)
+$(SWIGRUBYSO): $(LIBSO)
+else
+$(SWIGSO): $(LIBA)
+$(SWIGRUBYSO): $(LIBA)
 endif
 
 pywrap: all $(SWIGSO)
@@ -82,10 +87,10 @@ $(SWIGLOBJ): $(SWIGCOUT)
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(SWIGSO): $(SWIGLOBJ) all
+$(SWIGSO): $(SWIGLOBJ)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(PYLIBS)
 
-$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $< -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
-- 
2.54.0

