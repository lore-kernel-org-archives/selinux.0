Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27786361DD0
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646475; cv=none; b=KTZqY9CgllnKS+ZdbWTM+5J1MY4XjFCOrwzOMY/pKSdiO83Pa2ThSA5HHHnWvaX3kZubSg4SLo0OyW41i75PuNOx0aGM3OIGP/SKJfr0WYnnumkYfJscphTc+XwAqKkUOD0rmaT70D/OLFsdK86sAg53YmQeFfwH+JeadiH50CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646475; c=relaxed/simple;
	bh=7+pbbIiyLjKaT9UOXrrotfjV452g7NVFatojvps1bMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVawf2u6VF2X9cZ0OnolGJf3IpG/19+sQRuRmG9AaoBZ2WP8rjuYL86nz/Wy76nk5aKeizk7m2kajmmYS7Q8CTk4KDd5SBVe9rtnxCb31nCw9zg3vP11zqUFcKf3W0CvWzI48i2Aq2X1Oe8PD7UTIw798wJ7KzJ5vowA4DQsDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmWFaUsf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmWFaUsf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d58d7aad6so1506691cf.2
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646473; x=1787251273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nyln4D1pR4Prqszs92r8enDgYuk1RGcUOR71J3CBPXs=;
        b=PmWFaUsfWpx71ky1aG++2pqCJDtMYzycDZPi1WZRE6bxq+q0v7W2tEHOK8SAkf2KAn
         PEG0SkK21ZpOGoWrM2HdQ6IHmPZ53Kyu564Fb+RbbYw0DQsOyVt35XqbDTT6xc/41s4d
         gkAHcnqNlNJxvlOFHePh0RcKmvkMKBbJuk+IypubX6yqn3PQZ8DiKaQbrdnUQRBaYmW2
         sQgjPqkTuQGUTSh572f8PSN4uP5KO0NJ0ge2dovUCigR4BuK8XAlCXw/6IRjM8+Pc0GF
         yeJPN/5OL08r854zYBgcMFc2Al97shFvdiaTvIiGCaIPPPfO/nn4kwdDonMN3W3wYlQf
         L/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646473; x=1787251273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nyln4D1pR4Prqszs92r8enDgYuk1RGcUOR71J3CBPXs=;
        b=rsWvUaJK7xoJKpfSvQtZJK+PY+K/Z11Va1LxD3F2RglmgNEeiS3X+ZuWW8xlAs1SEi
         wsQjtFFrIdCsRvP/P0vVokEUbLJgfNTyO6qAxF7PMFGswaoDkvd4JPTFq435Olx1MV9p
         K1lDeyqiHNlSTlU0u0Qb844IdfqwfZDqs7hdHNexiY7/c8q10HYnMSyFZdIhN66TFfnq
         neGpP9Bpz6FDYNUyat5H5Z9h7Bx+WrUb33Icd5m1yaMG03M5krnjLz2EDdUzaeb4a9c/
         wd8Go4yiWjiqmF9I7xsXXS85PRib7sMgccvlzgU5JuCyh7V6DJH0NrjAR9lf/ffFPXMa
         FPCw==
X-Gm-Message-State: AOJu0YzgdHCJ7ZY+WaBo9ejQtaPXMe8Osbw0J81l5QGBZSuGFTxJASyy
	OgjY2H4Dz0Katqamw88KDb47O6mYV3sOAIJX2HxmloCch+yzz37hs9DtPW2dfQ==
X-Gm-Gg: AR+sD110oN2P+i6huQLA1O9R/dVJDXq2W37Xe/tnNC+XjwFsky/mg4L+Q+3IyWWHwH1
	ZJZgrlFNPLfXpU3cjxHmlF/W2KWUVygYIkNGbqd1uffgO4K8Z4MPmhI0SPT2Kjw3lU0Ny/UW8U7
	rLTsLCjfALl8VMsm5DUvPn3sk98r0OtZ1NkZd/RDmz+2CDiIrs5XwLD3GIrmBe6dMKX03LriiP5
	ZLtf9tZTBAkcC5+jOEL+zi84cJxId1hXT+s4Zm2333iazJBkzQKYf3Kfi51RXW/p/rQrUgSUOs/
	Jm9IVf+0SMTUEfwYYKlAY9v/ScyXSoSJYIKVxmTNhbPdk1FqXuobinwuXfe0joKHa3mxJfVlNBP
	KBJ7N/8WzooUak/zm5/bO3WL8mAxPayekUgd+L+ohPcyZuZoZykrrB/pxTONWqaO6cfYt3SeYrV
	/V9lsnDEy8Tu5WJcUOrvgG+20MPhpxVS4olcYWDQMc5/RPXMK5irWC42ljYKr8NX+kR3Vsz2DVZ
	K8Fc2EtUlEMC40Ak7wreUXbb/vkVzEY1FziWDZGPrQSn6q367iUE5ii0iw0HV4+
X-Received: by 2002:a05:622a:3cb:b0:527:7813:a439 with SMTP id d75a77b69052e-52d85420416mr491821cf.27.1786646473065;
        Thu, 13 Aug 2026 11:41:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84043866sm2279481cf.17.2026.08.13.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:41:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: escape config text spliced into build_regexps() patterns
Date: Thu, 13 Aug 2026 14:40:56 -0400
Message-ID: <20260813184056.185732-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_regexps() interpolates the base-classification, prefix/suffix
affix, word and Whitespace strings from the setrans configuration
directly into PCRE alternation patterns. A label containing a PCRE
metacharacter such as "." or "(" therefore either fails to compile,
matches unintended input, or produces a pathological regex that a
client can drive via TRANS_TO_RAW_CONTEXT. The Whitespace value goes
into a character class, where an unescaped "-" between two characters
is treated as a range and "]" ends the class early.

Backslash-escape the fixed PCRE metacharacter set when appending
config-supplied text; the same escaping is safe both inside and
outside a character class. None of the shipped example configurations
carry metacharacters in these fields, so behaviour is unchanged for
them. The configuration is root-owned, so this is hardening rather
than a boundary crossing.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 42 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 89235269..9704f5dc 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -1074,6 +1074,32 @@ static int buf_append(char **buf, size_t *cap, size_t *len, const char *s)
 	return 0;
 }
 
+/*
+ * Append s with PCRE metacharacters backslash-escaped so it matches
+ * literally.  Used for config-supplied label/word/affix/whitespace
+ * text spliced into the alternation patterns in build_regexps().
+ * Works both inside and outside a character class.
+ */
+static int buf_append_literal(char **buf, size_t *cap, size_t *len,
+			      const char *s)
+{
+	char esc[3] = { '\\', 0, 0 };
+	char lit[2] = { 0, 0 };
+
+	for (; *s; s++) {
+		if (strchr("\\^$.|?*+()[]{}-", *s)) {
+			esc[1] = *s;
+			if (buf_append(buf, cap, len, esc))
+				return -1;
+		} else {
+			lit[0] = *s;
+			if (buf_append(buf, cap, len, lit))
+				return -1;
+		}
+	}
+	return 0;
+}
+
 static void build_regexp(pcre2_code **r, char *buffer)
 {
 	int error;
@@ -1106,6 +1132,11 @@ static int build_regexps(domain_t *domain)
 		if (buf_append(&buffer, &cap, &len, (s))) \
 			goto err;                         \
 	} while (0)
+#define APPEND_LIT(s)                                             \
+	do {                                                      \
+		if (buf_append_literal(&buffer, &cap, &len, (s))) \
+			goto err;                                 \
+	} while (0)
 #define RESET()                           \
 	do {                              \
 		len = 0;                  \
@@ -1133,7 +1164,7 @@ static int build_regexps(domain_t *domain)
 	qsort(sortable, n_el, sizeof(char *), string_size);
 
 	for (i = 0; i < n_el; i++) {
-		APPEND(sortable[i]);
+		APPEND_LIT(sortable[i]);
 		if (i != (n_el - 1))
 			APPEND("|");
 	}
@@ -1149,7 +1180,7 @@ static int build_regexps(domain_t *domain)
 		if (g->prefixes) {
 			APPEND("(?:");
 			for (a = g->prefixes; a; a = a->next) {
-				APPEND(a->text);
+				APPEND_LIT(a->text);
 				if (a->next)
 					APPEND("|");
 			}
@@ -1185,13 +1216,13 @@ static int build_regexps(domain_t *domain)
 			if (i)
 				APPEND("|");
 			APPEND("\\b");
-			APPEND(g->sword[i]->text);
+			APPEND_LIT(g->sword[i]->text);
 			APPEND("\\b");
 		}
 
 		if (g->whitespace) {
 			APPEND("|[");
-			APPEND(g->whitespace);
+			APPEND_LIT(g->whitespace);
 			APPEND("]+");
 		}
 
@@ -1208,7 +1239,7 @@ static int build_regexps(domain_t *domain)
 			APPEND("[ 	]+");
 			APPEND("(?:");
 			for (a = g->suffixes; a; a = a->next) {
-				APPEND(a->text);
+				APPEND_LIT(a->text);
 				if (a->next)
 					APPEND("|");
 			}
@@ -1227,6 +1258,7 @@ err:
 	free(buffer);
 	return -1;
 #undef APPEND
+#undef APPEND_LIT
 #undef RESET
 }
 
-- 
2.55.0

