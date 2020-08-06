Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D5C47424
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DF722D37
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDH0SpBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgHFIGF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHFIFQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 04:05:16 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD8C06179E
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 01:04:28 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id lg2so13408349ejb.23
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 01:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=mOjwTlI4LaDoFAqHd/CEHg0Dqi+LihgQr+xeS1gXpis=;
        b=tDH0SpBJOVvaIUzPtmVuxUqyvnBSUCyMqFtYcMgVXHcDWUdJhLlmnBIESBCuGGSaNx
         AaAhbxZ2UhI28l81X3oB1EvwtIp1jgDi94nEgfOaNF2GVnHSpfYzELKPV5+2zEWAYCTr
         TWUkhoUsSXqNwPDg7Z0DUPSWlbins9V/M57xz4QQrPSG5eKVSJG22crM5gBg2HjWWM9P
         T34JtrSBzKMDvT7G6B0UvX+2439Pcg3AYzBn+vjjcorqRMI96vNu7DyKJvdF2Tb8bwDn
         HExshd30yG8HkERycM93BJ3soZw0kipbgYCmreSVmwsjTEAMxNuA1GUZBMwXXeXQlpoA
         P4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=mOjwTlI4LaDoFAqHd/CEHg0Dqi+LihgQr+xeS1gXpis=;
        b=IA5jlSaIGYTUV4XdWdB19RUX6pdB4zyqwiGgvVE2ewSArxSxAm+fns1aKRj9Mlatul
         x90hm20YCroqyKoCC0/VRwlEdhqK0boohZO9V+5Re0c3vxgUVvDwSOUTZ7OLGnHnS3Ga
         EMuG5CfkolZBRd6vNbkDeJAAaqK6eZQA1ftiHPtJXUMw84EUdnfG+n4s1Uwq+odJ7B44
         kySHRohg4TnTzJZ75j6SSajq1G3n3MsjGJK1NnEgQKs0n3OglZrovlQuqOfYl3FfwDb9
         RgVdG5yBQIdO/y7NH3gbjhAdCwoHlRpBTcL5MpAzd7RE8oRx1+AYrQLZwRoQYef8QO32
         eySw==
X-Gm-Message-State: AOAM531w8UlsQo5Wv/9Bnv5cAWW6VWjoJjwC00ID1JtZu8zD7TT52qbc
        geSLh0F4/BSTVu2m73CbN312OH0ZTA==
X-Google-Smtp-Source: ABdhPJw7+h3SDa+sB/Btd5MvQIu+UhCAl+l3KSnK/otVP3qHgJoDEOH9thLaoxF8EfWtBx/+v1vbL4HEQg==
X-Received: by 2002:a05:6402:297:: with SMTP id l23mr2957498edv.145.1596701065565;
 Thu, 06 Aug 2020 01:04:25 -0700 (PDT)
Date:   Thu,  6 Aug 2020 10:03:42 +0200
In-Reply-To: <20200806080358.3124505-1-tweek@google.com>
Message-Id: <20200806080358.3124505-2-tweek@google.com>
Mime-Version: 1.0
References: <20200806080358.3124505-1-tweek@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 2/2] selinux: add attributes to avc tracepoint
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Peter Enderborg <peter.enderborg@sony.com>

Add further attributes to filter the trace events from AVC.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 include/trace/events/avc.h | 41 ++++++++++++++++++++++++++++----------
 security/selinux/avc.c     | 22 +++++++++++---------
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index 07c058a9bbcd..ac5ef2e1c2c5 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Author: Thi=C3=A9baud Weksteen <tweek@google.com>
+ * Authors:	Thi=C3=A9baud Weksteen <tweek@google.com>
+ *		Peter Enderborg <Peter.Enderborg@sony.com>
  */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM avc
@@ -12,23 +13,43 @@
=20
 TRACE_EVENT(selinux_audited,
=20
-	TP_PROTO(struct selinux_audit_data *sad),
+	TP_PROTO(struct selinux_audit_data *sad,
+		char *scontext,
+		char *tcontext,
+		const char *tclass
+	),
=20
-	TP_ARGS(sad),
+	TP_ARGS(sad, scontext, tcontext, tclass),
=20
 	TP_STRUCT__entry(
-		__field(unsigned int, tclass)
-		__field(unsigned int, audited)
+		__field(u32, requested)
+		__field(u32, denied)
+		__field(u32, audited)
+		__field(int, result)
+		__string(scontext, scontext)
+		__string(tcontext, tcontext)
+		__string(tclass, tclass)
+		__field(u32, ssid)
+		__field(u32, tsid)
 	),
=20
 	TP_fast_assign(
-		__entry->tclass =3D sad->tclass;
-		__entry->audited =3D sad->audited;
+		__entry->requested	=3D sad->requested;
+		__entry->denied		=3D sad->denied;
+		__entry->audited	=3D sad->audited;
+		__entry->result		=3D sad->result;
+		__entry->ssid		=3D sad->ssid;
+		__entry->tsid		=3D sad->tsid;
+		__assign_str(tcontext, tcontext);
+		__assign_str(scontext, scontext);
+		__assign_str(tclass, tclass);
 	),
=20
-	TP_printk("tclass=3D%u audited=3D%x",
-		__entry->tclass,
-		__entry->audited)
+	TP_printk("requested=3D0x%x denied=3D0x%x audited=3D0x%x result=3D%d ssid=
=3D%u tsid=3D%u scontext=3D%s tcontext=3D%s tclass=3D%s",
+		__entry->requested, __entry->denied, __entry->audited, __entry->result,
+		__entry->ssid, __entry->tsid, __get_str(scontext), __get_str(tcontext),
+		__get_str(tclass)
+	)
 );
=20
 #endif
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b0a0af778b70..7de5cc5169af 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -705,35 +705,39 @@ static void avc_audit_post_callback(struct audit_buff=
er *ab, void *a)
 {
 	struct common_audit_data *ad =3D a;
 	struct selinux_audit_data *sad =3D ad->selinux_audit_data;
-	char *scontext;
+	char *scontext =3D NULL;
+	char *tcontext =3D NULL;
+	const char *tclass =3D NULL;
 	u32 scontext_len;
+	u32 tcontext_len;
 	int rc;
=20
-	trace_selinux_audited(sad);
-
 	rc =3D security_sid_to_context(sad->state, sad->ssid, &scontext,
 				     &scontext_len);
 	if (rc)
 		audit_log_format(ab, " ssid=3D%d", sad->ssid);
 	else {
 		audit_log_format(ab, " scontext=3D%s", scontext);
-		kfree(scontext);
 	}
=20
-	rc =3D security_sid_to_context(sad->state, sad->tsid, &scontext,
-				     &scontext_len);
+	rc =3D security_sid_to_context(sad->state, sad->tsid, &tcontext,
+				     &tcontext_len);
 	if (rc)
 		audit_log_format(ab, " tsid=3D%d", sad->tsid);
 	else {
-		audit_log_format(ab, " tcontext=3D%s", scontext);
-		kfree(scontext);
+		audit_log_format(ab, " tcontext=3D%s", tcontext);
 	}
=20
-	audit_log_format(ab, " tclass=3D%s", secclass_map[sad->tclass-1].name);
+	tclass =3D secclass_map[sad->tclass-1].name;
+	audit_log_format(ab, " tclass=3D%s", tclass);
=20
 	if (sad->denied)
 		audit_log_format(ab, " permissive=3D%u", sad->result ? 0 : 1);
=20
+	trace_selinux_audited(sad, scontext, tcontext, tclass);
+	kfree(tcontext);
+	kfree(scontext);
+
 	/* in case of invalid context report also the actual context string */
 	rc =3D security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
 					   &scontext_len);
--=20
2.28.0.163.g6104cc2f0b6-goog

