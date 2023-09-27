Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50ACE82CC8
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjI0TAj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjI0TAg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37533F9
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-417f2a1e98cso62919151cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841229; x=1696446029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytbgL25fdIq4KoxWnlSy+v+7erX3EDLe1aT130lWDJY=;
        b=hrhotFopg7N+7FQwIzkT0Aj6x51uwvegJvQf5elsV6pDkYJ2uNkemfioX7085kIRV9
         xfEffmTSl+MUTJ2UAKSnZD70jVZu1QgfjSaV0K7k36/4rywH6r3bglYXlahQHsO7LdEl
         RtNGO8aY+SVxwt7AELA/adWLng5f6TXPWJqQQAJP+3QVcrjkQvkTyMC4FfEDmVTh+GNS
         DlwLk1b2B4xMsTct+PqZRHkuqYI/3UWFAh0Se53DpHUFTtBtyoVVR0gUYjwFhuZQwpME
         m6edpOnrluR3rN4aGQjxtG5vIoahmBUYjAuJ9KWTdylmt0jOn4ZPxPovu2RSM2Lns9s9
         RRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841229; x=1696446029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytbgL25fdIq4KoxWnlSy+v+7erX3EDLe1aT130lWDJY=;
        b=bIoxbroBZynqRB7lnl5KvnneTm3uXBWjsJf6nEHGVyEXF4yKm4wO9BsjxmbjhvN8zW
         piSWDav8wg28EWu5FL6RGM5B/I8Ayogf8NSbN13BLPjRTWbQT6Sgr5xozj5Hvj0whgpD
         afLZv1+0MDrCqEUcOItaAYaq7LCdvupdSRzkm46qrYareBoWyYYYtHZ/k9TbkPIHoIxL
         PJmVaVD/24/2c4sDNLD0cmsKhqn9x7bIbAbrXvnR82iQcay7MvCxpDhvlUiziVk3wGrC
         f6gE0yKSGqmTjVS8nFD7TTBfhIbtfUlQr2ewMBfzmxC3066pYRbyiAbhNXNQ4CkwuWSj
         RLdw==
X-Gm-Message-State: AOJu0YzVIA/SPgMOaXJIlIPaWB56Gmrrwsgwnq96sujiIREX318uUv5l
        SSOk03y+SWCbfH5E9oyX/tdvc6TSJSs=
X-Google-Smtp-Source: AGHT+IEz6wyGQ+rhXWjQOSenc8CnpGY5qLKDXXEb94FOpbJzcGYpOB8Bdd9IxudvtIb/LnhPIP7ABw==
X-Received: by 2002:a05:622a:1ba0:b0:419:50c7:f6e9 with SMTP id bp32-20020a05622a1ba000b0041950c7f6e9mr2420233qtb.25.1695841228645;
        Wed, 27 Sep 2023 12:00:28 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:28 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/9] libsepol/cil: Allow IP address and mask values to be directly written
Date:   Wed, 27 Sep 2023 15:00:15 -0400
Message-ID: <20230927190021.1164278-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The nodecon statement requires that the IP address and mask values be
enclosed in parentheses so that these values can be distinguished from
named IP addresses. But since an identifier in CIL cannot start with a
number or contain colons, the parentheses are not really required.

Allow IP address and mask values to be written directly and do not
require (but still allow) parentheses around them. Distinguish
between an address or mask and an identifier by checking if the
first character is a number or if the string contains a colon.

Both of these are now valid:
  (nodecon (10.0.0.1) (255.255.255.0) (USER ROLE TYPE ((SENS) (SENS))))
  (nodecon 10.0.0.1 255.255.255.0 (USER ROLE TYPE ((SENS) (SENS))))

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 42 +++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index efe1601c..fa7148b0 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4387,26 +4387,42 @@ int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 
 	cil_nodecon_init(&nodecon);
 
-	if (parse_current->next->cl_head == NULL ) {
-		nodecon->addr_str = parse_current->next->data;
-	} else {
+	if (parse_current->next->cl_head) {
 		cil_ipaddr_init(&nodecon->addr);
-
 		rc = cil_fill_ipaddr(parse_current->next->cl_head, nodecon->addr);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
+	} else {
+		char *addr = parse_current->next->data;
+		if (strchr(addr, ':') || (strchr(addr, '.') && isdigit(addr[0]))) {
+			cil_ipaddr_init(&nodecon->addr);
+			rc = cil_fill_ipaddr(parse_current->next, nodecon->addr);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		} else {
+			nodecon->addr_str = addr;
+		}
 	}
 
-	if (parse_current->next->next->cl_head == NULL ) {
-		nodecon->mask_str = parse_current->next->next->data;
-	} else {
+	if (parse_current->next->next->cl_head) {
 		cil_ipaddr_init(&nodecon->mask);
-
 		rc = cil_fill_ipaddr(parse_current->next->next->cl_head, nodecon->mask);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
+	} else {
+		char *mask = parse_current->next->next->data;
+		if (strchr(mask, ':') || (strchr(mask, '.') && isdigit(mask[0]))) {
+			cil_ipaddr_init(&nodecon->mask);
+			rc = cil_fill_ipaddr(parse_current->next->next, nodecon->mask);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+		} else {
+			nodecon->mask_str = mask;
+		}
 	}
 
 	if (parse_current->next->next->next->cl_head == NULL ) {
@@ -5584,15 +5600,19 @@ exit:
 int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 {
 	int rc = SEPOL_ERR;
+	char *addr_str;
 
 	if (addr_node == NULL || addr_node->data == NULL || addr == NULL) {
 		goto exit;
 	}
 
-	if (strchr(addr_node->data, ':') != NULL) {
+	addr_str = addr_node->data;
+	if (strchr(addr_str, ':')) {
 		addr->family = AF_INET6;
-	} else {
+	} else if (strchr(addr_str, '.') && isdigit(addr_str[0])) {
 		addr->family = AF_INET;
+	} else {
+		goto exit;
 	}
 
 	rc = inet_pton(addr->family, addr_node->data, &addr->ip);
@@ -5604,7 +5624,7 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Bad ip address or netmask: %s\n", (addr_node && addr_node->data) ? (const char *)addr_node->data : "n/a");
+	cil_log(CIL_ERR, "Bad ip address or netmask: %s\n", (addr_node && addr_node->data) ? (const char *)addr_node->data : "NULL");
 	return rc;
 }
 
-- 
2.41.0

