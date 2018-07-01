Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61Evp4g008341
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 10:57:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 41JYQj48jgz3GD9q
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 14:57:49 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 41JYQh35p7z3GD9p
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A6D11561259
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 16:57:44 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Jul 2018 16:57:39 +0200
Message-Id: <20180701145739.23309-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] mcstrans: fix memory leaks reported by clang's
 static analyzer
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There are many memory leaks in mcstrans. Clean them up in order to
reduce the noise in clang's static analyzer report. Some are remaining,
because they are more complex to fix.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/src/mcstrans.c | 68 +++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 00fb80856da7..96bdbdff7d8b 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -708,6 +708,7 @@ append(affix_t **affixes, const char *val) {
 
 err:
 	log_error("allocation error %s", strerror(errno));
+	free(affix);
 	return -1;
 }
 
@@ -1517,8 +1518,10 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
 		} else {
 			trans = compute_trans_from_raw(range, domain);
 			if (trans)
-				if (add_cache(domain, range, trans) < 0)
+				if (add_cache(domain, range, trans) < 0) {
+					free(range);
 					return -1;
+				}
 		}
 
 		if (lrange && urange) {
@@ -1526,12 +1529,15 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
 			if (! ltrans) {
 				ltrans = compute_trans_from_raw(lrange, domain);
 				if (ltrans) {
-					if (add_cache(domain, lrange, ltrans) < 0)
+					if (add_cache(domain, lrange, ltrans) < 0) {
+						free(range);
 						return -1;
+					}
 				} else {
 					ltrans = strdup(lrange);
 					if (! ltrans) {
 						log_error("strdup failed %s", strerror(errno));
+						free(range);
 						return -1;
 					}
 				}
@@ -1541,25 +1547,36 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
 			if (! utrans) {
 				utrans = compute_trans_from_raw(urange, domain);
 				if (utrans) {
-					if (add_cache(domain, urange, utrans) < 0)
+					if (add_cache(domain, urange, utrans) < 0) {
+						free(ltrans);
+						free(range);
 						return -1;
+					}
 				} else {
 					utrans = strdup(urange);
 					if (! utrans) {
 						log_error("strdup failed %s", strerror(errno));
- 						return -1;
- 					}
- 				}
+						free(ltrans);
+						free(range);
+						return -1;
+					}
+				}
 			}
 
 			if (strcmp(ltrans, utrans) == 0) {
 				if (asprintf(&trans, "%s", ltrans) < 0) {
 					log_error("asprintf failed %s", strerror(errno));
+					free(utrans);
+					free(ltrans);
+					free(range);
 					return -1;
 				}
 			} else {
 				if (asprintf(&trans, "%s-%s", ltrans, utrans) < 0) {
 					log_error("asprintf failed %s", strerror(errno));
+					free(utrans);
+					free(ltrans);
+					free(range);
 					return -1;
 				}
 			}
@@ -1629,13 +1646,17 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
 				if (!canonical) {
 					canonical = compute_trans_from_raw(raw, domain);
 					if (canonical && strcmp(canonical, range))
-						if (add_cache(domain, raw, canonical) < 0)
+						if (add_cache(domain, raw, canonical) < 0) {
+							free(range);
 							return -1;
+						}
 				}
 				if (canonical)
 					free(canonical);
-				if (add_cache(domain, raw, range) < 0)
+				if (add_cache(domain, raw, range) < 0) {
+					free(range);
 					return -1;
+				}
 			} else {
 				log_debug("untrans_context unable to compute raw context %s\n", range);
 			}
@@ -1650,17 +1671,24 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
 					if (!canonical) {
 						canonical = compute_trans_from_raw(lraw, domain);
 						if (canonical)
-							if (add_cache(domain, lraw, canonical) < 0)
+							if (add_cache(domain, lraw, canonical) < 0) {
+								free(lraw);
+								free(range);
 								return -1;
+							}
 					}
 					if (canonical)
 						free(canonical);
-					if (add_cache(domain, lraw, lrange) < 0)
+					if (add_cache(domain, lraw, lrange) < 0) {
+						free(lraw);
+						free(range);
 						return -1;
+					}
 				} else {
 					lraw = strdup(lrange);
 					if (! lraw) {
 						log_error("strdup failed %s", strerror(errno));
+						free(range);
 						return -1;
 					}
 				}
@@ -1674,17 +1702,27 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
 					if (!canonical) {
 						canonical = compute_trans_from_raw(uraw, domain);
 						if (canonical)
-							if (add_cache(domain, uraw, canonical) < 0)
+							if (add_cache(domain, uraw, canonical) < 0) {
+								free(uraw);
+								free(lraw);
+								free(range);
 								return -1;
 							}
+					}
 					if (canonical)
 						free(canonical);
-					if (add_cache(domain, uraw, urange) < 0)
+					if (add_cache(domain, uraw, urange) < 0) {
+						free(uraw);
+						free(lraw);
+						free(range);
 						return -1;
+					}
 				} else {
 					uraw = strdup(urange);
 					if (! uraw) {
 						log_error("strdup failed %s", strerror(errno));
+						free(lraw);
+						free(range);
 						return -1;
 					}
 				}
@@ -1694,11 +1732,17 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
 			if (strcmp(lraw, uraw) == 0) {
 				if (asprintf(&raw, "%s", lraw) < 0) {
 					log_error("asprintf failed %s", strerror(errno));
+					free(uraw);
+					free(lraw);
+					free(range);
 					return -1;
 				}
 			} else {
 				if (asprintf(&raw, "%s-%s", lraw, uraw) < 0) {
 					log_error("asprintf failed %s", strerror(errno));
+					free(uraw);
+					free(lraw);
+					free(range);
 					return -1;
 				}
 			}
-- 
2.17.1
