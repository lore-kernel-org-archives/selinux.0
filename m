Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49963B71C7
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020441; cv=none; b=GZm8Po3yoDu3eV7M/Sy5XW5oHolyn+T0qlcAM0cJGZHVd/hUBZ0F9V3w3ZgNbM5jiVf8d1AnkW22R7x6KMfcuU6qg4sAa7waiVblS5rwWHpQHdHrxE5kJIf+3xcb+lR0PkSwog0Wb5XMgoOOxcqi7QezhojlKd/UNvrlZE2v+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020441; c=relaxed/simple;
	bh=tnfx8cMt/WOL5RD9IO2cld3X4twxITk6Cel2OFukG9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGVGKDgb05tphq3Aed8kYgTL3pHt8ZxIPAmFwy3tYPmFuZ0J/mp8NRl1ib8Ws1zSSE1PGzCTGs397UP+TiAyyH6t2mbRz9vBpcz7NUZYLg8V6JYf1rPXis1Urrf2+ZNVh8QIrS4fInTfHAblSrPEBrZWG476XY0+V3DPFtJkZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPpbgcB+; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPpbgcB+"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so34051436d6.3
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790020438; x=1790625238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vg7Y3TJpnWZhisRfvRmvkpOR3D3AeejKW5KDrDGKV3M=;
        b=BPpbgcB+VsMApOmLvOEWkJc7VJsRQiSJ7vcR+YAFkqtCWny+IwHu/Zlvt9DJX97NXt
         HgwnDTX8X+btIM39qFP24ARyIJqakmCNehGYDqs4l/ntl3j4D+/7J7EgQzy5MgIc+k3a
         rMPF8g1d9sDN+rtSLHNtlkDztVsQxnpwjJDXMdzCdXsiSfXKFjLfh1/O4ty7RlbWXw89
         GLY+gQf6SJv1y+fNz6J7q9vrGzX8hvMQtfS2SkbmOh7t6Rl9oxF3F+bT4QOLxFiGlgMX
         Brvo8o9ztElyMt3kwpIEcVpLjMGcT1D5i0qGc/G4+0d3hxgXzspYJtW2jLBv0vbq1ZfK
         CETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020438; x=1790625238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vg7Y3TJpnWZhisRfvRmvkpOR3D3AeejKW5KDrDGKV3M=;
        b=LTimkWXe71CkGjiuxupveRlP9aWivl/oe2qSvjZFF1AhTvOl3wP1Zq+zzrGKngSu8n
         6IRu2PbaknOppaDP8c+PLPxcRnp5tVZasL4Uu49twn3KsJgeMRvdvsmjiLUcHVpKiJn8
         6Y+FY14YmdK9kZV+aP9liEoQeYEBVtAJfuFRg1kIuhSDlVuuhwRba37iY5wyA/QxZhgZ
         Ou9brSmwfJS8eq++Uzt4/045ISnL5qGGontn41A1H/WHATAkFGzSKi/WwQpQd6+MGre6
         eZEN0Lp6+hWi37ZjsAAHbfg9I/Hp8XnDGTDhau1UuR7c/6wUYXlNGUV2ZoADjP/XGJQE
         dMpg==
X-Gm-Message-State: AFuF++lHnaxM0IFFOIlg4mfgj+sxFTc9a4ph2iokDKrJcficlHH2pT/w
	qyZhqvL3Unyc+HUyZvniezCVIun0BI48rdUrD13ZOi05vGNt731Vw0amrd4F9Q==
X-Gm-Gg: AYBFou3FUJfE/L6XcR748oiTmGyUSrdVNRp07oZDqwxx7hsjq58Q3zw41Blfa+AvBRP
	Ua7DNDmFPswO4LCBJK89vMf7vlD49+HkZHAKSdByvyameV6LPAFN1BBtZrky0ImhzkzgkucNoAY
	jkWRVraLIgui8QWZcyKGNk+qVAjBHJgzaYvUo95Z1KZuSuD28NEXTdCrNlJHE7ysI0oAbrgipXV
	WlgxEU2oKiMOyMgoJz8kggQV4vE3grpLZ4+5rCTd9YkKFU+qlQcLEoiia/zlR+AnhWAA+MdHpuC
	IxnuuMRqrbDJZgnpA5vqHy7T6pGg496vh1xsZxjLu/1O/2dLzz5cMHVVhsm1VMAx6pPvBy+ie3Q
	9Z0PjeHXjp+pHFCuURmuERl3dWMjbRvS1WQtqsdnlShQANmgpzHm1AySlb0jpS5aoAD2i34+VDk
	irHWZ57bctGYo2IEWvChYIaaN6Ad/8+Xwkhdj+wZHq1f1VUcn+w3xMDEu8TvG+dBRnSsgnFDSOF
	jDJfVJJwdrG1/BOEpf1Jfm/SP0jxkNCZnY45Q1ccP/n1j/9XwaOLcZQKcvIaKEqnYZ1ZiT/V2c/
	YDLlZ3cOGw==
X-Received: by 2002:a05:6214:5a09:b0:912:517b:8fd with SMTP id 6a1803df08f44-913fc98495cmr23030456d6.47.1790020438569;
        Mon, 21 Sep 2026 12:53:58 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a8a0c0sm74709906d6.36.2026.09.21.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:53:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/5] libsepol: consolidate IPPROTO_DCCP/SCTP fallbacks into kernel_to_common.h
Date: Mon, 21 Sep 2026 15:53:37 -0400
Message-ID: <20260921195341.25227-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five files that already include kernel_to_common.h each open-code the
same IPPROTO_DCCP/IPPROTO_SCTP fallback pair. Move the fallback into
the shared header (with the netinet/in.h include so the header is
self-contained) and drop the copies. ports.c, cil/src/cil_binary.c,
and checkpolicy keep their own copies since they do not include this
header.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/kernel_to_cil.c     | 6 ------
 libsepol/src/kernel_to_common.c  | 6 ------
 libsepol/src/kernel_to_common.h  | 7 +++++++
 libsepol/src/kernel_to_conf.c    | 6 ------
 libsepol/src/module_to_cil.c     | 6 ------
 libsepol/src/policydb_validate.c | 6 ------
 6 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index f274d597..09ff5319 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -9,12 +9,6 @@
 #include <arpa/inet.h>
 #include <errno.h>
 #include <netinet/in.h>
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP 33
-#endif
-#ifndef IPPROTO_SCTP
-#define IPPROTO_SCTP 132
-#endif
 
 #include <sepol/kernel_to_cil.h>
 #include <sepol/policydb/avtab.h>
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index f338b588..3edcabcf 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -7,12 +7,6 @@
 
 #include <arpa/inet.h>
 #include <netinet/in.h>
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP 33
-#endif
-#ifndef IPPROTO_SCTP
-#define IPPROTO_SCTP 132
-#endif
 
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/hashtab.h>
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index f00302fc..f319ea50 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -1,6 +1,13 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <sys/types.h>
+#include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
+#ifndef IPPROTO_SCTP
+#define IPPROTO_SCTP 132
+#endif
 
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/policydb.h>
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index c6e8fadd..6c6e5603 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -8,12 +8,6 @@
 
 #include <arpa/inet.h>
 #include <netinet/in.h>
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP 33
-#endif
-#ifndef IPPROTO_SCTP
-#define IPPROTO_SCTP 132
-#endif
 
 #include <sepol/kernel_to_conf.h>
 #include <sepol/policydb/avtab.h>
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index baf98ab0..c00c8d33 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -27,12 +27,6 @@
 #include <getopt.h>
 #include <libgen.h>
 #include <netinet/in.h>
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP 33
-#endif
-#ifndef IPPROTO_SCTP
-#define IPPROTO_SCTP 132
-#endif
 #include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 8fb8e4de..0a106d18 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1,12 +1,6 @@
 
 #include <ctype.h>
 #include <netinet/in.h>
-#ifndef IPPROTO_DCCP
-#define IPPROTO_DCCP 33
-#endif
-#ifndef IPPROTO_SCTP
-#define IPPROTO_SCTP 132
-#endif
 
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
-- 
2.55.0

