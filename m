Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99007EB64DA
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 15:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGSPOj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGSPOh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 11:14:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F408B7
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:14:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4039f7e1d3aso56093241cf.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689779674; x=1690384474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7z9kYJrlznX8xj+uJQrnfqflTPQKLBEeLTBdhfaLjc=;
        b=I7ANP3050iU2MSkk+Q7djaSci1cbOHrUp5Kv1AlO0r9Gu+IXmjyz8i/jNQs50b3x+7
         nWrvZo+M62nL6fTa3F9g/cL1eqS/JOIvZHPwqNADBkD+qWWltEqUmlr9SpdCNO4kA/wz
         XhDlIw3OzIj//kuBC8cO+DlVBKScPug5rHNWQ92+gmFcRpgO4G3Qpw2YhPZVkIqlpNhS
         bcS4df3aXGDqrKnjv91Hq5KSdnMeTF0adS+pNJeddpZzBpAifQqu2cCKJiO4AJu0AFPU
         nh02sYvPDhRKGk0D3Oe3l7QDXinJZV0fNBWmUDCQyXUCTFVBDtu7KXZwF/wH5uq5PlhU
         G37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689779674; x=1690384474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7z9kYJrlznX8xj+uJQrnfqflTPQKLBEeLTBdhfaLjc=;
        b=M/DL1Z8Rwi0qq1ZJGrJlRtsmz1mKOK8uRKpAZt7WvwrwWzGKc3AJUz4PZvRpQeilBH
         l4Wtl3KL8v9hdeHUEKhqyU6yiTsmftG/iam3BZgHW32HePoLSc95xmzaCv88fmXOzN6W
         71yU5BmJGtT4322GnYLNt9WzrIxAI7syhC6CPtv1ZLDgmMwBkpzmgF5cTWNlU+f/90nx
         u/zD4Tu3kc6HC8TUhtw7a2YBrfY8y79QrG7eye3tfyarnD4KeHfGR+RHBEr4Xoa3NJk5
         eTcJFGXfAECwPagN9+elcLFynqZmP7VHsw0BdiZ8IVNHREPXA8JjTkiEj0j6DcjNlhKu
         /0hg==
X-Gm-Message-State: ABy/qLbX19uoNVF0FBJQFv3j1jdQ0/yCnXwkTEN4S4C+CdpRFqhZFG5T
        pu4OC8Q99n5li3rOzeWBoucnavTCWsI=
X-Google-Smtp-Source: APBJJlFCJH5bZD9CWJWVQv0aiomF5Sq6YD3OQf4FhK7FmdhOwrhCFAKWevlj+VOi25Ubt7wMX2Crrg==
X-Received: by 2002:a05:622a:1703:b0:3ff:3013:d2aa with SMTP id h3-20020a05622a170300b003ff3013d2aamr27673956qtk.12.1689779674436;
        Wed, 19 Jul 2023 08:14:34 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id c25-20020ac86619000000b0040378535dccsm1387699qtp.43.2023.07.19.08.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 08:14:34 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: update my email address
Date:   Wed, 19 Jul 2023 11:12:50 -0400
Message-Id: <20230719151249.11818-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update my email address; MAINTAINERS was updated some time ago.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c              | 2 +-
 security/selinux/hooks.c            | 2 +-
 security/selinux/include/avc.h      | 2 +-
 security/selinux/include/avc_ss.h   | 2 +-
 security/selinux/include/objsec.h   | 2 +-
 security/selinux/include/security.h | 2 +-
 security/selinux/ss/avtab.c         | 2 +-
 security/selinux/ss/avtab.h         | 2 +-
 security/selinux/ss/constraint.h    | 2 +-
 security/selinux/ss/context.h       | 2 +-
 security/selinux/ss/ebitmap.c       | 2 +-
 security/selinux/ss/ebitmap.h       | 2 +-
 security/selinux/ss/hashtab.c       | 2 +-
 security/selinux/ss/hashtab.h       | 2 +-
 security/selinux/ss/mls.c           | 2 +-
 security/selinux/ss/mls.h           | 2 +-
 security/selinux/ss/mls_types.h     | 2 +-
 security/selinux/ss/policydb.c      | 2 +-
 security/selinux/ss/policydb.h      | 2 +-
 security/selinux/ss/services.c      | 2 +-
 security/selinux/ss/services.h      | 2 +-
 security/selinux/ss/sidtab.c        | 2 +-
 security/selinux/ss/sidtab.h        | 2 +-
 security/selinux/ss/symtab.c        | 2 +-
 security/selinux/ss/symtab.h        | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cd55479cce25..32eb67fb3e42 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the kernel access vector cache (AVC).
  *
- * Authors:  Stephen Smalley, <sds@tycho.nsa.gov>
+ * Authors:  Stephen Smalley, <stephen.smalley.work@gmail.com>
  *	     James Morris <jmorris@redhat.com>
  *
  * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9aa60ce23209..323bba423bce 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4,7 +4,7 @@
  *
  *  This file contains the SELinux hook function implementations.
  *
- *  Authors:  Stephen Smalley, <sds@tycho.nsa.gov>
+ *  Authors:  Stephen Smalley, <stephen.smalley.work@gmail.com>
  *	      Chris Vance, <cvance@nai.com>
  *	      Wayne Salamon, <wsalamon@nai.com>
  *	      James Morris <jmorris@redhat.com>
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 9e055f74daf6..8f0aa66ccb13 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -2,7 +2,7 @@
 /*
  * Access vector cache interface for object managers.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SELINUX_AVC_H_
 #define _SELINUX_AVC_H_
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index b9668be7b443..88b139e086c4 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -2,7 +2,7 @@
 /*
  * Access vector cache interface for the security server.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SELINUX_AVC_SS_H_
 #define _SELINUX_AVC_SS_H_
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 8f50e8fe0488..8159fd53c3de 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -4,7 +4,7 @@
  *
  *  This file contains the SELinux security data structures for kernel objects.
  *
- *  Author(s):  Stephen Smalley, <sds@tycho.nsa.gov>
+ *  Author(s):  Stephen Smalley, <stephen.smalley.work@gmail.com>
  *		Chris Vance, <cvance@nai.com>
  *		Wayne Salamon, <wsalamon@nai.com>
  *		James Morris <jmorris@redhat.com>
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 6b8b8fc3badd..668e393a9709 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -2,7 +2,7 @@
 /*
  * Security server interface.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  *
  */
 
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8d7c14ca27a2..81256d0cde6c 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the access vector table type.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 
 /* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index f265e9da18e2..b2382ef76697 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -6,7 +6,7 @@
  * table is used to represent the type enforcement
  * tables.
  *
- *  Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ *  Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 
 /* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 4e563be9ef5f..f76eb3128ad5 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -11,7 +11,7 @@
  * process from labeling an object with a different user
  * identity.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SS_CONSTRAINT_H_
 #define _SS_CONSTRAINT_H_
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index aed704b8c642..1f59468c0759 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -11,7 +11,7 @@
  * security server and can be changed without affecting
  * clients of the security server.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SS_CONTEXT_H_
 #define _SS_CONTEXT_H_
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index d31b87be9a1e..77875ad355f7 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the extensible bitmap type.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 /*
  * Updated: Hewlett-Packard <paul@paul-moore.com>
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e5b57dc3fc53..e3c807cfad90 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -10,7 +10,7 @@
  * an explicitly specified starting bit position within
  * the total bitmap.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SS_EBITMAP_H_
 #define _SS_EBITMAP_H_
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 3fb8f9026e9b..30532ec319ce 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the hash table type.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 043a773bf0b7..9dac6da45b98 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -6,7 +6,7 @@
  * functions for hash computation and key comparison are
  * provided by the creator of the table.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SS_HASHTAB_H_
 #define _SS_HASHTAB_H_
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 99571b19d4a9..b2c6c846ea03 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the multi-level security (MLS) policy.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 15cacde0ff61..107681dd1824 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -2,7 +2,7 @@
 /*
  * Multi-level security (MLS) policy operations.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 7d48d5e52233..f492cf148891 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -2,7 +2,7 @@
 /*
  * Type definitions for the multi-level security (MLS) policy.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cfe77ef24ee2..4e1ad618c5cf 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the policy database.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 
 /*
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 6b4ad8e91265..b97cda489753 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -3,7 +3,7 @@
  * A policy database (policydb) specifies the
  * configuration data for the security policy.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 
 /*
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 83b85536cd2b..e3ca9c2f396f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the security services.
  *
- * Authors : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Authors : Stephen Smalley, <stephen.smalley.work@gmail.com>
  *	     James Morris <jmorris@redhat.com>
  *
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 8a9b85f44b66..ed2ee6600467 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -2,7 +2,7 @@
 /*
  * Implementation of the security services.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SS_SERVICES_H_
 #define _SS_SERVICES_H_
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 38d25173aebd..d8ead463b8df 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the SID table type.
  *
- * Original author: Stephen Smalley, <sds@tycho.nsa.gov>
+ * Original author: Stephen Smalley, <stephen.smalley.work@gmail.com>
  * Author: Ondrej Mosnacek, <omosnacek@gmail.com>
  *
  * Copyright (C) 2018 Red Hat, Inc.
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 72810a080e77..22258201cd14 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -3,7 +3,7 @@
  * A security identifier table (sidtab) is a lookup table
  * of security context structures indexed by SID value.
  *
- * Original author: Stephen Smalley, <sds@tycho.nsa.gov>
+ * Original author: Stephen Smalley, <stephen.smalley.work@gmail.com>
  * Author: Ondrej Mosnacek, <omosnacek@gmail.com>
  *
  * Copyright (C) 2018 Red Hat, Inc.
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 7a77571fb275..43d7f0319ccd 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -2,7 +2,7 @@
 /*
  * Implementation of the symbol table type.
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index 3033c4db6cb6..0a3b5de79a0f 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -5,7 +5,7 @@
  * is arbitrary.  The symbol table type is implemented
  * using the hash table type (hashtab).
  *
- * Author : Stephen Smalley, <sds@tycho.nsa.gov>
+ * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
 #ifndef _SS_SYMTAB_H_
 #define _SS_SYMTAB_H_
-- 
2.40.1

