Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB27C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E7F2087E
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA1XRH/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgD0UXp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgD0UXp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90CC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so7405479plk.10
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kji8lSzPW87/KBKeOqpyZj6X7Z0zVGICZCNCndAUJME=;
        b=eA1XRH/XQ/3O2fLyuotixAi5i29aJAazJQT96jGoxCT1soFH2lkLXqMY/J/7W0xlMc
         YNP/yGU/YnYtSYOk+mujLyK3iSHL899S0H/FO7CdUIMOjy6RRSruQ40n7a7stYzvLfhR
         3sgSL/NicXO23lemRyxkv9Ucx4Gr/N2X5M35B27PCIcgiYtlP6cEOd0Xd+EHxcbwfGyA
         zsOekwBu05L6fgLbJqHM/b0hjw7AZ43Cn88ZJXglafUbHVh8aboR0oD+T4Doq7/YnMHh
         kf+aG9ZqjQ42ipiySEUr0X0g76KQREVKVW+Vtl4lnWHPIoVjXij7kLxKAHYMXnZpwntM
         S+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kji8lSzPW87/KBKeOqpyZj6X7Z0zVGICZCNCndAUJME=;
        b=hVPLAvUbMk6UJyR/8r1E8WNjejVTBulnk0F8aL/PKXfytDHH5dtGezWpn7C1MI0ab2
         skHt5w2ZeCQvFai75cnZZ8Zx9Nfwa6NLT+xNpKkBB59U3Zf1VPD2DxYAG7AOuzCqb4ue
         kyWoKEZHlfOX5G3HzpxE1vnX0E2dlg1b2y+bhVjZ5JR/uUlBZZsYuRdzvJNH04ohchMj
         ByhEpns4m5V/qJUvDKWS+BGz2BQlj1AWfvToiROuLEo38XMTUqaKmxzIvTKFXgGw1C8e
         qyz6lBDdROBpbs0Ou16nxpDy5BS+qfWb1HyRjrqq9doiW5k2Cp5U8nfuNblXLVBOCIxo
         DY+g==
X-Gm-Message-State: AGi0PubkemeG4QC98wsO25C+FS6Xko+O2FZjuO4locaqvTOiMgON10lY
        lAjSfOwLESyQwmGjyUro24Q=
X-Google-Smtp-Source: APiQypKrZuCyuPhsw/t2FtK57EejtN6//nqS7MeTL8mQfSGY6KCpRS1KLjzLu6esMTAt29onPewFdw==
X-Received: by 2002:a17:90b:3843:: with SMTP id nl3mr557471pjb.72.1588019024633;
        Mon, 27 Apr 2020 13:23:44 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:44 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 13/18] avc: create internal avc_init interface
Date:   Mon, 27 Apr 2020 15:23:10 -0500
Message-Id: <20200427202315.4943-14-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Now that avc_init is marked deprecated, create an avc_init2 interface
for internal users.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/avc.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index ab10b0f9f1cb..b4648b2de170 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -145,22 +145,7 @@ int avc_get_initial_sid(const char * name, security_id_t * sid)
 	return rc;
 }
 
-int avc_open(struct selinux_opt *opts, unsigned nopts)
-{
-	avc_setenforce = 0;
-
-	while (nopts--)
-		switch(opts[nopts].type) {
-		case AVC_OPT_SETENFORCE:
-			avc_setenforce = 1;
-			avc_enforcing = !!opts[nopts].value;
-			break;
-		}
-
-	return avc_init("avc", NULL, NULL, NULL, NULL);
-}
-
-int avc_init(const char *prefix,
+static int avc_init_internal(const char *prefix,
 	     const struct avc_memory_callback *mem_cb,
 	     const struct avc_log_callback *log_cb,
 	     const struct avc_thread_callback *thread_cb,
@@ -246,6 +231,30 @@ int avc_init(const char *prefix,
 	return rc;
 }
 
+int avc_open(struct selinux_opt *opts, unsigned nopts)
+{
+	avc_setenforce = 0;
+
+	while (nopts--)
+		switch(opts[nopts].type) {
+		case AVC_OPT_SETENFORCE:
+			avc_setenforce = 1;
+			avc_enforcing = !!opts[nopts].value;
+			break;
+		}
+
+	return avc_init_internal("avc", NULL, NULL, NULL, NULL);
+}
+
+int avc_init(const char *prefix,
+	     const struct avc_memory_callback *mem_cb,
+	     const struct avc_log_callback *log_cb,
+	     const struct avc_thread_callback *thread_cb,
+	     const struct avc_lock_callback *lock_cb)
+{
+	return avc_init_internal(prefix, mem_cb, log_cb, thread_cb, lock_cb);
+}
+
 void avc_cache_stats(struct avc_cache_stats *p)
 {
 	memcpy(p, &cache_stats, sizeof(cache_stats));
-- 
2.17.1

