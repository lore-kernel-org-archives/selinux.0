Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2A2D9787
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825592; cv=none; b=L5neD1aj3mkec0Me2BV2qBzNUIDayMmZJiIgV66DwfQXLZqU1y1JWP9y46QexDoSD12Emv6dmuA0obfiLtqmuv+daipThFD3vPoyMl5Nd6TxH/QC7p82svaCE2s2kQg0O9gk3dVUb3RP30qAwHWoSKeExnjVJXPRBJZJyzTUjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825592; c=relaxed/simple;
	bh=dzvIVYqyiRqeRVDMnfnJG0AmaNUH4zj15M86zAHB/4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iduhXUVNTtNsjgsHxjD6s11uq7k3HMUe4tmBCNjUxOCGMON6RX1JlMn1a2S09KOywXWnc5fW6wr/4ghQx2d3P2Z2gB+xRcteGchbd0/tw+CvZRFvKeUFKkFHpfXnJKz4DPO9nGFoQU+ezR88UP1Ca+UKXpguul378CgOj/Y7roY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfA2HhGJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfA2HhGJ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-912475287a5so1219581885a.2
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779825590; x=1780430390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVIvoljzWDwWN6ceT3J05uWgFnoUL/sjs26UAyvozkw=;
        b=CfA2HhGJMdk3l4+6cxzZ7s9bwC1SDKdRgDHFN5JUN6/lo2NvnTMMO9pLApKFEMwTpB
         ga0lsDp2p5nrOQdrOwRk539aweKED5QdjXJ5gFsi32KGQkwiXjVzLr9hOc+Y0On6CaiO
         PaXfgd54gMJBqjD4i6mdx7bYnxwrosbBUvxmmm/5LrDtVNC1E12vcXmP4WJzrnPzGXNt
         gyjA3hNIRGIChW1g8d4yXJ7hwwUs5CwZ8EY4bVOsfwTGs+Ph4pUtuzRrl3JqHcQDIbTa
         oKjZy0pfi4bCdHcSXnueiQ5WlJOdoiGQi7lPpcdMLgh12joe0sVbEte9UWtu/UEbTdMC
         b4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779825590; x=1780430390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVIvoljzWDwWN6ceT3J05uWgFnoUL/sjs26UAyvozkw=;
        b=FJqZcmF9O4XQUUSrWAhCey9IHA9okK4UiNMsL3kr5uE59eZUdLHUgQ+T2QkMh5DFBO
         b2DcW4YMJ2zWtUYx2hpBa10u3S71z8m1RLaKfMIkYBt/z4G5Qav47BKc2Hl7wGUxa52/
         h+ahIbC0IcdGRGQteCPIjTY+EEtE9MjPxBLP5DngsYjGR9RqnHLi/U5C5bQ36RMFaGyZ
         9ytW0S5pqNFVjmUH2VHu0lWedRQCl9OxQ59UXnVEg2v1fdyIdSACvgJI2wP2vcQPnfCp
         7c1jD3anRhIBjka9QQQ9RPUrDw0A9WeDs4zecVGOqi98o5VpzR0zWUEYGrEQ1ooeGZh/
         HJrg==
X-Gm-Message-State: AOJu0Yz5T/prMTVATB7ijsvHC41xaX94e0nl7ENqFCLZ2pLI8whZO4Lt
	pfHYFiKkbv54V6GYRJrSqPRAy69G0/UgpE8xQZm2PpiUmNU9+LjEesqU3phQ3w==
X-Gm-Gg: Acq92OFOQes7+lw22HzU/Zukmpafmeiy4k+U2w6i9tXcXfGtaleYYQMl1G1skI+lnyv
	JtTd9QOar+/0YTkbUQKf1NjBYBELgz0moSNKdjauDqBOT8FHIi1KS64o6njNMb4YPwIG1mGbfZr
	NtMPZzOgMBR2oZizE4uSwiLiCzY4Wd06NrcErIktIgPXfeEA+mUm7tbM/Z2AjoNvqBD6+4K8rQp
	yuDsupnX8sMvUXzoyibWdLEULUQ6LXcEn39FIH04xOAAKscMbxaLps3WYNfXNz3PJxB54upnWTs
	TLK23Q0+Z9J884b3hIPYQItHMZDFynJ4yZGLx9XNCaRJjS4CukmPI+IzOWaCRsGfbfZVkiYpNXB
	l8jCiHhKrJpIrLirHyhuJ7J0zGf+x6eDXC+oN+d7MkvXZReBiA69k61EsroKLZfICHmkaVDnJPr
	p9mI6Y+Ycn3a3q1nIVFpZoLD7Kemg3VRnKPxR6BL3qXAakNOv9OViy7v2u+QR33ke0qAmCLWCNV
	8xMpwor97EoEq7gnJ50mkfLvRpIt70WxA/SOw==
X-Received: by 2002:a05:620a:284c:b0:8cf:f215:24c6 with SMTP id af79cd13be357-914b4919b98mr2877886985a.21.1779825589570;
        Tue, 26 May 2026 12:59:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8706968sm287149385a.17.2026.05.26.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:59:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: prevent stack overflows
Date: Tue, 26 May 2026 15:59:17 -0400
Message-ID: <20260526195917.18869-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcstrans calls strcat() repeatedly on fixed-size stack buffers. Under
certain configurations and inputs, this could yield a stack overflow.
Introduce a buf_append() helper that dynamically allocates the buffer
and resizes it as needed and replace all uses of strcat() with it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 137 +++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 44 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 5ef6a0b9..002877e4 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -21,6 +21,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <stdio_ext.h>
+#include <stdint.h>
 #include <ctype.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
@@ -973,6 +974,38 @@ word_size(const void *p1, const void *p2) {
 	return spaceship_cmp(w2_len, w1_len);
 }
 
+static int buf_append(char **buf, size_t *cap, size_t *len, const char *s)
+{
+	size_t slen = strlen(s);
+
+	if (slen >= SIZE_MAX - 1 - *len) {
+		log_error("buf_append: length overflow (%zu + %zu)", *len, slen);
+		return -1;
+	}
+
+	size_t need = *len + slen + 1;
+	if (need > *cap) {
+		size_t ncap = *cap ? *cap : 128;
+		while (ncap < need) {
+			if (ncap > SIZE_MAX / 2) {
+				ncap = need;
+				break;
+			}
+			ncap *= 2;
+		}
+		char *n = realloc(*buf, ncap);
+		if (!n) {
+			log_error("buf_append: allocation error %s", strerror(errno));
+			return -1;
+		}
+		*buf = n;
+		*cap = ncap;
+	}
+	memcpy(*buf + *len, s, slen + 1);
+	*len += slen;
+	return 0;
+}
+
 static void
 build_regexp(pcre2_code **r, char *buffer) {
 	int error;
@@ -985,19 +1018,24 @@ build_regexp(pcre2_code **r, char *buffer) {
 		pcre2_get_error_message(error, errbuf, sizeof(errbuf));
 		log_error("pcre compilation of '%s' failed at offset %zu: %s\n", buffer, error_offset, errbuf);
 	}
-	buffer[0] = '\0';
 }
 
 static int
 build_regexps(domain_t *domain) {
-	char buffer[1024 * 128];
-	buffer[0] = '\0';
+	char *buffer = NULL;
+	size_t cap = 0, len = 0;
 	base_classification_t *bc;
 	word_group_t *g;
 	affix_t *a;
 	word_t *w;
 	size_t n_el, i;
 
+#define APPEND(s) do { if (buf_append(&buffer, &cap, &len, (s))) goto err; } while (0)
+#define RESET() do { len = 0; if (buffer) buffer[0] = '\0'; } while (0)
+
+	/* initialize buffer and cap to non-NULL/0 values */
+	APPEND("");
+
 	for (n_el = 0, bc = domain->base_classifications; bc; bc = bc->next) {
 		n_el++;
 	}
@@ -1005,7 +1043,7 @@ build_regexps(domain_t *domain) {
 	char **sortable = calloc(n_el, sizeof(char *));
 	if (!sortable) {
 		log_error("allocation error %s", strerror(errno));
-		return -1;
+		goto err;
 	}
 
 	for (i=0, bc = domain->base_classifications; bc; bc = bc->next) {
@@ -1015,31 +1053,33 @@ build_regexps(domain_t *domain) {
 	qsort(sortable, n_el, sizeof(char *), string_size);
 
 	for (i = 0; i < n_el; i++) {
-		strcat(buffer, sortable[i]);
-		if (i < n_el) strcat(buffer,"|");
+		APPEND(sortable[i]);
+		if (i != (n_el - 1)) APPEND("|");
 	}
 
 	free(sortable);
 
 	log_debug(">>> %s classification regexp=%s\n", domain->name, buffer);
 	build_regexp(&domain->base_classification_regexp, buffer);
+	RESET();
 
 	for (g = domain->groups; g; g = g->next) {
 		if (g->prefixes) {
-			strcat(buffer,"(?:");
+			APPEND("(?:");
 			for (a = g->prefixes; a; a = a->next) {
-				strcat(buffer, a->text);
-				if (a->next) strcat(buffer,"|");
+				APPEND(a->text);
+				if (a->next) APPEND("|");
 			}
-			strcat(buffer,")");
-			strcat(buffer,"[ 	]+");
+			APPEND(")");
+			APPEND("[ 	]+");
 			log_debug(">>> %s %s prefix regexp=%s\n", domain->name, g->name, buffer);
 			build_regexp(&g->prefix_regexp, buffer);
+			RESET();
 		}
 
 		if (g->prefixes)
-			strcat(buffer, "^");
-		strcat(buffer, "(?:");
+			APPEND("^");
+		APPEND("(?:");
 
 		g->sword_len=0;
 		for (w = g->words; w; w = w->next)
@@ -1048,7 +1088,7 @@ build_regexps(domain_t *domain) {
 		g->sword = calloc(g->sword_len, sizeof(word_t *));
 		if (!g->sword) {
 			log_error("allocation error %s", strerror(errno));
-			return -1;
+			goto err;
 		}
 
 		i=0;
@@ -1058,38 +1098,47 @@ build_regexps(domain_t *domain) {
 		qsort(g->sword, g->sword_len, sizeof(word_t *), word_size);
 
 		for (i=0; i < g->sword_len; i++) {
-			if (i) strcat(buffer,"|");
-			strcat(buffer,"\\b");
-			strcat(buffer, g->sword[i]->text);
-			strcat(buffer,"\\b");
+			if (i) APPEND("|");
+			APPEND("\\b");
+			APPEND(g->sword[i]->text);
+			APPEND("\\b");
 		}
 
 		if (g->whitespace) {
-			strcat(buffer,"|[");
-			strcat(buffer, g->whitespace);
-			strcat(buffer, "]+");
+			APPEND("|[");
+			APPEND(g->whitespace);
+			APPEND("]+");
 		}
 
-		strcat(buffer, ")+");
+		APPEND(")+");
 		if (g->suffixes)
-			strcat(buffer, "$");
+			APPEND("$");
 
 		log_debug(">>> %s %s modifier regexp=%s\n", domain->name, g->name, buffer);
 		build_regexp(&g->word_regexp, buffer);
+		RESET();
+
 		if (g->suffixes) {
-			strcat(buffer,"[ 	]+");
-			strcat(buffer,"(?:");
+			APPEND("[ 	]+");
+			APPEND("(?:");
 			for (a = g->suffixes; a; a = a->next) {
-				strcat(buffer, a->text);
-				if (a->next) strcat(buffer,"|");
+				APPEND(a->text);
+				if (a->next) APPEND("|");
 			}
-			strcat(buffer,")");
+			APPEND(")");
 			log_debug(">>> %s %s suffix regexp=%s\n", domain->name, g->name, buffer);
 			build_regexp(&g->suffix_regexp, buffer);
+			RESET();
 		}
 	}
 
+	free(buffer);
 	return 0;
+err:
+	free(buffer);
+	return -1;
+#undef APPEND
+#undef RESET
 }
 
 static char *
@@ -1349,6 +1398,8 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
 	word_group_t *g;
 	mls_level_t *l = NULL;
 	char *rval = NULL;
+	char *obuf = NULL;
+	size_t ocap = 0, olen = 0;
 	word_group_t *groups = NULL;
 	ebitmap_t bit_diff, temp, handled, nothandled, unhandled, orig_unhandled;
 
@@ -1482,39 +1533,36 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
 			ebitmap_destroy(&unhandled);
 			ebitmap_destroy(&orig_unhandled);
 			if (done) {
-				char buffer[9999];
-				buffer[0] = 0;
-				strcat(buffer, bc->trans);
-				strcat(buffer, " ");
+#define OAPPEND(s) do { if (buf_append(&obuf, &ocap, &olen, (s))) goto err; } while (0)
+				OAPPEND(bc->trans);
+				OAPPEND(" ");
 				for (g=groups; g; g = g->next) {
 					if (g->words && g->prefixes) {
-						strcat(buffer, g->prefixes->text);
-						strcat(buffer, " ");
+						OAPPEND(g->prefixes->text);
+						OAPPEND(" ");
 					}
 					word_t *w;
 					for (w=g->words; w; w = w->next) {
-						strcat(buffer, w->text);
+						OAPPEND(w->text);
 						if (w->next)
-							strcat(buffer, g->join);
+							OAPPEND(g->join);
 					}
 					if (g->words && g->suffixes) {
-						strcat(buffer, " ");
-						strcat(buffer, g->suffixes->text);
+						OAPPEND(" ");
+						OAPPEND(g->suffixes->text);
 					}
 					word_group_t *n = g->next;
 					while(g->words && n) {
 						if (n->words) {
-							strcat(buffer, " ");
+							OAPPEND(" ");
 							break;
 						}
 						n = n->next;
 					}
 				}
-				rval = strdup(buffer);
-				if (!rval) {
-					log_error("compute_trans_from_raw: allocation error %s", strerror(errno));
-					goto err;
-				}
+				rval = obuf;
+				obuf = NULL;
+#undef OAPPEND
 			}
 			/* clean up */
 			while (groups)
@@ -1542,6 +1590,7 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
 	return rval;
 
 err:
+	free(obuf);
 	while (groups)
 		destroy_group(&groups, groups);
 	mls_level_destroy(l);
-- 
2.54.0

