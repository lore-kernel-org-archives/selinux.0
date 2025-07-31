Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8478C91
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979032; cv=none; b=kW/4QI6vqboSRb1g/I13tmnyFmfQU+1LDZ5O+wZSDQ8oMtjaOlYooC9/0KZt+QyIo4LJhaGO13iqC9htfrQAVpedZ0e8YMZBiCN7vLo4UFD1+w1dLogYgs6sskQ/yVKwN1uHAZJEKrcPYjfUAdV6WFHOYk706eJ5OkTq71h+83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979032; c=relaxed/simple;
	bh=ITm29zf7j4dMd5m1p9OpIiasOdDw9Er7OnrQBxXCDuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/sdWl+gQ4x9GzJUYQ0Dz+gYgXp2SagefpRjuX9DN65p6ouyY6OsvqWJNlLtAElAZh75RS6hzfzsHb+o7mbVLq+bGa7iri+syClhWrufgqdIcNoT/jmRtokwlJcKKL37lysdU983JtMb1Kal6tBymnG99SuZA2MqokxZO5za154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVjxGj3Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVjxGj3Q"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455b002833bso4361845e9.0
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753979029; x=1754583829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZgQ/6wy+1Txzi1j/GRJ/5qj6Q1G7vnbHw34Hf20Buk=;
        b=YVjxGj3Q1nxhM0gWV+TXxAyHpxsSs9RqEPOtdgUmET/E9iEqEBHJynmG4Yht2v5GY4
         6mw1CbP7pT1ae/8WJ/tbz3bYGzuWi+dqFaFG7b6NVjJOR/NvRNvESC/j/r748lxGy9wO
         fzm++FKnsuwCAcF3cMIjjMqKZYf0hJehRida1/inVvHsjG96x5wBQbVPVF21YA5cg+XB
         vAyrWIaYOBJA24uEkpuxhbGjkvIS+DHpi2L2XtRZ3qgip1E8QpOPq8ZEnrudibVtMxyW
         lkKUn3dA/zaoiPxpXnd18L2PgDPKko4z+RLdDKOFKrRb7rsJzRjvoLcALRqB0ki7SIHb
         xYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753979029; x=1754583829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZgQ/6wy+1Txzi1j/GRJ/5qj6Q1G7vnbHw34Hf20Buk=;
        b=BkhF9LFehgkjcy24l/nUGjPO07tu6SZ66bm7Z9OIBrk3iWfhzo0e62aiBRt7Nh4QFD
         1VePKSfik/mmotqaHnODKKK7hCyZ/QFOgvKWSoxwq7V6Zk8X00+eTBguRFRrQBCJB4gw
         ZemsRGlEyfqfnCSQrENOrukyRKbX1yAdcXgiNi/abq+w8FpquoQ1VNJ2miBzwITkD1YE
         aOmKzz3s5SGMucGwrSL4td7W6vbeRaITbjtIyPtBV8cEMoQKl8FWU5D4YA4gmOpSDo/1
         FcBeEIKuEs5p/jWABr3NbeQJ2IxyGIVtIbZrMiDA+75k7XmBb4E9ZNkhLgReStdqse1z
         /9pA==
X-Gm-Message-State: AOJu0YzN37qzXOKxOu8TwA/DEOmJnXSTi2TSezBwAHh101ISVo3t36vt
	fsh/lgvCQXiwTDe0rb3JiIdZkQ56kNtMikdnMrBL7GKf6lWrTVK4yo2L4kkUtw==
X-Gm-Gg: ASbGncsa4hKkAURg399vZFi9uB8RmUu8CzdS4VgtfnmG9o6t7lpU3JTT15Ns0hgwfT5
	HM0QTVa0Zj9eoiwlh6Zpchd6kKPsp8n4hV7dgrIdZUd2rhQ1jrac+PXmD5C1z6gT27hsQ9nrS/L
	noothcCSLxfQ1vDZ3hwKmaxRQTM9NERthMXuxnzKqctI1Ucz40sozrfqaO32NjhtyUhXTNeNgvM
	1cLaXT3cuG9/5kntbgnlbkLY3N9/SeMIdVs/a1Ahp2sPbOwvvQUPrIdnFc55k9X5MZwAalmunrh
	KYWUdACaonh/XRBDJWHufaLxbI1FRH+Nl+sZkJ6mGgf8GfqOcuPzcnTvDAH2hVfmi8hS0Tu7IkB
	1v35JCT9nAZULCge/tg+8Pg4=
X-Google-Smtp-Source: AGHT+IHt9VZVrFZsoIBgvx2ifFvoXFwf2gJMz047Ogx6AKKPJuqzs+KWHr3+TPK6wY8JwmorrVGEoA==
X-Received: by 2002:a05:600c:3b95:b0:441:a715:664a with SMTP id 5b1f17b1804b1-45892bc6b91mr62038645e9.20.1753979028393;
        Thu, 31 Jul 2025 09:23:48 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377748sm70897015e9.9.2025.07.31.09.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:23:48 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: refactor selinux_check_securetty_context
Date: Thu, 31 Jul 2025 17:23:42 +0100
Message-ID: <20250731162342.1074496-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731162139.1074252-1-nvraxn@gmail.com>
References: <20250731162139.1074252-1-nvraxn@gmail.com>
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
 .../src/selinux_check_securetty_context.c     | 79 +++++++++++--------
 1 file changed, 45 insertions(+), 34 deletions(-)

v2: oops, didn't mean to include fcntl.h

diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index 7609752e..6d039f8f 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -8,45 +8,56 @@
 
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

