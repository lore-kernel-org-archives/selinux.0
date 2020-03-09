Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F4C10F27
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF7320675
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 15:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjf/f9lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCIPZx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:25:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36646 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgCIPZx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 11:25:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id i13so4961985pfe.3
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJZGoRwBNJZxuRbIvIWvyfacYl4SsUl9QKLrcRWuW8I=;
        b=Kjf/f9lzkyUdLMuBICdi61lP/5QbPGSdG9s1Vg+pyF7QoXABjsrXP6pLM9A6kLi67J
         hhkANhmiiksQujS6o1avg6GA8dzYjyJrd+KhI6UEDYpDMSoRQVH3CAnPQGIgRgRFbtVd
         AjzDBXG2aN9OTXJnB1xIT7sy5yAXKfo9IV6KsseuMK7ipUtbb4tNuLtN+P3kUwCv+gcY
         AANLmDe+9PB5EeEoj9cWX/Vb9tk2A4Jj4xE3SyydpCfe03/TIuO6Ly7PX9NNLZUs/b7K
         ZXDXHUfzeDOpfimNNTImhr0+/Kwa1L40I93LMT6Q/GDmMtrnQSFVxYoTr9LAwR4MyD8o
         xjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJZGoRwBNJZxuRbIvIWvyfacYl4SsUl9QKLrcRWuW8I=;
        b=V3xBYuCRHMKebstCcfQXmEuxSH1Ilmye3uvk+3lpUwSdx2rndKYWdDUtZu7n9CZaeF
         RSo0oi2tzolf8KWxjwYT3fgSqocUwo1DYgwu38SUQyESSNAdzXeWnYuh30+itgE+N97i
         HEZNCqMZTDQS/QQeF9KWFWzdV3/X2wJMmolW6N57ZCeLDiHh/4fDHGoXJcwSCDqu9C2m
         +PHw/Gz9L6KLjBxTPJqzKN959o8WPdnWJ4rV3S2yAXmyMTum8WM6P5K06Ivr7SsC/KxV
         RPdoF9idjB2eIGUFAYdwXOzXto4jjleLNjziPt/bWI1w2N9SdWganin3ZZB8aOIVFofB
         U1Ew==
X-Gm-Message-State: ANhLgQ3ilR5KwwrExWCzR3obtWl6bR4sNMRQlnHVaz0FzStpC9td+a2a
        9q/E6BBfaSDCbHAAFUwWm2Y=
X-Google-Smtp-Source: ADFU+vuEMTJpwJ4SDWHsR9S1RDJuFCE2E02tGI2T0BgnwlulCymYaGNYFCq9AJSjNB5OF41xojQFOA==
X-Received: by 2002:a63:5859:: with SMTP id i25mr16228899pgm.74.1583767550840;
        Mon, 09 Mar 2020 08:25:50 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id f4sm9800725pfn.116.2020.03.09.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:25:50 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org, selinux@vger.kernel.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: [PATCH 1/2] libsepol/dso: drop hidden_proto and hidden_def
Date:   Mon,  9 Mar 2020 10:25:38 -0500
Message-Id: <20200309152539.8581-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309152539.8581-1-william.c.roberts@intel.com>
References: <20200309152539.8581-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

libsepol already has a linker script controlling it's exports, so this
patch has a net 0 affect, with the exception that internal callers of
external routines, which there could be 0 of, could potentially call a
non-libsepol routine depending on library load order.

Additionally, verify that nothing changed in external symbols as well:

This was checked by generating an old export map (from master):
nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map

Then creating a new one for this library after this patch is applied:
nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map

And diffing them:
diff old.map new.map

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/boolean_internal.h   |  9 -----
 libsepol/src/boolean_record.c     |  8 -----
 libsepol/src/context_internal.h   | 13 --------
 libsepol/src/context_record.c     | 12 -------
 libsepol/src/debug.c              |  5 +--
 libsepol/src/debug.h              |  6 +---
 libsepol/src/dso.h                | 27 ---------------
 libsepol/src/ibendport_internal.h | 11 -------
 libsepol/src/ibendport_record.c   | 10 ------
 libsepol/src/ibpkey_internal.h    | 14 --------
 libsepol/src/ibpkey_record.c      | 13 --------
 libsepol/src/iface_internal.h     | 11 -------
 libsepol/src/iface_record.c       | 10 ------
 libsepol/src/module.c             |  2 --
 libsepol/src/module_internal.h    |  3 --
 libsepol/src/node_internal.h      | 19 -----------
 libsepol/src/node_record.c        | 18 ----------
 libsepol/src/policydb_internal.h  |  3 --
 libsepol/src/policydb_public.c    |  2 --
 libsepol/src/port_internal.h      | 13 --------
 libsepol/src/port_record.c        | 12 -------
 libsepol/src/private.h            |  7 ++--
 libsepol/src/services.c           | 55 +++++++++++++++----------------
 libsepol/src/user_internal.h      | 13 --------
 libsepol/src/user_record.c        | 12 -------
 libsepol/src/util.c               |  3 +-
 26 files changed, 33 insertions(+), 278 deletions(-)
 delete mode 100644 libsepol/src/dso.h

diff --git a/libsepol/src/boolean_internal.h b/libsepol/src/boolean_internal.h
index aad7adecb314..1c1e6a39ce09 100644
--- a/libsepol/src/boolean_internal.h
+++ b/libsepol/src/boolean_internal.h
@@ -3,14 +3,5 @@
 
 #include <sepol/boolean_record.h>
 #include <sepol/booleans.h>
-#include "dso.h"
 
-hidden_proto(sepol_bool_key_create)
-    hidden_proto(sepol_bool_key_unpack)
-    hidden_proto(sepol_bool_get_name)
-    hidden_proto(sepol_bool_set_name)
-    hidden_proto(sepol_bool_get_value)
-    hidden_proto(sepol_bool_set_value)
-    hidden_proto(sepol_bool_create)
-    hidden_proto(sepol_bool_free)
 #endif
diff --git a/libsepol/src/boolean_record.c b/libsepol/src/boolean_record.c
index a194704e851a..6cbf627a5f02 100644
--- a/libsepol/src/boolean_record.c
+++ b/libsepol/src/boolean_record.c
@@ -41,7 +41,6 @@ int sepol_bool_key_create(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_bool_key_create)
 
 void sepol_bool_key_unpack(const sepol_bool_key_t * key, const char **name)
 {
@@ -49,7 +48,6 @@ void sepol_bool_key_unpack(const sepol_bool_key_t * key, const char **name)
 	*name = key->name;
 }
 
-hidden_def(sepol_bool_key_unpack)
 
 int sepol_bool_key_extract(sepol_handle_t * handle,
 			   const sepol_bool_t * boolean,
@@ -94,7 +92,6 @@ const char *sepol_bool_get_name(const sepol_bool_t * boolean)
 	return boolean->name;
 }
 
-hidden_def(sepol_bool_get_name)
 
 int sepol_bool_set_name(sepol_handle_t * handle,
 			sepol_bool_t * boolean, const char *name)
@@ -110,7 +107,6 @@ int sepol_bool_set_name(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_bool_set_name)
 
 /* Value */
 int sepol_bool_get_value(const sepol_bool_t * boolean)
@@ -119,7 +115,6 @@ int sepol_bool_get_value(const sepol_bool_t * boolean)
 	return boolean->value;
 }
 
-hidden_def(sepol_bool_get_value)
 
 void sepol_bool_set_value(sepol_bool_t * boolean, int value)
 {
@@ -127,7 +122,6 @@ void sepol_bool_set_value(sepol_bool_t * boolean, int value)
 	boolean->value = value;
 }
 
-hidden_def(sepol_bool_set_value)
 
 /* Create */
 int sepol_bool_create(sepol_handle_t * handle, sepol_bool_t ** bool_ptr)
@@ -148,7 +142,6 @@ int sepol_bool_create(sepol_handle_t * handle, sepol_bool_t ** bool_ptr)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_bool_create)
 
 /* Deep copy clone */
 int sepol_bool_clone(sepol_handle_t * handle,
@@ -185,4 +178,3 @@ void sepol_bool_free(sepol_bool_t * boolean)
 	free(boolean);
 }
 
-hidden_def(sepol_bool_free)
diff --git a/libsepol/src/context_internal.h b/libsepol/src/context_internal.h
index 7987c1cef22d..3cae28cc1c67 100644
--- a/libsepol/src/context_internal.h
+++ b/libsepol/src/context_internal.h
@@ -2,18 +2,5 @@
 #define _SEPOL_CONTEXT_INTERNAL_H_
 
 #include <sepol/context_record.h>
-#include "dso.h"
 
-hidden_proto(sepol_context_clone)
-    hidden_proto(sepol_context_create)
-    hidden_proto(sepol_context_free)
-    hidden_proto(sepol_context_from_string)
-    hidden_proto(sepol_context_get_mls)
-    hidden_proto(sepol_context_get_role)
-    hidden_proto(sepol_context_get_type)
-    hidden_proto(sepol_context_get_user)
-    hidden_proto(sepol_context_set_mls)
-    hidden_proto(sepol_context_set_role)
-    hidden_proto(sepol_context_set_type)
-    hidden_proto(sepol_context_set_user)
 #endif
diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
index 0a8bbf6db407..317a42133884 100644
--- a/libsepol/src/context_record.c
+++ b/libsepol/src/context_record.c
@@ -29,7 +29,6 @@ const char *sepol_context_get_user(const sepol_context_t * con)
 	return con->user;
 }
 
-hidden_def(sepol_context_get_user)
 
 int sepol_context_set_user(sepol_handle_t * handle,
 			   sepol_context_t * con, const char *user)
@@ -47,7 +46,6 @@ int sepol_context_set_user(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_context_set_user)
 
 /* Role */
 const char *sepol_context_get_role(const sepol_context_t * con)
@@ -56,7 +54,6 @@ const char *sepol_context_get_role(const sepol_context_t * con)
 	return con->role;
 }
 
-hidden_def(sepol_context_get_role)
 
 int sepol_context_set_role(sepol_handle_t * handle,
 			   sepol_context_t * con, const char *role)
@@ -73,7 +70,6 @@ int sepol_context_set_role(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_context_set_role)
 
 /* Type */
 const char *sepol_context_get_type(const sepol_context_t * con)
@@ -82,7 +78,6 @@ const char *sepol_context_get_type(const sepol_context_t * con)
 	return con->type;
 }
 
-hidden_def(sepol_context_get_type)
 
 int sepol_context_set_type(sepol_handle_t * handle,
 			   sepol_context_t * con, const char *type)
@@ -99,7 +94,6 @@ int sepol_context_set_type(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_context_set_type)
 
 /* MLS */
 const char *sepol_context_get_mls(const sepol_context_t * con)
@@ -108,7 +102,6 @@ const char *sepol_context_get_mls(const sepol_context_t * con)
 	return con->mls;
 }
 
-hidden_def(sepol_context_get_mls)
 
 int sepol_context_set_mls(sepol_handle_t * handle,
 			  sepol_context_t * con, const char *mls)
@@ -125,7 +118,6 @@ int sepol_context_set_mls(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_context_set_mls)
 
 /* Create */
 int sepol_context_create(sepol_handle_t * handle, sepol_context_t ** con_ptr)
@@ -147,7 +139,6 @@ int sepol_context_create(sepol_handle_t * handle, sepol_context_t ** con_ptr)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_context_create)
 
 /* Deep copy clone */
 int sepol_context_clone(sepol_handle_t * handle,
@@ -188,7 +179,6 @@ int sepol_context_clone(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_context_clone)
 
 /* Destroy */
 void sepol_context_free(sepol_context_t * con)
@@ -204,7 +194,6 @@ void sepol_context_free(sepol_context_t * con)
 	free(con);
 }
 
-hidden_def(sepol_context_free)
 
 int sepol_context_from_string(sepol_handle_t * handle,
 			      const char *str, sepol_context_t ** con)
@@ -278,7 +267,6 @@ int sepol_context_from_string(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_context_from_string)
 
 static inline int safe_sum(size_t *sum, const size_t augends[], const size_t cnt) {
 
diff --git a/libsepol/src/debug.c b/libsepol/src/debug.c
index db57090fafd0..0458e3538884 100644
--- a/libsepol/src/debug.c
+++ b/libsepol/src/debug.c
@@ -23,25 +23,22 @@ int sepol_msg_get_level(sepol_handle_t * handle)
 	return handle->msg_level;
 }
 
-hidden_def(sepol_msg_get_level)
 
 const char *sepol_msg_get_channel(sepol_handle_t * handle)
 {
 	return handle->msg_channel;
 }
 
-hidden_def(sepol_msg_get_channel)
 
 const char *sepol_msg_get_fname(sepol_handle_t * handle)
 {
 	return handle->msg_fname;
 }
 
-hidden_def(sepol_msg_get_fname)
 #ifdef __GNUC__
     __attribute__ ((format(printf, 3, 4)))
 #endif
-void hidden sepol_msg_default_handler(void *varg __attribute__ ((unused)),
+void sepol_msg_default_handler(void *varg __attribute__ ((unused)),
 				      sepol_handle_t * handle,
 				      const char *fmt, ...)
 {
diff --git a/libsepol/src/debug.h b/libsepol/src/debug.h
index 56b397b58310..0b3965d8c500 100644
--- a/libsepol/src/debug.h
+++ b/libsepol/src/debug.h
@@ -21,7 +21,6 @@
 
 #include <stdio.h>
 #include <sepol/debug.h>
-#include "dso.h"
 #include "handle.h"
 
 #define STATUS_SUCCESS 0
@@ -62,13 +61,10 @@
 #ifdef __GNUC__
 __attribute__ ((format(printf, 3, 4)))
 #endif
-extern void hidden sepol_msg_default_handler(void *varg,
+extern void sepol_msg_default_handler(void *varg,
 					     sepol_handle_t * msg,
 					     const char *fmt, ...);
 
 extern struct sepol_handle sepol_compat_handle;
 
-hidden_proto(sepol_msg_get_channel)
-    hidden_proto(sepol_msg_get_fname)
-    hidden_proto(sepol_msg_get_level)
 #endif
diff --git a/libsepol/src/dso.h b/libsepol/src/dso.h
deleted file mode 100644
index a06e3496cc06..000000000000
--- a/libsepol/src/dso.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _SEPOL_DSO_H
-#define _SEPOL_DSO_H	1
-
-#if !defined(SHARED) || defined(ANDROID)
-    #define DISABLE_SYMVER 1
-#endif
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
diff --git a/libsepol/src/ibendport_internal.h b/libsepol/src/ibendport_internal.h
index ed8f9b4dd3d3..8bfb499e5c1b 100644
--- a/libsepol/src/ibendport_internal.h
+++ b/libsepol/src/ibendport_internal.h
@@ -3,16 +3,5 @@
 
 #include <sepol/ibendport_record.h>
 #include <sepol/ibendports.h>
-#include "dso.h"
 
-hidden_proto(sepol_ibendport_create)
-hidden_proto(sepol_ibendport_free)
-hidden_proto(sepol_ibendport_get_con)
-hidden_proto(sepol_ibendport_get_port)
-hidden_proto(sepol_ibendport_key_create)
-hidden_proto(sepol_ibendport_key_unpack)
-hidden_proto(sepol_ibendport_set_con)
-hidden_proto(sepol_ibendport_set_port)
-hidden_proto(sepol_ibendport_get_ibdev_name)
-hidden_proto(sepol_ibendport_set_ibdev_name)
 #endif
diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
index bc56f090d3a4..adf671615e5c 100644
--- a/libsepol/src/ibendport_record.c
+++ b/libsepol/src/ibendport_record.c
@@ -78,7 +78,6 @@ err:
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_ibendport_key_create)
 
 void sepol_ibendport_key_unpack(const sepol_ibendport_key_t *key,
 				const char **ibdev_name, int *port)
@@ -87,7 +86,6 @@ void sepol_ibendport_key_unpack(const sepol_ibendport_key_t *key,
 	*port = key->port;
 }
 
-hidden_def(sepol_ibendport_key_unpack)
 
 int sepol_ibendport_key_extract(sepol_handle_t *handle,
 				const sepol_ibendport_t *ibendport,
@@ -152,14 +150,12 @@ int sepol_ibendport_get_port(const sepol_ibendport_t *ibendport)
 	return ibendport->port;
 }
 
-hidden_def(sepol_ibendport_get_port)
 
 void sepol_ibendport_set_port(sepol_ibendport_t *ibendport, int port)
 {
 	ibendport->port = port;
 }
 
-hidden_def(sepol_ibendport_set_port)
 
 int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
 				   const sepol_ibendport_t *ibendport,
@@ -180,7 +176,6 @@ err:
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_ibendport_get_ibdev_name)
 
 int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
 				   sepol_ibendport_t *ibendport,
@@ -202,7 +197,6 @@ err:
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_ibendport_set_ibdev_name)
 
 /* Create */
 int sepol_ibendport_create(sepol_handle_t *handle, sepol_ibendport_t **ibendport)
@@ -222,7 +216,6 @@ int sepol_ibendport_create(sepol_handle_t *handle, sepol_ibendport_t **ibendport
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_ibendport_create)
 
 /* Deep copy clone */
 int sepol_ibendport_clone(sepol_handle_t *handle,
@@ -267,7 +260,6 @@ void sepol_ibendport_free(sepol_ibendport_t *ibendport)
 	free(ibendport);
 }
 
-hidden_def(sepol_ibendport_free)
 
 /* Context */
 sepol_context_t *sepol_ibendport_get_con(const sepol_ibendport_t *ibendport)
@@ -275,7 +267,6 @@ sepol_context_t *sepol_ibendport_get_con(const sepol_ibendport_t *ibendport)
 	return ibendport->con;
 }
 
-hidden_def(sepol_ibendport_get_con)
 
 int sepol_ibendport_set_con(sepol_handle_t *handle,
 			    sepol_ibendport_t *ibendport, sepol_context_t *con)
@@ -292,4 +283,3 @@ int sepol_ibendport_set_con(sepol_handle_t *handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_ibendport_set_con)
diff --git a/libsepol/src/ibpkey_internal.h b/libsepol/src/ibpkey_internal.h
index addf80a8bf7d..b875f942f8d1 100644
--- a/libsepol/src/ibpkey_internal.h
+++ b/libsepol/src/ibpkey_internal.h
@@ -3,19 +3,5 @@
 
 #include <sepol/ibpkey_record.h>
 #include <sepol/ibpkeys.h>
-#include "dso.h"
 
-hidden_proto(sepol_ibpkey_create)
-hidden_proto(sepol_ibpkey_free)
-hidden_proto(sepol_ibpkey_get_con)
-hidden_proto(sepol_ibpkey_get_high)
-hidden_proto(sepol_ibpkey_get_low)
-hidden_proto(sepol_ibpkey_key_create)
-hidden_proto(sepol_ibpkey_key_unpack)
-hidden_proto(sepol_ibpkey_set_con)
-hidden_proto(sepol_ibpkey_set_range)
-hidden_proto(sepol_ibpkey_get_subnet_prefix)
-hidden_proto(sepol_ibpkey_get_subnet_prefix_bytes)
-hidden_proto(sepol_ibpkey_set_subnet_prefix)
-hidden_proto(sepol_ibpkey_set_subnet_prefix_bytes)
 #endif
diff --git a/libsepol/src/ibpkey_record.c b/libsepol/src/ibpkey_record.c
index badf2b3b6338..6f7aa65602d1 100644
--- a/libsepol/src/ibpkey_record.c
+++ b/libsepol/src/ibpkey_record.c
@@ -128,7 +128,6 @@ err:
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_ibpkey_key_create)
 
 void sepol_ibpkey_key_unpack(const sepol_ibpkey_key_t *key,
 			     uint64_t *subnet_prefix, int *low, int *high)
@@ -138,7 +137,6 @@ void sepol_ibpkey_key_unpack(const sepol_ibpkey_key_t *key,
 	*high = key->high;
 }
 
-hidden_def(sepol_ibpkey_key_unpack)
 
 int sepol_ibpkey_key_extract(sepol_handle_t *handle,
 			     const sepol_ibpkey_t *ibpkey,
@@ -213,14 +211,12 @@ int sepol_ibpkey_get_low(const sepol_ibpkey_t *ibpkey)
 	return ibpkey->low;
 }
 
-hidden_def(sepol_ibpkey_get_low)
 
 int sepol_ibpkey_get_high(const sepol_ibpkey_t *ibpkey)
 {
 	return ibpkey->high;
 }
 
-hidden_def(sepol_ibpkey_get_high)
 
 void sepol_ibpkey_set_pkey(sepol_ibpkey_t *ibpkey, int pkey_num)
 {
@@ -234,7 +230,6 @@ void sepol_ibpkey_set_range(sepol_ibpkey_t *ibpkey, int low, int high)
 	ibpkey->high = high;
 }
 
-hidden_def(sepol_ibpkey_set_range)
 
 int sepol_ibpkey_get_subnet_prefix(sepol_handle_t *handle,
 				   const sepol_ibpkey_t *ibpkey,
@@ -257,7 +252,6 @@ err:
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_ibpkey_get_subnet_prefix)
 
 /* Subnet prefix */
 uint64_t sepol_ibpkey_get_subnet_prefix_bytes(const sepol_ibpkey_t *ibpkey)
@@ -265,7 +259,6 @@ uint64_t sepol_ibpkey_get_subnet_prefix_bytes(const sepol_ibpkey_t *ibpkey)
 	return ibpkey->subnet_prefix;
 }
 
-hidden_def(sepol_ibpkey_get_subnet_prefix_bytes)
 
 int sepol_ibpkey_set_subnet_prefix(sepol_handle_t *handle,
 				   sepol_ibpkey_t *ibpkey,
@@ -284,7 +277,6 @@ err:
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_ibpkey_set_subnet_prefix)
 
 void sepol_ibpkey_set_subnet_prefix_bytes(sepol_ibpkey_t *ibpkey,
 					  uint64_t subnet_prefix)
@@ -292,7 +284,6 @@ void sepol_ibpkey_set_subnet_prefix_bytes(sepol_ibpkey_t *ibpkey,
 	ibpkey->subnet_prefix = subnet_prefix;
 }
 
-hidden_def(sepol_ibpkey_set_subnet_prefix_bytes)
 
 /* Create */
 int sepol_ibpkey_create(sepol_handle_t *handle, sepol_ibpkey_t **ibpkey)
@@ -313,7 +304,6 @@ int sepol_ibpkey_create(sepol_handle_t *handle, sepol_ibpkey_t **ibpkey)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_ibpkey_create)
 
 /* Deep copy clone */
 int sepol_ibpkey_clone(sepol_handle_t *handle,
@@ -351,7 +341,6 @@ void sepol_ibpkey_free(sepol_ibpkey_t *ibpkey)
 	free(ibpkey);
 }
 
-hidden_def(sepol_ibpkey_free)
 
 /* Context */
 sepol_context_t *sepol_ibpkey_get_con(const sepol_ibpkey_t *ibpkey)
@@ -359,7 +348,6 @@ sepol_context_t *sepol_ibpkey_get_con(const sepol_ibpkey_t *ibpkey)
 	return ibpkey->con;
 }
 
-hidden_def(sepol_ibpkey_get_con)
 
 int sepol_ibpkey_set_con(sepol_handle_t *handle,
 			 sepol_ibpkey_t *ibpkey, sepol_context_t *con)
@@ -376,4 +364,3 @@ int sepol_ibpkey_set_con(sepol_handle_t *handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_ibpkey_set_con)
diff --git a/libsepol/src/iface_internal.h b/libsepol/src/iface_internal.h
index 5b78d9bd93ff..82fb60cb2c85 100644
--- a/libsepol/src/iface_internal.h
+++ b/libsepol/src/iface_internal.h
@@ -3,16 +3,5 @@
 
 #include <sepol/iface_record.h>
 #include <sepol/interfaces.h>
-#include "dso.h"
 
-hidden_proto(sepol_iface_create)
-    hidden_proto(sepol_iface_free)
-    hidden_proto(sepol_iface_get_ifcon)
-    hidden_proto(sepol_iface_get_msgcon)
-    hidden_proto(sepol_iface_get_name)
-    hidden_proto(sepol_iface_key_create)
-    hidden_proto(sepol_iface_key_unpack)
-    hidden_proto(sepol_iface_set_ifcon)
-    hidden_proto(sepol_iface_set_msgcon)
-    hidden_proto(sepol_iface_set_name)
 #endif
diff --git a/libsepol/src/iface_record.c b/libsepol/src/iface_record.c
index 6d568355468d..e77569898900 100644
--- a/libsepol/src/iface_record.c
+++ b/libsepol/src/iface_record.c
@@ -47,7 +47,6 @@ int sepol_iface_key_create(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_iface_key_create)
 
 void sepol_iface_key_unpack(const sepol_iface_key_t * key, const char **name)
 {
@@ -55,7 +54,6 @@ void sepol_iface_key_unpack(const sepol_iface_key_t * key, const char **name)
 	*name = key->name;
 }
 
-hidden_def(sepol_iface_key_unpack)
 
 int sepol_iface_key_extract(sepol_handle_t * handle,
 			    const sepol_iface_t * iface,
@@ -114,7 +112,6 @@ int sepol_iface_create(sepol_handle_t * handle, sepol_iface_t ** iface)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_iface_create)
 
 /* Name */
 const char *sepol_iface_get_name(const sepol_iface_t * iface)
@@ -123,7 +120,6 @@ const char *sepol_iface_get_name(const sepol_iface_t * iface)
 	return iface->name;
 }
 
-hidden_def(sepol_iface_get_name)
 
 int sepol_iface_set_name(sepol_handle_t * handle,
 			 sepol_iface_t * iface, const char *name)
@@ -139,7 +135,6 @@ int sepol_iface_set_name(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_iface_set_name)
 
 /* Interface Context */
 sepol_context_t *sepol_iface_get_ifcon(const sepol_iface_t * iface)
@@ -148,7 +143,6 @@ sepol_context_t *sepol_iface_get_ifcon(const sepol_iface_t * iface)
 	return iface->netif_con;
 }
 
-hidden_def(sepol_iface_get_ifcon)
 
 int sepol_iface_set_ifcon(sepol_handle_t * handle,
 			  sepol_iface_t * iface, sepol_context_t * con)
@@ -166,7 +160,6 @@ int sepol_iface_set_ifcon(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_iface_set_ifcon)
 
 /* Message Context */
 sepol_context_t *sepol_iface_get_msgcon(const sepol_iface_t * iface)
@@ -175,7 +168,6 @@ sepol_context_t *sepol_iface_get_msgcon(const sepol_iface_t * iface)
 	return iface->netmsg_con;
 }
 
-hidden_def(sepol_iface_get_msgcon)
 
 int sepol_iface_set_msgcon(sepol_handle_t * handle,
 			   sepol_iface_t * iface, sepol_context_t * con)
@@ -192,7 +184,6 @@ int sepol_iface_set_msgcon(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_iface_set_msgcon)
 
 /* Deep copy clone */
 int sepol_iface_clone(sepol_handle_t * handle,
@@ -238,4 +229,3 @@ void sepol_iface_free(sepol_iface_t * iface)
 	free(iface);
 }
 
-hidden_def(sepol_iface_free)
diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 3b8a0a59ca68..836da308f8d3 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -132,7 +132,6 @@ int sepol_module_package_create(sepol_module_package_t ** p)
 	return rc;
 }
 
-hidden_def(sepol_module_package_create)
 
 /* Deallocates all memory associated with a module package, including
  * the pointer itself.  Does nothing if p is NULL.
@@ -150,7 +149,6 @@ void sepol_module_package_free(sepol_module_package_t * p)
 	free(p);
 }
 
-hidden_def(sepol_module_package_free)
 
 char *sepol_module_package_get_file_contexts(sepol_module_package_t * p)
 {
diff --git a/libsepol/src/module_internal.h b/libsepol/src/module_internal.h
index cdd5ec65cfff..ac1be36a2f72 100644
--- a/libsepol/src/module_internal.h
+++ b/libsepol/src/module_internal.h
@@ -1,5 +1,2 @@
 #include <sepol/module.h>
-#include "dso.h"
 
-hidden_proto(sepol_module_package_create)
-    hidden_proto(sepol_module_package_free)
diff --git a/libsepol/src/node_internal.h b/libsepol/src/node_internal.h
index 802cda97c181..6d3c250543ae 100644
--- a/libsepol/src/node_internal.h
+++ b/libsepol/src/node_internal.h
@@ -3,24 +3,5 @@
 
 #include <sepol/node_record.h>
 #include <sepol/nodes.h>
-#include "dso.h"
 
-hidden_proto(sepol_node_create)
-    hidden_proto(sepol_node_key_free)
-    hidden_proto(sepol_node_free)
-    hidden_proto(sepol_node_get_con)
-    hidden_proto(sepol_node_get_addr)
-    hidden_proto(sepol_node_get_addr_bytes)
-    hidden_proto(sepol_node_get_mask)
-    hidden_proto(sepol_node_get_mask_bytes)
-    hidden_proto(sepol_node_get_proto)
-    hidden_proto(sepol_node_get_proto_str)
-    hidden_proto(sepol_node_key_create)
-    hidden_proto(sepol_node_key_unpack)
-    hidden_proto(sepol_node_set_con)
-    hidden_proto(sepol_node_set_addr)
-    hidden_proto(sepol_node_set_addr_bytes)
-    hidden_proto(sepol_node_set_mask)
-    hidden_proto(sepol_node_set_mask_bytes)
-    hidden_proto(sepol_node_set_proto)
 #endif
diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
index f3e78ff3c788..9ef429da8768 100644
--- a/libsepol/src/node_record.c
+++ b/libsepol/src/node_record.c
@@ -259,7 +259,6 @@ int sepol_node_key_create(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_node_key_create)
 
 void sepol_node_key_unpack(const sepol_node_key_t * key,
 			   const char **addr, const char **mask, int *proto)
@@ -270,7 +269,6 @@ void sepol_node_key_unpack(const sepol_node_key_t * key,
 	*proto = key->proto;
 }
 
-hidden_def(sepol_node_key_unpack)
 
 int sepol_node_key_extract(sepol_handle_t * handle,
 			   const sepol_node_t * node,
@@ -314,7 +312,6 @@ void sepol_node_key_free(sepol_node_key_t * key)
 	free(key);
 }
 
-hidden_def(sepol_node_key_free)
 
 int sepol_node_compare(const sepol_node_t * node, const sepol_node_key_t * key)
 {
@@ -375,7 +372,6 @@ int sepol_node_get_addr(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_node_get_addr)
 
 int sepol_node_get_addr_bytes(sepol_handle_t * handle,
 			      const sepol_node_t * node,
@@ -394,7 +390,6 @@ int sepol_node_get_addr_bytes(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_node_get_addr_bytes)
 
 int sepol_node_set_addr(sepol_handle_t * handle,
 			sepol_node_t * node, int proto, const char *addr)
@@ -420,7 +415,6 @@ int sepol_node_set_addr(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_node_set_addr)
 
 int sepol_node_set_addr_bytes(sepol_handle_t * handle,
 			      sepol_node_t * node,
@@ -440,7 +434,6 @@ int sepol_node_set_addr_bytes(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_node_set_addr_bytes)
 
 /* Mask */
 int sepol_node_get_mask(sepol_handle_t * handle,
@@ -464,7 +457,6 @@ int sepol_node_get_mask(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_node_get_mask)
 
 int sepol_node_get_mask_bytes(sepol_handle_t * handle,
 			      const sepol_node_t * node,
@@ -483,7 +475,6 @@ int sepol_node_get_mask_bytes(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_node_get_mask_bytes)
 
 int sepol_node_set_mask(sepol_handle_t * handle,
 			sepol_node_t * node, int proto, const char *mask)
@@ -509,7 +500,6 @@ int sepol_node_set_mask(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_node_set_mask)
 
 int sepol_node_set_mask_bytes(sepol_handle_t * handle,
 			      sepol_node_t * node,
@@ -528,7 +518,6 @@ int sepol_node_set_mask_bytes(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_node_set_mask_bytes)
 
 /* Protocol */
 int sepol_node_get_proto(const sepol_node_t * node)
@@ -537,7 +526,6 @@ int sepol_node_get_proto(const sepol_node_t * node)
 	return node->proto;
 }
 
-hidden_def(sepol_node_get_proto)
 
 void sepol_node_set_proto(sepol_node_t * node, int proto)
 {
@@ -545,7 +533,6 @@ void sepol_node_set_proto(sepol_node_t * node, int proto)
 	node->proto = proto;
 }
 
-hidden_def(sepol_node_set_proto)
 
 const char *sepol_node_get_proto_str(int proto)
 {
@@ -560,7 +547,6 @@ const char *sepol_node_get_proto_str(int proto)
 	}
 }
 
-hidden_def(sepol_node_get_proto_str)
 
 /* Create */
 int sepol_node_create(sepol_handle_t * handle, sepol_node_t ** node)
@@ -584,7 +570,6 @@ int sepol_node_create(sepol_handle_t * handle, sepol_node_t ** node)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_node_create)
 
 /* Deep copy clone */
 int sepol_node_clone(sepol_handle_t * handle,
@@ -637,7 +622,6 @@ void sepol_node_free(sepol_node_t * node)
 	free(node);
 }
 
-hidden_def(sepol_node_free)
 
 /* Context */
 sepol_context_t *sepol_node_get_con(const sepol_node_t * node)
@@ -646,7 +630,6 @@ sepol_context_t *sepol_node_get_con(const sepol_node_t * node)
 	return node->con;
 }
 
-hidden_def(sepol_node_get_con)
 
 int sepol_node_set_con(sepol_handle_t * handle,
 		       sepol_node_t * node, sepol_context_t * con)
@@ -664,4 +647,3 @@ int sepol_node_set_con(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_node_set_con)
diff --git a/libsepol/src/policydb_internal.h b/libsepol/src/policydb_internal.h
index f7bcdfa3df31..06ba5c8be144 100644
--- a/libsepol/src/policydb_internal.h
+++ b/libsepol/src/policydb_internal.h
@@ -2,9 +2,6 @@
 #define _SEPOL_POLICYDB_INTERNAL_H_
 
 #include <sepol/policydb.h>
-#include "dso.h"
 
-hidden_proto(sepol_policydb_create)
-    hidden_proto(sepol_policydb_free)
 extern const char *policydb_target_strings[];
 #endif
diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
index 747a43ff0a5c..e5def7078eb0 100644
--- a/libsepol/src/policydb_public.c
+++ b/libsepol/src/policydb_public.c
@@ -73,7 +73,6 @@ int sepol_policydb_create(sepol_policydb_t ** sp)
 	return 0;
 }
 
-hidden_def(sepol_policydb_create)
 
 void sepol_policydb_free(sepol_policydb_t * p)
 {
@@ -83,7 +82,6 @@ void sepol_policydb_free(sepol_policydb_t * p)
 	free(p);
 }
 
-hidden_def(sepol_policydb_free)
 
 int sepol_policy_kern_vers_min(void)
 {
diff --git a/libsepol/src/port_internal.h b/libsepol/src/port_internal.h
index ffb5f65ad20b..80cf5c25366d 100644
--- a/libsepol/src/port_internal.h
+++ b/libsepol/src/port_internal.h
@@ -3,18 +3,5 @@
 
 #include <sepol/port_record.h>
 #include <sepol/ports.h>
-#include "dso.h"
 
-hidden_proto(sepol_port_create)
-    hidden_proto(sepol_port_free)
-    hidden_proto(sepol_port_get_con)
-    hidden_proto(sepol_port_get_high)
-    hidden_proto(sepol_port_get_low)
-    hidden_proto(sepol_port_get_proto)
-    hidden_proto(sepol_port_get_proto_str)
-    hidden_proto(sepol_port_key_create)
-    hidden_proto(sepol_port_key_unpack)
-    hidden_proto(sepol_port_set_con)
-    hidden_proto(sepol_port_set_proto)
-    hidden_proto(sepol_port_set_range)
 #endif
diff --git a/libsepol/src/port_record.c b/libsepol/src/port_record.c
index 15fb198fb359..7054dbc2e1b4 100644
--- a/libsepol/src/port_record.c
+++ b/libsepol/src/port_record.c
@@ -46,7 +46,6 @@ int sepol_port_key_create(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_port_key_create)
 
 void sepol_port_key_unpack(const sepol_port_key_t * key,
 			   int *low, int *high, int *proto)
@@ -57,7 +56,6 @@ void sepol_port_key_unpack(const sepol_port_key_t * key,
 	*proto = key->proto;
 }
 
-hidden_def(sepol_port_key_unpack)
 
 int sepol_port_key_extract(sepol_handle_t * handle,
 			   const sepol_port_t * port,
@@ -141,7 +139,6 @@ int sepol_port_get_low(const sepol_port_t * port)
 	return port->low;
 }
 
-hidden_def(sepol_port_get_low)
 
 int sepol_port_get_high(const sepol_port_t * port)
 {
@@ -149,7 +146,6 @@ int sepol_port_get_high(const sepol_port_t * port)
 	return port->high;
 }
 
-hidden_def(sepol_port_get_high)
 
 void sepol_port_set_port(sepol_port_t * port, int port_num)
 {
@@ -165,7 +161,6 @@ void sepol_port_set_range(sepol_port_t * port, int low, int high)
 	port->high = high;
 }
 
-hidden_def(sepol_port_set_range)
 
 /* Protocol */
 int sepol_port_get_proto(const sepol_port_t * port)
@@ -174,7 +169,6 @@ int sepol_port_get_proto(const sepol_port_t * port)
 	return port->proto;
 }
 
-hidden_def(sepol_port_get_proto)
 
 const char *sepol_port_get_proto_str(int proto)
 {
@@ -193,7 +187,6 @@ const char *sepol_port_get_proto_str(int proto)
 	}
 }
 
-hidden_def(sepol_port_get_proto_str)
 
 void sepol_port_set_proto(sepol_port_t * port, int proto)
 {
@@ -201,7 +194,6 @@ void sepol_port_set_proto(sepol_port_t * port, int proto)
 	port->proto = proto;
 }
 
-hidden_def(sepol_port_set_proto)
 
 /* Create */
 int sepol_port_create(sepol_handle_t * handle, sepol_port_t ** port)
@@ -223,7 +215,6 @@ int sepol_port_create(sepol_handle_t * handle, sepol_port_t ** port)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_port_create)
 
 /* Deep copy clone */
 int sepol_port_clone(sepol_handle_t * handle,
@@ -262,7 +253,6 @@ void sepol_port_free(sepol_port_t * port)
 	free(port);
 }
 
-hidden_def(sepol_port_free)
 
 /* Context */
 sepol_context_t *sepol_port_get_con(const sepol_port_t * port)
@@ -271,7 +261,6 @@ sepol_context_t *sepol_port_get_con(const sepol_port_t * port)
 	return port->con;
 }
 
-hidden_def(sepol_port_get_con)
 
 int sepol_port_set_con(sepol_handle_t * handle,
 		       sepol_port_t * port, sepol_context_t * con)
@@ -289,4 +278,3 @@ int sepol_port_set_con(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_port_set_con)
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index b884c23b91fe..f5b5277f183a 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -14,7 +14,6 @@
 #endif
 
 #include <errno.h>
-#include <dso.h>
 
 #ifdef __APPLE__
 #define __BYTE_ORDER  BYTE_ORDER
@@ -62,7 +61,7 @@ extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
 						unsigned int target_platform);
 
 /* Reading from a policy "file". */
-extern int next_entry(void *buf, struct policy_file *fp, size_t bytes) hidden;
+extern int next_entry(void *buf, struct policy_file *fp, size_t bytes);
 extern size_t put_entry(const void *ptr, size_t size, size_t n,
-		        struct policy_file *fp) hidden;
-extern int str_read(char **strp, struct policy_file *fp, size_t len) hidden;
+		        struct policy_file *fp);
+extern int str_read(char **strp, struct policy_file *fp, size_t len);
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 3758436f8e34..51314dabb574 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -66,7 +66,6 @@
 #include "private.h"
 #include "context.h"
 #include "av_permissions.h"
-#include "dso.h"
 #include "mls.h"
 
 #define BUG() do { ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
@@ -121,13 +120,13 @@ static char *pop(void)
 }
 /* End Stack services */
 
-int hidden sepol_set_sidtab(sidtab_t * s)
+int sepol_set_sidtab(sidtab_t * s)
 {
 	sidtab = s;
 	return 0;
 }
 
-int hidden sepol_set_policydb(policydb_t * p)
+int sepol_set_policydb(policydb_t * p)
 {
 	policydb = p;
 	return 0;
@@ -1013,7 +1012,7 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	return 0;
 }
 
-int hidden sepol_validate_transition(sepol_security_id_t oldsid,
+int sepol_validate_transition(sepol_security_id_t oldsid,
 				     sepol_security_id_t newsid,
 				     sepol_security_id_t tasksid,
 				     sepol_security_class_t tclass)
@@ -1064,7 +1063,7 @@ int hidden sepol_validate_transition(sepol_security_id_t oldsid,
  * sepol_validate_transition_reason_buffer - the reason buffer is realloc'd
  * in the constraint_expr_eval_reason() function.
  */
-int hidden sepol_validate_transition_reason_buffer(sepol_security_id_t oldsid,
+int sepol_validate_transition_reason_buffer(sepol_security_id_t oldsid,
 				     sepol_security_id_t newsid,
 				     sepol_security_id_t tasksid,
 				     sepol_security_class_t tclass,
@@ -1122,7 +1121,7 @@ int hidden sepol_validate_transition_reason_buffer(sepol_security_id_t oldsid,
 	return 0;
 }
 
-int hidden sepol_compute_av_reason(sepol_security_id_t ssid,
+int sepol_compute_av_reason(sepol_security_id_t ssid,
 				   sepol_security_id_t tsid,
 				   sepol_security_class_t tclass,
 				   sepol_access_vector_t requested,
@@ -1156,7 +1155,7 @@ int hidden sepol_compute_av_reason(sepol_security_id_t ssid,
  * REASON_BUF_SIZE. If the buffer size is exceeded, then it is realloc'd
  * in the constraint_expr_eval_reason() function.
  */
-int hidden sepol_compute_av_reason_buffer(sepol_security_id_t ssid,
+int sepol_compute_av_reason_buffer(sepol_security_id_t ssid,
 				   sepol_security_id_t tsid,
 				   sepol_security_class_t tclass,
 				   sepol_access_vector_t requested,
@@ -1198,7 +1197,7 @@ out:
 	return rc;
 }
 
-int hidden sepol_compute_av(sepol_security_id_t ssid,
+int sepol_compute_av(sepol_security_id_t ssid,
 			    sepol_security_id_t tsid,
 			    sepol_security_class_t tclass,
 			    sepol_access_vector_t requested,
@@ -1213,7 +1212,7 @@ int hidden sepol_compute_av(sepol_security_id_t ssid,
  * Return a class ID associated with the class string specified by
  * class_name.
  */
-int hidden sepol_string_to_security_class(const char *class_name,
+int sepol_string_to_security_class(const char *class_name,
 			sepol_security_class_t *tclass)
 {
 	class_datum_t *tclass_datum;
@@ -1232,7 +1231,7 @@ int hidden sepol_string_to_security_class(const char *class_name,
  * Return access vector bit associated with the class ID and permission
  * string.
  */
-int hidden sepol_string_to_av_perm(sepol_security_class_t tclass,
+int sepol_string_to_av_perm(sepol_security_class_t tclass,
 					const char *perm_name,
 					sepol_access_vector_t *av)
 {
@@ -1277,7 +1276,7 @@ out:
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-int hidden sepol_sid_to_context(sepol_security_id_t sid,
+int sepol_sid_to_context(sepol_security_id_t sid,
 				sepol_security_context_t * scontext,
 				size_t * scontext_len)
 {
@@ -1300,7 +1299,7 @@ int hidden sepol_sid_to_context(sepol_security_id_t sid,
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
  */
-int hidden sepol_context_to_sid(const sepol_security_context_t scontext,
+int sepol_context_to_sid(const sepol_security_context_t scontext,
 				size_t scontext_len, sepol_security_id_t * sid)
 {
 
@@ -1480,7 +1479,7 @@ static int sepol_compute_sid(sepol_security_id_t ssid,
  * Compute a SID to use for labeling a new object in the 
  * class `tclass' based on a SID pair.  
  */
-int hidden sepol_transition_sid(sepol_security_id_t ssid,
+int sepol_transition_sid(sepol_security_id_t ssid,
 				sepol_security_id_t tsid,
 				sepol_security_class_t tclass,
 				sepol_security_id_t * out_sid)
@@ -1493,7 +1492,7 @@ int hidden sepol_transition_sid(sepol_security_id_t ssid,
  * polyinstantiated object of class `tclass' based on 
  * a SID pair.
  */
-int hidden sepol_member_sid(sepol_security_id_t ssid,
+int sepol_member_sid(sepol_security_id_t ssid,
 			    sepol_security_id_t tsid,
 			    sepol_security_class_t tclass,
 			    sepol_security_id_t * out_sid)
@@ -1505,7 +1504,7 @@ int hidden sepol_member_sid(sepol_security_id_t ssid,
  * Compute a SID to use for relabeling an object in the 
  * class `tclass' based on a SID pair.  
  */
-int hidden sepol_change_sid(sepol_security_id_t ssid,
+int sepol_change_sid(sepol_security_id_t ssid,
 			    sepol_security_id_t tsid,
 			    sepol_security_class_t tclass,
 			    sepol_security_id_t * out_sid)
@@ -1691,7 +1690,7 @@ static int convert_context(sepol_security_id_t key __attribute__ ((unused)),
 }
 
 /* Reading from a policy "file". */
-int hidden next_entry(void *buf, struct policy_file *fp, size_t bytes)
+int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 {
 	size_t nread;
 
@@ -1718,7 +1717,7 @@ int hidden next_entry(void *buf, struct policy_file *fp, size_t bytes)
 	return 0;
 }
 
-size_t hidden put_entry(const void *ptr, size_t size, size_t n,
+size_t put_entry(const void *ptr, size_t size, size_t n,
 			struct policy_file *fp)
 {
 	size_t bytes = size * n;
@@ -1753,7 +1752,7 @@ size_t hidden put_entry(const void *ptr, size_t size, size_t n,
  *   0 - Success
  *  -1 - Failure with errno set
  */
-int hidden str_read(char **strp, struct policy_file *fp, size_t len)
+int str_read(char **strp, struct policy_file *fp, size_t len)
 {
 	int rc;
 	char *str;
@@ -1796,7 +1795,7 @@ int hidden str_read(char **strp, struct policy_file *fp, size_t len)
  *
  * Reset the access vector cache.
  */
-int hidden sepol_load_policy(void *data, size_t len)
+int sepol_load_policy(void *data, size_t len)
 {
 	policydb_t oldpolicydb, newpolicydb;
 	sidtab_t oldsidtab, newsidtab;
@@ -1869,7 +1868,7 @@ int hidden sepol_load_policy(void *data, size_t len)
  * the file system and the `file_sid' SID is returned
  * for all files within that file system.
  */
-int hidden sepol_fs_sid(char *name,
+int sepol_fs_sid(char *name,
 			sepol_security_id_t * fs_sid,
 			sepol_security_id_t * file_sid)
 {
@@ -1911,7 +1910,7 @@ int hidden sepol_fs_sid(char *name,
  * Return the SID of the ibpkey specified by
  * `subnet prefix', and `pkey number'.
  */
-int hidden sepol_ibpkey_sid(uint64_t subnet_prefix,
+int sepol_ibpkey_sid(uint64_t subnet_prefix,
 			    uint16_t pkey, sepol_security_id_t *out_sid)
 {
 	ocontext_t *c;
@@ -1947,7 +1946,7 @@ out:
  * Return the SID of the subnet management interface specified by
  * `device name', and `port'.
  */
-int hidden sepol_ibendport_sid(char *dev_name,
+int sepol_ibendport_sid(char *dev_name,
 			       uint8_t port,
 			       sepol_security_id_t *out_sid)
 {
@@ -1984,7 +1983,7 @@ out:
  * Return the SID of the port specified by
  * `domain', `type', `protocol', and `port'.
  */
-int hidden sepol_port_sid(uint16_t domain __attribute__ ((unused)),
+int sepol_port_sid(uint16_t domain __attribute__ ((unused)),
 			  uint16_t type __attribute__ ((unused)),
 			  uint8_t protocol,
 			  uint16_t port, sepol_security_id_t * out_sid)
@@ -2024,7 +2023,7 @@ int hidden sepol_port_sid(uint16_t domain __attribute__ ((unused)),
  * the default SID for messages received on the
  * interface.
  */
-int hidden sepol_netif_sid(char *name,
+int sepol_netif_sid(char *name,
 			   sepol_security_id_t * if_sid,
 			   sepol_security_id_t * msg_sid)
 {
@@ -2082,7 +2081,7 @@ static int match_ipv6_addrmask(uint32_t * input, uint32_t * addr,
  * in bytes and `domain' is the communications domain or
  * address family in which the address should be interpreted.
  */
-int hidden sepol_node_sid(uint16_t domain,
+int sepol_node_sid(uint16_t domain,
 			  void *addrp,
 			  size_t addrlen, sepol_security_id_t * out_sid)
 {
@@ -2155,7 +2154,7 @@ int hidden sepol_node_sid(uint16_t domain,
  */
 #define SIDS_NEL 25
 
-int hidden sepol_get_user_sids(sepol_security_id_t fromsid,
+int sepol_get_user_sids(sepol_security_id_t fromsid,
 			       char *username,
 			       sepol_security_id_t ** sids, uint32_t * nel)
 {
@@ -2250,7 +2249,7 @@ int hidden sepol_get_user_sids(sepol_security_id_t fromsid,
  * that cannot support a persistent label mapping or use another
  * fixed labeling behavior like transition SIDs or task SIDs.
  */
-int hidden sepol_genfs_sid(const char *fstype,
+int sepol_genfs_sid(const char *fstype,
 			   const char *path,
 			   sepol_security_class_t sclass,
 			   sepol_security_id_t * sid)
@@ -2297,7 +2296,7 @@ int hidden sepol_genfs_sid(const char *fstype,
 	return rc;
 }
 
-int hidden sepol_fs_use(const char *fstype,
+int sepol_fs_use(const char *fstype,
 			unsigned int *behavior, sepol_security_id_t * sid)
 {
 	int rc = 0;
diff --git a/libsepol/src/user_internal.h b/libsepol/src/user_internal.h
index 7523b7d54076..f5b22b023034 100644
--- a/libsepol/src/user_internal.h
+++ b/libsepol/src/user_internal.h
@@ -3,18 +3,5 @@
 
 #include <sepol/user_record.h>
 #include <sepol/users.h>
-#include "dso.h"
 
-hidden_proto(sepol_user_add_role)
-    hidden_proto(sepol_user_create)
-    hidden_proto(sepol_user_free)
-    hidden_proto(sepol_user_get_mlslevel)
-    hidden_proto(sepol_user_get_mlsrange)
-    hidden_proto(sepol_user_get_roles)
-    hidden_proto(sepol_user_has_role)
-    hidden_proto(sepol_user_key_create)
-    hidden_proto(sepol_user_key_unpack)
-    hidden_proto(sepol_user_set_mlslevel)
-    hidden_proto(sepol_user_set_mlsrange)
-    hidden_proto(sepol_user_set_name)
 #endif
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index fa95f2d1b227..ac5200604091 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -51,7 +51,6 @@ int sepol_user_key_create(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_user_key_create)
 
 void sepol_user_key_unpack(const sepol_user_key_t * key, const char **name)
 {
@@ -59,7 +58,6 @@ void sepol_user_key_unpack(const sepol_user_key_t * key, const char **name)
 	*name = key->name;
 }
 
-hidden_def(sepol_user_key_unpack)
 
 int sepol_user_key_extract(sepol_handle_t * handle,
 			   const sepol_user_t * user,
@@ -115,7 +113,6 @@ int sepol_user_set_name(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_user_set_name)
 
 /* MLS */
 const char *sepol_user_get_mlslevel(const sepol_user_t * user)
@@ -124,7 +121,6 @@ const char *sepol_user_get_mlslevel(const sepol_user_t * user)
 	return user->mls_level;
 }
 
-hidden_def(sepol_user_get_mlslevel)
 
 int sepol_user_set_mlslevel(sepol_handle_t * handle,
 			    sepol_user_t * user, const char *mls_level)
@@ -141,7 +137,6 @@ int sepol_user_set_mlslevel(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_user_set_mlslevel)
 
 const char *sepol_user_get_mlsrange(const sepol_user_t * user)
 {
@@ -149,7 +144,6 @@ const char *sepol_user_get_mlsrange(const sepol_user_t * user)
 	return user->mls_range;
 }
 
-hidden_def(sepol_user_get_mlsrange)
 
 int sepol_user_set_mlsrange(sepol_handle_t * handle,
 			    sepol_user_t * user, const char *mls_range)
@@ -166,7 +160,6 @@ int sepol_user_set_mlsrange(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_user_set_mlsrange)
 
 /* Roles */
 int sepol_user_get_num_roles(const sepol_user_t * user)
@@ -207,7 +200,6 @@ int sepol_user_add_role(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_user_add_role)
 
 int sepol_user_has_role(const sepol_user_t * user, const char *role)
 {
@@ -220,7 +212,6 @@ int sepol_user_has_role(const sepol_user_t * user, const char *role)
 	return 0;
 }
 
-hidden_def(sepol_user_has_role)
 
 int sepol_user_set_roles(sepol_handle_t * handle,
 			 sepol_user_t * user,
@@ -292,7 +283,6 @@ int sepol_user_get_roles(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden_def(sepol_user_get_roles)
 
 void sepol_user_del_role(sepol_user_t * user, const char *role)
 {
@@ -330,7 +320,6 @@ int sepol_user_create(sepol_handle_t * handle, sepol_user_t ** user_ptr)
 	return STATUS_SUCCESS;
 }
 
-hidden_def(sepol_user_create)
 
 /* Deep copy clone */
 int sepol_user_clone(sepol_handle_t * handle,
@@ -386,4 +375,3 @@ void sepol_user_free(sepol_user_t * user)
 	free(user);
 }
 
-hidden_def(sepol_user_free)
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index a4008882b94b..d51750af3fa1 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -27,7 +27,6 @@
 #include <sepol/policydb/flask_types.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/util.h>
-#include <dso.h>
 
 struct val_to_name {
 	unsigned int val;
@@ -250,7 +249,7 @@ static inline int tokenize_str(char delim, char **str, char **ptr, size_t *len)
  * contain the remaining content of line_buf. If the delimiter is any whitespace
  * character, then all whitespace will be squashed.
  */
-int hidden tokenize(char *line_buf, char delim, int num_args, ...)
+int tokenize(char *line_buf, char delim, int num_args, ...)
 {
 	char **arg, *buf_p;
 	int rc, items;
-- 
2.17.1

