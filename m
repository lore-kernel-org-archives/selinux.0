Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29BB188
	for <selinux@vger.kernel.org>; Mon, 15 Jan 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JvV9uzSH"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so10000523a12.3
        for <selinux@vger.kernel.org>; Mon, 15 Jan 2024 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705325772; x=1705930572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pf/xk+wno3evHz+8CTDXoE/7UYic8tNgKuE0bNhlOoY=;
        b=JvV9uzSHCGVlFOYhlA5+CRpjbscU7W7n0NbZbEkKyIfx3tESPyhEj+gqaCgrC0omfu
         KTrFTNapQhxZqN4dchg/Bhe9fzI62hHZ6B6zaZMGn50fhy5AKSuXS2r37jxR+2itGfXX
         UWF/aGMFUHHu5s6Z1YWWbkwbPrjiOL5Bma3ptk2gS/fu2wrn6OHzWqTiywYSvUM6lJ7T
         oBNCRYzd+UD8yGX7m8OiXO2Smnn1GdKXVQs52AU4AlaxOENcVyQvwZldQEJ8oW90DzKe
         BK9X5iStPQst7tO5A3/PK0qkXNAnayh7sAaX8fI+dtr7UHTvknm8AdZf4FY+fb4MWs9J
         qjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325772; x=1705930572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf/xk+wno3evHz+8CTDXoE/7UYic8tNgKuE0bNhlOoY=;
        b=TY5QDl+RvLNaQ6xw60vI5If+OabRuP/l1zfCAJ9CJCsjGa5F3iXc4Ly91Sjz/NzAZM
         9d6Z8HP2bGpbdhKWGcOKHOBrfckUHDwEBAVQKuAhEr1xfWdw3IxkWb2Ffc1fdseYVIRA
         9cNr4jD0yS3lOUI+QAmQvQSDdSSdleYtVlfMqp65q/Twd/0CBXzbp/Ui/Q3nD7BKUphN
         v1HKgO9jTwE+ht3O3NZljIpAvRex7l8WKzS26fI+TJ4vDVuSRaXvtOuIwLyooR2aCn1o
         CwdGwkLBsZji8alubL9OHW6mHD5uKnhhSpGgh+XmMaunC7CoC8fY8e14r3Ic0prrKDeA
         3DAw==
X-Gm-Message-State: AOJu0Yx6OrP/dY2cwW4ClVe6XRgODmaPWjvAOUrfqBu+aLBR6OzFBfFX
	ndGRw2WvEcLG+7RFkqIFig84cpH6HvM=
X-Google-Smtp-Source: AGHT+IHAsuVjNtLu/wuUMgBmagdc2VlREfV5T8WKDuet/3NgmSsPDShUpNJMnOqk3tKBoDrhT1PS8A==
X-Received: by 2002:a05:6402:318b:b0:554:3b5d:b09c with SMTP id di11-20020a056402318b00b005543b5db09cmr2702022edb.22.1705325771736;
        Mon, 15 Jan 2024 05:36:11 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-025-246.78.50.pool.telefonica.de. [78.50.25.246])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0055410f0d709sm5356625edb.19.2024.01.15.05.36.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:36:11 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libselinux: use reentrant strtok_r(3)
Date: Mon, 15 Jan 2024 14:36:01 +0100
Message-ID: <20240115133607.10783-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the reentrant version strtok_r(3) instead of strtok(3) to avoid
potential data races with concurrent threads.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 38f10f1c..acb729c8 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -243,7 +243,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
 	int index = 0, found = 0;
 	uint64_t nfile = 0;
 	char *mount_info[4];
-	char *buf = NULL, *item;
+	char *buf = NULL, *item, *saveptr;
 
 	/* Check to see if the kernel supports seclabel */
 	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
@@ -258,13 +258,14 @@ static uint64_t exclude_non_seclabel_mounts(void)
 	while (getline(&buf, &len, fp) != -1) {
 		found = 0;
 		index = 0;
-		item = strtok(buf, " ");
+		saveptr = NULL;
+		item = strtok_r(buf, " ", &saveptr);
 		while (item != NULL) {
 			mount_info[index] = item;
 			index++;
 			if (index == 4)
 				break;
-			item = strtok(NULL, " ");
+			item = strtok_r(NULL, " ", &saveptr);
 		}
 		if (index < 4) {
 			selinux_log(SELINUX_ERROR,
@@ -276,14 +277,15 @@ static uint64_t exclude_non_seclabel_mounts(void)
 		/* Remove pre-existing entry */
 		remove_exclude(mount_info[1]);
 
-		item = strtok(mount_info[3], ",");
+		saveptr = NULL;
+		item = strtok_r(mount_info[3], ",", &saveptr);
 		while (item != NULL) {
 			if (strcmp(item, "seclabel") == 0) {
 				found = 1;
 				nfile += file_system_count(mount_info[1]);
 				break;
 			}
-			item = strtok(NULL, ",");
+			item = strtok_r(NULL, ",", &saveptr);
 		}
 
 		/* Exclude mount points without the seclabel option */
-- 
2.43.0

