Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44780C4338F
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 10:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275A36023D
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhHIKwm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Aug 2021 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhHIKwl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Aug 2021 06:52:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798EEC061798
        for <selinux@vger.kernel.org>; Mon,  9 Aug 2021 03:52:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id yk17so28093917ejb.11
        for <selinux@vger.kernel.org>; Mon, 09 Aug 2021 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=26jkPL6BJnMb2W2E5wauYB6hl/AYTw6gVBuaalt2rj0=;
        b=gy/6hT8fy9tiXiuHsQ9EstnxQDX32pGW1DpDUUmmONDKSngj/liDhaUQaMsbFUSoPK
         YT4dZ5pxO8UzpbxLDWD1WMHaGW+H/rOgUu63z7HqskZ4VjG863dB7dhtejLgQfeA1MHT
         hJa3ELKPqubxXtDDf/fHMcFRkD4Bn0Uis3KoBEUv94pLRpjHi4slBDs51XUvvchEuhqI
         fCvdQs/yr6WjG+KxhlfgG42hZEOG6xIuU9kExuDk6XLirqre+K59FKklWl20oVA3iJMC
         Gue21kRXAgQj/GHq5FigQelgQajjlgHSo0daYWk07RESB8VbEbEcz+POsvsGYjjXeFNH
         QMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26jkPL6BJnMb2W2E5wauYB6hl/AYTw6gVBuaalt2rj0=;
        b=L59zig7CZCc8d4uy2+TVRsQJYsnHaLcZi/h1/zpHT8lE2ll+d5U5lf1JlWaCWI4X+O
         6oFwR34XxwXA+l9eh2XRJNGEx/iJgiMEaTP1EeKWfCP8Sqp+v9nRR2K0I0pw6lh8BSMw
         6sBkGlA7msYBjEhhvd25+6R9dCt1fPbvyXnnWoPs78yBulAUpgbkC5jAeUc9aYZiBxzH
         1uJueKrvdy5iAossmr3swWXw+3j/SfWQX88Z0XjtsMIH/atR6YY/JjrhQBR4y+q1UFAs
         8HUj2EL13knMTp0Pvbqk3/rMItsHhxn1B7a4yJHI1/ZLv9otJVF5k/y5kzu2oULHOoqm
         wkJw==
X-Gm-Message-State: AOAM532JasWlDKVPunmtxE94+4/M/1IB2cozuTD20PANsomU9P/rCT0M
        2f4c3eB+QQUXDLGt6gliDaCjNRWk1N848A==
X-Google-Smtp-Source: ABdhPJwKNzQoxtb4WPKyB78RVEMuYesGORJG950NssmRU6I8yeUdQ1RdPxfKBgGw35Tbwxl0JQYsxw==
X-Received: by 2002:a17:906:616:: with SMTP id s22mr21908101ejb.210.1628506339019;
        Mon, 09 Aug 2021 03:52:19 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-178-135.77.3.pool.telefonica.de. [77.3.178.135])
        by smtp.gmail.com with ESMTPSA id x20sm2302090ejb.100.2021.08.09.03.52.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 03:52:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/2] libsepol: replace strerror by %m
Date:   Mon,  9 Aug 2021 12:52:09 +0200
Message-Id: <20210809105209.12705-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809105209.12705-1-cgzones@googlemail.com>
References: <20210809105209.12705-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The standard function `strerror(3)` is not thread safe.  This does not
only affect the concurrent usage of libselinux itself but also with
other `strerror(3)` linked libraries.
Use the thread safe GNU extension format specifier `%m`[1].

libselinux already uses the GNU extension format specifier `%ms`.

[1]: https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conversions.html

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ibpkey_record.c  |  7 +++----
 libsepol/src/kernel_to_cil.c  | 11 +++++------
 libsepol/src/kernel_to_conf.c | 11 +++++------
 libsepol/src/module.c         |  8 ++++++--
 libsepol/src/module_to_cil.c  | 11 +++++------
 libsepol/src/node_record.c    | 10 ++++------
 libsepol/src/services.c       |  2 +-
 7 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/libsepol/src/ibpkey_record.c b/libsepol/src/ibpkey_record.c
index 6f7aa656..d95e95fe 100644
--- a/libsepol/src/ibpkey_record.c
+++ b/libsepol/src/ibpkey_record.c
@@ -38,8 +38,8 @@ static int ibpkey_parse_subnet_prefix(sepol_handle_t *handle,
 	struct in6_addr in_addr;
 
 	if (inet_pton(AF_INET6, subnet_prefix_str, &in_addr) <= 0) {
-		ERR(handle, "could not parse IPv6 address for ibpkey subnet prefix %s: %s",
-		    subnet_prefix_str, strerror(errno));
+		ERR(handle, "could not parse IPv6 address for ibpkey subnet prefix %s: %m",
+		    subnet_prefix_str);
 		return STATUS_ERR;
 	}
 
@@ -64,8 +64,7 @@ static int ibpkey_expand_subnet_prefix(sepol_handle_t *handle,
 	if (inet_ntop(AF_INET6, &addr, subnet_prefix_str,
 		      INET6_ADDRSTRLEN) == NULL) {
 		ERR(handle,
-		    "could not expand IPv6 address to string: %s",
-		    strerror(errno));
+		    "could not expand IPv6 address to string: %m");
 		return STATUS_ERR;
 	}
 
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 336d53b0..81427e65 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2779,13 +2779,13 @@ static int write_selinux_node_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (node = pdb->ocontexts[4]; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2819,13 +2819,13 @@ static int write_selinux_node6_rules_to_cil(FILE *out, struct policydb *pdb)
 
 	for (node = pdb->ocontexts[6]; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET6, &node->u.node6.addr, addr, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET6, &node->u.node6.mask, mask, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2867,8 +2867,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
 
 		if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
 			      subnet_prefix_str, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("ibpkeycon subnet_prefix is invalid: %s",
-				      strerror(errno));
+			sepol_log_err("ibpkeycon subnet_prefix is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index cb8e1380..179f0ad1 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2652,13 +2652,13 @@ static int write_selinux_node_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (node = pdb->ocontexts[4]; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2693,13 +2693,13 @@ static int write_selinux_node6_rules_to_conf(FILE *out, struct policydb *pdb)
 
 	for (node6 = pdb->ocontexts[6]; node6 != NULL; node6 = node6->next) {
 		if (inet_ntop(AF_INET6, &node6->u.node6.addr, addr, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon address is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET6, &node6->u.node6.mask, mask, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("Nodecon mask is invalid: %s", strerror(errno));
+			sepol_log_err("Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2741,8 +2741,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
 
 		if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
 			      subnet_prefix_str, INET6_ADDRSTRLEN) == NULL) {
-			sepol_log_err("ibpkeycon address is invalid: %s",
-				      strerror(errno));
+			sepol_log_err("ibpkeycon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 9b53bc47..02a5de2c 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -796,7 +796,9 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
 
 			len = le32_to_cpu(buf[0]);
 			if (str_read(name, file, len)) {
-				ERR(file->handle, "%s", strerror(errno));
+				ERR(file->handle,
+				    "cannot read module name (at section %u): %m",
+				    i);
 				goto cleanup;
 			}
 
@@ -809,7 +811,9 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
 			}
 			len = le32_to_cpu(buf[0]);
 			if (str_read(version, file, len)) {
-				ERR(file->handle, "%s", strerror(errno));
+				ERR(file->handle,
+				    "cannot read module version (at section %u): %m",
+				i);
 				goto cleanup;
 			}
 			seen |= SEEN_MOD;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 21d8e5db..9c7e3d3a 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2668,8 +2668,7 @@ static int ocontext_selinux_ibpkey_to_cil(struct policydb *pdb,
 
 		if (inet_ntop(AF_INET6, &subnet_prefix.s6_addr,
 			      subnet_prefix_str, INET6_ADDRSTRLEN) == NULL) {
-			log_err("ibpkeycon subnet_prefix is invalid: %s",
-				strerror(errno));
+			log_err("ibpkeycon subnet_prefix is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2714,13 +2713,13 @@ static int ocontext_selinux_node_to_cil(struct policydb *pdb, struct ocontext *n
 
 	for (node = nodes; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET, &node->u.node.addr, addr, INET_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon address is invalid: %s", strerror(errno));
+			log_err("Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET, &node->u.node.mask, mask, INET_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon mask is invalid: %s", strerror(errno));
+			log_err("Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
@@ -2746,13 +2745,13 @@ static int ocontext_selinux_node6_to_cil(struct policydb *pdb, struct ocontext *
 
 	for (node = nodes; node != NULL; node = node->next) {
 		if (inet_ntop(AF_INET6, &node->u.node6.addr, addr, INET6_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon address is invalid: %s", strerror(errno));
+			log_err("Nodecon address is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
 
 		if (inet_ntop(AF_INET6, &node->u.node6.mask, mask, INET6_ADDRSTRLEN) == NULL) {
-			log_err("Nodecon mask is invalid: %s", strerror(errno));
+			log_err("Nodecon mask is invalid: %m");
 			rc = -1;
 			goto exit;
 		}
diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
index 9ef429da..2e575bf1 100644
--- a/libsepol/src/node_record.c
+++ b/libsepol/src/node_record.c
@@ -53,7 +53,7 @@ static int node_parse_addr(sepol_handle_t * handle,
 
 			if (inet_pton(AF_INET, addr_str, &in_addr) <= 0) {
 				ERR(handle, "could not parse IPv4 address "
-				    "%s: %s", addr_str, strerror(errno));
+				    "%s: %m", addr_str);
 				return STATUS_ERR;
 			}
 
@@ -66,7 +66,7 @@ static int node_parse_addr(sepol_handle_t * handle,
 
 			if (inet_pton(AF_INET6, addr_str, &in_addr) <= 0) {
 				ERR(handle, "could not parse IPv6 address "
-				    "%s: %s", addr_str, strerror(errno));
+				    "%s: %m", addr_str);
 				return STATUS_ERR;
 			}
 
@@ -147,8 +147,7 @@ static int node_expand_addr(sepol_handle_t * handle,
 				      INET_ADDRSTRLEN) == NULL) {
 
 				ERR(handle,
-				    "could not expand IPv4 address to string: %s",
-				    strerror(errno));
+				    "could not expand IPv4 address to string: %m");
 				return STATUS_ERR;
 			}
 			break;
@@ -163,8 +162,7 @@ static int node_expand_addr(sepol_handle_t * handle,
 				      INET6_ADDRSTRLEN) == NULL) {
 
 				ERR(handle,
-				    "could not expand IPv6 address to string: %s",
-				    strerror(errno));
+				    "could not expand IPv6 address to string: %m");
 				return STATUS_ERR;
 			}
 			break;
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 47a3dc14..673b3971 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -145,7 +145,7 @@ int sepol_set_policydb_from_file(FILE * fp)
 	}
 	if (policydb_read(&mypolicydb, &pf, 0)) {
 		policydb_destroy(&mypolicydb);
-		ERR(NULL, "can't read binary policy: %s", strerror(errno));
+		ERR(NULL, "can't read binary policy: %m");
 		return -1;
 	}
 	policydb = &mypolicydb;
-- 
2.32.0

