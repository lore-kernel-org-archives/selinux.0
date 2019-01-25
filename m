Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF643C282C2
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6419218A2
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAYKHt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:07:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46136 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfAYKHt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 05:07:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so9579662wrt.13
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 02:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy8KcznAf9g6eSSxJbggh8BsOEGr4rIkQni41J/fxbM=;
        b=JQsHQE1IXD2qgGUREwdIeRrmVSMjFIhF01KUOVFMVJoZRFpEveo1yJrtEHG2afz2GD
         Ney5qGNmv7B2WDc5F8TIiJkNbS4mM5hxEkIg6kCfX+1cmdnN05nwhjYAkfInR7+rTqNF
         N1FeeSR5a7rRo04UtLvLNw3DQpV6lXxiPRNo31/duQnp5HrzkcMn5Mco1NA9op6Wh3lE
         a50MKIPfFlJu9l/maMox82wL3H21ycbPMwXxfcwjl7kbkD15framiBwHAHhYLarJd3G/
         PVro/rx8ua8mRSCNzGEZ3onzfsbEUmHZWH05UdriYuDFgbZ9d3WiLVzXHT8VS2JcSPyS
         HqJQ==
X-Gm-Message-State: AJcUukfWJ5fxg2Tpdi8QHuA4AzjYAZt1YQMyAKio/aIoIDFk+VDfF+n8
        kspjCAC5ccK/dzoVuzN2cQhOr3UN8mM=
X-Google-Smtp-Source: ALg8bN6vay93IIAa4SJ3ZEDR7pt5npMmZCPe8laERsx54xCLrhrLSR5GrnjN8D1hNFCwJSE/bgJq/g==
X-Received: by 2002:adf:a14d:: with SMTP id r13mr10354463wrr.169.1548410866471;
        Fri, 25 Jan 2019 02:07:46 -0800 (PST)
Received: from p600.fit.wifi.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id v6sm89155089wro.57.2019.01.25.02.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:07:45 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 1/4] selinux: inline some AVC functions used only once
Date:   Fri, 25 Jan 2019 11:06:48 +0100
Message-Id: <20190125100651.21753-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125100651.21753-1-omosnace@redhat.com>
References: <20190125100651.21753-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

avc_dump_av() and avc_dump_query() are each used only in one place. Get
rid of them and open code their contents in the call sites.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c | 140 +++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 82 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9b63d8ee1687..502162eeb3a0 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -129,75 +129,6 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
 	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
 }
 
-/**
- * avc_dump_av - Display an access vector in human-readable form.
- * @tclass: target security class
- * @av: access vector
- */
-static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
-{
-	const char **perms;
-	int i, perm;
-
-	if (av == 0) {
-		audit_log_format(ab, " null");
-		return;
-	}
-
-	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
-	perms = secclass_map[tclass-1].perms;
-
-	audit_log_format(ab, " {");
-	i = 0;
-	perm = 1;
-	while (i < (sizeof(av) * 8)) {
-		if ((perm & av) && perms[i]) {
-			audit_log_format(ab, " %s", perms[i]);
-			av &= ~perm;
-		}
-		i++;
-		perm <<= 1;
-	}
-
-	if (av)
-		audit_log_format(ab, " 0x%x", av);
-
-	audit_log_format(ab, " }");
-}
-
-/**
- * avc_dump_query - Display a SID pair and a class in human-readable form.
- * @ssid: source security identifier
- * @tsid: target security identifier
- * @tclass: target security class
- */
-static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
-			   u32 ssid, u32 tsid, u16 tclass)
-{
-	int rc;
-	char *scontext;
-	u32 scontext_len;
-
-	rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
-	if (rc)
-		audit_log_format(ab, "ssid=%d", ssid);
-	else {
-		audit_log_format(ab, "scontext=%s", scontext);
-		kfree(scontext);
-	}
-
-	rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
-	if (rc)
-		audit_log_format(ab, " tsid=%d", tsid);
-	else {
-		audit_log_format(ab, " tcontext=%s", scontext);
-		kfree(scontext);
-	}
-
-	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
-	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
-}
-
 /**
  * avc_init - Initialize the AVC.
  *
@@ -735,11 +666,37 @@ out:
 static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
-	audit_log_format(ab, "avc:  %s ",
-			 ad->selinux_audit_data->denied ? "denied" : "granted");
-	avc_dump_av(ab, ad->selinux_audit_data->tclass,
-			ad->selinux_audit_data->audited);
-	audit_log_format(ab, " for ");
+	struct selinux_audit_data *sad = ad->selinux_audit_data;
+	u32 av = sad->audited;
+	const char **perms;
+	int i, perm;
+
+	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
+
+	if (av == 0) {
+		audit_log_string(ab, " null");
+		return;
+	}
+
+	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
+	perms = secclass_map[sad->tclass-1].perms;
+
+	audit_log_string(ab, " {");
+	i = 0;
+	perm = 1;
+	while (i < (sizeof(av) * 8)) {
+		if ((perm & av) && perms[i]) {
+			audit_log_format(ab, " %s", perms[i]);
+			av &= ~perm;
+		}
+		i++;
+		perm <<= 1;
+	}
+
+	if (av)
+		audit_log_format(ab, " 0x%x", av);
+
+	audit_log_string(ab, " } for ");
 }
 
 /**
@@ -751,15 +708,34 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
-	audit_log_format(ab, " ");
-	avc_dump_query(ab, ad->selinux_audit_data->state,
-		       ad->selinux_audit_data->ssid,
-		       ad->selinux_audit_data->tsid,
-		       ad->selinux_audit_data->tclass);
-	if (ad->selinux_audit_data->denied) {
-		audit_log_format(ab, " permissive=%u",
-				 ad->selinux_audit_data->result ? 0 : 1);
+	struct selinux_audit_data *sad = ad->selinux_audit_data;
+	char *scontext;
+	u32 scontext_len;
+	int rc;
+
+	rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
+				     &scontext_len);
+	if (rc)
+		audit_log_format(ab, " ssid=%d", sad->ssid);
+	else {
+		audit_log_format(ab, " scontext=%s", scontext);
+		kfree(scontext);
 	}
+
+	rc = security_sid_to_context(sad->state, sad->tsid, &scontext,
+				     &scontext_len);
+	if (rc)
+		audit_log_format(ab, " tsid=%d", sad->tsid);
+	else {
+		audit_log_format(ab, " tcontext=%s", scontext);
+		kfree(scontext);
+	}
+
+	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
+	audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
+
+	if (sad->denied)
+		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
 }
 
 /* This is the slow part of avc audit with big stack footprint */
-- 
2.20.1

