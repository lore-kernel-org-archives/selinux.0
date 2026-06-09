Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CA3431E3
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022323; cv=none; b=R/8eEn9zymw40S/kawQQrsK2fr4pxcJrgzixvC/brCwXDXCJGYMXpx5zf77Dm6m92pADir4D52TDqDzG2vrCU3CmGiAe22sevgHVqxIuusHs15D9AximflFBB56OZmoc6qL2R/RuIsGA+F54LZiu5yRPOisX6BSooy2NW2E5MDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022323; c=relaxed/simple;
	bh=aNaahN4MRiJch9ubAz8VhDifhPMbwibVuf6msmyI1xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=isL3rVNH06R314Wl2EZokVt490vku3du34G3w95yoJkSmyAuOc9vFGbl/fo0mGJKNC3x8+NrI13ef/QXhvwYXhyEhjKQ8Az+URdsuwozdXra/GBjyEGNcZxF8JjwFU2dNpzDR62iPkprP/lDAQglTjoy3ut5yxRLQJRYAE3sLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rgHeS+p7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rgHeS+p7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rgHeS+p7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rgHeS+p7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AD5F75BAB;
	Tue,  9 Jun 2026 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1781022320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LHQkavjB3pH6ZbWnRUwf89s2vFs02NVIlCVxa2hrKn0=;
	b=rgHeS+p7CnKdYH40WFTRQnfhzbedX097aphIKeApq17/WIl5dvCdr16q11WHF+LxOU1+Vb
	EV4LKERS58l+ibDQqG8bRFJ1VBm/jiGv5vDkMopY6m7QjjmkqLwwqCBgaRrfpjhBPMFRec
	PS5sERhy2bzBmH7ltxewAZA/Rfp/AEY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rgHeS+p7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1781022320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LHQkavjB3pH6ZbWnRUwf89s2vFs02NVIlCVxa2hrKn0=;
	b=rgHeS+p7CnKdYH40WFTRQnfhzbedX097aphIKeApq17/WIl5dvCdr16q11WHF+LxOU1+Vb
	EV4LKERS58l+ibDQqG8bRFJ1VBm/jiGv5vDkMopY6m7QjjmkqLwwqCBgaRrfpjhBPMFRec
	PS5sERhy2bzBmH7ltxewAZA/Rfp/AEY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FC5C779A7;
	Tue,  9 Jun 2026 16:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jb7fGXA+KGqBRgAAD6G6ig
	(envelope-from <rfrohl@suse.com>); Tue, 09 Jun 2026 16:25:20 +0000
From: Robert Frohl <rfrohl@suse.com>
To: selinux@vger.kernel.org
Cc: Robert Frohl <rfrohl@suse.com>
Subject: [PATCH] sandbox/sandbox: fix saving file changes
Date: Tue,  9 Jun 2026 18:24:27 +0200
Message-ID: <20260609162427.47578-1-rfrohl@suse.com>
X-Mailer: git-send-email 2.53.0
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
X-Spamd-Result: default: False [-2.97 / 50.00];
	BAYES_HAM(-2.96)[99.81%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8AD5F75BAB
X-Spam-Score: -2.97

Fixes the following backtrace on saving files:

  $ sandbox -M -H sandbox_home/ -T sandbox_tmp/ /usr/bin/vim sandbox_home/cmd
  [edit file and save]
  Traceback (most recent call last):
    File "/usr/bin/sandbox", line 565, in <module>
      rc = sandbox.main()
    File "/usr/bin/sandbox", line 553, in main
      return self.__execute()
             ~~~~~~~~~~~~~~^^
    File "/usr/bin/sandbox", line 530, in __execute
      savefile(dest, i, self.__options.X_ind)
      ~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/usr/bin/sandbox", line 133, in savefile
      ans = input(_("Do you want to save changes to '%s' (y/N): ") % orig)
            ^^^^^
  UnboundLocalError: cannot access local variable 'input' where it is not associated with a value

Signed-off-by: Robert Frohl <rfrohl@suse.com>
---
 sandbox/sandbox | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index e3fd6119..4e7d56fd 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -126,10 +126,6 @@ def savefile(new, orig, X_ind):
         if rc == Gtk.ResponseType.YES:
             copy = True
     else:
-        try:
-            input = raw_input
-        except NameError:
-            pass
         ans = input(_("Do you want to save changes to '%s' (y/N): ") % orig)
         if re.match(_("[yY]"), ans):
             copy = True
-- 
2.53.0

