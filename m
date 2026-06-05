Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52553A75AC
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683298; cv=none; b=kHsi3OmCRyyyw91pBtyghMD06esCYCzE5a96CWp6DvR+/NYNWXgCRI5tmi0fZN3sm9QS75PEf552OP1JZqEBf6zHSStPuHSSJlPSlxF71Bf5rrE7e0vd/dwR4a2wM2cHBWpT/CAYnomBbwlr8ds+xnFsYgxs/iuEystD0tflhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683298; c=relaxed/simple;
	bh=dwPKiGViHVhRnLDV3zjPI2iXc+ULjgaWxTbkaTqJquM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wu0FVT2ELkQuVYgvfEmxEDdvsQC3Msv3VPBE2mpYQ6zzipj6q/Z+aV1a4cDUOoygj+VL2F0+hRTmrXINXcxwzGV4P5tAHk1PXJHxIzfxpiEal0f5jKwBLgx8DgygtjavcK92Wn2Gb9fEPnQRvxWDqyh5Rb6WfsydHR8HYGnkbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hpAVekXu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hpAVekXu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780683295;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p7wh/Dta/jOTGLlvEzDnf5f1I8OlC7EbTcfbZ45WKi4=;
	b=hpAVekXuYWJCrk2pXjm0oiDYBPi8vwybKTiBF3opJ/b2FofKmVFgsiH57j6Dcsk2XOmbw5
	CPbEG9t4mW6un+5lua2PbD8/7tjtk3bgJZWRgY8YgyepHOZaxP3aHf2DrOgTfTSs3yq5iF
	tcdFsgPuTl12wEFoz8Diz+yLgYmF6x5hNxofYKxgSY7GtRD4e+xgmu6QJ7repys4Y7rZd8
	qcZWv1RFjl2zMJjMcrn7GTw19alXOymBjnw30jHYgXN6JSmbMiTprnKNcqkktZbRWH+hgs
	dXDt7MBEeVh3Av2MUQh6QH+9Anz+iJznIh58yTDUWLwwZ7YJBrzLMA49Y6a0Xg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 09/11] restorecond: warn on selinux_restorecon(3) failure
Date: Fri,  5 Jun 2026 20:14:41 +0200
Message-ID: <20260605181441.248083-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Warn in case selinux_restorecon(3) fails instead of ignoring.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: print to stderr when using custom user
---
 restorecond/watch.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 8e1c36fe..a30603c7 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -202,7 +202,19 @@ void watch_list_add(int fd, const char *path)
 				continue;
 			if (len > 0 && strcmp(&p[len], "/..") == 0)
 				continue;
-			selinux_restorecon(p, r_opts.restorecon_flags);
+			if (selinux_restorecon(p, r_opts.restorecon_flags) <
+			    0) {
+				if (errno != ENOENT) {
+					if (!run_as_user)
+						syslog(LOG_ERR,
+						       "Unable to relabel (%s) %s\n",
+						       p, strerror(errno));
+					else
+						fprintf(stderr,
+							"Unable to relabel (%s) %s\n",
+							p, strerror(errno));
+				}
+			}
 		}
 		globfree(&globbuf);
 	}
@@ -286,8 +298,24 @@ int watch_list_find(int wd, const char *file)
 				    0)
 					exitApp("Error allocating memory.");
 
-				selinux_restorecon(path,
-						   r_opts.restorecon_flags);
+				if (selinux_restorecon(
+					    path, r_opts.restorecon_flags) <
+				    0) {
+					if (errno != ENOENT) {
+						if (!run_as_user)
+							syslog(LOG_ERR,
+							       "Unable to relabel (%s) %s\n",
+							       path,
+							       strerror(errno));
+						else
+							fprintf(stderr,
+								"Unable to relabel (%s) %s\n",
+								path,
+								strerror(
+									errno));
+					}
+				}
+
 				free(path);
 				return 0;
 			}
-- 
2.53.0

