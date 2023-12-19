Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021C1D53F
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KPMW/XAT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a268836254aso29889266b.1
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002217; x=1703607017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPxl73yp8gvv4Ub9Kt55vpgHWcFNiSXPFtyzcpZrOWE=;
        b=KPMW/XATfXdTqocwjqsVbpwqQRx16DEHxEkrQN36yPkVC9dEhuUWa29boYBwXNOPAd
         /iyIrhys19E6NXbELWkG8uksqZjOc2aBB5qrMF06UApMLW9ijEzc3G0EJ2a59xyJnLGk
         dTYIfFTElRlxuLtOBQ0kre1vUW8psHEQyq1Me6tt++GSOYzDQQ23aaPxelsa/UqhTuca
         9Uy8SfK6DiTOvSnU8SmWK7WM6yL9hCqmQOpLN//XJdQQq5aUc/FgndOKvZi2x3W3dPuv
         FG/u2zPw6n1gRfNKOVrSb5s1k5Fo7V3HEKjdyhtrEd40tbYDf0JhUpCKt6Vg6WowK4bv
         1eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002217; x=1703607017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPxl73yp8gvv4Ub9Kt55vpgHWcFNiSXPFtyzcpZrOWE=;
        b=Dlha//brM1rwx0lOKml+uYsGv4RDPN3jWPcjdq5GSsg4zJUVj7s15r2363WDcgRpFj
         c/ZLL8Hh63ahVa3R4xmhybocPlelFq17E8WiM9Dl2/ZrPHI0JQFj8G8UXZw+7hWtvxaV
         bbp8oaONQ1Bas6zgD0yviARZ0a9HvJPnoAi24u3/5EUpoF99YSYKt7D/FEzGSSo65A8m
         tfEydXQi6W7VZGS6fFE1abZwuKyTfLOksEjLUXKXVk4Z5+CTd/cbM7IwvrNDwWTNkCtv
         iQ2srbZkmI017JugJrHu6s1cD/pNsPqz5b9wUy+V9xZzFxh1F6VP5CP56GBiU5A/o/XE
         y+2w==
X-Gm-Message-State: AOJu0YwSJmgUYoOcb+rtaw56iUZXxcXJTfujYBTSr1QvGcwCqM1krEsW
	FGQjRmVii198rJRMOAZy21nX6hL7blE=
X-Google-Smtp-Source: AGHT+IGl2oGGKgaoQ/l1e/U1l/TgKaGjugLcyrpZqNbDL++5s8T0oFwyWld6ZcUwcTZ82d5nWMXIRA==
X-Received: by 2002:a17:906:b30d:b0:a23:5758:bc3e with SMTP id n13-20020a170906b30d00b00a235758bc3emr1570040ejz.96.1703002217293;
        Tue, 19 Dec 2023 08:10:17 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:16 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 08/11] libselinux: support huge passwd/group entries
Date: Tue, 19 Dec 2023 17:09:30 +0100
Message-ID: <20231219160943.334370-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

getpwnam_r(3) and getgrnam_r(3) might return ERANGE in case the supplied
buffer was too short for the passwd/group entry.  Retry with a bigger
buffer.

Also use a fallback buffer size in case the libc returns -1 for
sysconf(3) of _SC_GETPW_R_SIZE_MAX or _SC_GETGR_R_SIZE_MAX, like musl.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/seusers.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index e5cfd510..16d69347 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -6,6 +6,8 @@
 #include <stdio_ext.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
+
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 
@@ -99,15 +101,30 @@ static gid_t get_default_gid(const char *name) {
 	struct passwd pwstorage, *pwent = NULL;
 	gid_t gid = -1;
 	/* Allocate space for the getpwnam_r buffer */
+	char *rbuf = NULL;
 	long rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (rbuflen <= 0) return -1;
-	char *rbuf = malloc(rbuflen);
-	if (rbuf == NULL) return -1;
+	if (rbuflen <= 0)
+		rbuflen = 1024;
+
+	for (;;) {
+		int rc;
+
+		rbuf = malloc(rbuflen);
+		if (rbuf == NULL)
+			break;
 
-	int retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == 0 && pwent) {
-		gid = pwent->pw_gid;
+		rc = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
+		if (rc == ERANGE && rbuflen < LONG_MAX / 2) {
+			free(rbuf);
+			rbuflen *= 2;
+			continue;
+		}
+		if (rc == 0 && pwent)
+			gid = pwent->pw_gid;
+
+		break;
 	}
+
 	free(rbuf);
 	return gid;
 }
@@ -120,7 +137,7 @@ static int check_group(const char *group, const char *name, const gid_t gid) {
 
 	long rbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
 	if (rbuflen <= 0)
-		return 0;
+		rbuflen = 1024;
 	char *rbuf;
 
 	while(1) {
@@ -129,7 +146,7 @@ static int check_group(const char *group, const char *name, const gid_t gid) {
 			return 0;
 		int retval = getgrnam_r(group, &gbuf, rbuf, 
 				rbuflen, &grent);
-		if ( retval == ERANGE )
+		if (retval == ERANGE && rbuflen < LONG_MAX / 2)
 		{
 			free(rbuf);
 			rbuflen = rbuflen * 2;
-- 
2.43.0

