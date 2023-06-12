Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27414C7EE2E
	for <selinux@archiver.kernel.org>; Mon, 12 Jun 2023 09:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjFLJnv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFLJnT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jun 2023 05:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B37EC8
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFos/X//uKuniYz2qpcbAbf8WpJsZ1+fegHxhjw+UC8=;
        b=N59yYERohX+6oBX5R9Nv4WsIxAdiWuSvjRhki3on4qQORvEhRlBwmrkRL6hd9Ly4qJBMHx
        JlurEXi92SOO0W5biMSdP0xgSVsNVfocMyfk8zMcq92yW4Lzdlc9ejLLFpebnAeH9I0KpL
        iQyf5jQ9VeQ4FDkIi4PlMd/h206pzSo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-PwaGdbQ9MLetLMLSTFaHiw-1; Mon, 12 Jun 2023 05:31:12 -0400
X-MC-Unique: PwaGdbQ9MLetLMLSTFaHiw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-974566553ccso478580966b.3
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562270; x=1689154270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFos/X//uKuniYz2qpcbAbf8WpJsZ1+fegHxhjw+UC8=;
        b=Unk8nubFBdbB6QBwoydq9WupMR5mEwR9PUu4fxwRkEsmsHtZxOK6hddZkYmOh7/+hL
         1RClkaX2DTWaxzf0sKVy/3KLVTf1hfR8Ao9YeSPxc1/fqj5Kf8QIvsZ/UYbKft/pWg7V
         FL8ls54WDijT1piI7q9HLQ5Gwv66qgMEe9pPa2xvfCpcWq+myKpoCvSocW+f3k0OD+m2
         YZeACiP8vfMRMa4Y+MA+gW7g6yXdPNjUMIWESrZE1hWMNgN/1M8BaWi9LGNE2BWU1zMP
         onx9lORTuJySnWMZeKYcmjFY2BpoVItwEKswMIrCF94kj69vfnxvdSWv4uNR1gaM/pmE
         e/8A==
X-Gm-Message-State: AC+VfDyrxi/3q9v8++4QyQgJd0ADDfMuRGb5J3PIO3LDXkgYRC3+fR6a
        oqJCiSkl17JIO2xt/d+cV2poMEe9+6JNYdhze1oOhaSO3KK4ea3oUxZJq+54J6fQhApCl6iGGUH
        vucXbNKW8TfE3Gfufu09zCzSkfGhHejbKpLUMRFsybG1oqKcIvTyriVon/Hem3oBUT4Kpj9YETo
        0d+hsT
X-Received: by 2002:a17:907:928e:b0:974:1eb9:f74e with SMTP id bw14-20020a170907928e00b009741eb9f74emr9780757ejc.3.1686562270625;
        Mon, 12 Jun 2023 02:31:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Mvuuk1fE1UXI5bci1N1gLY593qZlCyYaWN0VThRmSDUeu9tfVCIFQZevtRzIpA8UEsqPK7A==
X-Received: by 2002:a17:907:928e:b0:974:1eb9:f74e with SMTP id bw14-20020a170907928e00b009741eb9f74emr9780736ejc.3.1686562270177;
        Mon, 12 Jun 2023 02:31:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906a28800b009655eb8be26sm4958000ejz.73.2023.06.12.02.31.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:31:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 1/2] libsepol: stop translating deprecated intial SIDs to strings
Date:   Mon, 12 Jun 2023 11:31:06 +0200
Message-Id: <20230612093107.1066410-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612093107.1066410-1-omosnace@redhat.com>
References: <20230612093107.1066410-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Many of the initial SIDs are no longer used by the kernel, so
translating them to the legacy names doesn't bring much value. Clear the
legacy names from the table and let the code translate them to the
fallback "unknown" names instead.

Note that this only affects the generated text output when converting
policies from binary to text form. The text policy languages let the
policy define its own names for the initial SIDs based on the order in
which they are declared, so the table is never used to convert from name
to SID. Thus this is just a cosmetic change and has no functional
impact.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/kernel_to_cil.c    |  4 ++--
 libsepol/src/kernel_to_common.h | 36 ++++++++++++++++-----------------
 libsepol/src/kernel_to_conf.c   |  4 ++--
 libsepol/src/module_to_cil.c    |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index e9cd89c2..bd04c087 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -567,7 +567,7 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		if (i < num_sids) {
+		if (i < num_sids && sid_to_str[i]) {
 			sid = (char *)sid_to_str[i];
 		} else {
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
@@ -2577,7 +2577,7 @@ static int write_sid_context_rules_to_cil(FILE *out, struct policydb *pdb, const
 
 	for (isid = pdb->ocontexts[0]; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		if (i < num_sids) {
+		if (i < num_sids && sid_to_str[i]) {
 			sid = (char *)sid_to_str[i];
 		} else {
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 159c4289..6073ff3a 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -13,33 +13,33 @@
 // initial sid names aren't actually stored in the pp files, need to a have
 // a mapping, taken from the linux kernel
 static const char * const selinux_sid_to_str[] = {
-	"null",
+	NULL,
 	"kernel",
 	"security",
 	"unlabeled",
-	"fs",
+	NULL,
 	"file",
-	"file_labels",
-	"init",
+	NULL,
+	NULL,
 	"any_socket",
 	"port",
 	"netif",
 	"netmsg",
 	"node",
-	"igmp_packet",
-	"icmp_socket",
-	"tcp_socket",
-	"sysctl_modprobe",
-	"sysctl",
-	"sysctl_fs",
-	"sysctl_kernel",
-	"sysctl_net",
-	"sysctl_net_unix",
-	"sysctl_vm",
-	"sysctl_dev",
-	"kmod",
-	"policy",
-	"scmp_packet",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
 	"devnull",
 };
 
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index c48a7114..3be87184 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -464,7 +464,7 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		if (i < num_sids) {
+		if (i < num_sids && sid_to_str[i]) {
 			sid = (char *)sid_to_str[i];
 		} else {
 			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
@@ -2445,7 +2445,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
 
 	for (isid = pdb->ocontexts[0]; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		if (i < num_sids) {
+		if (i < num_sids && sid_to_str[i]) {
 			sid = (char *)sid_to_str[i];
 		} else {
 			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index e7bc6ee6..a46775ca 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2549,7 +2549,7 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		if (i < num_sids) {
+		if (i < num_sids && sid_to_string[i]) {
 			sid = (char*)sid_to_string[i];
 		} else {
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
-- 
2.40.1

