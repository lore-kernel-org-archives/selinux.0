Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911EEC2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5729A24125
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 16:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WCSQz6Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAUQZB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:25:01 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:47605 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUQZA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 11:25:00 -0500
X-EEMSG-check-017: 47896480|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="47896480"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 16:24:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579623897; x=1611159897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WO458gUW+tzGBrUBpbCgNQ11b3oxSnvVo+BjuTfgA58=;
  b=WCSQz6JeOAeqlv/rY8cpHdaKQ/WkAeeWQ7a6F6OngAuZ1dSSXddeWsk9
   jZteIy2/TjlnhJdBczWmGBSosEpVBl2mcCaI1vlq981iEWl+f7kUyEZsm
   hZKXVJmPFaALabHZUP2nkWHE/ywYBP8L6if797NKhk44mm78/3tYL4bBy
   h+mvSzsuZWwefMklMWRaycfeupoM7/oKhAGDumuR8FWLHnLsNobqx/cA0
   wypVR927ICw3k3DlJHncqQ+OEa4qfM/cQTpL2Rw9IjDxf/MOCk69hlZm3
   +y9B2nGRXhayIIMLVjsB3eseG330EqhlggZoxAlDzRODRvTAujCv+a87p
   A==;
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="32154759"
IronPort-PHdr: =?us-ascii?q?9a23=3AFzrGdRSwyeQgCtmVYG7Oku5pItpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYBKN2/xhgRfzUJnB7Loc0qyK6vymADxLscvJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HUrnZLdOhbxmNlLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcUMlRTShBCZ6iYYUJAeQKIOJUo5D9qlYKqBezAxSnCuHyxT9SnnL43bM03f?=
 =?us-ascii?q?kvHw/F2wIvEN0AvW/IoNj2LqoeTfq4wLXUwTjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EIEY0laTcK5463LE/io?=
 =?us-ascii?q?AfsVjDHyDqmEX2i7WadkM49eiz9+vreLDmpp6YN4NsiwH+NLohmtCnDOglPQ?=
 =?us-ascii?q?UDUHKX9OSh2LH540H0T6tGgucrnqXBtZDVP8Ubpqq3Aw9P1YYj7g6yDyy739?=
 =?us-ascii?q?QDhnQHMFJEdw6Hj4juIV3OJuv4Au2lj1Sjlzdr2ejKPqf9DZXVMnjDjLDhcK?=
 =?us-ascii?q?5m5E5dxwozytZf6olJBb4fO/3zW1X+tNrCAh8+KQy0zP7tCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvJsVCW4uIvIu+MZJIauTvmNfgl6ODhjWUjlV8eY6apx50XZ268Hvh8JE?=
 =?us-ascii?q?WZe3Xs0Z89FjIRsw4/SvH6oEONXCQVZHuoWa84oDYhB9GIF4DGE7uxjaSB0S?=
 =?us-ascii?q?HzJZhfYmRLGxjYCnvzX5mVUPcLLiSJK4lulSJSBuvpcJMoyRz77Fyy8LFgNO?=
 =?us-ascii?q?eBv3BJuA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BGAABuJSde/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWgGA?=
 =?us-ascii?q?QELAYF8gWwBIBIqjRWGZAEBBAaLJYolhSmBewkBAQEBAQEBAQEbHAEBhECCO?=
 =?us-ascii?q?DUIDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KYMoCwFGgVGCWww/glclrzozhUqDM?=
 =?us-ascii?q?oE+gTgBhzqEc3mBB4ERNoMbijcEjVyKHJdagkOCSZNcDBuadgEtqzIBN4FYK?=
 =?us-ascii?q?wgCGAghD4MnUBgNiA0XjkEjAzCOEQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Jan 2020 16:24:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LGO9Pg075212;
        Tue, 21 Jan 2020 11:24:09 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     bigon@debian.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: export flush_class_cache(), call it on policyload
Date:   Tue, 21 Jan 2020 11:25:32 -0500
Message-Id: <20200121162532.29494-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rename flush_class_cache() to selinux_flush_class_cache(), export it
for direct use by userspace policy enforcers, and call it on all policy
load notifications rather than only when using selinux_check_access().
This ensures that policy reloads that change a userspace class or
permission value will be reflected by subsequent string_to_security_class()
or string_to_av_perm() calls.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/include/selinux/selinux.h |  3 +++
 libselinux/src/avc_internal.c        |  2 ++
 libselinux/src/checkAccess.c         | 13 -------------
 libselinux/src/selinux_internal.h    |  3 +--
 libselinux/src/stringrep.c           |  4 +++-
 5 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fe46e681488d..7922d96b70c7 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -418,6 +418,9 @@ extern int security_av_string(security_class_t tclass,
 /* Display an access vector in a string representation. */
 extern void print_access_vector(security_class_t tclass, access_vector_t av);
 
+/* Flush the SELinux class cache, e.g. upon a policy reload. */
+extern void selinux_flush_class_cache(void);
+
 /* Set the function used by matchpathcon_init when displaying
    errors about the file_contexts configuration.  If not set,
    then this defaults to fprintf(stderr, fmt, ...). */
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 49cecc96daee..568a3d928ac1 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -23,6 +23,7 @@
 #include "callbacks.h"
 #include "selinux_netlink.h"
 #include "avc_internal.h"
+#include "selinux_internal.h"
 
 #ifndef NETLINK_SELINUX
 #define NETLINK_SELINUX 7
@@ -207,6 +208,7 @@ static int avc_netlink_process(void *buf)
 				avc_prefix, rc, errno);
 			return rc;
 		}
+		selinux_flush_class_cache();
 		rc = selinux_netlink_policyload(msg->seqno);
 		if (rc < 0)
 			return rc;
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 16bfcfb63f85..7227ffe51eac 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -10,25 +10,12 @@
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static int selinux_enabled;
 
-static int avc_reset_callback(uint32_t event __attribute__((unused)),
-		      security_id_t ssid __attribute__((unused)),
-		      security_id_t tsid __attribute__((unused)),
-		      security_class_t tclass __attribute__((unused)),
-		      access_vector_t perms __attribute__((unused)),
-		      access_vector_t *out_retained __attribute__((unused)))
-{
-	flush_class_cache();
-	return 0;
-}
-
 static void avc_init_once(void)
 {
 	selinux_enabled = is_selinux_enabled();
 	if (selinux_enabled == 1) {
 		if (avc_open(NULL, 0))
 			return;
-		avc_add_callback(avc_reset_callback, AVC_CALLBACK_RESET,
-				 0, 0, 0, 0);
 	}
 }
 
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 8b4bed2fd0d1..61b78aaa7c10 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -107,8 +107,7 @@ hidden_proto(selinux_trans_to_raw_context);
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 hidden_proto(selinux_reset_config);
-
-hidden void flush_class_cache(void);
+hidden_proto(selinux_flush_class_cache);
 
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 4db95398e138..29757b750878 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -158,7 +158,7 @@ err1:
 	return NULL;
 }
 
-hidden void flush_class_cache(void)
+void selinux_flush_class_cache(void)
 {
 	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
 	size_t i;
@@ -180,6 +180,8 @@ hidden void flush_class_cache(void)
 	discover_class_cache = NULL;
 }
 
+hidden_def(selinux_flush_class_cache)
+
 security_class_t string_to_security_class(const char *s)
 {
 	struct discover_class_node *node;
-- 
2.24.1

