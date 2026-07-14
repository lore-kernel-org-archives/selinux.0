Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34872EA468;
	Tue, 14 Jul 2026 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002200; cv=none; b=OGjuccZ4aAwVA3d2EXYw2uB6926lkbbi9ubhvAB+MzpkC6zGq2nHlx/OyhO9U/gwHUYdu7SNctJkomZoX1bw4tamD3CqBOIF9eHBHpxKcO+7MM0EAqZZbCA1TA7RU2w3C7EeMWtfpnJN5qiNakwrANi/KDSFEkBUv5CznFL5mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002200; c=relaxed/simple;
	bh=r9qAHXM2zd4FVX3LIXXdn3MvFOhDn6h5x2aMTJmQR24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mGTY/8K2VqbD/OEzdEN341IZo4veVUX8s9pBLn5h9n8UROJcuJdXmGMvjMYysZOiwzgoFutWjij3hPipPTLOtCRX6jlnQDxkD8nIrI0dwrB0jrQX3mMzCNc+GWRRdaXR5JRzlNZvp6rDiE/IePZFOTYz3Q9TqQC2MHHOiVTCVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=vV0PlLAZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqEtEOQO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="vV0PlLAZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqEtEOQO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E3FB3EC017E;
	Tue, 14 Jul 2026 00:09:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 00:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1784002196; x=1784088596; bh=CsGZTGFI5zpHU/1Zb8AytgBmYpEOxPNd
	1k65b5SEYvQ=; b=vV0PlLAZiyZ05m9Hjtt5UPyziDk4IRIWGqyj4WrAbibh/tQ4
	zqEcgaoz5qKemp5QerhKXPG+Y25kp0fDuhAAGLV8BbO3nV4VLKjE7mrxIw97Bqb3
	KDW867VxLUt+Il3wj1mCQinCgMKvEAp0U5KJPoTIviZIcfQPbXPbdpi6vLKxKUSV
	mD5yQxOZeYfOsHsUGlGhOYI2Nr7mQrGJGL7+MGStihoritoo+xF8a6SzPb9H1ktv
	0vrQWwjnKkrDTVUpHFlDT+b3lJurVjGtYnNq+Y/17w9997g758O2R4a6348vsXz5
	dP3NaLNeynfIsCsCBv2HRjCj/aiHn2vCmpSciQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784002196; x=
	1784088596; bh=CsGZTGFI5zpHU/1Zb8AytgBmYpEOxPNd1k65b5SEYvQ=; b=l
	qEtEOQOBbTJf4PPpIlXBcOU0BsgJP36r91jj+EnHP38Sm9fhlTGIOtQ3eb9evDB3
	ALy19Xz+hR36tAY/fS+D4bFbKmP4RT/ESEmzZSZWDp7rCZo1kXNi6JdwY/IeM1QD
	3Zr6YDRjArKcYb5rhp6ka4fkl/NRsh5K75zljI+pdbec9BGithJTImqxhUUAx6DS
	OBd3nabz4DJHJrkeRXuyPB7W2UzMwYzJTe+iFjE0Q9Kdxwh7hq1ycQ0RUCtuej9V
	pLuOkRTrz7int1XpUcMhYDbdBYsFp7AbaWkZhaFrr0piPAXMe2JY9KM7q+EP5vcQ
	0gqoDnGk0PAlpUsskk+9A==
X-ME-Sender: <xms:lLZVaoONxg6C8ZWcEqPJZfY21TYwHFEpMVy0SFLbmFqSW7JZBurYQA>
    <xme:lLZVagcdE0JHox1wCf3uZbOJ6IXTbQhlTrXOs5VwPXLeSssgAPXJqIGA2bQY_WBvY
    hD8SUxzuFK4LF6fnFGUVwQsq3Ap_Wxl_gbp63AYEAhgv0eZ_JOMjQ>
X-ME-Received: <xmr:lLZVavViwVfDzeMqESSOwhFJL97PkSs5JEAU7ZSdIGZkMs8fA81M-6Umef8>
X-ME-Proxy-Cause: dmFkZTGdZ+hlVJXMs5NsKKYoO98AJjqpD1IRSanayknuWCf04xCumbdvtZD+XY0EMTuLtO
    YAHfHzhGaQcyVTrw9KXkq4igwQU7338sy2TYgAhNcDoEaCrIM3RDzaDss8+O7axpLEnoRo
    Nx76kphfhtoAHbP/LCjP5uNn8h0HJvskN6OQcFB/V+BRraA80x/O89sodqioMH+EZAUgOy
    mJWPdvR6FqS7sm1AlnXgrxmUNlXc9n+l4Zt7s9YnDiOyKVjZDcT5JzXeNxyn5mNNhGuF7e
    lDPEb4kE/298wi6yPOxx371b0TkEesfci0ag4gNW7eJoW5o0CL4cl7f3c8wSR1Fl49X3Zx
    ABzeFkP3rIPQEqmVTAOwmdgHxsUQGqVMuDKS0fss+UbMg0QcWR9J5g05eT1Y0qG4bHij/F
    EKYNEIIBNuzO5BUhVPD8+hkujfoqgrg1l5k9x8sYEaM1V3xCa8WCwk6l2pYFkq3q66rb4u
    yvsbdh4KmIjWvOYL+cGP5oS5c48EsRb4goUE74lE0XKjFeGOYXXvxL1bdQM94hpwagA1lB
    TWiQlgFMN+TY0ZZmjbe143N2dGpha3gDpt6epxfqf7d+P0m39M5sfCjLgVD/eSjiEeBWar
    6WxZzvFwhK38lEm4fftvIRNRSWdWy2fwfeKJtgOwvzfvLsQyogaAkuaLxocQ
X-ME-Proxy: <xmx:lLZVagiaF9BXwvib0CZSgJzF11kMc-FVJRDMe8EdjVwg5uBUJlGdAw>
    <xmx:lLZVam8NCRRBeNdFzt9cXtYKqVFeBePMivmSamq69YB_q6EEupfOiQ>
    <xmx:lLZVaqazsUXRFaw684qw7z9Zj4xymjHWZe-ufj3RE4mSOp67IYgqhA>
    <xmx:lLZVal382y0QuYCprL-c0iiDw9VmyahS5YjVS5xp8rxz9PfOvfNbUQ>
    <xmx:lLZVauP3CSmKpTtWSzdoq73FJ6Cqvu-NEfj4w-VwwTZ8aoVCmH4lFGiH>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 00:09:56 -0400 (EDT)
Date: Mon, 13 Jul 2026 23:09:54 -0500
From: Ian Bridges <icb@fastmail.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: compute the IMA configuration settings string
 length once at boot
Message-ID: <alW2ktr8JUVlQNgU@dev>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

selinux_ima_collect_state() builds a string of the current SELinux
configuration settings. The string lists each setting as a name and
one digit. The length of the string therefore never changes, but is
still recomputed on every call.

Add selinux_ima_config_len_init() to compute the length once during
selinux_init(). Update selinux_ima_collect_state() to use the stored
length.

Suggested-by: Paul Moore <paul@paul-moore.com>
Link: https://lore.kernel.org/r/df755e0282dab3b932d19aceab71b7d7@paul-moore.com
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
The produced string is unchanged. selinux_ima_collect_state() now
depends on selinux_ima_config_len_init() having run. The call sits in
selinux_init(), as suggested in the review of the seq_buf conversion.

The length computation itself moves verbatim. The strlen() + 1 on
the string literal could become sizeof(), which counts the
terminator. That rewrite was left out so the moved block stays
identical to the applied code.

The patch was tested as follows.

- W=1 build of security/selinux with CONFIG_IMA=y, zero warnings.
- A userspace differential harness compiled the old and the new
  functions side by side, covering every combination of the settings
  and the policy capabilities. The outputs were byte identical. The
  stored length was an exact fit for the produced string in every
  case, with no overflow and no slack.

 security/selinux/hooks.c       |  3 +++
 security/selinux/ima.c         | 33 ++++++++++++++++++++++++---------
 security/selinux/include/ima.h |  4 ++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f4a4edbff2bd..1ead2eee1944 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,6 +107,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "ima.h"
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
@@ -7856,6 +7857,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
+	selinux_ima_config_len_init();
+
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
 			   &selinux_lsmid);
 
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index cb0efa2fc1ad..cda68122e032 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -13,6 +13,27 @@
 #include "security.h"
 #include "ima.h"
 
+static int selinux_ima_config_len __ro_after_init;
+
+/*
+ * selinux_ima_config_len_init - Compute the configuration settings string length
+ *
+ * The string is fixed text plus one digit per setting, so its length
+ * is known at boot.
+ */
+void __init selinux_ima_config_len_init(void)
+{
+	int buf_len, suffix_len, i;
+
+	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
+	suffix_len = strlen("=0;");
+
+	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
+		buf_len += strlen(selinux_policycap_names[i]) + suffix_len;
+
+	selinux_ima_config_len = buf_len;
+}
+
 /*
  * selinux_ima_collect_state - Read selinux configuration settings
  *
@@ -23,19 +44,13 @@ static char *selinux_ima_collect_state(void)
 {
 	struct seq_buf s;
 	char *buf;
-	int buf_len, suffix_len, i;
+	int i;
 
-	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
-	suffix_len = strlen("=0;");
-
-	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
-		buf_len += strlen(selinux_policycap_names[i]) + suffix_len;
-
-	buf = kzalloc(buf_len, GFP_KERNEL);
+	buf = kzalloc(selinux_ima_config_len, GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
-	seq_buf_init(&s, buf, buf_len);
+	seq_buf_init(&s, buf, selinux_ima_config_len);
 
 	seq_buf_printf(&s, "initialized=%d;enforcing=%d;checkreqprot=%d;",
 		       selinux_initialized(), enforcing_enabled(),
diff --git a/security/selinux/include/ima.h b/security/selinux/include/ima.h
index 38ab302f5946..d7d18f030d3d 100644
--- a/security/selinux/include/ima.h
+++ b/security/selinux/include/ima.h
@@ -14,9 +14,13 @@
 #include "security.h"
 
 #ifdef CONFIG_IMA
+void __init selinux_ima_config_len_init(void);
 extern void selinux_ima_measure_state(void);
 extern void selinux_ima_measure_state_locked(void);
 #else
+static inline void selinux_ima_config_len_init(void)
+{
+}
 static inline void selinux_ima_measure_state(void)
 {
 }
-- 
2.47.3

