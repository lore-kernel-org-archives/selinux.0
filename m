Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FD197A7D;
	Fri, 26 Jun 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489437; cv=none; b=N5rdYQOJ3jpbENMHyeEzLBYZIRnZlJgbe3wBNyZGKts+I5cBYtty7rQzGG7Fh4drcv7l/kiRVAgqiL2OeyKkcW42bklBPULVvPEGzhQHkSjO0lEXFxLGQW2bTrOC+g2+dkmO3ste1lGFL5T2XWyTleuKIrOWvUeTX6rZTYGOfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489437; c=relaxed/simple;
	bh=yPAlb8Ui5Zj40cwMQLJtp4HZS8TEkFZLEgfWTysqu8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HtpbleuUWy5wOTD5Sd7u9uK/DBoJ2lZfZvcZU+45sxfgibKM4whQnTaYCsz3hnBDqJHrb9pdR2s3yjbCyhbx3vjLqMR5M+HpCjD/GNPdEUrBBO3NEOYLtuWcVHbnOBDAqYcZn3WZsy/7fFgSdqbIJ2+tgFj2i+RXT/f5JC8m3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=Tbv5DrPF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQVmppr/; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="Tbv5DrPF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQVmppr/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 133F61380C23;
	Fri, 26 Jun 2026 11:57:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 26 Jun 2026 11:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1782489434; x=1782493034; bh=opuKrtUE/2bKi1cyeB0bUYvy6wt0jZot
	m+Li6EvISX8=; b=Tbv5DrPFTK5L6KyGw6Uf458OCMKIlGKz+0/sHQVtzIo/PNkc
	SfGhYg6YbMY+aBq2zk6K21x54JyCIy96VmyvwgDyvSAtfFIjRHgdADQv9htCcrkp
	YWadim9X9XIBysmil9yJ9dGwRXXFGPxvcAeYziufBCejreQOwP/DCVQATbvYFdgS
	5Mgznf0WvIk2iDmihTp5mMue529jD424Aza01OXudi2U+JWwgNxBwhhBnxeKGF7m
	11sDZ9G1oeFRm8u671/gMv/RIHBBa3zHZ5daCs3DdVRB0wba/xH6lW0Y/HCXocfW
	hIFodonuGWh/LnOKcNmlcV7G8Z4YHRJQ1Wtp9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782489434; x=
	1782493034; bh=opuKrtUE/2bKi1cyeB0bUYvy6wt0jZotm+Li6EvISX8=; b=X
	QVmppr/XtLwZfoAgZr82tr/o7CuthCYmtgQeS8a21ySsVGeuTPsHuOtVHz+mZYrJ
	N58T1PGosxwKN9/PNtXlhUrik2jBcrFUw33Nqbaq4UqEfcBffwsfCoqm/lFPqEij
	ieWaNpHqVeSTCB6drP62kj65FZ3d/9FhIMlsAzmvCazjo4afs5CHPpRKaINTRieZ
	facvoHULcLqfHmugwcr2i6uTQuhT3244aYlGL3EW4f1LMv6m60ypkEM9GL65NCEz
	upigMC+hJrpaEQ7/2TQvC6k9+rjIxdAQ5hFxvsnvgsqWPvmEg45FUqLwLCrYfxRL
	ZgGD5m2gNylUweD0Mnsjg==
X-ME-Sender: <xms:WaE-anvKb_1SG2rjUTis1Ru4TawpPGRA3hqfPPSdTq3-Pgeys_Ijwg>
    <xme:WaE-ajbXFzsD8bD1QSWrHSiAU9ONNYv9m5HryiQ4gu4nbxR_WoHQCCfqjLZxlueUt
    ktFtcabFVjxC8zAuOEbfvD1yvuwRbx5tDd7k4-OQYLsmQNg7S8XPg>
X-ME-Received: <xmr:WaE-apycUdwvOv-esk4OrZNpypJ9mtvuaJHJsNkCZNoet0Rv9bOrcZRFQMs>
X-ME-Proxy-Cause: dmFkZTGv5wm1aBrGFc5VxFaDJ73BYzDkCyCs7qD2tlEKVNj/3/sm48JJlq/OBszWXCyYZU
    BwUzsVkrCo9NaYQlMCnzs7mntTbfubZBW8KgdKcASVpKPCOh0sBv7mzzTnLhzJdj+8GjE6
    WS3Pd96HTL8B8Sndl1WCfVkQJ6c4sweHCRKq8vGIg6CWy3Mt78pdM/X83BUvZPARg67zMT
    gHRK6nDA3cPBo3rrFuHp7c717MNTkDPWQG4FuuoGrxcuaK+BEhDCORyTuKeLFI6CoNrLC7
    DEBF2l54X9qYHQddmj1cY35wcvU97YnOR7vs0j2utiCY1XSib0CcHBWDzDzK8YpwbPLiQg
    4tV4FUldIJNif0CbhaDT+iz56V2VZ/CGv60hq4CVwdlUP+35rnIY6Kn5gHwGUWFDydfVsd
    qw28ZQ6THpJ07rYAdIkCT+nWrgfX3HxMTsn+5q6ZSEJQSsGQZ4/Xp/LMd9OqSTFloC11Uy
    mIGN4xj+K+1Rhsz3eaIj4WozOfzAGIOPy6a8ewY4n0DmcCtB/b3SB78PmpIbmez0JUNlgI
    xd5OlBpoXXsfFdxqCAZKd4aK3+q8G7OIMhKs7+C9rWa+Q0krzmKgwpc1UVXgGEs3A3OK6E
    IWbRrUIs8upbMX9TaosKhfpFNl45txD5ZZp0b6Y4x0Dq3LJh+l3G0JyzPEHg
X-ME-Proxy: <xmx:WaE-arjaEcgP4HyDfthKqFh80bkIE6R94shnqjqXE_etPUq8ukh8Vg>
    <xmx:WaE-allM_1bL8cp9FcurCpVWMS_CSEeCUYxqYScCjSMoyFpvrmMkOQ>
    <xmx:WaE-ahjmBoheAmthLH_tsxhXABTIE-3KQgtueuBiTkcBgo3eH3UGRA>
    <xmx:WaE-ap1cflN9oLWH9j5qSIJkiGesuJieU4Ww-DilpZdWc7xLjxFySQ>
    <xmx:WaE-aiTkzdcWmr2rqNUjP2dNDUMtQbaONxhAM9esHjHGwCyhkBX8UGEH>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 11:57:13 -0400 (EDT)
Date: Fri, 26 Jun 2026 10:57:10 -0500
From: Ian Bridges <icb@fastmail.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH v2] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <aj6hVjECikvYtnED@dev>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the deprecated strlcat() API[1], replace the
strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
seq_buf, which tracks the write position and remaining space internally.

Each field is written with seq_buf_printf() using a "=%d;" format, which
removes the open-coded "=1;"/"=0;" constants. The seven per-append
WARN_ON(rc >= buf_len) truncation checks are replaced by a single
seq_buf_has_overflowed() check after the string is built.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
Changed in v2: replace the v1 seq_buf_puts() pairs with seq_buf_printf()
using a "=%d;" format, which drops the open-coded "=1;"/"=0;" constants.

v1: https://lore.kernel.org/all/ajlN94VO7BYNUTAy@dev/

I didn't change the precomputation of the string size. An alternative,
which is used by other seq_buf callers (e.g. kernel/rcu/refscale.c,
mm/memcontrol.c), is to drop the precomputation and allocate an oversized
fixed buffer, relying on the seq_buf overflow check as a backstop. I'm
happy to rework the patch to adopt that alternative.

 security/selinux/ima.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index aa34da9b0aeb..cb0efa2fc1ad 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -9,6 +9,7 @@
  */
 #include <linux/vmalloc.h>
 #include <linux/ima.h>
+#include <linux/seq_buf.h>
 #include "security.h"
 #include "ima.h"
 
@@ -20,46 +21,31 @@
  */
 static char *selinux_ima_collect_state(void)
 {
-	const char *on = "=1;", *off = "=0;";
+	struct seq_buf s;
 	char *buf;
-	int buf_len, len, i, rc;
+	int buf_len, suffix_len, i;
 
 	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
+	suffix_len = strlen("=0;");
 
-	len = strlen(on);
 	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
-		buf_len += strlen(selinux_policycap_names[i]) + len;
+		buf_len += strlen(selinux_policycap_names[i]) + suffix_len;
 
 	buf = kzalloc(buf_len, GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
-	rc = strscpy(buf, "initialized", buf_len);
-	WARN_ON(rc < 0);
+	seq_buf_init(&s, buf, buf_len);
 
-	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
-	WARN_ON(rc >= buf_len);
+	seq_buf_printf(&s, "initialized=%d;enforcing=%d;checkreqprot=%d;",
+		       selinux_initialized(), enforcing_enabled(),
+		       checkreqprot_get());
 
-	rc = strlcat(buf, "enforcing", buf_len);
-	WARN_ON(rc >= buf_len);
-
-	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
-	WARN_ON(rc >= buf_len);
-
-	rc = strlcat(buf, "checkreqprot", buf_len);
-	WARN_ON(rc >= buf_len);
-
-	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
-	WARN_ON(rc >= buf_len);
-
-	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
-		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
-		WARN_ON(rc >= buf_len);
+	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
+		seq_buf_printf(&s, "%s=%d;", selinux_policycap_names[i],
+			       selinux_state.policycap[i]);
 
-		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
-			buf_len);
-		WARN_ON(rc >= buf_len);
-	}
+	WARN_ON(seq_buf_has_overflowed(&s));
 
 	return buf;
 }
-- 
2.47.3

