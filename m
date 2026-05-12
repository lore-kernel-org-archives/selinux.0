Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552853AA4EB
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616377; cv=none; b=EOU3R1wylBO2w/koFZFfPJ4eeqRaKmB75HBlTSpdVJn4vLkFI4NNR0h4U6XmtTn58qjv3m9JNlNZ9IG8UqUh7ovDDDvAGqAnu3/cn+PBlMwwXrReP7DO8PyRWB9vHNb22yx7QKdr3ZheLbGmtgtaNAEy+Pdr9+serTFH4f14IaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616377; c=relaxed/simple;
	bh=+08r8pXDnz4/IwWlwzAugBzdyujJDzvTRFNjkPsibNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opS1qWLxcaZfEbXj5+l5sLJnOfRf8Ss+UUOALNx4jW7xwiLQMtT/Ck7m4VETzSDjSXkDcivEZIA+4zZvVwRRWo1pZ5Rh6F95T0CeTGI/lzEDE/9f+96EJTkl+3/53Lz1kf7bAl6w7+yE4AUcrHa9iPkphJYLQinQpgXpib6esQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmPQ6ynE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmPQ6ynE"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d560ede296so657847685a.0
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616375; x=1779221175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORbKqvXZvTKWCvXD+AML840TdfL2JRKAq0WxLwp4k+c=;
        b=fmPQ6ynEsygu0BJpl7jyPH+2pyCmuTrTIQHs38Te43YE1FJFH1pvtcNU640lwp3ipw
         H222L2A8RfJk2O3Bo/InaPro3igC8t3w5ljGVpEKk3bJ+4/Rq7jzEzF/xvco1mA9zTdR
         6bKXdnM4BRKykMgigB0FI7kg3ZiYihfdQYweM/casd6QxehVB1yqmczi+6mcfjohe6v7
         fp3MmRiovmkSkbzrmyou3bgbjOzYvnP0yqWgtS4GFjBcV8XpbGlMnbgXFry6oypSJ/HZ
         UAqeXiRmwrNlybdCUQrIiAulVxW9mCALu8da3EEFNBzGQzhZKel1bPi0zZh9L87sG/nJ
         Y4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616375; x=1779221175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORbKqvXZvTKWCvXD+AML840TdfL2JRKAq0WxLwp4k+c=;
        b=hv5KWCkjKdG5p1pYebnC0sg4yuX1zBS9wx3d65ymuRLB5oySwZXjsnJKlJ3vo0HSNI
         HIhLdDNCJAEO7zBn3KD+2HYupm04I7+ub/m+E1oUrmlD5PHGGtqefnSgggPmH2ykZidc
         0O0z55TG7vzqM7dPIM3I53xfx3LX7B6Tt7j8QWvMelPc+pavYH+iArOWzMfx241gDGEl
         sE4pVVObbTMVwJK3GonoQ7LtyKn1hcIDeWCPPam8vlwcU6I7i2c6FIwBjraweEt2GtcW
         w1vraJGH/WjyWEtYWv4NSCc0HAj/kevCAuCacvBj0hw7b+oWxR9O9D/j4r28Qw9Cko83
         /fLg==
X-Gm-Message-State: AOJu0YznCdwoHCEg5Q7AKu/2XcAags8BW7g3snu4KohWb4JgY0C9RVZh
	+XOo740yJcG2zI3EeW463838vnHROKxvaN9gBqpQI5xtzytLeaiFELo/2z2M+Q==
X-Gm-Gg: Acq92OEYai3ADSUuGAnxyBLkNnnDLfM+/gBLl5vdC4kSyCaXRg33D5VcgdVDueAgkx2
	0OnMH8ABAQDrVxvrKqTAISR7CJ6xyPV3BlNoCFX9zdaZJVVULgKmZ4QyCQiV2STDZtA5UpUGQe2
	gsafz8XJA75HKYWs4/3aCBfd8bd1rIYQ41E/yOUjXjKU5XchLafFEVwaVCYmNeQUUMitjZO+xOj
	p6b7kWLxR0VjcUrH4PSu+nI9D0UhN114oFKJb9wIR4FSgrHvCY043tA2gd9yFLkRig7/ZwMwIWk
	h1HMjq9ua7oJSxxCwlMVS0AKUwk9IKcI/rcgmjWBDAbN4sbclxRYRSbdGqs1Aqcw/NssX2o6pzx
	qj3BSy9dPJk3tdmbQETpe+GePkjAYL6Yo3u0M2Wc3mS+MBb2+QQ/UNt9xhKO4L9Oj5y/nE6cj9X
	OWRNbMaSDALUJysHOUOjUG6lU8rdAts54+P25RthTcLsJRzQACk7heYBOU1WUTwKGhuYtQnefIk
	sTnnRzl2P9/RVAs4xBMsQzPPnqHeBfOvhDCRX5O0Rfwt8YyjWvu01M=
X-Received: by 2002:a05:620a:440a:b0:8cf:c106:faca with SMTP id af79cd13be357-90f8ac08836mr69078685a.36.1778616374772;
        Tue, 12 May 2026 13:06:14 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd057acsm3815526985a.47.2026.05.12.13.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:06:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: remount /tmp and /var/tmp with the proper flags
Date: Tue, 12 May 2026 16:06:05 -0400
Message-ID: <20260512200605.753172-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mount(2) with MS_BIND ignores any nosuid/nodev/noexec flags, so
seunshare_mount() was never setting those on the /tmp and
/var/tmp mounts. Fix seunshare_mount() to remount them
with those flags after the bind mount, which does
set them properly.

Test:
mkdir tmp
seunshare -t tmp /bin/bash
cp /bin/bash /tmp
/tmp/bash

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index b9c85bf2..985e0cfb 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -260,26 +260,32 @@ static int verify_shell(const char *shell_name)
  */
 static int seunshare_mount(const char *src, const char *dst, struct stat *src_st)
 {
-	int flags = 0;
+	int bind_flags = MS_BIND;
+	int sec_flags = 0;
 	int is_tmp = 0;
 
 	if (verbose)
 		printf(_("Mounting %s on %s\n"), src, dst);
 
 	if (strcmp("/tmp", dst) == 0) {
-		flags = flags | MS_NODEV | MS_NOSUID | MS_NOEXEC;
+		sec_flags = MS_NODEV | MS_NOSUID | MS_NOEXEC;
 		is_tmp = 1;
 	}
 
 	if (strncmp("/run/user", dst, 9) == 0) {
-		flags = flags | MS_REC;
+		bind_flags |= MS_REC;
 	}
 
 	/* mount directory */
-	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
+	if (mount(src, dst, NULL, bind_flags, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
 		return -1;
 	}
+	/* remount with security flags, ignored on original bind mount */
+	if (sec_flags && mount(NULL, dst, NULL, MS_BIND | MS_REMOUNT | sec_flags, NULL) < 0) {
+		fprintf(stderr, _("Failed to remount %s: %m\n"), dst);
+		return -1;
+	}
 
 	/* verify whether we mounted what we expected to mount */
 	if (verify_directory(dst, src_st, NULL) < 0) return -1;
@@ -289,10 +295,15 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
 		if (verbose)
 			printf(_("Mounting /tmp on /var/tmp\n"));
 
-		if (mount("/tmp", "/var/tmp",  NULL, MS_BIND | flags, NULL) < 0) {
+		if (mount("/tmp", "/var/tmp",  NULL, MS_BIND, NULL) < 0) {
 			fprintf(stderr, _("Failed to mount /tmp on /var/tmp: %s\n"), strerror(errno));
 			return -1;
 		}
+		/* remount with security flags, ignored on original bind mount */
+		if (mount(NULL, "/var/tmp", NULL, MS_BIND | MS_REMOUNT | sec_flags, NULL) < 0) {
+			fprintf(stderr, _("Failed to remount /var/tmp: %m\n"));
+			return -1;
+		}
 	}
 
 	return 0;
-- 
2.54.0

