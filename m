Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34643C1D4D
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338783; cv=none; b=PhcTYMtLCHkxfkCJPnCsLI6zwPQ0+GUHPUVPE5Oo6f/QeONvb2Ba+Nr4H4OKacghpKciVO5xG1tBOm7FboatISVASSn7fJ4VlSSHqGOAkYyeKYlkQm5BpFTrLCm6ETq2Bva6W2j80oPVhGNgefnnQ1Wuct2jytFNCiSj071k2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338783; c=relaxed/simple;
	bh=cuQZv+rJ4uDyeLSFCmJBol65pVC394drdcrzDxyXzo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0FvvngzC1MOAivg3r6A13p+kKlt/jWHlWRHQIW4USbl9Mz98wOIi32sddRc9eTfwZz8Q7GpzTOoXLzu89RYjbqvgbpvNUHX2/FpkTLAfmK9Dq8Y6+rMGmcYU4zAaj4dpsVuCVxDxAnaRnb+hwW4GPV0qhkyUjDYG/zQ6U2Qzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sqZKqKh7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b70myQHI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COB8TXT0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cFLu8Diu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sqZKqKh7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b70myQHI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COB8TXT0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cFLu8Diu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62FE07B91A;
	Wed, 29 Jul 2026 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4dkrzt1uJlWwa0sCWA3bNMgbSl1KeMKn/90XfyPKbCE=;
	b=sqZKqKh7IU5ZUJeD6e1t7HBxVTa9Kd9i+9kiRLCRzqIjsHTicQCvA6jI1ngFOsbDJdWB2b
	3tXMtQwjTP2ODzs+5QyMvTy3p124o4ITdzTLF2ue8Y0Wgt2OIMv5xjndTeDKypluYHfOcK
	X1KrCzIl86iOI4WIb9+TAXqqNT1Xu14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4dkrzt1uJlWwa0sCWA3bNMgbSl1KeMKn/90XfyPKbCE=;
	b=b70myQHI+FdlRSfu9qy4PBxi9xzmNXpbTCAtSMqwh3lFTsFJR9j82LqCveWxckHfB8/E3g
	dnL/Pd7OehU8Z+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4dkrzt1uJlWwa0sCWA3bNMgbSl1KeMKn/90XfyPKbCE=;
	b=COB8TXT0BeRevSPgGq6yGxNyv48BRw9GqyHjesf/edDEn7ntnJG0cNn7eDoWh0J4R8ynlw
	s+Kknl8GgR6UGoxmcNJq5o+FkvVh4YQyziv4BNXjNWVVxIBJ71gkqXn+ubB8LctXw7kNAE
	DdJKW1A+GZaNFG2yYyYGys7a0yKOOMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4dkrzt1uJlWwa0sCWA3bNMgbSl1KeMKn/90XfyPKbCE=;
	b=cFLu8Diu5ip5nbjTbEKuGXge7dD7GSdP8ZTuKTsipSgwbRQzRFdnjR4kcnvX0WBUcHOMJM
	PMPdBe0dG4Be55CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55BCD779B1;
	Wed, 29 Jul 2026 15:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ghpjFJMbamqfbwAAD6G6ig
	(envelope-from <cahu@suse.de>); Wed, 29 Jul 2026 15:26:11 +0000
From: Cathy Hu <cahu@suse.de>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/2] libselinux: add pyproject.toml file
Date: Wed, 29 Jul 2026 17:19:17 +0200
Message-ID: <20260729152415.1606580-2-cahu@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Add a pyproject.toml file for the libselinux python bindings.

Fixes: https://github.com/SELinuxProject/selinux/issues/505
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
same as v2
 libselinux/src/pyproject.toml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 libselinux/src/pyproject.toml

diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.toml
new file mode 100644
index 00000000..dfc44e81
--- /dev/null
+++ b/libselinux/src/pyproject.toml
@@ -0,0 +1,24 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "selinux"
+version = "3.11"
+description = "Python bindings for libselinux (SELinux userspace library)"
+readme = "../README.md"
+license = "libselinux-1.0"
+authors = [
+    { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
+classifiers = [
+    "Programming Language :: Python :: 3",
+    "Operating System :: POSIX :: Linux",
+    "Topic :: Security",
+]
+
+[project.urls]
+Homepage = "https://github.com/SELinuxProject/selinux"
+
+# The actual .so is produced by a custom build_ext (SWIG + libselinux.so),
+# driven from setup.py.
-- 
2.54.0

