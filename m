Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746FC3F2CD
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC120735
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBWKCnfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCWRuw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:50:52 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40527 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbgCWRuw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 13:50:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so157229pjb.5
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpunz8XPfSN+NweHcR0U9u4aw5cWqH5PqUj/GkO2Cpk=;
        b=rBWKCnfYHr/tFRfnPAMGGs8jpQT0f9cBT/9lS3PFpcQQvqavyV7VqLYnE/B5uOTMl/
         dGlL6f0+I94ne1q67iyCG6NXvT7H/oKMHvWpq7e7XtYVonz7qCxp0bw9PnworEebzFJl
         OEKeYyksPZXCEGWwXzNoBwaZLSFfOXFyhLbB/nujjX/3ewnni+vLzyD8y9sFDIEoHiYU
         O8P4LtaAy3dP+EkZDJKmv9eoFXE98Y+XIuYdKlMaBNVdM8LJCzdUyT/IlB4Ya5SzWSa1
         rw2Aus6FD4p6gs2QpzxPjbV4AUAu5rfr6q7WoIdhj8MtwHyLFj5ns3RJqHXlPFgAEXDv
         bfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wpunz8XPfSN+NweHcR0U9u4aw5cWqH5PqUj/GkO2Cpk=;
        b=W7ocPFG4QX8pQKFGZv0GSYN3MjXosX60+ciSCYDaSrqWMVwWZq7BLTGNLhUYrQ3sSQ
         1oHffBt+qwJGBa4WSiUSeq8YWrAFAWaNrrnlcNpI93eMMC8DzWn4glTpGBfZ4oBF7eLg
         OdSzh/KumAj2UxuaqRhiRch5Sk/07o646YR6e+9MRLiyOWQIyzTuAbyN9UulhI2cSNmx
         E7g2NXKFXwGJGIWgIwVTFCdNzedqEuj/XllgmqWqhxLS7/TOVTiwfLT9YDUChxs/o4gG
         6/RHTMt4qu383XKWVa60pMMb5skd9QxRPMXDX6g/UUv9ScNT2YmDQRnpCWv+jpp+cfiH
         yZqQ==
X-Gm-Message-State: ANhLgQ1QpTJdbIcOW1G4QM4zu/IIRSheoafHAtvVhRMQ1TsrTxoC/ekF
        V3PnI83uRqXRbzKMi5mwKCc=
X-Google-Smtp-Source: ADFU+vtukKk7izyh+td4Zpes/Fe0uHXaTEhPY6dRJ7gCd4yOKBk6SwSTV8sT8ifS1pAqqYnuBpfgnA==
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr581171pjb.18.1584985847851;
        Mon, 23 Mar 2020 10:50:47 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id j126sm13963979pfg.60.2020.03.23.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:50:47 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     drepper@redhat.com, nicolas.iooss@m4x.org, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH 1/4] libsemanage: drop hidden
Date:   Mon, 23 Mar 2020 12:50:34 -0500
Message-Id: <20200323175037.19170-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323175037.19170-1-william.c.roberts@intel.com>
References: <20200323175037.19170-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/boolean_internal.h   | 13 -----
 libsemanage/src/boolean_record.c     | 12 -----
 libsemanage/src/context_internal.h   | 11 -----
 libsemanage/src/context_record.c     |  5 --
 libsemanage/src/database_llist.c     |  2 +-
 libsemanage/src/debug.c              |  7 +--
 libsemanage/src/debug.h              |  8 +---
 libsemanage/src/dso.h                | 23 ---------
 libsemanage/src/fcontext_internal.h  | 20 +-------
 libsemanage/src/fcontext_record.c    | 16 -------
 libsemanage/src/fcontexts_file.c     |  1 -
 libsemanage/src/fcontexts_local.c    |  4 +-
 libsemanage/src/handle.c             |  5 --
 libsemanage/src/handle.h             |  1 -
 libsemanage/src/handle_internal.h    | 13 -----
 libsemanage/src/ibendport_internal.h | 20 +-------
 libsemanage/src/ibendport_record.c   | 15 +-----
 libsemanage/src/ibendports_file.c    |  1 -
 libsemanage/src/ibendports_local.c   |  3 +-
 libsemanage/src/ibpkey_internal.h    | 24 +---------
 libsemanage/src/ibpkey_record.c      | 19 +-------
 libsemanage/src/ibpkeys_file.c       |  1 -
 libsemanage/src/ibpkeys_local.c      |  3 +-
 libsemanage/src/iface_internal.h     | 15 ------
 libsemanage/src/iface_record.c       | 13 -----
 libsemanage/src/interfaces_file.c    |  1 -
 libsemanage/src/module_internal.h    | 27 -----------
 libsemanage/src/modules.c            | 21 +-------
 libsemanage/src/modules.h            |  2 +-
 libsemanage/src/node_internal.h      | 27 +----------
 libsemanage/src/node_record.c        | 22 +--------
 libsemanage/src/nodes_file.c         |  1 -
 libsemanage/src/nodes_local.c        |  1 -
 libsemanage/src/port_internal.h      | 23 +--------
 libsemanage/src/port_record.c        | 18 +------
 libsemanage/src/ports_file.c         |  1 -
 libsemanage/src/ports_local.c        |  3 +-
 libsemanage/src/semanage_store.c     |  1 -
 libsemanage/src/seuser_internal.h    | 20 +-------
 libsemanage/src/seuser_record.c      | 14 ------
 libsemanage/src/seusers_local.c      |  3 +-
 libsemanage/src/seusers_policy.c     |  1 -
 libsemanage/src/user_base_record.c   | 32 ++++++-------
 libsemanage/src/user_extra_record.c  | 14 +++---
 libsemanage/src/user_internal.h      | 72 ++++++++++------------------
 libsemanage/src/user_record.c        | 22 ++-------
 libsemanage/src/users_policy.c       |  2 -
 47 files changed, 78 insertions(+), 505 deletions(-)
 delete mode 100644 libsemanage/src/context_internal.h
 delete mode 100644 libsemanage/src/dso.h
 delete mode 100644 libsemanage/src/handle_internal.h
 delete mode 100644 libsemanage/src/module_internal.h

diff --git a/libsemanage/src/boolean_internal.h b/libsemanage/src/boolean_internal.h
index dc23c2731670..8d1c20dc7337 100644
--- a/libsemanage/src/boolean_internal.h
+++ b/libsemanage/src/boolean_internal.h
@@ -7,19 +7,6 @@
 #include <semanage/booleans_active.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_bool_clone)
-    hidden_proto(semanage_bool_compare)
-    hidden_proto(semanage_bool_compare2)
-    hidden_proto(semanage_bool_create)
-    hidden_proto(semanage_bool_free)
-    hidden_proto(semanage_bool_get_name)
-    hidden_proto(semanage_bool_get_value)
-    hidden_proto(semanage_bool_key_extract)
-    hidden_proto(semanage_bool_key_free)
-    hidden_proto(semanage_bool_set_name)
-    hidden_proto(semanage_bool_set_value)
 
 /* BOOL RECORD: method table */
 extern record_table_t SEMANAGE_BOOL_RTABLE;
diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index c234094ef86f..95f3a8620ead 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -8,7 +8,6 @@
 
 #include <string.h>
 #include <sepol/boolean_record.h>
-#include "handle_internal.h"
 
 typedef sepol_bool_t semanage_bool_t;
 typedef sepol_bool_key_t semanage_bool_key_t;
@@ -40,14 +39,12 @@ int semanage_bool_key_extract(semanage_handle_t * handle,
 	return sepol_bool_key_extract(handle->sepolh, boolean, key);
 }
 
-hidden_def(semanage_bool_key_extract)
 
 void semanage_bool_key_free(semanage_bool_key_t * key)
 {
 	sepol_bool_key_free(key);
 }
 
-hidden_def(semanage_bool_key_free)
 
 int semanage_bool_compare(const semanage_bool_t * boolean,
 			  const semanage_bool_key_t * key)
@@ -56,7 +53,6 @@ int semanage_bool_compare(const semanage_bool_t * boolean,
 	return sepol_bool_compare(boolean, key);
 }
 
-hidden_def(semanage_bool_compare)
 
 int semanage_bool_compare2(const semanage_bool_t * boolean,
 			   const semanage_bool_t * boolean2)
@@ -65,7 +61,6 @@ int semanage_bool_compare2(const semanage_bool_t * boolean,
 	return sepol_bool_compare2(boolean, boolean2);
 }
 
-hidden_def(semanage_bool_compare2)
 
 static int semanage_bool_compare2_qsort(const semanage_bool_t ** boolean,
 					const semanage_bool_t ** boolean2)
@@ -81,7 +76,6 @@ const char *semanage_bool_get_name(const semanage_bool_t * boolean)
 	return sepol_bool_get_name(boolean);
 }
 
-hidden_def(semanage_bool_get_name)
 
 int semanage_bool_set_name(semanage_handle_t * handle,
 			   semanage_bool_t * boolean, const char *name)
@@ -141,7 +135,6 @@ out:
 	return rc;
 }
 
-hidden_def(semanage_bool_set_name)
 
 /* Value */
 int semanage_bool_get_value(const semanage_bool_t * boolean)
@@ -150,7 +143,6 @@ int semanage_bool_get_value(const semanage_bool_t * boolean)
 	return sepol_bool_get_value(boolean);
 }
 
-hidden_def(semanage_bool_get_value)
 
 void semanage_bool_set_value(semanage_bool_t * boolean, int value)
 {
@@ -158,7 +150,6 @@ void semanage_bool_set_value(semanage_bool_t * boolean, int value)
 	sepol_bool_set_value(boolean, value);
 }
 
-hidden_def(semanage_bool_set_value)
 
 /* Create/Clone/Destroy */
 int semanage_bool_create(semanage_handle_t * handle,
@@ -168,7 +159,6 @@ int semanage_bool_create(semanage_handle_t * handle,
 	return sepol_bool_create(handle->sepolh, bool_ptr);
 }
 
-hidden_def(semanage_bool_create)
 
 int semanage_bool_clone(semanage_handle_t * handle,
 			const semanage_bool_t * boolean,
@@ -178,7 +168,6 @@ int semanage_bool_clone(semanage_handle_t * handle,
 	return sepol_bool_clone(handle->sepolh, boolean, bool_ptr);
 }
 
-hidden_def(semanage_bool_clone)
 
 void semanage_bool_free(semanage_bool_t * boolean)
 {
@@ -186,7 +175,6 @@ void semanage_bool_free(semanage_bool_t * boolean)
 	sepol_bool_free(boolean);
 }
 
-hidden_def(semanage_bool_free)
 
 /* Record base functions */
 record_table_t SEMANAGE_BOOL_RTABLE = {
diff --git a/libsemanage/src/context_internal.h b/libsemanage/src/context_internal.h
deleted file mode 100644
index 729bfc84132d..000000000000
--- a/libsemanage/src/context_internal.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _SEMANAGE_CONTEXT_INTERNAL_H_
-#define _SEMANAGE_CONTEXT_INTERNAL_H_
-
-#include <semanage/context_record.h>
-#include "dso.h"
-
-hidden_proto(semanage_context_clone)
-    hidden_proto(semanage_context_free)
-    hidden_proto(semanage_context_from_string)
-    hidden_proto(semanage_context_to_string)
-#endif
diff --git a/libsemanage/src/context_record.c b/libsemanage/src/context_record.c
index a228565e90b7..16ba518eef34 100644
--- a/libsemanage/src/context_record.c
+++ b/libsemanage/src/context_record.c
@@ -6,7 +6,6 @@
 typedef sepol_context_t semanage_context_t;
 
 #define _SEMANAGE_CONTEXT_DEFINED_
-#include "context_internal.h"
 
 /* User */
 const char *semanage_context_get_user(const semanage_context_t * con)
@@ -80,7 +79,6 @@ int semanage_context_clone(semanage_handle_t * handle,
 	return sepol_context_clone(handle->sepolh, con, con_ptr);
 }
 
-hidden_def(semanage_context_clone)
 
 void semanage_context_free(semanage_context_t * con)
 {
@@ -88,7 +86,6 @@ void semanage_context_free(semanage_context_t * con)
 	sepol_context_free(con);
 }
 
-hidden_def(semanage_context_free)
 
 /* Parse to/from string */
 int semanage_context_from_string(semanage_handle_t * handle,
@@ -98,7 +95,6 @@ int semanage_context_from_string(semanage_handle_t * handle,
 	return sepol_context_from_string(handle->sepolh, str, con);
 }
 
-hidden_def(semanage_context_from_string)
 
 int semanage_context_to_string(semanage_handle_t * handle,
 			       const semanage_context_t * con, char **str_ptr)
@@ -107,4 +103,3 @@ int semanage_context_to_string(semanage_handle_t * handle,
 	return sepol_context_to_string(handle->sepolh, con, str_ptr);
 }
 
-hidden_def(semanage_context_to_string)
diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index c8f4ff0bf392..240b2557b47e 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -218,7 +218,7 @@ int dbase_llist_modify(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_count(semanage_handle_t * handle __attribute__ ((unused)),
+ int dbase_llist_count(semanage_handle_t * handle __attribute__ ((unused)),
 			     dbase_llist_t * dbase, unsigned int *response)
 {
 
diff --git a/libsemanage/src/debug.c b/libsemanage/src/debug.c
index 08a9e026042b..3c345462c845 100644
--- a/libsemanage/src/debug.c
+++ b/libsemanage/src/debug.c
@@ -33,25 +33,22 @@ int semanage_msg_get_level(semanage_handle_t * handle)
 	return handle->msg_level;
 }
 
-hidden_def(semanage_msg_get_level)
 
 const char *semanage_msg_get_channel(semanage_handle_t * handle)
 {
 	return handle->msg_channel;
 }
 
-hidden_def(semanage_msg_get_channel)
 
 const char *semanage_msg_get_fname(semanage_handle_t * handle)
 {
 	return handle->msg_fname;
 }
 
-hidden_def(semanage_msg_get_fname)
 #ifdef __GNUC__
     __attribute__ ((format(printf, 3, 4)))
 #endif
-void hidden semanage_msg_default_handler(void *varg __attribute__ ((unused)),
+void semanage_msg_default_handler(void *varg __attribute__ ((unused)),
 					 semanage_handle_t * handle,
 					 const char *fmt, ...)
 {
@@ -91,7 +88,7 @@ void hidden semanage_msg_default_handler(void *varg __attribute__ ((unused)),
 #ifdef __GNUC__
 __attribute__ ((format(printf, 3, 4)))
 #endif
-void hidden semanage_msg_relay_handler(void *varg,
+void semanage_msg_relay_handler(void *varg,
 				       sepol_handle_t * sepolh,
 				       const char *fmt, ...)
 {
diff --git a/libsemanage/src/debug.h b/libsemanage/src/debug.h
index 92bfcf5f53aa..a18a95be3f91 100644
--- a/libsemanage/src/debug.h
+++ b/libsemanage/src/debug.h
@@ -27,7 +27,6 @@
 #include <semanage/debug.h>
 #include <sepol/debug.h>
 #include "handle.h"
-#include "dso.h"
 
 #define STATUS_SUCCESS 0
 #define STATUS_ERR -1
@@ -62,18 +61,15 @@
 #ifdef __GNUC__
 __attribute__ ((format(printf, 3, 4)))
 #endif
-extern void hidden semanage_msg_default_handler(void *varg,
+extern void semanage_msg_default_handler(void *varg,
 						semanage_handle_t * handle,
 						const char *fmt, ...);
 
 #ifdef __GNUC__
 __attribute__ ((format(printf, 3, 4)))
 #endif
-extern void hidden semanage_msg_relay_handler(void *varg,
+extern void semanage_msg_relay_handler(void *varg,
 					      sepol_handle_t * handle,
 					      const char *fmt, ...);
 
-hidden_proto(semanage_msg_get_channel)
-    hidden_proto(semanage_msg_get_fname)
-    hidden_proto(semanage_msg_get_level)
 #endif
diff --git a/libsemanage/src/dso.h b/libsemanage/src/dso.h
deleted file mode 100644
index 8c9a0140871f..000000000000
--- a/libsemanage/src/dso.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef _SEMANAGE_DSO_H
-#define _SEMANAGE_DSO_H	1
-
-#ifdef SHARED
-# define hidden __attribute__ ((visibility ("hidden")))
-# define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
-# define __hidden_proto(fct, internal)	\
-     extern __typeof (fct) internal;	\
-     extern __typeof (fct) fct __asm (#internal) hidden;
-# if defined(__alpha__) || defined(__mips__)
-#  define hidden_def(fct) \
-     asm (".globl " #fct "\n" #fct " = " #fct "_internal");
-# else
-#  define hidden_def(fct) \
-     asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");
-#endif
-#else
-# define hidden
-# define hidden_proto(fct)
-# define hidden_def(fct)
-#endif
-
-#endif
diff --git a/libsemanage/src/fcontext_internal.h b/libsemanage/src/fcontext_internal.h
index c7767d077c0b..7ae20f12b566 100644
--- a/libsemanage/src/fcontext_internal.h
+++ b/libsemanage/src/fcontext_internal.h
@@ -7,24 +7,6 @@
 #include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_fcontext_key_create)
-    hidden_proto(semanage_fcontext_key_extract)
-    hidden_proto(semanage_fcontext_key_free)
-    hidden_proto(semanage_fcontext_compare)
-    hidden_proto(semanage_fcontext_compare2)
-    hidden_proto(semanage_fcontext_create)
-    hidden_proto(semanage_fcontext_get_expr)
-    hidden_proto(semanage_fcontext_set_expr)
-    hidden_proto(semanage_fcontext_get_type)
-    hidden_proto(semanage_fcontext_get_type_str)
-    hidden_proto(semanage_fcontext_set_type)
-    hidden_proto(semanage_fcontext_get_con)
-    hidden_proto(semanage_fcontext_set_con)
-    hidden_proto(semanage_fcontext_clone)
-    hidden_proto(semanage_fcontext_free)
-    hidden_proto(semanage_fcontext_iterate_local)
 
 /* FCONTEXT RECORD: method table */
 extern record_table_t SEMANAGE_FCONTEXT_RTABLE;
@@ -36,7 +18,7 @@ extern int fcontext_file_dbase_init(semanage_handle_t * handle,
 
 extern void fcontext_file_dbase_release(dbase_config_t * dconfig);
 
-extern int hidden semanage_fcontext_validate_local(semanage_handle_t * handle,
+extern int semanage_fcontext_validate_local(semanage_handle_t * handle,
 						   const sepol_policydb_t *
 						   policydb);
 
diff --git a/libsemanage/src/fcontext_record.c b/libsemanage/src/fcontext_record.c
index f39efa199223..ae1b03244de8 100644
--- a/libsemanage/src/fcontext_record.c
+++ b/libsemanage/src/fcontext_record.c
@@ -7,7 +7,6 @@ typedef struct semanage_fcontext_key record_key_t;
 #include <stdlib.h>
 #include <string.h>
 #include "fcontext_internal.h"
-#include "context_internal.h"
 #include "debug.h"
 
 struct semanage_fcontext {
@@ -57,7 +56,6 @@ int semanage_fcontext_key_create(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_fcontext_key_create)
 
 int semanage_fcontext_key_extract(semanage_handle_t * handle,
 				  const semanage_fcontext_t * fcontext,
@@ -75,7 +73,6 @@ int semanage_fcontext_key_extract(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_fcontext_key_extract)
 
 void semanage_fcontext_key_free(semanage_fcontext_key_t * key)
 {
@@ -83,7 +80,6 @@ void semanage_fcontext_key_free(semanage_fcontext_key_t * key)
 	free(key);
 }
 
-hidden_def(semanage_fcontext_key_free)
 
 int semanage_fcontext_compare(const semanage_fcontext_t * fcontext,
 			      const semanage_fcontext_key_t * key)
@@ -104,7 +100,6 @@ int semanage_fcontext_compare(const semanage_fcontext_t * fcontext,
 	}
 }
 
-hidden_def(semanage_fcontext_compare)
 
 int semanage_fcontext_compare2(const semanage_fcontext_t * fcontext,
 			       const semanage_fcontext_t * fcontext2)
@@ -125,7 +120,6 @@ int semanage_fcontext_compare2(const semanage_fcontext_t * fcontext,
 	}
 }
 
-hidden_def(semanage_fcontext_compare2)
 
 static int semanage_fcontext_compare2_qsort(const semanage_fcontext_t **
 					    fcontext,
@@ -158,7 +152,6 @@ int semanage_fcontext_create(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_fcontext_create)
 
 /* Regexp */
 const char *semanage_fcontext_get_expr(const semanage_fcontext_t * fcontext)
@@ -167,7 +160,6 @@ const char *semanage_fcontext_get_expr(const semanage_fcontext_t * fcontext)
 	return fcontext->expr;
 }
 
-hidden_def(semanage_fcontext_get_expr)
 
 int semanage_fcontext_set_expr(semanage_handle_t * handle,
 			       semanage_fcontext_t * fcontext, const char *expr)
@@ -183,7 +175,6 @@ int semanage_fcontext_set_expr(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_fcontext_set_expr)
 
 /* Type */
 int semanage_fcontext_get_type(const semanage_fcontext_t * fcontext)
@@ -192,7 +183,6 @@ int semanage_fcontext_get_type(const semanage_fcontext_t * fcontext)
 	return fcontext->type;
 }
 
-hidden_def(semanage_fcontext_get_type)
 
 const char *semanage_fcontext_get_type_str(int type)
 {
@@ -219,7 +209,6 @@ const char *semanage_fcontext_get_type_str(int type)
 	}
 }
 
-hidden_def(semanage_fcontext_get_type_str)
 
 void semanage_fcontext_set_type(semanage_fcontext_t * fcontext, int type)
 {
@@ -227,7 +216,6 @@ void semanage_fcontext_set_type(semanage_fcontext_t * fcontext, int type)
 	fcontext->type = type;
 }
 
-hidden_def(semanage_fcontext_set_type)
 
 /* Context */
 semanage_context_t *semanage_fcontext_get_con(const semanage_fcontext_t *
@@ -237,7 +225,6 @@ semanage_context_t *semanage_fcontext_get_con(const semanage_fcontext_t *
 	return fcontext->con;
 }
 
-hidden_def(semanage_fcontext_get_con)
 
 int semanage_fcontext_set_con(semanage_handle_t * handle,
 			      semanage_fcontext_t * fcontext,
@@ -256,7 +243,6 @@ int semanage_fcontext_set_con(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_fcontext_set_con)
 
 /* Deep copy clone */
 int semanage_fcontext_clone(semanage_handle_t * handle,
@@ -288,7 +274,6 @@ int semanage_fcontext_clone(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(semanage_fcontext_clone)
 
 /* Destroy */
 void semanage_fcontext_free(semanage_fcontext_t * fcontext)
@@ -302,7 +287,6 @@ void semanage_fcontext_free(semanage_fcontext_t * fcontext)
 	free(fcontext);
 }
 
-hidden_def(semanage_fcontext_free)
 
 /* Record base functions */
 record_table_t SEMANAGE_FCONTEXT_RTABLE = {
diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
index 1e596519832b..04cd365aa2df 100644
--- a/libsemanage/src/fcontexts_file.c
+++ b/libsemanage/src/fcontexts_file.c
@@ -15,7 +15,6 @@ typedef struct dbase_file dbase_t;
 #include <strings.h>
 #include <semanage/handle.h>
 #include "fcontext_internal.h"
-#include "context_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff --git a/libsemanage/src/fcontexts_local.c b/libsemanage/src/fcontexts_local.c
index b0da236b17a9..ea994d8cf108 100644
--- a/libsemanage/src/fcontexts_local.c
+++ b/libsemanage/src/fcontexts_local.c
@@ -10,7 +10,6 @@ typedef struct semanage_fcontext record_t;
 #include <sepol/policydb.h>
 #include <sepol/context.h>
 #include "fcontext_internal.h"
-#include "context_internal.h"
 #include "debug.h"
 #include "handle.h"
 #include "database.h"
@@ -68,7 +67,6 @@ int semanage_fcontext_iterate_local(semanage_handle_t * handle,
 	return dbase_iterate(handle, dconfig, handler, handler_arg);
 }
 
-hidden_def(semanage_fcontext_iterate_local)
 
 int semanage_fcontext_list_local(semanage_handle_t * handle,
 				 semanage_fcontext_t *** records,
@@ -118,7 +116,7 @@ static int validate_handler(const semanage_fcontext_t * fcon, void *varg)
 	return -1;
 }
 
-int hidden semanage_fcontext_validate_local(semanage_handle_t * handle,
+int semanage_fcontext_validate_local(semanage_handle_t * handle,
 					    const sepol_policydb_t * policydb)
 {
 
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 5e59aef700a2..bb1e61400760 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -48,7 +48,6 @@ int semanage_set_root(const char *root)
 	return 0;
 }
 
-hidden_def(semanage_set_root);
 
 const char * semanage_root(void)
 {
@@ -58,7 +57,6 @@ const char * semanage_root(void)
 	return private_semanage_root;
 }
 
-hidden_def(semanage_root);
 
 semanage_handle_t *semanage_handle_create(void)
 {
@@ -364,7 +362,6 @@ int semanage_access_check(semanage_handle_t * sh)
 	return -1;		/* unreachable */
 }
 
-hidden_def(semanage_access_check)
 
 int semanage_disconnect(semanage_handle_t * sh)
 {
@@ -394,7 +391,6 @@ void semanage_handle_destroy(semanage_handle_t * sh)
 	free(sh);
 }
 
-hidden_def(semanage_handle_destroy)
 
 /********************* public transaction functions *********************/
 int semanage_begin_transaction(semanage_handle_t * sh)
@@ -416,7 +412,6 @@ int semanage_begin_transaction(semanage_handle_t * sh)
 	return 0;
 }
 
-hidden_def(semanage_begin_transaction)
 
 int semanage_commit(semanage_handle_t * sh)
 {
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index a91907b098bf..e1ce83ba2d08 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -25,7 +25,6 @@
 
 #include <stdint.h>
 #include <stddef.h>
-#include "handle_internal.h"
 #include <sepol/handle.h>
 #include "modules.h"
 #include "semanage_conf.h"
diff --git a/libsemanage/src/handle_internal.h b/libsemanage/src/handle_internal.h
deleted file mode 100644
index d4b4d9c7db53..000000000000
--- a/libsemanage/src/handle_internal.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef _SEMANAGE_HANDLE_INTERNAL_H_
-#define _SEMANAGE_HANDLE_INTERNAL_H_
-
-#include <semanage/handle.h>
-#include "dso.h"
-
-hidden_proto(semanage_begin_transaction)
-hidden_proto(semanage_handle_destroy)
-hidden_proto(semanage_reload_policy)
-hidden_proto(semanage_access_check)
-hidden_proto(semanage_set_root)
-hidden_proto(semanage_root)
-#endif
diff --git a/libsemanage/src/ibendport_internal.h b/libsemanage/src/ibendport_internal.h
index 970fbdb2ed37..eada2d4b2fa1 100644
--- a/libsemanage/src/ibendport_internal.h
+++ b/libsemanage/src/ibendport_internal.h
@@ -6,22 +6,6 @@
 #include <semanage/ibendports_policy.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_ibendport_create)
-hidden_proto(semanage_ibendport_compare)
-hidden_proto(semanage_ibendport_compare2)
-hidden_proto(semanage_ibendport_clone)
-hidden_proto(semanage_ibendport_free)
-hidden_proto(semanage_ibendport_key_extract)
-hidden_proto(semanage_ibendport_key_free)
-hidden_proto(semanage_ibendport_get_port)
-hidden_proto(semanage_ibendport_set_port)
-hidden_proto(semanage_ibendport_get_con)
-hidden_proto(semanage_ibendport_set_con)
-hidden_proto(semanage_ibendport_list_local)
-hidden_proto(semanage_ibendport_get_ibdev_name)
-hidden_proto(semanage_ibendport_set_ibdev_name)
 
 /* IBENDPORT RECORD: method table */
 extern record_table_t SEMANAGE_IBENDPORT_RTABLE;
@@ -38,11 +22,11 @@ extern int ibendport_policydb_dbase_init(semanage_handle_t *handle,
 
 extern void ibendport_policydb_dbase_release(dbase_config_t *dconfig);
 
-extern int hidden semanage_ibendport_validate_local(semanage_handle_t *handle);
+extern int semanage_ibendport_validate_local(semanage_handle_t *handle);
 
 /* ==== Internal (to ibendports) API === */
 
-hidden int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
+ int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
 					     const semanage_ibendport_t **ibendport2);
 
 #endif
diff --git a/libsemanage/src/ibendport_record.c b/libsemanage/src/ibendport_record.c
index 955067eadf22..a8cb125d9413 100644
--- a/libsemanage/src/ibendport_record.c
+++ b/libsemanage/src/ibendport_record.c
@@ -29,7 +29,6 @@ int semanage_ibendport_compare(const semanage_ibendport_t *ibendport,
 	return sepol_ibendport_compare(ibendport, key);
 }
 
-hidden_def(semanage_ibendport_compare)
 
 int semanage_ibendport_compare2(const semanage_ibendport_t *ibendport,
 				const semanage_ibendport_t *ibendport2)
@@ -37,9 +36,8 @@ int semanage_ibendport_compare2(const semanage_ibendport_t *ibendport,
 	return sepol_ibendport_compare2(ibendport, ibendport2);
 }
 
-hidden_def(semanage_ibendport_compare2)
 
-hidden int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
+ int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
 					     const semanage_ibendport_t **ibendport2)
 {
 	return sepol_ibendport_compare2(*ibendport, *ibendport2);
@@ -60,14 +58,12 @@ int semanage_ibendport_key_extract(semanage_handle_t *handle,
 	return sepol_ibendport_key_extract(handle->sepolh, ibendport, key_ptr);
 }
 
-hidden_def(semanage_ibendport_key_extract)
 
 void semanage_ibendport_key_free(semanage_ibendport_key_t *key)
 {
 	sepol_ibendport_key_free(key);
 }
 
-hidden_def(semanage_ibendport_key_free)
 
 int semanage_ibendport_get_ibdev_name(semanage_handle_t *handle,
 				      const semanage_ibendport_t *ibendport,
@@ -76,7 +72,6 @@ int semanage_ibendport_get_ibdev_name(semanage_handle_t *handle,
 	return sepol_ibendport_get_ibdev_name(handle->sepolh, ibendport, ibdev_name_ptr);
 }
 
-hidden_def(semanage_ibendport_get_ibdev_name)
 
 int semanage_ibendport_set_ibdev_name(semanage_handle_t *handle,
 				      semanage_ibendport_t *ibendport,
@@ -85,28 +80,24 @@ int semanage_ibendport_set_ibdev_name(semanage_handle_t *handle,
 	return sepol_ibendport_set_ibdev_name(handle->sepolh, ibendport, ibdev_name);
 }
 
-hidden_def(semanage_ibendport_set_ibdev_name)
 
 int semanage_ibendport_get_port(const semanage_ibendport_t *ibendport)
 {
 	return sepol_ibendport_get_port(ibendport);
 }
 
-hidden_def(semanage_ibendport_get_port)
 
 void semanage_ibendport_set_port(semanage_ibendport_t *ibendport, int port)
 {
 	sepol_ibendport_set_port(ibendport, port);
 }
 
-hidden_def(semanage_ibendport_set_port)
 
 semanage_context_t *semanage_ibendport_get_con(const semanage_ibendport_t *ibendport)
 {
 	return sepol_ibendport_get_con(ibendport);
 }
 
-hidden_def(semanage_ibendport_get_con)
 
 int semanage_ibendport_set_con(semanage_handle_t *handle,
 			       semanage_ibendport_t *ibendport,
@@ -115,7 +106,6 @@ int semanage_ibendport_set_con(semanage_handle_t *handle,
 	return sepol_ibendport_set_con(handle->sepolh, ibendport, con);
 }
 
-hidden_def(semanage_ibendport_set_con)
 
 int semanage_ibendport_create(semanage_handle_t *handle,
 			      semanage_ibendport_t **ibendport_ptr)
@@ -123,7 +113,6 @@ int semanage_ibendport_create(semanage_handle_t *handle,
 	return sepol_ibendport_create(handle->sepolh, ibendport_ptr);
 }
 
-hidden_def(semanage_ibendport_create)
 
 int semanage_ibendport_clone(semanage_handle_t *handle,
 			     const semanage_ibendport_t *ibendport,
@@ -132,14 +121,12 @@ int semanage_ibendport_clone(semanage_handle_t *handle,
 	return sepol_ibendport_clone(handle->sepolh, ibendport, ibendport_ptr);
 }
 
-hidden_def(semanage_ibendport_clone)
 
 void semanage_ibendport_free(semanage_ibendport_t *ibendport)
 {
 	sepol_ibendport_free(ibendport);
 }
 
-hidden_def(semanage_ibendport_free)
 
 /*key base functions */
 record_table_t SEMANAGE_IBENDPORT_RTABLE = {
diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
index 402c7a5e59ec..bafa8c1d65bf 100644
--- a/libsemanage/src/ibendports_file.c
+++ b/libsemanage/src/ibendports_file.c
@@ -15,7 +15,6 @@ typedef struct dbase_file dbase_t;
 #include <strings.h>
 #include <semanage/handle.h>
 #include "ibendport_internal.h"
-#include "context_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff --git a/libsemanage/src/ibendports_local.c b/libsemanage/src/ibendports_local.c
index 8b5567d88ad9..e696fdcab611 100644
--- a/libsemanage/src/ibendports_local.c
+++ b/libsemanage/src/ibendports_local.c
@@ -74,9 +74,8 @@ int semanage_ibendport_list_local(semanage_handle_t *handle,
 	return dbase_list(handle, dconfig, records, count);
 }
 
-hidden_def(semanage_ibendport_list_local)
 
-int hidden semanage_ibendport_validate_local(semanage_handle_t *handle)
+int semanage_ibendport_validate_local(semanage_handle_t *handle)
 {
 	semanage_ibendport_t **ibendports = NULL;
 	unsigned int nibendports = 0;
diff --git a/libsemanage/src/ibpkey_internal.h b/libsemanage/src/ibpkey_internal.h
index 9465bb8d71dd..1e206b626c22 100644
--- a/libsemanage/src/ibpkey_internal.h
+++ b/libsemanage/src/ibpkey_internal.h
@@ -6,26 +6,6 @@
 #include <semanage/ibpkeys_policy.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_ibpkey_create)
-hidden_proto(semanage_ibpkey_compare)
-hidden_proto(semanage_ibpkey_compare2)
-hidden_proto(semanage_ibpkey_clone)
-hidden_proto(semanage_ibpkey_free)
-hidden_proto(semanage_ibpkey_key_extract)
-hidden_proto(semanage_ibpkey_key_free)
-hidden_proto(semanage_ibpkey_get_high)
-hidden_proto(semanage_ibpkey_get_low)
-hidden_proto(semanage_ibpkey_set_pkey)
-hidden_proto(semanage_ibpkey_set_range)
-hidden_proto(semanage_ibpkey_get_con)
-hidden_proto(semanage_ibpkey_set_con)
-hidden_proto(semanage_ibpkey_list_local)
-hidden_proto(semanage_ibpkey_get_subnet_prefix)
-hidden_proto(semanage_ibpkey_get_subnet_prefix_bytes)
-hidden_proto(semanage_ibpkey_set_subnet_prefix)
-hidden_proto(semanage_ibpkey_set_subnet_prefix_bytes)
 
 /* PKEY RECORD: method table */
 extern record_table_t SEMANAGE_IBPKEY_RTABLE;
@@ -42,11 +22,11 @@ extern int ibpkey_policydb_dbase_init(semanage_handle_t *handle,
 
 extern void ibpkey_policydb_dbase_release(dbase_config_t *dconfig);
 
-extern int hidden semanage_ibpkey_validate_local(semanage_handle_t *handle);
+extern int semanage_ibpkey_validate_local(semanage_handle_t *handle);
 
 /* ==== Internal (to ibpkeys) API === */
 
-hidden int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
+ int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
 					  const semanage_ibpkey_t **ibpkey2);
 
 #endif
diff --git a/libsemanage/src/ibpkey_record.c b/libsemanage/src/ibpkey_record.c
index ca5bc76d4ae0..bb7fa6ea2a04 100644
--- a/libsemanage/src/ibpkey_record.c
+++ b/libsemanage/src/ibpkey_record.c
@@ -29,7 +29,6 @@ int semanage_ibpkey_compare(const semanage_ibpkey_t *ibpkey,
 	return sepol_ibpkey_compare(ibpkey, key);
 }
 
-hidden_def(semanage_ibpkey_compare)
 
 int semanage_ibpkey_compare2(const semanage_ibpkey_t *ibpkey,
 			     const semanage_ibpkey_t *ibpkey2)
@@ -37,9 +36,8 @@ int semanage_ibpkey_compare2(const semanage_ibpkey_t *ibpkey,
 	return sepol_ibpkey_compare2(ibpkey, ibpkey2);
 }
 
-hidden_def(semanage_ibpkey_compare2)
 
-hidden int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
+ int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
 					  const semanage_ibpkey_t **ibpkey2)
 {
 	return sepol_ibpkey_compare2(*ibpkey, *ibpkey2);
@@ -60,14 +58,12 @@ int semanage_ibpkey_key_extract(semanage_handle_t *handle,
 	return sepol_ibpkey_key_extract(handle->sepolh, ibpkey, key_ptr);
 }
 
-hidden_def(semanage_ibpkey_key_extract)
 
 void semanage_ibpkey_key_free(semanage_ibpkey_key_t *key)
 {
 	sepol_ibpkey_key_free(key);
 }
 
-hidden_def(semanage_ibpkey_key_free)
 
 int semanage_ibpkey_get_subnet_prefix(semanage_handle_t *handle,
 				      const semanage_ibpkey_t *ibpkey,
@@ -76,14 +72,12 @@ int semanage_ibpkey_get_subnet_prefix(semanage_handle_t *handle,
 	return sepol_ibpkey_get_subnet_prefix(handle->sepolh, ibpkey, subnet_prefix_ptr);
 }
 
-hidden_def(semanage_ibpkey_get_subnet_prefix)
 
 uint64_t semanage_ibpkey_get_subnet_prefix_bytes(const semanage_ibpkey_t *ibpkey)
 {
 	return sepol_ibpkey_get_subnet_prefix_bytes(ibpkey);
 }
 
-hidden_def(semanage_ibpkey_get_subnet_prefix_bytes)
 
 int semanage_ibpkey_set_subnet_prefix(semanage_handle_t *handle,
 				      semanage_ibpkey_t *ibpkey,
@@ -92,7 +86,6 @@ int semanage_ibpkey_set_subnet_prefix(semanage_handle_t *handle,
 	return sepol_ibpkey_set_subnet_prefix(handle->sepolh, ibpkey, subnet_prefix);
 }
 
-hidden_def(semanage_ibpkey_set_subnet_prefix)
 
 void semanage_ibpkey_set_subnet_prefix_bytes(semanage_ibpkey_t *ibpkey,
 					     uint64_t subnet_prefix)
@@ -100,42 +93,36 @@ void semanage_ibpkey_set_subnet_prefix_bytes(semanage_ibpkey_t *ibpkey,
 	return sepol_ibpkey_set_subnet_prefix_bytes(ibpkey, subnet_prefix);
 }
 
-hidden_def(semanage_ibpkey_set_subnet_prefix_bytes)
 
 int semanage_ibpkey_get_low(const semanage_ibpkey_t *ibpkey)
 {
 	return sepol_ibpkey_get_low(ibpkey);
 }
 
-hidden_def(semanage_ibpkey_get_low)
 
 int semanage_ibpkey_get_high(const semanage_ibpkey_t *ibpkey)
 {
 	return sepol_ibpkey_get_high(ibpkey);
 }
 
-hidden_def(semanage_ibpkey_get_high)
 
 void semanage_ibpkey_set_pkey(semanage_ibpkey_t *ibpkey, int ibpkey_num)
 {
 	sepol_ibpkey_set_pkey(ibpkey, ibpkey_num);
 }
 
-hidden_def(semanage_ibpkey_set_pkey)
 
 void semanage_ibpkey_set_range(semanage_ibpkey_t *ibpkey, int low, int high)
 {
 	sepol_ibpkey_set_range(ibpkey, low, high);
 }
 
-hidden_def(semanage_ibpkey_set_range)
 
 semanage_context_t *semanage_ibpkey_get_con(const semanage_ibpkey_t *ibpkey)
 {
 	return sepol_ibpkey_get_con(ibpkey);
 }
 
-hidden_def(semanage_ibpkey_get_con)
 
 int semanage_ibpkey_set_con(semanage_handle_t *handle,
 			    semanage_ibpkey_t *ibpkey, semanage_context_t *con)
@@ -143,7 +130,6 @@ int semanage_ibpkey_set_con(semanage_handle_t *handle,
 	return sepol_ibpkey_set_con(handle->sepolh, ibpkey, con);
 }
 
-hidden_def(semanage_ibpkey_set_con)
 
 int semanage_ibpkey_create(semanage_handle_t *handle,
 			   semanage_ibpkey_t **ibpkey_ptr)
@@ -151,7 +137,6 @@ int semanage_ibpkey_create(semanage_handle_t *handle,
 	return sepol_ibpkey_create(handle->sepolh, ibpkey_ptr);
 }
 
-hidden_def(semanage_ibpkey_create)
 
 int semanage_ibpkey_clone(semanage_handle_t *handle,
 			  const semanage_ibpkey_t *ibpkey,
@@ -160,14 +145,12 @@ int semanage_ibpkey_clone(semanage_handle_t *handle,
 	return sepol_ibpkey_clone(handle->sepolh, ibpkey, ibpkey_ptr);
 }
 
-hidden_def(semanage_ibpkey_clone)
 
 void semanage_ibpkey_free(semanage_ibpkey_t *ibpkey)
 {
 	sepol_ibpkey_free(ibpkey);
 }
 
-hidden_def(semanage_ibpkey_free)
 
 /* key base functions */
 record_table_t SEMANAGE_IBPKEY_RTABLE = {
diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
index ceaea7ada7f6..929bc31e612e 100644
--- a/libsemanage/src/ibpkeys_file.c
+++ b/libsemanage/src/ibpkeys_file.c
@@ -15,7 +15,6 @@ typedef struct dbase_file dbase_t;
 #include <strings.h>
 #include <semanage/handle.h>
 #include "ibpkey_internal.h"
-#include "context_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff --git a/libsemanage/src/ibpkeys_local.c b/libsemanage/src/ibpkeys_local.c
index e194ee01c8ca..6d05d125470d 100644
--- a/libsemanage/src/ibpkeys_local.c
+++ b/libsemanage/src/ibpkeys_local.c
@@ -74,9 +74,8 @@ int semanage_ibpkey_list_local(semanage_handle_t *handle,
 	return dbase_list(handle, dconfig, records, count);
 }
 
-hidden_def(semanage_ibpkey_list_local)
 
-int hidden semanage_ibpkey_validate_local(semanage_handle_t *handle)
+int semanage_ibpkey_validate_local(semanage_handle_t *handle)
 {
 	semanage_ibpkey_t **ibpkeys = NULL;
 	unsigned int nibpkeys = 0;
diff --git a/libsemanage/src/iface_internal.h b/libsemanage/src/iface_internal.h
index 5cb77789e170..df38fb0f92c8 100644
--- a/libsemanage/src/iface_internal.h
+++ b/libsemanage/src/iface_internal.h
@@ -6,21 +6,6 @@
 #include <semanage/interfaces_policy.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_iface_create)
-    hidden_proto(semanage_iface_compare)
-    hidden_proto(semanage_iface_compare2)
-    hidden_proto(semanage_iface_clone)
-    hidden_proto(semanage_iface_free)
-    hidden_proto(semanage_iface_get_ifcon)
-    hidden_proto(semanage_iface_get_msgcon)
-    hidden_proto(semanage_iface_get_name)
-    hidden_proto(semanage_iface_key_extract)
-    hidden_proto(semanage_iface_key_free)
-    hidden_proto(semanage_iface_set_ifcon)
-    hidden_proto(semanage_iface_set_msgcon)
-    hidden_proto(semanage_iface_set_name)
 
 /* IFACE RECORD: method table */
 extern record_table_t SEMANAGE_IFACE_RTABLE;
diff --git a/libsemanage/src/iface_record.c b/libsemanage/src/iface_record.c
index e7d72d755baa..e54cdd2d820d 100644
--- a/libsemanage/src/iface_record.c
+++ b/libsemanage/src/iface_record.c
@@ -31,7 +31,6 @@ int semanage_iface_compare(const semanage_iface_t * iface,
 	return sepol_iface_compare(iface, key);
 }
 
-hidden_def(semanage_iface_compare)
 
 int semanage_iface_compare2(const semanage_iface_t * iface,
 			    const semanage_iface_t * iface2)
@@ -40,7 +39,6 @@ int semanage_iface_compare2(const semanage_iface_t * iface,
 	return sepol_iface_compare2(iface, iface2);
 }
 
-hidden_def(semanage_iface_compare2)
 
 static int semanage_iface_compare2_qsort(const semanage_iface_t ** iface,
 					 const semanage_iface_t ** iface2)
@@ -64,7 +62,6 @@ int semanage_iface_key_extract(semanage_handle_t * handle,
 	return sepol_iface_key_extract(handle->sepolh, iface, key_ptr);
 }
 
-hidden_def(semanage_iface_key_extract)
 
 void semanage_iface_key_free(semanage_iface_key_t * key)
 {
@@ -72,7 +69,6 @@ void semanage_iface_key_free(semanage_iface_key_t * key)
 	sepol_iface_key_free(key);
 }
 
-hidden_def(semanage_iface_key_free)
 
 /* Name */
 const char *semanage_iface_get_name(const semanage_iface_t * iface)
@@ -81,7 +77,6 @@ const char *semanage_iface_get_name(const semanage_iface_t * iface)
 	return sepol_iface_get_name(iface);
 }
 
-hidden_def(semanage_iface_get_name)
 
 int semanage_iface_set_name(semanage_handle_t * handle,
 			    semanage_iface_t * iface, const char *name)
@@ -90,7 +85,6 @@ int semanage_iface_set_name(semanage_handle_t * handle,
 	return sepol_iface_set_name(handle->sepolh, iface, name);
 }
 
-hidden_def(semanage_iface_set_name)
 
 /* Context */
 semanage_context_t *semanage_iface_get_ifcon(const semanage_iface_t * iface)
@@ -99,7 +93,6 @@ semanage_context_t *semanage_iface_get_ifcon(const semanage_iface_t * iface)
 	return sepol_iface_get_ifcon(iface);
 }
 
-hidden_def(semanage_iface_get_ifcon)
 
 int semanage_iface_set_ifcon(semanage_handle_t * handle,
 			     semanage_iface_t * iface, semanage_context_t * con)
@@ -108,7 +101,6 @@ int semanage_iface_set_ifcon(semanage_handle_t * handle,
 	return sepol_iface_set_ifcon(handle->sepolh, iface, con);
 }
 
-hidden_def(semanage_iface_set_ifcon)
 
 semanage_context_t *semanage_iface_get_msgcon(const semanage_iface_t * iface)
 {
@@ -116,7 +108,6 @@ semanage_context_t *semanage_iface_get_msgcon(const semanage_iface_t * iface)
 	return sepol_iface_get_msgcon(iface);
 }
 
-hidden_def(semanage_iface_get_msgcon)
 
 int semanage_iface_set_msgcon(semanage_handle_t * handle,
 			      semanage_iface_t * iface,
@@ -126,7 +117,6 @@ int semanage_iface_set_msgcon(semanage_handle_t * handle,
 	return sepol_iface_set_msgcon(handle->sepolh, iface, con);
 }
 
-hidden_def(semanage_iface_set_msgcon)
 
 /* Create/Clone/Destroy */
 int semanage_iface_create(semanage_handle_t * handle,
@@ -136,7 +126,6 @@ int semanage_iface_create(semanage_handle_t * handle,
 	return sepol_iface_create(handle->sepolh, iface_ptr);
 }
 
-hidden_def(semanage_iface_create)
 
 int semanage_iface_clone(semanage_handle_t * handle,
 			 const semanage_iface_t * iface,
@@ -146,7 +135,6 @@ int semanage_iface_clone(semanage_handle_t * handle,
 	return sepol_iface_clone(handle->sepolh, iface, iface_ptr);
 }
 
-hidden_def(semanage_iface_clone)
 
 void semanage_iface_free(semanage_iface_t * iface)
 {
@@ -154,7 +142,6 @@ void semanage_iface_free(semanage_iface_t * iface)
 	sepol_iface_free(iface);
 }
 
-hidden_def(semanage_iface_free)
 
 /* Record base functions */
 record_table_t SEMANAGE_IFACE_RTABLE = {
diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
index 1478af976e59..c19c8f949c91 100644
--- a/libsemanage/src/interfaces_file.c
+++ b/libsemanage/src/interfaces_file.c
@@ -14,7 +14,6 @@ typedef struct dbase_file dbase_t;
 #include <stdio.h>
 #include <semanage/handle.h>
 #include "iface_internal.h"
-#include "context_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff --git a/libsemanage/src/module_internal.h b/libsemanage/src/module_internal.h
deleted file mode 100644
index c99f6c28ee8b..000000000000
--- a/libsemanage/src/module_internal.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _SEMANAGE_MODULE_INTERNAL_H_
-#define _SEMANAGE_MODULE_INTERNAL_H_
-
-#include <semanage/modules.h>
-#include "dso.h"
-
-hidden_proto(semanage_module_get_name)
-    hidden_proto(semanage_module_info_datum_destroy)
-    hidden_proto(semanage_module_list_nth)
-    hidden_proto(semanage_module_info_create)
-    hidden_proto(semanage_module_info_destroy)
-    hidden_proto(semanage_module_info_get_priority)
-    hidden_proto(semanage_module_info_get_name)
-    hidden_proto(semanage_module_info_get_lang_ext)
-    hidden_proto(semanage_module_info_get_enabled)
-    hidden_proto(semanage_module_info_set_priority)
-    hidden_proto(semanage_module_info_set_name)
-    hidden_proto(semanage_module_info_set_lang_ext)
-    hidden_proto(semanage_module_info_set_enabled)
-    hidden_proto(semanage_module_key_create)
-    hidden_proto(semanage_module_key_destroy)
-    hidden_proto(semanage_module_key_get_priority)
-    hidden_proto(semanage_module_key_get_name)
-    hidden_proto(semanage_module_key_set_priority)
-    hidden_proto(semanage_module_key_set_name)
-    hidden_proto(semanage_module_set_enabled)
-#endif
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 190435059d3e..6d3eb60ae462 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -22,6 +22,7 @@
 /* This file implements only the publicly-visible module functions to libsemanage. */
 
 #include "direct_api.h"
+#include "modules.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
 
@@ -241,7 +242,6 @@ void semanage_module_info_datum_destroy(semanage_module_info_t * modinfo)
 	}
 }
 
-hidden_def(semanage_module_info_datum_destroy)
 
 semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t * list,
 						 int n)
@@ -249,14 +249,12 @@ semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t * list,
 	return list + n;
 }
 
-hidden_def(semanage_module_list_nth)
 
 const char *semanage_module_get_name(semanage_module_info_t * modinfo)
 {
 	return modinfo->name;
 }
 
-hidden_def(semanage_module_get_name)
 
 /* Legacy function that remains to preserve ABI
  * compatibility.
@@ -279,7 +277,6 @@ int semanage_module_info_create(semanage_handle_t *sh,
 	return semanage_module_info_init(sh, *modinfo);
 }
 
-hidden_def(semanage_module_info_create)
 
 int semanage_module_info_destroy(semanage_handle_t *sh,
 				 semanage_module_info_t *modinfo)
@@ -296,7 +293,6 @@ int semanage_module_info_destroy(semanage_handle_t *sh,
 	return semanage_module_info_init(sh, modinfo);
 }
 
-hidden_def(semanage_module_info_destroy)
 
 int semanage_module_info_init(semanage_handle_t *sh,
 			      semanage_module_info_t *modinfo)
@@ -371,7 +367,6 @@ int semanage_module_info_get_priority(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_get_priority)
 
 int semanage_module_info_get_name(semanage_handle_t *sh,
 				  semanage_module_info_t *modinfo,
@@ -386,7 +381,6 @@ int semanage_module_info_get_name(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_get_name)
 
 int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
 				      semanage_module_info_t *modinfo,
@@ -401,7 +395,6 @@ int semanage_module_info_get_lang_ext(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_get_lang_ext)
 
 int semanage_module_info_get_enabled(semanage_handle_t *sh,
 				     semanage_module_info_t *modinfo,
@@ -416,7 +409,6 @@ int semanage_module_info_get_enabled(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_get_enabled)
 
 int semanage_module_info_set_priority(semanage_handle_t *sh,
 				      semanage_module_info_t *modinfo,
@@ -437,7 +429,6 @@ int semanage_module_info_set_priority(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_set_priority)
 
 int semanage_module_info_set_name(semanage_handle_t *sh,
 				  semanage_module_info_t *modinfo,
@@ -468,7 +459,6 @@ int semanage_module_info_set_name(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_set_name)
 
 int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
 				      semanage_module_info_t *modinfo,
@@ -499,7 +489,6 @@ int semanage_module_info_set_lang_ext(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_set_lang_ext)
 
 int semanage_module_info_set_enabled(semanage_handle_t *sh,
 				     semanage_module_info_t *modinfo,
@@ -520,7 +509,6 @@ int semanage_module_info_set_enabled(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_info_set_enabled)
 
 int semanage_module_get_path(semanage_handle_t *sh,
 			     const semanage_module_info_t *modinfo,
@@ -685,7 +673,6 @@ int semanage_module_key_create(semanage_handle_t *sh,
 	return semanage_module_key_init(sh, *modkey);
 }
 
-hidden_def(semanage_module_key_create)
 
 int semanage_module_key_destroy(semanage_handle_t *sh,
 				semanage_module_key_t *modkey)
@@ -701,7 +688,6 @@ int semanage_module_key_destroy(semanage_handle_t *sh,
 	return semanage_module_key_init(sh, modkey);
 }
 
-hidden_def(semanage_module_key_destroy)
 
 int semanage_module_key_init(semanage_handle_t *sh,
 			     semanage_module_key_t *modkey)
@@ -728,7 +714,6 @@ int semanage_module_key_get_name(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_key_get_name)
 
 int semanage_module_key_get_priority(semanage_handle_t *sh,
 				     semanage_module_key_t *modkey,
@@ -743,7 +728,6 @@ int semanage_module_key_get_priority(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_key_get_priority)
 
 int semanage_module_key_set_name(semanage_handle_t *sh,
 				 semanage_module_key_t *modkey,
@@ -776,7 +760,6 @@ cleanup:
 	return status;
 }
 
-hidden_def(semanage_module_key_set_name)
 
 int semanage_module_key_set_priority(semanage_handle_t *sh,
 				     semanage_module_key_t *modkey,
@@ -796,7 +779,6 @@ int semanage_module_key_set_priority(semanage_handle_t *sh,
 	return 0;
 }
 
-hidden_def(semanage_module_key_set_priority)
 
 int semanage_module_get_enabled_1_1(semanage_handle_t *sh,
 				const semanage_module_key_t *modkey,
@@ -847,7 +829,6 @@ int semanage_module_set_enabled(semanage_handle_t *sh,
 	return sh->funcs->set_enabled(sh, modkey, enabled);
 }
 
-hidden_def(semanage_module_set_enabled)
 
 /* This function exists only for ABI compatibility. It has been deprecated and
  * should not be used. Instead, use semanage_module_set_enabled() */
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 8a5c01f47e94..2d3576fb15df 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -24,7 +24,7 @@
 
 #include <stdint.h>
 
-#include "module_internal.h"
+#include "semanage/modules.h"
 
 int semanage_module_install_pp(semanage_handle_t * sh,
 			    char *module_data, size_t data_len);
diff --git a/libsemanage/src/node_internal.h b/libsemanage/src/node_internal.h
index 58175603b1ab..234143b49699 100644
--- a/libsemanage/src/node_internal.h
+++ b/libsemanage/src/node_internal.h
@@ -6,29 +6,6 @@
 #include <semanage/nodes_policy.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_node_create)
-    hidden_proto(semanage_node_compare)
-    hidden_proto(semanage_node_compare2)
-    hidden_proto(semanage_node_clone)
-    hidden_proto(semanage_node_free)
-    hidden_proto(semanage_node_key_extract)
-    hidden_proto(semanage_node_key_free)
-    hidden_proto(semanage_node_get_addr)
-    hidden_proto(semanage_node_get_addr_bytes)
-    hidden_proto(semanage_node_get_mask)
-    hidden_proto(semanage_node_get_mask_bytes)
-    hidden_proto(semanage_node_get_proto)
-    hidden_proto(semanage_node_set_addr)
-    hidden_proto(semanage_node_set_addr_bytes)
-    hidden_proto(semanage_node_set_mask)
-    hidden_proto(semanage_node_set_mask_bytes)
-    hidden_proto(semanage_node_set_proto)
-    hidden_proto(semanage_node_get_proto_str)
-    hidden_proto(semanage_node_get_con)
-    hidden_proto(semanage_node_set_con)
-    hidden_proto(semanage_node_list_local)
 
 /* NODE RECORD: method table */
 extern record_table_t SEMANAGE_NODE_RTABLE;
@@ -45,11 +22,11 @@ extern int node_policydb_dbase_init(semanage_handle_t * handle,
 
 extern void node_policydb_dbase_release(dbase_config_t * dconfig);
 
-extern int hidden semanage_node_validate_local(semanage_handle_t * handle);
+extern int semanage_node_validate_local(semanage_handle_t * handle);
 
 /* ==== Internal (to nodes) API === */
 
-hidden int semanage_node_compare2_qsort(const semanage_node_t ** node,
+ int semanage_node_compare2_qsort(const semanage_node_t ** node,
 					const semanage_node_t ** node2);
 
 #endif
diff --git a/libsemanage/src/node_record.c b/libsemanage/src/node_record.c
index 5368ceeedcbc..e1c6e03a2b10 100644
--- a/libsemanage/src/node_record.c
+++ b/libsemanage/src/node_record.c
@@ -32,7 +32,6 @@ int semanage_node_compare(const semanage_node_t * node,
 	return sepol_node_compare(node, key);
 }
 
-hidden_def(semanage_node_compare)
 
 int semanage_node_compare2(const semanage_node_t * node,
 			   const semanage_node_t * node2)
@@ -41,9 +40,8 @@ int semanage_node_compare2(const semanage_node_t * node,
 	return sepol_node_compare2(node, node2);
 }
 
-hidden_def(semanage_node_compare2)
 
-hidden int semanage_node_compare2_qsort(const semanage_node_t ** node,
+ int semanage_node_compare2_qsort(const semanage_node_t ** node,
 					const semanage_node_t ** node2)
 {
 
@@ -68,7 +66,6 @@ int semanage_node_key_extract(semanage_handle_t * handle,
 	return sepol_node_key_extract(handle->sepolh, node, key_ptr);
 }
 
-hidden_def(semanage_node_key_extract)
 
 void semanage_node_key_free(semanage_node_key_t * key)
 {
@@ -76,7 +73,6 @@ void semanage_node_key_free(semanage_node_key_t * key)
 	sepol_node_key_free(key);
 }
 
-hidden_def(semanage_node_key_free)
 
 /* Address */
 int semanage_node_get_addr(semanage_handle_t * handle,
@@ -86,7 +82,6 @@ int semanage_node_get_addr(semanage_handle_t * handle,
 	return sepol_node_get_addr(handle->sepolh, node, addr_ptr);
 }
 
-hidden_def(semanage_node_get_addr)
 
 int semanage_node_get_addr_bytes(semanage_handle_t * handle,
 				 const semanage_node_t * node,
@@ -96,7 +91,6 @@ int semanage_node_get_addr_bytes(semanage_handle_t * handle,
 	return sepol_node_get_addr_bytes(handle->sepolh, node, addr, addr_sz);
 }
 
-hidden_def(semanage_node_get_addr_bytes)
 
 int semanage_node_set_addr(semanage_handle_t * handle,
 			   semanage_node_t * node, int proto, const char *addr)
@@ -105,7 +99,6 @@ int semanage_node_set_addr(semanage_handle_t * handle,
 	return sepol_node_set_addr(handle->sepolh, node, proto, addr);
 }
 
-hidden_def(semanage_node_set_addr)
 
 int semanage_node_set_addr_bytes(semanage_handle_t * handle,
 				 semanage_node_t * node,
@@ -115,7 +108,6 @@ int semanage_node_set_addr_bytes(semanage_handle_t * handle,
 	return sepol_node_set_addr_bytes(handle->sepolh, node, addr, addr_sz);
 }
 
-hidden_def(semanage_node_set_addr_bytes)
 
 /* Netmask */
 int semanage_node_get_mask(semanage_handle_t * handle,
@@ -125,7 +117,6 @@ int semanage_node_get_mask(semanage_handle_t * handle,
 	return sepol_node_get_mask(handle->sepolh, node, mask_ptr);
 }
 
-hidden_def(semanage_node_get_mask)
 
 int semanage_node_get_mask_bytes(semanage_handle_t * handle,
 				 const semanage_node_t * node,
@@ -135,7 +126,6 @@ int semanage_node_get_mask_bytes(semanage_handle_t * handle,
 	return sepol_node_get_mask_bytes(handle->sepolh, node, mask, mask_sz);
 }
 
-hidden_def(semanage_node_get_mask_bytes)
 
 int semanage_node_set_mask(semanage_handle_t * handle,
 			   semanage_node_t * node, int proto, const char *mask)
@@ -144,7 +134,6 @@ int semanage_node_set_mask(semanage_handle_t * handle,
 	return sepol_node_set_mask(handle->sepolh, node, proto, mask);
 }
 
-hidden_def(semanage_node_set_mask)
 
 int semanage_node_set_mask_bytes(semanage_handle_t * handle,
 				 semanage_node_t * node,
@@ -154,7 +143,6 @@ int semanage_node_set_mask_bytes(semanage_handle_t * handle,
 	return sepol_node_set_mask_bytes(handle->sepolh, node, mask, mask_sz);
 }
 
-hidden_def(semanage_node_set_mask_bytes)
 
 /* Protocol */
 int semanage_node_get_proto(const semanage_node_t * node)
@@ -163,7 +151,6 @@ int semanage_node_get_proto(const semanage_node_t * node)
 	return sepol_node_get_proto(node);
 }
 
-hidden_def(semanage_node_get_proto)
 
 void semanage_node_set_proto(semanage_node_t * node, int proto)
 {
@@ -171,7 +158,6 @@ void semanage_node_set_proto(semanage_node_t * node, int proto)
 	sepol_node_set_proto(node, proto);
 }
 
-hidden_def(semanage_node_set_proto)
 
 const char *semanage_node_get_proto_str(int proto)
 {
@@ -179,7 +165,6 @@ const char *semanage_node_get_proto_str(int proto)
 	return sepol_node_get_proto_str(proto);
 }
 
-hidden_def(semanage_node_get_proto_str)
 
 /* Context */
 semanage_context_t *semanage_node_get_con(const semanage_node_t * node)
@@ -188,7 +173,6 @@ semanage_context_t *semanage_node_get_con(const semanage_node_t * node)
 	return sepol_node_get_con(node);
 }
 
-hidden_def(semanage_node_get_con)
 
 int semanage_node_set_con(semanage_handle_t * handle,
 			  semanage_node_t * node, semanage_context_t * con)
@@ -197,7 +181,6 @@ int semanage_node_set_con(semanage_handle_t * handle,
 	return sepol_node_set_con(handle->sepolh, node, con);
 }
 
-hidden_def(semanage_node_set_con)
 
 /* Create/Clone/Destroy */
 int semanage_node_create(semanage_handle_t * handle,
@@ -207,7 +190,6 @@ int semanage_node_create(semanage_handle_t * handle,
 	return sepol_node_create(handle->sepolh, node_ptr);
 }
 
-hidden_def(semanage_node_create)
 
 int semanage_node_clone(semanage_handle_t * handle,
 			const semanage_node_t * node,
@@ -217,7 +199,6 @@ int semanage_node_clone(semanage_handle_t * handle,
 	return sepol_node_clone(handle->sepolh, node, node_ptr);
 }
 
-hidden_def(semanage_node_clone)
 
 void semanage_node_free(semanage_node_t * node)
 {
@@ -225,7 +206,6 @@ void semanage_node_free(semanage_node_t * node)
 	sepol_node_free(node);
 }
 
-hidden_def(semanage_node_free)
 
 /* Port base functions */
 record_table_t SEMANAGE_NODE_RTABLE = {
diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
index f6c8895d66c1..c3647f2ad622 100644
--- a/libsemanage/src/nodes_file.c
+++ b/libsemanage/src/nodes_file.c
@@ -15,7 +15,6 @@ typedef struct dbase_file dbase_t;
 #include <strings.h>
 #include <semanage/handle.h>
 #include "node_internal.h"
-#include "context_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff --git a/libsemanage/src/nodes_local.c b/libsemanage/src/nodes_local.c
index 93af4501d89b..c85fe4e735a0 100644
--- a/libsemanage/src/nodes_local.c
+++ b/libsemanage/src/nodes_local.c
@@ -69,4 +69,3 @@ int semanage_node_list_local(semanage_handle_t * handle,
 	return dbase_list(handle, dconfig, records, count);
 }
 
-hidden_def(semanage_node_list_local)
diff --git a/libsemanage/src/port_internal.h b/libsemanage/src/port_internal.h
index ebd2bc84b9c9..670174722f79 100644
--- a/libsemanage/src/port_internal.h
+++ b/libsemanage/src/port_internal.h
@@ -6,25 +6,6 @@
 #include <semanage/ports_policy.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_port_create)
-    hidden_proto(semanage_port_compare)
-    hidden_proto(semanage_port_compare2)
-    hidden_proto(semanage_port_clone)
-    hidden_proto(semanage_port_free)
-    hidden_proto(semanage_port_key_extract)
-    hidden_proto(semanage_port_key_free)
-    hidden_proto(semanage_port_get_high)
-    hidden_proto(semanage_port_get_low)
-    hidden_proto(semanage_port_set_port)
-    hidden_proto(semanage_port_set_range)
-    hidden_proto(semanage_port_get_proto)
-    hidden_proto(semanage_port_set_proto)
-    hidden_proto(semanage_port_get_proto_str)
-    hidden_proto(semanage_port_get_con)
-    hidden_proto(semanage_port_set_con)
-    hidden_proto(semanage_port_list_local)
 
 /* PORT RECORD: method table */
 extern record_table_t SEMANAGE_PORT_RTABLE;
@@ -41,11 +22,11 @@ extern int port_policydb_dbase_init(semanage_handle_t * handle,
 
 extern void port_policydb_dbase_release(dbase_config_t * dconfig);
 
-extern int hidden semanage_port_validate_local(semanage_handle_t * handle);
+extern int semanage_port_validate_local(semanage_handle_t * handle);
 
 /* ==== Internal (to ports) API === */
 
-hidden int semanage_port_compare2_qsort(const semanage_port_t ** port,
+ int semanage_port_compare2_qsort(const semanage_port_t ** port,
 					const semanage_port_t ** port2);
 
 #endif
diff --git a/libsemanage/src/port_record.c b/libsemanage/src/port_record.c
index b878ca78b31a..f8a1633eebe0 100644
--- a/libsemanage/src/port_record.c
+++ b/libsemanage/src/port_record.c
@@ -31,7 +31,6 @@ int semanage_port_compare(const semanage_port_t * port,
 	return sepol_port_compare(port, key);
 }
 
-hidden_def(semanage_port_compare)
 
 int semanage_port_compare2(const semanage_port_t * port,
 			   const semanage_port_t * port2)
@@ -40,9 +39,8 @@ int semanage_port_compare2(const semanage_port_t * port,
 	return sepol_port_compare2(port, port2);
 }
 
-hidden_def(semanage_port_compare2)
 
-hidden int semanage_port_compare2_qsort(const semanage_port_t ** port,
+ int semanage_port_compare2_qsort(const semanage_port_t ** port,
 					const semanage_port_t ** port2)
 {
 
@@ -65,7 +63,6 @@ int semanage_port_key_extract(semanage_handle_t * handle,
 	return sepol_port_key_extract(handle->sepolh, port, key_ptr);
 }
 
-hidden_def(semanage_port_key_extract)
 
 void semanage_port_key_free(semanage_port_key_t * key)
 {
@@ -73,7 +70,6 @@ void semanage_port_key_free(semanage_port_key_t * key)
 	sepol_port_key_free(key);
 }
 
-hidden_def(semanage_port_key_free)
 
 /* Protocol */
 int semanage_port_get_proto(const semanage_port_t * port)
@@ -82,7 +78,6 @@ int semanage_port_get_proto(const semanage_port_t * port)
 	return sepol_port_get_proto(port);
 }
 
-hidden_def(semanage_port_get_proto)
 
 void semanage_port_set_proto(semanage_port_t * port, int proto)
 {
@@ -90,7 +85,6 @@ void semanage_port_set_proto(semanage_port_t * port, int proto)
 	sepol_port_set_proto(port, proto);
 }
 
-hidden_def(semanage_port_set_proto)
 
 const char *semanage_port_get_proto_str(int proto)
 {
@@ -98,7 +92,6 @@ const char *semanage_port_get_proto_str(int proto)
 	return sepol_port_get_proto_str(proto);
 }
 
-hidden_def(semanage_port_get_proto_str)
 
 /* Port */
 int semanage_port_get_low(const semanage_port_t * port)
@@ -107,7 +100,6 @@ int semanage_port_get_low(const semanage_port_t * port)
 	return sepol_port_get_low(port);
 }
 
-hidden_def(semanage_port_get_low)
 
 int semanage_port_get_high(const semanage_port_t * port)
 {
@@ -115,7 +107,6 @@ int semanage_port_get_high(const semanage_port_t * port)
 	return sepol_port_get_high(port);
 }
 
-hidden_def(semanage_port_get_high)
 
 void semanage_port_set_port(semanage_port_t * port, int port_num)
 {
@@ -123,7 +114,6 @@ void semanage_port_set_port(semanage_port_t * port, int port_num)
 	sepol_port_set_port(port, port_num);
 }
 
-hidden_def(semanage_port_set_port)
 
 void semanage_port_set_range(semanage_port_t * port, int low, int high)
 {
@@ -131,7 +121,6 @@ void semanage_port_set_range(semanage_port_t * port, int low, int high)
 	sepol_port_set_range(port, low, high);
 }
 
-hidden_def(semanage_port_set_range)
 
 /* Context */
 semanage_context_t *semanage_port_get_con(const semanage_port_t * port)
@@ -140,7 +129,6 @@ semanage_context_t *semanage_port_get_con(const semanage_port_t * port)
 	return sepol_port_get_con(port);
 }
 
-hidden_def(semanage_port_get_con)
 
 int semanage_port_set_con(semanage_handle_t * handle,
 			  semanage_port_t * port, semanage_context_t * con)
@@ -149,7 +137,6 @@ int semanage_port_set_con(semanage_handle_t * handle,
 	return sepol_port_set_con(handle->sepolh, port, con);
 }
 
-hidden_def(semanage_port_set_con)
 
 /* Create/Clone/Destroy */
 int semanage_port_create(semanage_handle_t * handle,
@@ -159,7 +146,6 @@ int semanage_port_create(semanage_handle_t * handle,
 	return sepol_port_create(handle->sepolh, port_ptr);
 }
 
-hidden_def(semanage_port_create)
 
 int semanage_port_clone(semanage_handle_t * handle,
 			const semanage_port_t * port,
@@ -169,7 +155,6 @@ int semanage_port_clone(semanage_handle_t * handle,
 	return sepol_port_clone(handle->sepolh, port, port_ptr);
 }
 
-hidden_def(semanage_port_clone)
 
 void semanage_port_free(semanage_port_t * port)
 {
@@ -177,7 +162,6 @@ void semanage_port_free(semanage_port_t * port)
 	sepol_port_free(port);
 }
 
-hidden_def(semanage_port_free)
 
 /* Port base functions */
 record_table_t SEMANAGE_PORT_RTABLE = {
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 4738d467b8cd..ade4102f0e0d 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -15,7 +15,6 @@ typedef struct dbase_file dbase_t;
 #include <strings.h>
 #include <semanage/handle.h>
 #include "port_internal.h"
-#include "context_internal.h"
 #include "database_file.h"
 #include "parse_utils.h"
 #include "debug.h"
diff --git a/libsemanage/src/ports_local.c b/libsemanage/src/ports_local.c
index ffd5a838b294..e7e9bdbf93e3 100644
--- a/libsemanage/src/ports_local.c
+++ b/libsemanage/src/ports_local.c
@@ -71,9 +71,8 @@ int semanage_port_list_local(semanage_handle_t * handle,
 	return dbase_list(handle, dconfig, records, count);
 }
 
-hidden_def(semanage_port_list_local)
 
-int hidden semanage_port_validate_local(semanage_handle_t * handle)
+int semanage_port_validate_local(semanage_handle_t * handle)
 {
 
 	semanage_port_t **ports = NULL;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 58dded6e5c7b..859c0a2231a1 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1476,7 +1476,6 @@ int semanage_reload_policy(semanage_handle_t * sh)
 	return r;
 }
 
-hidden_def(semanage_reload_policy)
 
 /* This expands the file_context.tmpl file to file_context and homedirs.template */
 int semanage_split_fc(semanage_handle_t * sh)
diff --git a/libsemanage/src/seuser_internal.h b/libsemanage/src/seuser_internal.h
index bf9cab0c8751..fdb52ef9238f 100644
--- a/libsemanage/src/seuser_internal.h
+++ b/libsemanage/src/seuser_internal.h
@@ -7,24 +7,6 @@
 #include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_seuser_clone)
-    hidden_proto(semanage_seuser_compare)
-    hidden_proto(semanage_seuser_compare2)
-    hidden_proto(semanage_seuser_create)
-    hidden_proto(semanage_seuser_free)
-    hidden_proto(semanage_seuser_get_mlsrange)
-    hidden_proto(semanage_seuser_get_name)
-    hidden_proto(semanage_seuser_get_sename)
-    hidden_proto(semanage_seuser_key_create)
-    hidden_proto(semanage_seuser_key_extract)
-    hidden_proto(semanage_seuser_key_free)
-    hidden_proto(semanage_seuser_set_mlsrange)
-    hidden_proto(semanage_seuser_set_name)
-    hidden_proto(semanage_seuser_set_sename)
-    hidden_proto(semanage_seuser_iterate)
-    hidden_proto(semanage_seuser_iterate_local)
 
 /* SEUSER RECORD: method table */
 extern record_table_t SEMANAGE_SEUSER_RTABLE;
@@ -36,7 +18,7 @@ extern int seuser_file_dbase_init(semanage_handle_t * handle,
 
 extern void seuser_file_dbase_release(dbase_config_t * dconfig);
 
-extern int hidden semanage_seuser_validate_local(semanage_handle_t * handle,
+extern int semanage_seuser_validate_local(semanage_handle_t * handle,
 						 const sepol_policydb_t *
 						 policydb);
 
diff --git a/libsemanage/src/seuser_record.c b/libsemanage/src/seuser_record.c
index 1ed459486228..44a54758d22e 100644
--- a/libsemanage/src/seuser_record.c
+++ b/libsemanage/src/seuser_record.c
@@ -59,7 +59,6 @@ int semanage_seuser_key_create(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_seuser_key_create)
 
 int semanage_seuser_key_extract(semanage_handle_t * handle,
 				const semanage_seuser_t * seuser,
@@ -76,7 +75,6 @@ int semanage_seuser_key_extract(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(semanage_seuser_key_extract)
 
 void semanage_seuser_key_free(semanage_seuser_key_t * key)
 {
@@ -84,7 +82,6 @@ void semanage_seuser_key_free(semanage_seuser_key_t * key)
 	free(key);
 }
 
-hidden_def(semanage_seuser_key_free)
 
 int semanage_seuser_compare(const semanage_seuser_t * seuser,
 			    const semanage_seuser_key_t * key)
@@ -93,7 +90,6 @@ int semanage_seuser_compare(const semanage_seuser_t * seuser,
 	return strcmp(seuser->name, key->name);
 }
 
-hidden_def(semanage_seuser_compare)
 
 int semanage_seuser_compare2(const semanage_seuser_t * seuser,
 			     const semanage_seuser_t * seuser2)
@@ -102,7 +98,6 @@ int semanage_seuser_compare2(const semanage_seuser_t * seuser,
 	return strcmp(seuser->name, seuser2->name);
 }
 
-hidden_def(semanage_seuser_compare2)
 
 static int semanage_seuser_compare2_qsort(const semanage_seuser_t ** seuser,
 					  const semanage_seuser_t ** seuser2)
@@ -118,7 +113,6 @@ const char *semanage_seuser_get_name(const semanage_seuser_t * seuser)
 	return seuser->name;
 }
 
-hidden_def(semanage_seuser_get_name)
 
 int semanage_seuser_set_name(semanage_handle_t * handle,
 			     semanage_seuser_t * seuser, const char *name)
@@ -134,7 +128,6 @@ int semanage_seuser_set_name(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_seuser_set_name)
 
 /* Selinux Name */
 const char *semanage_seuser_get_sename(const semanage_seuser_t * seuser)
@@ -143,7 +136,6 @@ const char *semanage_seuser_get_sename(const semanage_seuser_t * seuser)
 	return seuser->sename;
 }
 
-hidden_def(semanage_seuser_get_sename)
 
 int semanage_seuser_set_sename(semanage_handle_t * handle,
 			       semanage_seuser_t * seuser, const char *sename)
@@ -160,7 +152,6 @@ int semanage_seuser_set_sename(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_seuser_set_sename)
 
 /* MLS Range */
 const char *semanage_seuser_get_mlsrange(const semanage_seuser_t * seuser)
@@ -169,7 +160,6 @@ const char *semanage_seuser_get_mlsrange(const semanage_seuser_t * seuser)
 	return seuser->mls_range;
 }
 
-hidden_def(semanage_seuser_get_mlsrange)
 
 int semanage_seuser_set_mlsrange(semanage_handle_t * handle,
 				 semanage_seuser_t * seuser,
@@ -186,7 +176,6 @@ int semanage_seuser_set_mlsrange(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_seuser_set_mlsrange)
 
 /* Create */
 int semanage_seuser_create(semanage_handle_t * handle,
@@ -209,7 +198,6 @@ int semanage_seuser_create(semanage_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(semanage_seuser_create)
 
 /* Deep copy clone */
 int semanage_seuser_clone(semanage_handle_t * handle,
@@ -242,7 +230,6 @@ int semanage_seuser_clone(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(semanage_seuser_clone)
 
 /* Destroy */
 void semanage_seuser_free(semanage_seuser_t * seuser)
@@ -257,7 +244,6 @@ void semanage_seuser_free(semanage_seuser_t * seuser)
 	free(seuser);
 }
 
-hidden_def(semanage_seuser_free)
 
 /* Record base functions */
 record_table_t SEMANAGE_SEUSER_RTABLE = {
diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 3e2761c4388a..6508ec0562d9 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -223,7 +223,6 @@ int semanage_seuser_iterate_local(semanage_handle_t * handle,
 	return dbase_iterate(handle, dconfig, handler, handler_arg);
 }
 
-hidden_def(semanage_seuser_iterate_local)
 
 int semanage_seuser_list_local(semanage_handle_t * handle,
 			       semanage_seuser_t *** records,
@@ -320,7 +319,7 @@ static int validate_handler(const semanage_seuser_t * seuser, void *varg)
  * it will (1) deadlock, because iterate is not reentrant outside
  * a transaction, and (2) be racy, because it makes multiple dbase calls */
 
-int hidden semanage_seuser_validate_local(semanage_handle_t * handle,
+int semanage_seuser_validate_local(semanage_handle_t * handle,
 					  const sepol_policydb_t * policydb)
 {
 
diff --git a/libsemanage/src/seusers_policy.c b/libsemanage/src/seusers_policy.c
index 89fb4d8f2c0b..77af0dd2e2ac 100644
--- a/libsemanage/src/seusers_policy.c
+++ b/libsemanage/src/seusers_policy.c
@@ -47,7 +47,6 @@ int semanage_seuser_iterate(semanage_handle_t * handle,
 	return dbase_iterate(handle, dconfig, handler, handler_arg);
 }
 
-hidden_def(semanage_seuser_iterate)
 
 int semanage_seuser_list(semanage_handle_t * handle,
 			 semanage_seuser_t *** records, unsigned int *count)
diff --git a/libsemanage/src/user_base_record.c b/libsemanage/src/user_base_record.c
index 7dfa8c6bcdb2..470376652a02 100644
--- a/libsemanage/src/user_base_record.c
+++ b/libsemanage/src/user_base_record.c
@@ -25,7 +25,7 @@ typedef semanage_user_key_t record_key_t;
 #include "debug.h"
 
 /* Key */
-hidden int semanage_user_base_key_extract(semanage_handle_t * handle,
+ int semanage_user_base_key_extract(semanage_handle_t * handle,
 					  const semanage_user_base_t * user,
 					  semanage_user_key_t ** key)
 {
@@ -56,14 +56,14 @@ static int semanage_user_base_compare2_qsort(const semanage_user_base_t ** user,
 }
 
 /* Name */
-hidden const char *semanage_user_base_get_name(const semanage_user_base_t *
+ const char *semanage_user_base_get_name(const semanage_user_base_t *
 					       user)
 {
 
 	return sepol_user_get_name(user);
 }
 
-hidden int semanage_user_base_set_name(semanage_handle_t * handle,
+ int semanage_user_base_set_name(semanage_handle_t * handle,
 				       semanage_user_base_t * user,
 				       const char *name)
 {
@@ -72,14 +72,14 @@ hidden int semanage_user_base_set_name(semanage_handle_t * handle,
 }
 
 /* MLS */
-hidden const char *semanage_user_base_get_mlslevel(const semanage_user_base_t *
+ const char *semanage_user_base_get_mlslevel(const semanage_user_base_t *
 						   user)
 {
 
 	return sepol_user_get_mlslevel(user);
 }
 
-hidden int semanage_user_base_set_mlslevel(semanage_handle_t * handle,
+ int semanage_user_base_set_mlslevel(semanage_handle_t * handle,
 					   semanage_user_base_t * user,
 					   const char *mls_level)
 {
@@ -87,14 +87,14 @@ hidden int semanage_user_base_set_mlslevel(semanage_handle_t * handle,
 	return sepol_user_set_mlslevel(handle->sepolh, user, mls_level);
 }
 
-hidden const char *semanage_user_base_get_mlsrange(const semanage_user_base_t *
+ const char *semanage_user_base_get_mlsrange(const semanage_user_base_t *
 						   user)
 {
 
 	return sepol_user_get_mlsrange(user);
 }
 
-hidden int semanage_user_base_set_mlsrange(semanage_handle_t * handle,
+ int semanage_user_base_set_mlsrange(semanage_handle_t * handle,
 					   semanage_user_base_t * user,
 					   const char *mls_range)
 {
@@ -103,13 +103,13 @@ hidden int semanage_user_base_set_mlsrange(semanage_handle_t * handle,
 }
 
 /* Role management */
-hidden int semanage_user_base_get_num_roles(const semanage_user_base_t * user)
+ int semanage_user_base_get_num_roles(const semanage_user_base_t * user)
 {
 
 	return sepol_user_get_num_roles(user);
 }
 
-hidden int semanage_user_base_add_role(semanage_handle_t * handle,
+ int semanage_user_base_add_role(semanage_handle_t * handle,
 				       semanage_user_base_t * user,
 				       const char *role)
 {
@@ -117,21 +117,21 @@ hidden int semanage_user_base_add_role(semanage_handle_t * handle,
 	return sepol_user_add_role(handle->sepolh, user, role);
 }
 
-hidden void semanage_user_base_del_role(semanage_user_base_t * user,
+ void semanage_user_base_del_role(semanage_user_base_t * user,
 					const char *role)
 {
 
 	sepol_user_del_role(user, role);
 }
 
-hidden int semanage_user_base_has_role(const semanage_user_base_t * user,
+ int semanage_user_base_has_role(const semanage_user_base_t * user,
 				       const char *role)
 {
 
 	return sepol_user_has_role(user, role);
 }
 
-hidden int semanage_user_base_get_roles(semanage_handle_t * handle,
+ int semanage_user_base_get_roles(semanage_handle_t * handle,
 					const semanage_user_base_t * user,
 					const char ***roles_arr,
 					unsigned int *num_roles)
@@ -140,7 +140,7 @@ hidden int semanage_user_base_get_roles(semanage_handle_t * handle,
 	return sepol_user_get_roles(handle->sepolh, user, roles_arr, num_roles);
 }
 
-hidden int semanage_user_base_set_roles(semanage_handle_t * handle,
+ int semanage_user_base_set_roles(semanage_handle_t * handle,
 					semanage_user_base_t * user,
 					const char **roles_arr,
 					unsigned int num_roles)
@@ -150,14 +150,14 @@ hidden int semanage_user_base_set_roles(semanage_handle_t * handle,
 }
 
 /* Create/Clone/Destroy */
-hidden int semanage_user_base_create(semanage_handle_t * handle,
+ int semanage_user_base_create(semanage_handle_t * handle,
 				     semanage_user_base_t ** user_ptr)
 {
 
 	return sepol_user_create(handle->sepolh, user_ptr);
 }
 
-hidden int semanage_user_base_clone(semanage_handle_t * handle,
+ int semanage_user_base_clone(semanage_handle_t * handle,
 				    const semanage_user_base_t * user,
 				    semanage_user_base_t ** user_ptr)
 {
@@ -165,7 +165,7 @@ hidden int semanage_user_base_clone(semanage_handle_t * handle,
 	return sepol_user_clone(handle->sepolh, user, user_ptr);
 }
 
-hidden void semanage_user_base_free(semanage_user_base_t * user)
+ void semanage_user_base_free(semanage_user_base_t * user)
 {
 
 	sepol_user_free(user);
diff --git a/libsemanage/src/user_extra_record.c b/libsemanage/src/user_extra_record.c
index efb9c5bfc66b..d2707224a223 100644
--- a/libsemanage/src/user_extra_record.c
+++ b/libsemanage/src/user_extra_record.c
@@ -76,14 +76,14 @@ static int semanage_user_extra_compare2_qsort(const semanage_user_extra_t **
 }
 
 /* Name */
-hidden const char *semanage_user_extra_get_name(const semanage_user_extra_t *
+ const char *semanage_user_extra_get_name(const semanage_user_extra_t *
 						user_extra)
 {
 
 	return user_extra->name;
 }
 
-hidden int semanage_user_extra_set_name(semanage_handle_t * handle,
+ int semanage_user_extra_set_name(semanage_handle_t * handle,
 					semanage_user_extra_t * user_extra,
 					const char *name)
 {
@@ -100,14 +100,14 @@ hidden int semanage_user_extra_set_name(semanage_handle_t * handle,
 }
 
 /* Labeling prefix */
-hidden const char *semanage_user_extra_get_prefix(const semanage_user_extra_t *
+ const char *semanage_user_extra_get_prefix(const semanage_user_extra_t *
 						  user_extra)
 {
 
 	return user_extra->prefix;
 }
 
-hidden int semanage_user_extra_set_prefix(semanage_handle_t * handle,
+ int semanage_user_extra_set_prefix(semanage_handle_t * handle,
 					  semanage_user_extra_t * user_extra,
 					  const char *prefix)
 {
@@ -124,7 +124,7 @@ hidden int semanage_user_extra_set_prefix(semanage_handle_t * handle,
 }
 
 /* Create */
-hidden int semanage_user_extra_create(semanage_handle_t * handle,
+ int semanage_user_extra_create(semanage_handle_t * handle,
 				      semanage_user_extra_t ** user_extra_ptr)
 {
 
@@ -145,7 +145,7 @@ hidden int semanage_user_extra_create(semanage_handle_t * handle,
 }
 
 /* Destroy */
-hidden void semanage_user_extra_free(semanage_user_extra_t * user_extra)
+ void semanage_user_extra_free(semanage_user_extra_t * user_extra)
 {
 
 	if (!user_extra)
@@ -157,7 +157,7 @@ hidden void semanage_user_extra_free(semanage_user_extra_t * user_extra)
 }
 
 /* Deep copy clone */
-hidden int semanage_user_extra_clone(semanage_handle_t * handle,
+ int semanage_user_extra_clone(semanage_handle_t * handle,
 				     const semanage_user_extra_t * user_extra,
 				     semanage_user_extra_t ** user_extra_ptr)
 {
diff --git a/libsemanage/src/user_internal.h b/libsemanage/src/user_internal.h
index 2fede9479e52..678a73a51149 100644
--- a/libsemanage/src/user_internal.h
+++ b/libsemanage/src/user_internal.h
@@ -7,26 +7,6 @@
 #include <semanage/users_policy.h>
 #include "database.h"
 #include "handle.h"
-#include "dso.h"
-
-hidden_proto(semanage_user_add_role)
-    hidden_proto(semanage_user_clone)
-    hidden_proto(semanage_user_compare)
-    hidden_proto(semanage_user_compare2)
-    hidden_proto(semanage_user_create)
-    hidden_proto(semanage_user_free)
-    hidden_proto(semanage_user_get_mlslevel)
-    hidden_proto(semanage_user_get_mlsrange)
-    hidden_proto(semanage_user_get_name)
-    hidden_proto(semanage_user_get_roles)
-    hidden_proto(semanage_user_key_create)
-    hidden_proto(semanage_user_key_extract)
-    hidden_proto(semanage_user_key_free)
-    hidden_proto(semanage_user_set_mlslevel)
-    hidden_proto(semanage_user_set_mlsrange)
-    hidden_proto(semanage_user_set_name)
-    hidden_proto(semanage_user_exists)
-    hidden_proto(semanage_user_query)
 
 /* USER record: method table */
 extern record_table_t SEMANAGE_USER_RTABLE;
@@ -77,99 +57,99 @@ typedef struct semanage_user_base semanage_user_base_t;
 #define _SEMANAGE_USER_BASE_DEFINED_
 #endif
 
-hidden int semanage_user_base_create(semanage_handle_t * handle,
+ int semanage_user_base_create(semanage_handle_t * handle,
 				     semanage_user_base_t ** user_ptr);
 
-hidden int semanage_user_base_clone(semanage_handle_t * handle,
+ int semanage_user_base_clone(semanage_handle_t * handle,
 				    const semanage_user_base_t * user,
 				    semanage_user_base_t ** user_ptr);
 
-hidden int semanage_user_base_key_extract(semanage_handle_t * handle,
+ int semanage_user_base_key_extract(semanage_handle_t * handle,
 					  const semanage_user_base_t * user,
 					  semanage_user_key_t ** key);
 
-hidden const char *semanage_user_base_get_name(const semanage_user_base_t *
+ const char *semanage_user_base_get_name(const semanage_user_base_t *
 					       user);
 
-hidden int semanage_user_base_set_name(semanage_handle_t * handle,
+ int semanage_user_base_set_name(semanage_handle_t * handle,
 				       semanage_user_base_t * user,
 				       const char *name);
 
-hidden const char *semanage_user_base_get_mlslevel(const semanage_user_base_t *
+ const char *semanage_user_base_get_mlslevel(const semanage_user_base_t *
 						   user);
 
-hidden int semanage_user_base_set_mlslevel(semanage_handle_t * handle,
+ int semanage_user_base_set_mlslevel(semanage_handle_t * handle,
 					   semanage_user_base_t * user,
 					   const char *mls_level);
 
-hidden const char *semanage_user_base_get_mlsrange(const semanage_user_base_t *
+ const char *semanage_user_base_get_mlsrange(const semanage_user_base_t *
 						   user);
 
-hidden int semanage_user_base_set_mlsrange(semanage_handle_t * handle,
+ int semanage_user_base_set_mlsrange(semanage_handle_t * handle,
 					   semanage_user_base_t * user,
 					   const char *mls_range);
 
-hidden int semanage_user_base_get_num_roles(const semanage_user_base_t * user);
+ int semanage_user_base_get_num_roles(const semanage_user_base_t * user);
 
-hidden int semanage_user_base_add_role(semanage_handle_t * handle,
+ int semanage_user_base_add_role(semanage_handle_t * handle,
 				       semanage_user_base_t * user,
 				       const char *role);
 
-hidden void semanage_user_base_del_role(semanage_user_base_t * user,
+ void semanage_user_base_del_role(semanage_user_base_t * user,
 					const char *role);
 
-hidden int semanage_user_base_has_role(const semanage_user_base_t * user,
+ int semanage_user_base_has_role(const semanage_user_base_t * user,
 				       const char *role);
 
-hidden int semanage_user_base_get_roles(semanage_handle_t * handle,
+ int semanage_user_base_get_roles(semanage_handle_t * handle,
 					const semanage_user_base_t * user,
 					const char ***roles_arr,
 					unsigned int *num_roles);
 
-hidden int semanage_user_base_set_roles(semanage_handle_t * handle,
+ int semanage_user_base_set_roles(semanage_handle_t * handle,
 					semanage_user_base_t * user,
 					const char **roles_arr,
 					unsigned int num_roles);
 
-hidden void semanage_user_base_free(semanage_user_base_t * user);
+ void semanage_user_base_free(semanage_user_base_t * user);
 
 /*=========== Internal API: Extra User record ==========*/
 struct semanage_user_extra;
 typedef struct semanage_user_extra semanage_user_extra_t;
 
-hidden int semanage_user_extra_create(semanage_handle_t * handle,
+ int semanage_user_extra_create(semanage_handle_t * handle,
 				      semanage_user_extra_t ** user_extra_ptr);
 
-hidden int semanage_user_extra_clone(semanage_handle_t * handle,
+ int semanage_user_extra_clone(semanage_handle_t * handle,
 				     const semanage_user_extra_t * user_extra,
 				     semanage_user_extra_t ** user_extra_ptr);
 
-hidden const char *semanage_user_extra_get_name(const semanage_user_extra_t *
+ const char *semanage_user_extra_get_name(const semanage_user_extra_t *
 						user_extra);
 
-hidden int semanage_user_extra_set_name(semanage_handle_t * handle,
+ int semanage_user_extra_set_name(semanage_handle_t * handle,
 					semanage_user_extra_t * user_extra,
 					const char *name);
 
-hidden const char *semanage_user_extra_get_prefix(const semanage_user_extra_t *
+ const char *semanage_user_extra_get_prefix(const semanage_user_extra_t *
 						  user_extra);
 
-hidden int semanage_user_extra_set_prefix(semanage_handle_t * handle,
+ int semanage_user_extra_set_prefix(semanage_handle_t * handle,
 					  semanage_user_extra_t * user_extra,
 					  const char *prefix);
 
-hidden void semanage_user_extra_free(semanage_user_extra_t * user_extra);
+ void semanage_user_extra_free(semanage_user_extra_t * user_extra);
 
 /*======== Internal API: Join record ========== */
-hidden void semanage_user_key_unpack(const semanage_user_key_t * key,
+ void semanage_user_key_unpack(const semanage_user_key_t * key,
 				     const char **name);
 
-hidden int semanage_user_join(semanage_handle_t * handle,
+ int semanage_user_join(semanage_handle_t * handle,
 			      const semanage_user_base_t * record1,
 			      const semanage_user_extra_t * record2,
 			      semanage_user_t ** result);
 
-hidden int semanage_user_split(semanage_handle_t * handle,
+ int semanage_user_split(semanage_handle_t * handle,
 			       const semanage_user_t * record,
 			       semanage_user_base_t ** split1,
 			       semanage_user_extra_t ** split2);
diff --git a/libsemanage/src/user_record.c b/libsemanage/src/user_record.c
index 452392505f4b..bb8f4de12979 100644
--- a/libsemanage/src/user_record.c
+++ b/libsemanage/src/user_record.c
@@ -37,7 +37,6 @@ int semanage_user_key_create(semanage_handle_t * handle,
 	return sepol_user_key_create(handle->sepolh, name, key);
 }
 
-hidden_def(semanage_user_key_create)
 
 int semanage_user_key_extract(semanage_handle_t * handle,
 			      const semanage_user_t * user,
@@ -47,7 +46,6 @@ int semanage_user_key_extract(semanage_handle_t * handle,
 	return semanage_user_base_key_extract(handle, user->base, key);
 }
 
-hidden_def(semanage_user_key_extract)
 
 void semanage_user_key_free(semanage_user_key_t * key)
 {
@@ -55,9 +53,8 @@ void semanage_user_key_free(semanage_user_key_t * key)
 	sepol_user_key_free(key);
 }
 
-hidden_def(semanage_user_key_free)
 
-hidden void semanage_user_key_unpack(const semanage_user_key_t * key,
+ void semanage_user_key_unpack(const semanage_user_key_t * key,
 				     const char **name)
 {
 
@@ -73,7 +70,6 @@ int semanage_user_compare(const semanage_user_t * user,
 	return strcmp(user->name, name);
 }
 
-hidden_def(semanage_user_compare)
 
 int semanage_user_compare2(const semanage_user_t * user,
 			   const semanage_user_t * user2)
@@ -82,7 +78,6 @@ int semanage_user_compare2(const semanage_user_t * user,
 	return strcmp(user->name, user2->name);
 }
 
-hidden_def(semanage_user_compare2)
 
 static int semanage_user_compare2_qsort(const semanage_user_t ** user,
 					const semanage_user_t ** user2)
@@ -97,7 +92,6 @@ const char *semanage_user_get_name(const semanage_user_t * user)
 	return user->name;
 }
 
-hidden_def(semanage_user_get_name)
 
 int semanage_user_set_name(semanage_handle_t * handle,
 			   semanage_user_t * user, const char *name)
@@ -126,7 +120,6 @@ int semanage_user_set_name(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(semanage_user_set_name)
 
 /* Labeling prefix */
 const char *semanage_user_get_prefix(const semanage_user_t * user)
@@ -149,7 +142,6 @@ const char *semanage_user_get_mlslevel(const semanage_user_t * user)
 	return semanage_user_base_get_mlslevel(user->base);
 }
 
-hidden_def(semanage_user_get_mlslevel)
 
 int semanage_user_set_mlslevel(semanage_handle_t * handle,
 			       semanage_user_t * user, const char *mls_level)
@@ -158,7 +150,6 @@ int semanage_user_set_mlslevel(semanage_handle_t * handle,
 	return semanage_user_base_set_mlslevel(handle, user->base, mls_level);
 }
 
-hidden_def(semanage_user_set_mlslevel)
 
 const char *semanage_user_get_mlsrange(const semanage_user_t * user)
 {
@@ -166,7 +157,6 @@ const char *semanage_user_get_mlsrange(const semanage_user_t * user)
 	return semanage_user_base_get_mlsrange(user->base);
 }
 
-hidden_def(semanage_user_get_mlsrange)
 
 int semanage_user_set_mlsrange(semanage_handle_t * handle,
 			       semanage_user_t * user, const char *mls_range)
@@ -175,7 +165,6 @@ int semanage_user_set_mlsrange(semanage_handle_t * handle,
 	return semanage_user_base_set_mlsrange(handle, user->base, mls_range);
 }
 
-hidden_def(semanage_user_set_mlsrange)
 
 /* Role management */
 int semanage_user_get_num_roles(const semanage_user_t * user)
@@ -191,7 +180,6 @@ int semanage_user_add_role(semanage_handle_t * handle,
 	return semanage_user_base_add_role(handle, user->base, role);
 }
 
-hidden_def(semanage_user_add_role)
 
 void semanage_user_del_role(semanage_user_t * user, const char *role)
 {
@@ -214,7 +202,6 @@ int semanage_user_get_roles(semanage_handle_t * handle,
 					    num_roles);
 }
 
-hidden_def(semanage_user_get_roles)
 
 int semanage_user_set_roles(semanage_handle_t * handle,
 			    semanage_user_t * user,
@@ -255,7 +242,6 @@ int semanage_user_create(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(semanage_user_create)
 
 int semanage_user_clone(semanage_handle_t * handle,
 			const semanage_user_t * user,
@@ -289,7 +275,6 @@ int semanage_user_clone(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(semanage_user_clone)
 
 void semanage_user_free(semanage_user_t * user)
 {
@@ -303,10 +288,9 @@ void semanage_user_free(semanage_user_t * user)
 	free(user);
 }
 
-hidden_def(semanage_user_free)
 
 /* Join properties */
-hidden int semanage_user_join(semanage_handle_t * handle,
+ int semanage_user_join(semanage_handle_t * handle,
 			      const semanage_user_base_t * record1,
 			      const semanage_user_extra_t * record2,
 			      semanage_user_t ** result)
@@ -369,7 +353,7 @@ hidden int semanage_user_join(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden int semanage_user_split(semanage_handle_t * handle,
+ int semanage_user_split(semanage_handle_t * handle,
 			       const semanage_user_t * record,
 			       semanage_user_base_t ** split1,
 			       semanage_user_extra_t ** split2)
diff --git a/libsemanage/src/users_policy.c b/libsemanage/src/users_policy.c
index 74f59dc10486..a75513242d0c 100644
--- a/libsemanage/src/users_policy.c
+++ b/libsemanage/src/users_policy.c
@@ -19,7 +19,6 @@ int semanage_user_query(semanage_handle_t * handle,
 	return dbase_query(handle, dconfig, key, response);
 }
 
-hidden_def(semanage_user_query)
 
 int semanage_user_exists(semanage_handle_t * handle,
 			 const semanage_user_key_t * key, int *response)
@@ -29,7 +28,6 @@ int semanage_user_exists(semanage_handle_t * handle,
 	return dbase_exists(handle, dconfig, key, response);
 }
 
-hidden_def(semanage_user_exists)
 
 int semanage_user_count(semanage_handle_t * handle, unsigned int *response)
 {
-- 
2.17.1

