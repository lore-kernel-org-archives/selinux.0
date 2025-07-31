Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB723C515
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982240; cv=none; b=oO7jZCoQb2Z3i9IckDNRjW0UCdZcs3ctW2c3xPgs+zLx/9fpLpUqohZJsFRm3nCJN+6vwQFVbWQ78vxqL47oSDV64DlNoTk2IXn5yPi32+ZZcUPL+cvymDCONyGgb2LzwlJo+c9rUxWekVCg/QImciiOYfUiLxhZd7MlLHZ8OVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982240; c=relaxed/simple;
	bh=z2FZpXXl8QuOZLLZSpEFXpOZ89YUT0TkehDdsFLJxcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg+l5q9UDc38pjEytsELlrsrljErudH2h7JErgFXCwtZdLCfonqax/ujld09axBEZxnlx0R1pLU3DoByWSKX5rI8YgEA+lMuJJDmD0cDJlo8X8Ka0P25j2OEP207fViwlExd8Ks/laX9cIaP48Grzx0poxIvClKJ/XExPNqZFQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQSlqCa1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQSlqCa1"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7910123a0so1164994f8f.1
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753982236; x=1754587036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EBN9mDr/mtT8FZeiTZxjF9uZtax2B6ac9hr9NxYdvM=;
        b=RQSlqCa1kdxXkUL76kMDwVPsZGSkUjD14mKf3h8+I1QyEAG4ilP17qsL7OrC+6PhBC
         vGpYmVl5s5Z8QiMoyIWt1kHXUN4Lbuhemcz4Wn+t2WcBDpHP1Ner7BGMBXe4hLm6DFrV
         WdL9tIetQdDVe+E+dYAxbdVxKp9KbQjvTtJZzoq2UJJEVjaBr+qforpejmapjRBNbGOk
         oNlqx+/ozQSSTXiV7jAXrqAzvLKgMjbIYs6GDPKmPLBHxEqO8mc4cibbrfaRiBEZMmZ9
         FROdu2E0hZTgdkl0EgRSA/mJ5NbT3uBCH5UzW0VHXTdfVoI0jGmFUpG6SMNd30AfF6un
         oB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982236; x=1754587036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EBN9mDr/mtT8FZeiTZxjF9uZtax2B6ac9hr9NxYdvM=;
        b=U2WbK+Ii8sWOr685Td6pmqaF7TDi7/jRukkv+Y8pr+zRYKccGCtzsnjqgfZkNZNWY3
         2seHMch4bvwDtOcne7L/n65qdmWX6IxHA7JPY6GHro8FGNPL6Oc7kmu7n3M6tVnWM7jq
         E/cYaw98budPEGjt9FBLCsHVfXoTX7NUbIcCcg+mKJdF3aBbuJcHKbatJ8oVC7EgSSoE
         z5CqvF6BU4IOC8zOw7kp8k+dERHpHDq50gV6oVReFuO9V5JHf/rwaClxmrp2/OQHqIhb
         tyBI7isFDs2VaGXboAyVTvrQRfSbcQoG05ECe9fawKzuTuBFWj5+ov64tUWtX/BYND+K
         UbeA==
X-Gm-Message-State: AOJu0YwDjFa9HR4xTRJluZwDMvmyixSUlWSlsV8BR1VzVfJ3EwDTWpnN
	sVV5+Q13rmKl9BL4vbIqA8tR1ULFPOGk0gL11WtCg/mrbK/QcPLstQkzXbgajA==
X-Gm-Gg: ASbGncthFCBp13dMAHhS0XvaV0K6lZoh/PxvHylaOdC9BVcwsxXhit2O+p0348qAxuE
	kyUckKjVueK+YskT7zj42OZAbMfyxDcn9eRnDWF6XdKKkTsfQHSb5yPctb7MH68b6Lb8JuDCTR7
	Er/tCWa0zQdY/JbfpwieR2i7EnWQTWfxP9JvWPRoBVL4Ovac0IHaHqK+qqbONENRloCFJ3dgqwK
	TOoI8eVLkDsazFgKvfh1SQvoDcYSliOKn68pVwhjJIoz5q6RRpdUPVRUEcGiiqI95w5ouhzOW+T
	dyJQG5lQ592z7nKG7tOjPcjyAysGzUwjsUZcbzi+5bFZwwxP2BCpvkW2EHTJmvFNzctdkfWbJvv
	ve32dVWDtiQaIvzQsIUmD+nE=
X-Google-Smtp-Source: AGHT+IGbNN0xIhI1xMiToOrWaVuV+4dWje7hYLRO1gfLKEjJ2Div5AxD0JIsy4JP8y0yjlhbchjacw==
X-Received: by 2002:a5d:64cc:0:b0:3b7:861f:4887 with SMTP id ffacd0b85a97d-3b794fe4e62mr7154543f8f.3.1753982235598;
        Thu, 31 Jul 2025 10:17:15 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588ddb7e45sm70133135e9.3.2025.07.31.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:17:15 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] seunshare: always use translations when printing
Date: Thu, 31 Jul 2025 18:17:06 +0100
Message-ID: <20250731171706.1079400-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some errors previously were not using gettext for translations, hence
wrap them with the _ macro.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 sandbox/seunshare.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 106f625f..97430535 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -103,7 +103,7 @@ static int set_signal_handles(void)
 
 	/* Empty the signal mask in case someone is blocking a signal */
 	if (sigemptyset(&empty)) {
-		fprintf(stderr, "Unable to obtain empty signal set\n");
+		fprintf(stderr, _("Unable to obtain empty signal set\n"));
 		return -1;
 	}
 
@@ -111,12 +111,12 @@ static int set_signal_handles(void)
 
 	/* Terminate on SIGHUP */
 	if (signal(SIGHUP, SIG_DFL) == SIG_ERR) {
-		perror("Unable to set SIGHUP handler");
+		perror(_("Unable to set SIGHUP handler"));
 		return -1;
 	}
 
 	if (signal(SIGINT, handler) == SIG_ERR) {
-		perror("Unable to set SIGINT handler");
+		perror(_("Unable to set SIGINT handler"));
 		return -1;
 	}
 
@@ -353,7 +353,7 @@ static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
 
 	/* match glob for all files in src dir */
 	if (asprintf(&buf, "%s/*", src) == -1) {
-		fprintf(stderr, "Out of memory\n");
+		fprintf(stderr, _("Out of memory\n"));
 		return -1;
 	}
 
@@ -371,12 +371,12 @@ static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
 
 		if (!buf) {
 			if (asprintf(&newbuf, "\'%s\'", path) == -1) {
-				fprintf(stderr, "Out of memory\n");
+				fprintf(stderr, _("Out of memory\n"));
 				goto err;
 			}
 		} else {
 			if (asprintf(&newbuf, "%s  \'%s\'", buf, path) == -1) {
-				fprintf(stderr, "Out of memory\n");
+				fprintf(stderr, _("Out of memory\n"));
 				goto err;
 			}
 		}
@@ -387,7 +387,7 @@ static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
 
 	if (buf) {
 		if (asprintf(&newbuf, "/usr/bin/rsync -trlHDq %s '%s'", buf, dst) == -1) {
-			fprintf(stderr, "Out of memory\n");
+			fprintf(stderr, _("Out of memory\n"));
 			goto err;
 		}
 		*cmdbuf=newbuf;
-- 
2.50.1

