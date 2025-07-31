Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81961FAC48
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978911; cv=none; b=AGOpPwjuLqU5OoftaAwWSBBbz64IMdVWyAMIX026t6CGSSEGHPnxDPtCT6+Z3/ayWXfJvsFd2zbMnYbjdHHHfiiotTBOFC7+snv7vQmMqwezLRk5YsIqzklplJ7tW+KwxUnPLILwGSPAzrV6+L6JuojvgRtohU6kElI1VHzBbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978911; c=relaxed/simple;
	bh=XUAKX1MQJHYz0UdcNn4jxKQVZkDAvB4WPW2Taa4D0Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGLDSKGiMwhNyCz0+O5Z8GnZbqA8viWRc1auWi8DwiIRwnYaEWxKkHmaJSDv8HBOIIHNW3eHeqSLseo2KSQExrtSU4XuxuGAyvMOTmk6PzEidxH8d0mCXt3r51ilROO24fQPfiIixKvt9SBffc8e/lZTpMsJAnsHFjZ8uaWqjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POiWvVe9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POiWvVe9"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso11064015e9.3
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753978908; x=1754583708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyXUEFy1lnbbX1bBnpdtnyXGN3019k2ZD7Ay6ixwFPc=;
        b=POiWvVe9jLUC/F4B8kjgxn6XVX9sS/gignqBeUPADuKaJ53lVj1Wlrs7W93UhFfkBq
         ggJrkFUX8YMkrhT+gcA5oF4sQijgIufBUuln4JhJCzYN0HFbqCGi4Aya8RFwRmCP1Jh9
         QJJItw39lT+i8dM2Xf+kZX+EKxwIg67R8Nfhyhyc/oj0AmTYi5qtUWZTE+/sUpabwvoH
         8v3koMBkmnMBXhQtf8sX7FTePcBmOBvlD9GC/RgXz/S355bAZ/ZN/PRyh4I5p+DY59Gj
         MhIlEHVU61P1Jhb2LN59yKxp72n1TrTqvJYCMizx0QxqEiKs6+OhZ4DMMwdhDyxJ/fuY
         1rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978908; x=1754583708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyXUEFy1lnbbX1bBnpdtnyXGN3019k2ZD7Ay6ixwFPc=;
        b=K9PE11W1FO4koMbFZR7swAfZwiySbC+ySAMKv6GG1hTFl9GPWXFyQSo7PryD6skrIZ
         WyaKujF0+WyiLbqjYlAV22mYOka1OKu1ThwCq0Znc6V6mnzK4aIuuo8z3Rs8SDabOAIi
         TYNlBjP4NMzM7lpdI/JeBbnNI12g3kWYzFRW4y5jFUgIkeGi5FzObnMR4DUTAkN9T2Nr
         SMkctBgijXlV9U/zul5q1IF5OHAxfsUfXAYWEUOdkJyw1qEZHpLDYSHVbJzAdE/cT+Ry
         iBk9PR7pK+yGLfYkauBy6+iOq2CdyOQWhutvxMFq/skEXfs6t4Nghri17B2DJJCZyZ2I
         MPHQ==
X-Gm-Message-State: AOJu0Yzsg/5bBfbaciVYeIJwfsJhF6kFjI7kNRB7Sxeus9IMECQALz9e
	Y6IXa839K4eSyXfJlWd8vsEWLscHql1CUBZJaZ9JQoMsdbmvhFc9GFHienZaAw==
X-Gm-Gg: ASbGncsFKnW338FvS5KuET2hYp1VepeNi5sSsFH306HkKbDYcX1kFAuHRaKMX0C4W2b
	grLEAIlzlhtmvwrmMUBE2DEmS5LDoqPsmMfzxa25qKGa7uc0M7+5Qe05nc37ZkVdrNbxySjWy77
	RIPnrTZHzdJmooSZN4PAV2Mqzg5Yqg+jFarbep71KBF9frCQ56jxjrmw2LCv5dY0xT+cvWRJcGQ
	PEVegNE0DptPWYvpqNB+yL4m8AOFtJ94AvI3tbRRcbLqFLrrN5APDFFpve2mjQtTbS+DgLpXtzB
	f9oTOudpt78sh+mZ6ixTRBX1M/qShkZ1sMRxtvAayQBOfZjKc0aynR0dgWt3i246RvP4cQ+8Dx5
	xNhSRNvEbbllU
X-Google-Smtp-Source: AGHT+IG7u/gF31al3u66i34WT+zey0HmzSZ01So6kJvnahAgCK72U/wEiIpeWgR+Kl9UB/3nma6yiQ==
X-Received: by 2002:a05:6000:2405:b0:3b7:8880:181a with SMTP id ffacd0b85a97d-3b794fd644amr5431114f8f.13.1753978907869;
        Thu, 31 Jul 2025 09:21:47 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536acc9sm73669685e9.6.2025.07.31.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:21:47 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libselinux: refactor selinux_check_securetty_context
Date: Thu, 31 Jul 2025 17:21:39 +0100
Message-ID: <20250731162139.1074252-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invert the checks for fp and con, and initalise char *end as NULL.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .../src/selinux_check_securetty_context.c     | 80 +++++++++++--------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index 7609752e..f04b66e0 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -1,3 +1,4 @@
+#include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
@@ -8,45 +9,56 @@
 
 int selinux_check_securetty_context(const char * tty_context)
 {
+	context_t con = context_new(tty_context);
+	if (!con) {
+		return -1;
+	}
+
+	FILE *fp = fopen(selinux_securetty_types_path(), "re");
+	if (!fp) {
+		context_free(con);
+		return -1;
+	}
+
+	const char *type = context_type_get(con);
+
 	char *line = NULL;
-	char *start, *end = NULL;
+	char *start = NULL;
+	char *end = NULL;
 	size_t line_len = 0;
-	ssize_t len;
 	int found = -1;
-	FILE *fp;
-	fp = fopen(selinux_securetty_types_path(), "re");
-	if (fp) {
-		context_t con = context_new(tty_context);
-		if (con) {
-			const char *type = context_type_get(con);
-			while ((len = getline(&line, &line_len, fp)) != -1) {
-
-				if (line[len - 1] == '\n')
-					line[len - 1] = 0;
-
-				/* Skip leading whitespace. */
-				start = line;
-				while (*start && isspace((unsigned char)*start))
-					start++;
-				if (!(*start))
-					continue;
-
-				end = start;
-				while (*end && !isspace((unsigned char)*end))
-					end++;
-				if (*end)
-					*end++ = 0;
-				if (!strcmp(type, start)) {
-					found = 0;
-					break;
-				}
-			}
-			free(line);
-			context_free(con);
+	ssize_t len;
+	while ((len = getline(&line, &line_len, fp)) != -1) {
+
+		if (line[len - 1] == '\n') {
+			line[len - 1] = 0;
+		}
+
+		/* Skip leading whitespace. */
+		start = line;
+		while (*start && isspace((unsigned char)*start)) {
+			start++;
+		}
+		if (!(*start)) {
+			continue;
+		}
+
+		end = start;
+		while (*end && !isspace((unsigned char)*end)) {
+			end++;
+		}
+		if (*end) {
+			*end++ = 0;
+		}
+		if (!strcmp(type, start)) {
+			found = 0;
+			break;
 		}
-		fclose(fp);
 	}
 
+	free(line);
+	context_free(con);
+	fclose(fp);
+
 	return found;
 }
-
-- 
2.50.1

