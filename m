Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C3C07E97
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3C861490
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhGCOeZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:34:25 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58759 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhGCOeV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Jul 2021 10:34:21 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 34E70564DD4
        for <selinux@vger.kernel.org>; Sat,  3 Jul 2021 16:31:46 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/6] libselinux: silence -Wextra-semi-stmt warning
Date:   Sat,  3 Jul 2021 16:31:18 +0200
Message-Id: <20210703143122.1441578-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
References: <20210703143122.1441578-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul  3 16:31:46 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Ubuntu 20.04, when building with clang -Werror -Wextra-semi-stmt
(which is not the default build configuration), the compiler reports:

      sha1.c:90:21: error: empty expression statement has no effect;
      remove unnecessary ';' to silence this warning
      [-Werror,-Wextra-semi-stmt]
          R0(a,b,c,d,e, 0); R0(e,a,b,c,d, 1); R0(d,e,a,b,c, 2); R0(c,d,e,a,b, 3);
                          ^
      In file included from selinux_restorecon.c:39:
      ./label_file.h:458:15: error: empty expression statement has no
      effect; remove unnecessary ';' to silence this warning
      [-Werror,-Wextra-semi-stmt]
                                  lineno);
                                        ^

Introduce "do { } while (0)" blocks to silence such warnings.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/avc_internal.h                | 22 +++++++++++++-------
 libselinux/src/label_internal.h              | 10 +++++----
 libselinux/src/load_policy.c                 |  2 +-
 libselinux/src/procattr.c                    |  4 ++--
 libselinux/src/sha1.c                        | 11 +++++-----
 libselinux/utils/matchpathcon.c              |  2 +-
 libselinux/utils/selabel_lookup_best_match.c |  2 +-
 7 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index da67affc9307..a9a4aa0b3c42 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -85,10 +85,12 @@ static inline void avc_free(void *ptr)
 
 /* this is a macro in order to use the variadic capability. */
 #define avc_log(type, format...) \
-  if (avc_func_log) \
-    avc_func_log(format); \
-  else \
-    selinux_log(type, format);
+  do { \
+    if (avc_func_log) \
+      avc_func_log(format); \
+    else \
+      selinux_log(type, format); \
+  } while (0)
 
 static inline void avc_suppl_audit(void *ptr, security_class_t class,
 				   char *buf, size_t len)
@@ -137,14 +139,18 @@ static inline void avc_free_lock(void *lock)
 #ifdef AVC_CACHE_STATS
 
 #define avc_cache_stats_incr(field) \
-  cache_stats.field ++;
+  do { \
+    cache_stats.field ++; \
+  } while (0)
 #define avc_cache_stats_add(field, num) \
-  cache_stats.field += num;
+  do { \
+    cache_stats.field += num; \
+  } while (0)
 
 #else
 
-#define avc_cache_stats_incr(field)
-#define avc_cache_stats_add(field, num)
+#define avc_cache_stats_incr(field) do {} while (0)
+#define avc_cache_stats_add(field, num) do {} while (0)
 
 #endif
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 361b443cb9c4..782c6aa8cc0c 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -128,10 +128,12 @@ extern int myprintf_compat;
 extern void __attribute__ ((format(printf, 1, 2)))
 (*myprintf) (const char *fmt, ...) ;
 
-#define COMPAT_LOG(type, fmt...) if (myprintf_compat)	  \
-		myprintf(fmt);				  \
-	else						  \
-		selinux_log(type, fmt);
+#define COMPAT_LOG(type, fmt...) do {			\
+	if (myprintf_compat)				\
+		myprintf(fmt);				\
+	else						\
+		selinux_log(type, fmt);			\
+	} while (0)
 
 extern int
 compat_validate(struct selabel_handle *rec,
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 0034fa53d6e6..5857b821e80e 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -80,7 +80,7 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 	if (libsepolh) {
 		usesepol = 1;
 		dlerror();
-#define DLERR() if ((errormsg = dlerror())) goto dlclose;
+#define DLERR() do { if ((errormsg = dlerror())) goto dlclose; } while (0)
 		vers_max = dlsym(libsepolh, "sepol_policy_kern_vers_max");
 		DLERR();
 		vers_min = dlsym(libsepolh, "sepol_policy_kern_vers_min");
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 840570525f5f..6552ee01bca8 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -146,7 +146,7 @@ static int getprocattrcon_raw(char ** context,
 		default:
 			errno = ENOENT;
 			return -1;
-	};
+	}
 
 	if (prev_context && prev_context != UNSET) {
 		*context = strdup(prev_context);
@@ -240,7 +240,7 @@ static int setprocattrcon_raw(const char * context,
 		default:
 			errno = ENOENT;
 			return -1;
-	};
+	}
 
 	if (!context && !*prev_context)
 		return 0;
diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 664bbcf26eef..a848467785f3 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -16,6 +16,7 @@
 //        sha1.c:73:33: error: cast from 'uint8_t *' (aka 'unsigned char *') to 'CHAR64LONG16 *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
 //             CHAR64LONG16*       block = (CHAR64LONG16*) workspace;
 //                                                                     William Roberts <william.c.roberts@intel.com>
+//    - Silence clang's -Wextra-semi-stmt warning - July 2021, Nicolas Iooss <nicolas.iooss@m4x.org>
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -49,11 +50,11 @@ typedef union
     ^block->l[(i+2)&15]^block->l[i&15],1))
 
 // (R0+R1), R2, R3, R4 are the different operations used in SHA1
-#define R0(v,w,x,y,z,i)  z += ((w&(x^y))^y)     + blk0(i)+ 0x5A827999 + rol(v,5); w=rol(w,30);
-#define R1(v,w,x,y,z,i)  z += ((w&(x^y))^y)     + blk(i) + 0x5A827999 + rol(v,5); w=rol(w,30);
-#define R2(v,w,x,y,z,i)  z += (w^x^y)           + blk(i) + 0x6ED9EBA1 + rol(v,5); w=rol(w,30);
-#define R3(v,w,x,y,z,i)  z += (((w|x)&y)|(w&x)) + blk(i) + 0x8F1BBCDC + rol(v,5); w=rol(w,30);
-#define R4(v,w,x,y,z,i)  z += (w^x^y)           + blk(i) + 0xCA62C1D6 + rol(v,5); w=rol(w,30);
+#define R0(v,w,x,y,z,i)  do { z += ((w&(x^y))^y)     + blk0(i)+ 0x5A827999 + rol(v,5); w=rol(w,30); } while (0)
+#define R1(v,w,x,y,z,i)  do { z += ((w&(x^y))^y)     + blk(i) + 0x5A827999 + rol(v,5); w=rol(w,30); } while (0)
+#define R2(v,w,x,y,z,i)  do { z += (w^x^y)           + blk(i) + 0x6ED9EBA1 + rol(v,5); w=rol(w,30); } while (0)
+#define R3(v,w,x,y,z,i)  do { z += (((w|x)&y)|(w&x)) + blk(i) + 0x8F1BBCDC + rol(v,5); w=rol(w,30); } while (0)
+#define R4(v,w,x,y,z,i)  do { z += (w^x^y)           + blk(i) + 0xCA62C1D6 + rol(v,5); w=rol(w,30); } while (0)
 
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index a07e160dee71..1d713c01f81c 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -65,7 +65,7 @@ static mode_t string_to_mode(char *s)
 		return S_IFREG;
 	default:
 		return -1;
-	};
+	}
 	return -1;
 }
 
diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/utils/selabel_lookup_best_match.c
index 6a7174233667..2cddc6cde051 100644
--- a/libselinux/utils/selabel_lookup_best_match.c
+++ b/libselinux/utils/selabel_lookup_best_match.c
@@ -47,7 +47,7 @@ static mode_t string_to_mode(char *s)
 		return S_IFSOCK;
 	case 'f':
 		return S_IFREG;
-	};
+	}
 	return 0;
 }
 
-- 
2.32.0

